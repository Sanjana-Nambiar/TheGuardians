import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:guardians/services/hume_ai.dart';

class HumeChatPage extends StatefulWidget {
  const HumeChatPage({super.key});

  @override
  _HumeChatPageState createState() => _HumeChatPageState();
}

class _HumeChatPageState extends State<HumeChatPage> {
  final HumeAIService _humeService = HumeAIService();
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _recognizedText = "Tap the mic and speak...";

  @override
  void initState() {
    super.initState();
    _humeService.connect(); // ✅ Connect on app launch
  }

  @override
  void dispose() {
    _humeService.disconnect();
    super.dispose();
  }

  void _startListening() async {
    bool available = await _speechToText.initialize();
    if (available) {
      setState(() => _isListening = true);
      _speechToText.listen(
        onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });

          if (result.finalResult) {
            _humeService.sendText(_recognizedText); // ✅ Send voice input
            setState(() => _isListening = false);
          }
        },
      );
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() => _isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hume AI Chat")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // Adjust padding
            child: Center(
              child: Text(
                _recognizedText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ),
          ),
          const SizedBox(height: 40),
          IconButton(
            icon: Icon(_isListening ? Icons.mic : Icons.mic_none, size: 50),
            color: Colors.blue,
            onPressed: _isListening ? _stopListening : _startListening,
          ),
        ],
      ),
    );
  }
}

