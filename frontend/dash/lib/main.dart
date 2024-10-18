import 'package:dash/pages/main/HomePage.dart';
import 'package:dash/pages/main/LoginPage.dart';
import 'package:dash/pages/main/MainPage.dart';
import 'package:dash/pages/main/ProfilePage.dart';
import 'package:dash/pages/main/RankPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const MainPage()),
        GetPage(name: '/rank', page: () => const RankPage()),
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(name: '/login', page: () => const LoginPage())
      ],
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
