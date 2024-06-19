import 'package:electronic_equipment_store/representation/screens/cart_screen.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/account_screen_customer.dart';
import 'package:electronic_equipment_store/representation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';


class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({super.key});

  static const String routeName = '/customer_main_screen';

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreen();
}

class _CustomerMainScreen extends State<CustomerMainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          MainCartScreen(),
          AccountScreenTrue(),
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
