import 'package:RadioWave/providers/radioProvider.dart';
import 'package:RadioWave/screen/radioScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:RadioWave/dataInit/firestoreExample.dart';
import 'package:RadioWave/screen/loginPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RadioWave',
      home: ChangeNotifierProvider<RadioProvider>(
        create: (context) => RadioProvider(),
        child: MaterialApp(home: LoginPage()),
      ),
    );
  }
}
