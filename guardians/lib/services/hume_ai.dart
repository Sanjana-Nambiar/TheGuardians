
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:web_socket_channel/io.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:just_audio_platform_interface/just_audio_platform_interface.dart';

// class HumeAIService {
//   final String apiKey = "3gPUbQfVJghZXGo2KymRKXsNG6AvkzwLnx6URSby4E1Vn5AU"; // Replace with your actual Hume API key
//   IOWebSocketChannel? _channel;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isConnected = false;
//   Function(String)? onAssistantResponse; // Callback for AI response

//   /// Connect to Hume AI WebSocket
//   void connect({Function(String)? onAssistantResponse}) {
//     this.onAssistantResponse = onAssistantResponse;

//     if (_isConnected) {
//       print("WebSocket is already connected.");
//       return;
//     }

//     final String url = "wss://api.hume.ai/v0/evi/chat?api_key=$apiKey";
//     print("Connecting to Hume AI WebSocket...");
//     _channel = IOWebSocketChannel.connect(Uri.parse(url));

//     _channel?.stream.listen((message) async {
//       print("Hume AI Response: $message");
//       final response = jsonDecode(message);

//       switch (response["type"]) {
//         case "chat_metadata":
//           print("Chat Metadata: Chat ID - ${response["chat_id"]}");
//           break;

//         case "assistant_message":
//           final assistantMessage = response["message"]["content"];
//           print("Assistant Message: $assistantMessage");

//           if (onAssistantResponse != null) {
//             onAssistantResponse!(assistantMessage);
//           }
//           break;

//         case "audio_output":
//           await _handleAudioOutput(response["data"]);
//           break;

//         case "assistant_end":
//           print("Assistant has finished responding.");
//           break;

//         case "error":
//           print("Error: ${response["message"]}");
//           break;

//         default:
//           print("Unhandled response type: ${response["type"]}");
//       }
//     }, onError: (error) {
//       print("WebSocket Error: $error");
//       reconnect();
//     }, onDone: () {
//       print("WebSocket Closed");
//       _isConnected = false;
//       reconnect();
//     });

//     _isConnected = true;
//   }

//   /// Handle audio output by writing to a temporary file and playing it
//   Future<void> _handleAudioOutput(String base64Audio) async {
//     try {
//       // Decode Base64 audio data into bytes
//       Uint8List audioBytes = base64Decode(base64Audio);

//       if (audioBytes.isEmpty) {
//         print("⚠️ ERROR: Received empty audio data from Hume AI.");
//         return;
//       }

//       // Write the audio bytes to a temporary file
//       Directory tempDir = await getTemporaryDirectory();
//       File tempAudioFile = File('${tempDir.path}/temp_audio.wav');
//       await tempAudioFile.writeAsBytes(audioBytes);

//       // Play the temporary audio file
//       await _audioPlayer.setFilePath(tempAudioFile.path);
//       await _audioPlayer.setVolume(1.0);
//       await _audioPlayer.play();

//       print("🎧 Audio should be playing now...");
//     } catch (e) {
//       print("❌ Error playing audio: $e");
//     }
//   }

//   /// Reconnect WebSocket
//   void reconnect() {
//     print("Reconnecting to WebSocket...");
//     disconnect();
//     connect();
//   }

//   /// Disconnect WebSocket
//   void disconnect() {
//     if (_channel != null) {
//       print("Disconnecting WebSocket...");
//       _channel?.sink.close();
//       _channel = null;
//       _isConnected = false;
//     }
//   }

//   /// Send user text input
//   void sendText(String text) {
//     if (_channel != null && _isConnected) {
//       final Map<String, dynamic> request = {
//         "type": "user_input",
//         "chat_id": "mock_chat_session",
//         "text": text,
//       };
//       print("Sending to Hume AI: $request");
//       _channel?.sink.add(jsonEncode(request));
//     } else {
//       print("WebSocket is not connected. Cannot send text.");
//     }
//   }
// }

///just detecting levels

// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:web_socket_channel/io.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';

// class HumeAIService {
//   final String apiKey = "8QOhZhnYwo3hHEymLcdsEtodGAm5hH8ON3X4EKekA1AMeq3s"; // Replace with your actual Hume API key
//   IOWebSocketChannel? _channel;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isConnected = false;

//   /// Callback for caregiver alert (e.g., show a dialog or send a notification)
//   Function(String)? onCaregiverAlert;

