import 'package:dash/pages/main/HomePage.dart';
import 'package:dash/pages/main/MainPage.dart';
import 'package:dash/pages/main/ProfilePage.dart';
import 'package:dash/pages/main/RankPage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/rank', page: () => const RankPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
      ],
      initialRoute: '/login', 
      debugShowCheckedModeBanner: false,
    );
  }
}


