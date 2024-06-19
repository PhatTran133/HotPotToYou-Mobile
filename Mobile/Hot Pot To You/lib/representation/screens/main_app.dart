import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/representation/screens/cart_screen.dart';
import 'package:electronic_equipment_store/representation/screens/guest/account_screen.dart';
import 'package:electronic_equipment_store/representation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const String routeName = '/main_app';

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          MainCartScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        selectedItemColor: ColorPalette.primaryColor,
        unselectedItemColor: ColorPalette.textHide,
        margin: const EdgeInsets.symmetric(
            horizontal: kMediumPadding24, vertical: kDefaultPadding16),
        items: [
          SalomonBottomBarItem(
            title: const Text('Trang chủ'),
            icon: const Icon(
              FontAwesomeIcons.house,
              size: kDefaultIconSize18,
            ),
          ),
          SalomonBottomBarItem(
            title: const Text('Giỏ hàng'),
            icon: const Icon(
              FontAwesomeIcons.cartShopping,
              size: kDefaultIconSize18,
            ),
          ),
          SalomonBottomBarItem(
            title: const Text('Tài khoản'),
            icon: const Icon(
              FontAwesomeIcons.solidUser,
              size: kDefaultIconSize18,
            ),
          ),
        ],
      ),
    );
  }
}