//   /// Connect to Hume AI WebSocket
//   void connect({Function(String)? onCaregiverAlert}) {
//     this.onCaregiverAlert = onCaregiverAlert;

//     if (_isConnected) {
//       print("WebSocket is already connected.");
//       return;
//     }

//     final String url = "wss://api.hume.ai/v0/evi/chat?api_key=$apiKey";
//     print("Connecting to Hume AI WebSocket...");
//     _channel = IOWebSocketChannel.connect(Uri.parse(url));

//     _channel?.stream.listen((message) async {
//       print("Hume AI Response: $message");
//       final response = jsonDecode(message);

//       switch (response["type"]) {
//         case "chat_metadata":
//           print("Chat Metadata: Chat ID - ${response["chat_id"]}");
//           break;

//         case "assistant_message":
//           final assistantMessage = response["message"]["content"];
//           print("Assistant Message: $assistantMessage");

//           // Check prosody scores for anxiety/distress
//           final models = response["models"];
//           if (models != null && models.containsKey("prosody")) {
//             final prosodyScores = models["prosody"]["scores"];
//             _checkAnxietyOrDistress(prosodyScores);
//           }
//           break;

//         case "audio_output":
//           await _handleAudioOutput(response["data"]);
//           break;

//         case "assistant_end":
//           print("Assistant has finished responding.");
//           break;

//         case "error":
//           print("Error: ${response["message"]}");
//           break;

//         default:
//           print("Unhandled response type: ${response["type"]}");
//       }
//     }, onError: (error) {
//       print("WebSocket Error: $error");
//       reconnect();
//     }, onDone: () {
//       print("WebSocket Closed");
//       _isConnected = false;
//       reconnect();
//     });

//     _isConnected = true;
//   }

//   /// Check anxiety or distress levels
//   void _checkAnxietyOrDistress(Map<String, dynamic> scores) {
//     final anxietyScore = scores["Anxiety"] ?? 0.0;
//     final distressScore = scores["Distress"] ?? 0.0;

//     if (anxietyScore > 0.01) {
//       print("⚠️ High Anxiety Detected: $anxietyScore");
//       _triggerCaregiverAlert("High Anxiety detected with a score of $anxietyScore.");
//     }

//     if (distressScore > 0.01) {
//       print("⚠️ High Distress Detected: $distressScore");
//       _triggerCaregiverAlert("High Distress detected with a score of $distressScore.");
//     }
//   }

//   /// Trigger caregiver alert
//   void _triggerCaregiverAlert(String message) {
//     if (onCaregiverAlert != null) {
//       onCaregiverAlert!(message);
//     }
//   }

//   /// Handle audio output by writing to a temporary file and playing it
//   Future<void> _handleAudioOutput(String base64Audio) async {
//     try {
//       // Decode Base64 audio data into bytes
//       Uint8List audioBytes = base64Decode(base64Audio);

//       if (audioBytes.isEmpty) {
//         print("⚠️ ERROR: Received empty audio data from Hume AI.");
//         return;
//       }

//       // Write the audio bytes to a temporary file
//       Directory tempDir = await getTemporaryDirectory();
//       File tempAudioFile = File('${tempDir.path}/temp_audio.wav');
//       await tempAudioFile.writeAsBytes(audioBytes);

//       // Play the temporary audio file
//       await _audioPlayer.setFilePath(tempAudioFile.path);
//       await _audioPlayer.setVolume(1.0);
//       await _audioPlayer.play();

//       print("🎧 Audio should be playing now...");
//     } catch (e) {
//       print("❌ Error playing audio: $e");
//     }
//   }

//   /// Reconnect WebSocket
//   void reconnect() {
//     print("Reconnecting to WebSocket...");
//     disconnect();
//     connect();
//   }

//   /// Disconnect WebSocket
//   void disconnect() {
//     if (_channel != null) {
//       print("Disconnecting WebSocket...");
//       _channel?.sink.close();
//       _channel = null;
//       _isConnected = false;
//     }
//   }

