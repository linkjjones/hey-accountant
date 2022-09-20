import 'package:flutter/material.dart';
import 'package:hey_accountant_fe/pages/navpages/command_page.dart';
import 'package:hey_accountant_fe/pages/navpages/dashboard_page.dart';
import 'package:hey_accountant_fe/pages/navpages/voice_ui_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Pages list for navigation
  List pages = [
    const CommandPage(),
    const VoiceUIPage(),
    const DashboardPage(),
  ];

  int currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,  // to prevent clicks under the icon
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.black54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: "Commands", icon: Icon(Icons.question_mark)),
          BottomNavigationBarItem(label: "Accountant", icon: Icon(Icons.hearing)),
          BottomNavigationBarItem(label: "Dashboard", icon: Icon(Icons.bar_chart)),
        ],
      ),
    );
  }
}
