import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rafiq/core/theme/app_colors.dart';
import 'package:rafiq/core/utils/assets_manger.dart';
import 'package:rafiq/features/bookings/presentation/pages/bookings_screen.dart';
import 'package:rafiq/features/chatbot/presentation/pages/chatbot_page.dart';
import 'package:rafiq/features/doctors/presentation/pages/doctors_screen.dart';
import 'package:rafiq/features/home/presentation/pages/home.dart';
import 'package:rafiq/features/profile/presentation/pages/profile_page.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;

  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  bool _isNavBarVisible = true;

  late final List<Widget> tabs;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    tabs = const [
      Home(),
      ChatBotScreen(),
      DoctorsScreen(),
      BookingsScreen(),
      ProfileTab(),
    ];
    _updateNavVisibility(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        if (currentIndex != 0) {
          setState(() {
            currentIndex = 0;
            _updateNavVisibility(0);
          });
        }
      },
      child: Scaffold(
        body: tabs[currentIndex],
        bottomNavigationBar: _isNavBarVisible ? _buttonNavBar() : null,
      ),
    );
  }

  void _updateNavVisibility(int index) {
    _isNavBarVisible = index != 1;
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
              ? const Icon(Icons.home)
              : const Icon(Icons.home_outlined),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.chatBot),
          icon: SvgPicture.asset(SvgManger.unChatBot),
          label: 'رفيقك',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.doctor),
          icon: SvgPicture.asset(SvgManger.unDoctor),
          label: 'الأطباء',
        ),
        BottomNavigationBarItem(
          activeIcon: SvgPicture.asset(SvgManger.ticket),
          icon: SvgPicture.asset(SvgManger.unTicket),
          label: 'حجوزاتي',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 4
              ? const Icon(Icons.person)
              : const Icon(Icons.person_outline),
          label: 'حسابي',
        ),
      ],
    );
  }

  void _onTap(int newIndex) {
    if (currentIndex == newIndex) return;

    setState(() {
      currentIndex = newIndex;
      _updateNavVisibility(newIndex);
    });
  }
}