//   /// Send user text input
//   void sendText(String text) {
//     if (_channel != null && _isConnected) {
//       final Map<String, dynamic> request = {
//         "type": "user_input",
//         "chat_id": "mock_chat_session",
//         "text": text,
//       };
//       print("Sending to Hume AI: $request");
//       _channel?.sink.add(jsonEncode(request));
//     } else {
//       print("WebSocket is not connected. Cannot send text.");
//     }
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:web_socket_channel/io.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class HumeAIService {
  final String apiKey = "grYQCAKqHeGS75E0d02sczHslwG8R0nzhKgMqxvV7faGHSYy"; // Replace with your actual Hume API key
  IOWebSocketChannel? _channel;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isConnected = false;

  /// ✅ Persistent Anxiety & Distress Levels (DO NOT RESET)
  static double anxietyLevel = 0.0;
  static double distressLevel = 0.0;

  /// ✅ Callback to notify caregiver page when stress levels change
  Function()? onStressUpdated;

  /// Connect to Hume AI WebSocket
  void connect({Function()? onStressUpdated}) {
    this.onStressUpdated = onStressUpdated;

    if (_isConnected) {
      print("WebSocket is already connected.");
      return;
    }

    final String url = "wss://api.hume.ai/v0/evi/chat?api_key=$apiKey";
    print("Connecting to Hume AI WebSocket...");
    _channel = IOWebSocketChannel.connect(Uri.parse(url));

    _channel?.stream.listen((message) async {
      print("Hume AI Response: $message");
      final response = jsonDecode(message);

      switch (response["type"]) {
        case "chat_metadata":
          print("Chat Metadata: Chat ID - ${response["chat_id"]}");
          break;

        case "assistant_message":
          final assistantMessage = response["message"]["content"];
          print("Assistant Message: $assistantMessage");

          // ✅ Update Anxiety & Distress scores
          final models = response["models"];
          if (models != null && models.containsKey("prosody")) {
            final prosodyScores = models["prosody"]["scores"];
            _updateStressLevels(prosodyScores);
          }
          break;

        case "audio_output":
          await _handleAudioOutput(response["data"]);
          break;

        case "assistant_end":
          print("Assistant has finished responding.");
          break;

        case "error":
          print("Error: ${response["message"]}");
          break;

        default:
          print("Unhandled response type: ${response["type"]}");
      }
    }, onError: (error) {
      print("WebSocket Error: $error");
      reconnect();
    }, onDone: () {
      print("WebSocket Closed");
      _isConnected = false;
      reconnect();
    });

    _isConnected = true;
  }

  /// ✅ Keep Anxiety & Distress Levels Persistent
  void _updateStressLevels(Map<String, dynamic> scores) {
    anxietyLevel = scores["Anxiety"] ?? anxietyLevel; // Keep previous value if null
    distressLevel = scores["Distress"] ?? distressLevel;

    print("📊 Updated Anxiety: $anxietyLevel | Distress: $distressLevel");

    if (onStressUpdated != null) {
      onStressUpdated!(); // Notify CaregiverPage
    }
  }

  /// ✅ Get Latest Anxiety & Distress Levels
  Map<String, double> getStressLevels() {
    return {
      "Anxiety": anxietyLevel,
      "Distress": distressLevel,
    };
  }

  /// Handle audio output by writing to a temporary file and playing it
  Future<void> _handleAudioOutput(String base64Audio) async {
    try {
      Uint8List audioBytes = base64Decode(base64Audio);
      if (audioBytes.isEmpty) return;

      Directory tempDir = await getTemporaryDirectory();
      File tempAudioFile = File('${tempDir.path}/temp_audio.wav');
      await tempAudioFile.writeAsBytes(audioBytes);

      await _audioPlayer.setFilePath(tempAudioFile.path);
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.play();

      print("🎧 Audio should be playing now...");
    } catch (e) {
      print("❌ Error playing audio: $e");
    }
  }

  /// Reconnect WebSocket
  void reconnect() {
    print("Reconnecting to WebSocket...");
    disconnect();
    connect();
  }

  /// Disconnect WebSocket
  void disconnect() {
    if (_channel != null) {
      print("Disconnecting WebSocket...");
      _channel?.sink.close();
      _channel = null;
      _isConnected = false;
    }
  }

  /// Send user text input
  void sendText(String text) {
    if (_channel != null && _isConnected) {
      final Map<String, dynamic> request = {
        "type": "user_input",
        "chat_id": "mock_chat_session",
        "text": text,
      };
      print("Sending to Hume AI: $request");
      _channel?.sink.add(jsonEncode(request));
    } else {
      print("WebSocket is not connected. Cannot send text.");
    }
  }
}
