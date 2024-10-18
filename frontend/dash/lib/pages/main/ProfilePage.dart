import 'package:dash/api/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDEEF1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildProfileCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildProfileImage(),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  FirebaseAuth.instance.currentUser!.displayName ?? 'No Name',
                  style: const TextStyle(
                    color: Color(0xFF101012),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildOxygenInfo(),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(color: Color(0xFF8F98A8), thickness: 1),
          _buildProfileEditButton(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FirebaseAuth.instance.currentUser!.photoURL != null
              ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
              : const NetworkImage('https://via.placeholder.com/66x66'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOxygenInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          '내 산소',
          style: TextStyle(
            color: Color(0xFF555E70),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder<Map<String, dynamic>>(
          future: UserApi().getUserById(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else {
              return RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: Color(0xFF0053FF),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(text: '${snapshot.data!['data']['money']} O'),
                    WidgetSpan(
                      child: Transform.translate(
                        offset: const Offset(0, 1),
                        child: const Text(
                          '2',
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            color: Color(0xFF0053FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildProfileEditButton() {
    return GestureDetector(
      onTap: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '프로필 수정',
              style: TextStyle(
                color: Color(0xFF555E70),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF555E70),
            ),
          ],
        ),
      ),
    );
  }
}