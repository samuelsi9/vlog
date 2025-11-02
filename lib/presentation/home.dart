import 'package:flutter/material.dart';
import 'package:vlog/Models/user_model.dart';
import 'package:vlog/presentation/screen/profilepage.dart';
import 'package:vlog/presentation/realhome.dart';
import 'package:vlog/presentation/screen/profilepage.dart';

class MainScreen extends StatefulWidget {
  final String? token;
  const MainScreen({super.key, required this.token});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List pages = [Realhome(), Scaffold(), Scaffold(), ProfileScreen()];
    print(widget.token);
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {});
          selectedIndex = value;
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Message"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: " Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
