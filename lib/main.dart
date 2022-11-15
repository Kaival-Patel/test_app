import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simform_kaival/src/modules/home/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: kDebugMode,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.pink[300])),
      title: 'Simform Kaival Practical Task',
      home: UserBackupScreen(),
    );
  }
}
