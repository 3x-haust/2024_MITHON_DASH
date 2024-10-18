import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xffffffff),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/trophy.svg',
            color: currentIndex == 0 ? const Color(0xff3572EF) : null,
            width: 24,
            height: 24,
          ),
          label: "랭킹",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home.svg',
            color: currentIndex == 1 ? const Color(0xff3572EF) : null,
            width: 24,
            height: 24,
          ),
          label: "홈",
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/person.svg',
            color: currentIndex == 2 ? const Color(0xff3572EF) : null,
            width: 24,
            height: 24,
          ),
          label: "마이페이지",
        ),
      ],
      selectedItemColor: const Color(0xff3572EF),
      unselectedItemColor: const Color(0xff8F98A8),
    );
  }
}