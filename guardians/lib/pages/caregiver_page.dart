// import 'package:flutter/material.dart';
// import 'package:guardians/services/hume_ai.dart';

// class CaregiverPage extends StatefulWidget {
//   const CaregiverPage({super.key});

//   @override
//   _CaregiverPageState createState() => _CaregiverPageState();
// }

// class _CaregiverPageState extends State<CaregiverPage> {
//   final HumeAIService _humeService = HumeAIService();
//   String alertMessage = "No alerts yet.";

//   @override
//   void initState() {
//     super.initState();
//     _humeService.connect(onCaregiverAlert: _showAlert);
//   }

//   void _showAlert(String message) {
//     setState(() {
//       alertMessage = message;
//     });

//     // Display a dialog for immediate caregiver attention
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Caregiver Alert"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _humeService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Caregiver Page"),
//       ),
//       body: Center(
//         child: Text(
//           alertMessage,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:guardians/services/hume_ai.dart';

// class CaregiverPage extends StatefulWidget {
//   const CaregiverPage({super.key});

//   @override
//   _CaregiverPageState createState() => _CaregiverPageState();
// }

// class _CaregiverPageState extends State<CaregiverPage> {
//   final HumeAIService _humeService = HumeAIService();
//   String alertMessage = "No alerts yet.";

//   @override
//   void initState() {
//     super.initState();
//     _humeService.connect(onCaregiverAlert: _showAlert);
//   }

//   /// ✅ **Display Alert in UI & Show Dialog**
//   void _showAlert(String message) {
//     setState(() {
//       alertMessage = message;
//     });

//     // Display a dialog immediately for caregiver attention
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("🚨 Caregiver Alert"),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _humeService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Caregiver Page"),
//       ),
//       body: Center(
//         child: Text(
//           alertMessage,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:guardians/services/hume_ai.dart';

// class CaregiverPage extends StatefulWidget {
//   const CaregiverPage({super.key});

//   @override
//   _CaregiverPageState createState() => _CaregiverPageState();
// }

// class _CaregiverPageState extends State<CaregiverPage> {
//   final HumeAIService _humeService = HumeAIService();
//   String alertMessage = "No alerts yet.";

//   @override
//   void initState() {
//     super.initState();
//     _humeService.connect(onStressUpdated: _updateStressLevels);
//     _updateStressLevels();
//   }

//   /// ✅ Check Stress Levels & Update UI
//   void _updateStressLevels() {
//     Map<String, double> stressLevels = _humeService.getStressLevels();
//     double anxiety = stressLevels["Anxiety"] ?? 0.0;
//     double distress = stressLevels["Distress"] ?? 0.0;

//     print("📊 Checking Stress Levels - Anxiety: $anxiety, Distress: $distress");

//     if (anxiety > 0.05 || distress > 0.05) {
//       _showAlert("🚨 High Stress Alert! Anxiety: $anxiety | Distress: $distress");
//     }
//   }

//   /// ✅ Show Caregiver Alert
//   void _showAlert(String message) {
//     setState(() {
//       alertMessage = message;
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("🚨 Caregiver Alert"),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _humeService.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Caregiver Page"),
//       ),
//       body: Center(
//         child: Text(
//           alertMessage,
//           textAlign: TextAlign.center,
//           style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:guardians/services/hume_ai.dart';

class CaregiverPage extends StatefulWidget {
  const CaregiverPage({super.key});

  @override
  _CaregiverPageState createState() => _CaregiverPageState();
}

class _CaregiverPageState extends State<CaregiverPage> {
  final HumeAIService _humeService = HumeAIService();
  double anxietyLevel = 0.0;
  double distressLevel = 0.0;
  String alertMessage = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _humeService.connect(onStressUpdated: _updateStressLevels);
      _updateStressLevels();
    });
  }

  void _updateStressLevels() {
    Map<String, double> stressLevels = _humeService.getStressLevels();
    setState(() {
      anxietyLevel = stressLevels["Anxiety"] ?? 0.0;
      distressLevel = stressLevels["Distress"] ?? 0.0;
    });

    print("📊 Stress Levels - Anxiety: $anxietyLevel, Distress: $distressLevel");

    if (anxietyLevel > 0.05 || distressLevel > 0.05) {
      _showAlert(
          "🚨 High Stress Alert! Anxiety: ${(anxietyLevel * 100).toStringAsFixed(1)}% | Distress: ${(distressLevel * 100).toStringAsFixed(1)}%");
    }
  }

  void _showAlert(String message) {
    setState(() {
      alertMessage = message;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("🚨 Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _humeService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Caregiver Dashboard"),
        backgroundColor: const Color(0xFFFAE3C6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            const Text(
              "Welcome Crystal!",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown),
            ),
            const SizedBox(height: 20),

            // Map Section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: AssetImage("assets/map.png"), // Replace with a real map image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stress Levels Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStressCard(
                  "Distress Level",
                  "${(distressLevel * 100).toStringAsFixed(1)}%",
                  distressLevel > 0.05 ? Colors.red : Colors.green,
                ),
                _buildStressCard(
                  "Anxiety Level",
                  "${(anxietyLevel * 100).toStringAsFixed(1)}%",
                  anxietyLevel > 0.05 ? Colors.red : Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureButton(
                  "Memory Book",
                  "assets/memory.png", // Replace with actual asset
                  () => print("Navigate to Memory Book"),
                ),
                _buildFeatureButton(
                  "Voice Notes",
                  "assets/daily.png", // Replace with actual asset
                  () => print("Navigate to Voice Notes"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFeatureButton(
                  "Safe Area",
                  "assets/safearea.png", // Replace with actual asset
                  () => print("Navigate to Safe Area"),
                ),
              ],
            ),

            // Alert Section
            if (alertMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Text(
                    alertMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStressCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 150,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureButton(
      String title, String imagePath, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
