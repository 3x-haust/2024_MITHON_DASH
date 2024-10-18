import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget {
  final VoidCallback onNotificationPressed;

  const MyAppBar({
    super.key,
    required this.onNotificationPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffEDEEF1),
      scrolledUnderElevation: 0,
      title: const Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Dash',
              style: TextStyle(
              color: Color(0xff717C8C),
              fontSize: 24,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            'assets/icons/setting.svg',
            width: 24,
            height: 24,
          ),
          onPressed: onNotificationPressed,
        ),
      ],
    );
  }
}