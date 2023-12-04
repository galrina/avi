import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avi/views/login/login_page.dart';
import 'package:avi/views/splash/splash_page.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
 // options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux ) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(380, 700));
    WindowManager.instance.setMaximumSize(const Size(380, 700));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Klaar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashPage(),
    );
  }
}

