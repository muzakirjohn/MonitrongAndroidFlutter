import 'package:flutter/material.dart';
import 'package:monitoring/Home.dart';
import 'package:monitoring/Pages/ProfilePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:monitoring/Pages/LoginPage.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoring',
      // debugShowMaterialGrid: true,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Color.fromRGBO(238, 238, 238, 1)),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/profile': (context) => ProfilePage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
