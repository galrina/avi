import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avi/views/login/login_page.dart';

import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux || Platform.isIOS) {
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
      title: 'Avi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

