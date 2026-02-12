import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/theme/assets_manger.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';
import 'package:rafiq/features/doctors/presentation/pages/doctors_screen.dart';

import 'package:rafiq/features/home/presentation/pages/home.dart';
import 'package:rafiq/features/profile/presentation/pages/profile_page.dart';
import 'package:rafiq/features/ticket/presentation/pages/ticket_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isNavBarVisible = true;
  List<Widget> tabs = [
    Home(),
    ChatBotScreen(),
    DoctorTab(),
    TicketTab(),
    ProfileTab(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isNavBarVisible ? _buttonNavBar() : null,
      body: tabs[currentIndex],
    );
  }

  Widget _buttonNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,

      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      onTap: _onTap,
      items: [
        BottomNavigationBarItem(
          icon: currentIndex == 0
              ? Icon(Icons.home)
              : Icon(Icons.home_outlined),
          label: 'الرئسيه',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.chatBot),
          icon: SvgPicture.asset(SvgManger.unChatBot),
          label: 'رفيقك',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.doctor),
          icon: SvgPicture.asset(SvgManger.unDoctor),
          label: 'الاطباء',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.ticket),
          icon: SvgPicture.asset(SvgManger.unTicket),
          label: 'حجوزاتي',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 4
              ? Icon(Icons.person)
              : Icon(Icons.person_outline),
          label: 'حسابي',
        ),
      ],
    );
  }

  Future<void> _onTap(int newIndex) async {
    currentIndex = newIndex;
    setState(() {});
    if (newIndex == 1) {
      await Future.delayed(const Duration(milliseconds: 150));
      setState(() {
        _isNavBarVisible = false;
      });
    } else {
      setState(() {
        _isNavBarVisible = true;
      });
    }
  }
}
