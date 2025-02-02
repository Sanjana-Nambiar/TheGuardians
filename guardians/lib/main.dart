// import 'package:flutter/material.dart';
// import 'package:guardians/pages/welcome_page.dart';
// import 'package:guardians/pages/home_page.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Guardian App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const WelcomePage(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:guardians/pages/welcome_page.dart';
import 'package:guardians/pages/home_page.dart';
import 'package:guardians/pages/hume_chat_page.dart';

// // void main() {
// //   runApp(const MyApp());
// // }



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guardian App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
        '/hume_chat': (context) => const HumeChatPage(),
      },
    );
  }
}
