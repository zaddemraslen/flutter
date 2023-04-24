import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_notebook/providers/blockProvider.dart';
import 'package:the_notebook/screen/blockScreen.dart';
import 'package:the_notebook/screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<blockProvider>(
          create: (context) => blockProvider(), child: const blockScreen()),
      /*homeScreen(),*/
    );
  }
}
