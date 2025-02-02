// //home page for patient only

// import 'package:flutter/material.dart';
// import 'package:guardians/pages/hume_chat_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(""),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Welcome to Solis.",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const HumeChatPage()),
//                 );
//               },
//               child: const Text("Chat with Hume AI"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// for caregiver only


import 'package:flutter/material.dart';
import 'package:guardians/pages/hume_chat_page.dart';
import 'package:guardians/pages/caregiver_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to the Solis.",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Button for Chat with Hume AI
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HumeChatPage()),
                );
              },
              child: const Text("Chat with Hume AI"),
            ),

            const SizedBox(height: 20),

            // Button for Checking Up on Patient
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CaregiverPage()),
                );
              },
              child: const Text("Check Up On Them"),
            ),
          ],
        ),
      ),
    );
  }
}
