import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/order_history_screen.dart';
import 'package:electronic_equipment_store/representation/screens/customer/customer_main_screen.dart';
import 'package:electronic_equipment_store/representation/screens/login_or_register/forgot_password_screen.dart';
import 'package:electronic_equipment_store/representation/screens/login_or_register/login_screen.dart';
import 'package:electronic_equipment_store/representation/screens/main_app.dart';
import 'package:electronic_equipment_store/representation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  MainApp.routeName: (context) => const MainApp(),
  LoginScreen.routeName: (context) => LoginScreen(
        onTap: () {},
      ),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  CustomerMainScreen.routeName: (context) => const CustomerMainScreen(),
  OrderHistoryScreen.routeName: (context) => const OrderHistoryScreen(),
};
