import 'package:flutter/material.dart';
import 'package:flutter_steps_tracker/app/home/profile/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.menuScreenContext});
  final BuildContext menuScreenContext;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController();
  }

  List<Widget> _buildScreens() => [
        ProfileScreen(
          menuScreenContext: widget.menuScreenContext,
        ),
        ProfileScreen(
          menuScreenContext: widget.menuScreenContext,
        ),
        ProfileScreen(
          menuScreenContext: widget.menuScreenContext,
        ),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Profile",
          activeColorPrimary: const Color.fromARGB(255, 238, 110, 93),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          title: "Profile",
          activeColorPrimary: const Color.fromARGB(255, 238, 110, 93),
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: "Profile",
          activeColorPrimary: const Color.fromARGB(255, 238, 110, 93),
          inactiveColorPrimary: Colors.grey,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        resizeToAvoidBottomInset: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        bottomScreenMargin: 0,
        backgroundColor: Colors.black,
        hideNavigationBar: false,
        decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property
      ),
    );
  }
}
