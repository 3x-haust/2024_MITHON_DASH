import 'package:dash/api/User.dart';
import 'package:dash/pages/main/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFEDEEF1),
        child: SafeArea(
          child: Column(
            children: [
              _buildLogo(),
              const Spacer(),
              _buildGoogleSignInButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 100,),
        Image.asset('assets/icons/logo.png', width: 200, height: 200),
        const SizedBox(height: 24),
        const Text(
          'Dash',
          style: TextStyle(
            color: Color(0xFF0053FF),
            fontSize: 48,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 29),
      child: ElevatedButton(
        onPressed: _isSigningIn ? null : _handleGoogleSignIn,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        child: _isSigningIn
            ? const CircularProgressIndicator()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/google.svg', height: 18, width: 18),
                  const SizedBox(width: 4),
                  const Text(
                    'Google 계정으로 시작하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn() async {
    try {
      setState(() {
        _isSigningIn = true;
      });

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google Sign In was cancelled');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      final userApiResult = await UserApi().getUserById(FirebaseAuth.instance.currentUser!.uid);
      if (user != null && userApiResult['error'] == 'User not found') {
        UserApi().createUser(FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown User', FirebaseAuth.instance.currentUser!.uid);
      } 
      
      Get.to(() => const MainPage());
    } catch (e) {
      print('Error during Google sign in: $e');
    } finally {
      setState(() {
        _isSigningIn = false;
      });
    }
  }
}