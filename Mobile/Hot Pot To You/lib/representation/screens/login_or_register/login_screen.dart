import 'dart:convert';

import 'package:electronic_equipment_store/core/constants/my_textformfield.dart';
import 'package:electronic_equipment_store/models/h_customer_model.dart';
import 'package:electronic_equipment_store/representation/screens/customer/customer_main_screen.dart';
import 'package:electronic_equipment_store/representation/screens/login_or_register/forgot_password_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/button_widget.dart';
import 'package:electronic_equipment_store/services/api_service.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/cart_provider.dart';
import 'package:electronic_equipment_store/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/textstyle_constants.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});

  static const String routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _showPass = false;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  void signInClicked() async {
    if (emailController.text.isEmpty) {
      showCustomDialog(context, 'Lỗi', 'Bạn chưa nhập "Email".', true);
    } else if (passwordController.text.isEmpty) {
      showCustomDialog(context, 'Lỗi', 'Bạn chưa nhập "Password".', true);
    } else {
      if (validateEmail(emailController.text) == null &&
          validatePassword(passwordController.text) == null) {
        showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: ColorPalette.primaryColor,
              ),
            );
          },
        );
        try {
          final response = await ApiService.logIn(
              emailController.text, passwordController.text);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          if (response != null) {
            final responseCustomer =
                await ApiService.getUser(emailController.text);
                var tokenBox = Hive.box('tokenBox');
                tokenBox.put('token',response['value']);
            if (responseCustomer != null) {
              final userModel = CustomerModel.fromJson(responseCustomer['value']);
              var userBox = Hive.box('userBox');
              userBox.put('user', json.encode(userModel.toJson()));
              final authProvider =
                    // ignore: use_build_context_synchronously
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.setUser(userModel);
                // ignore: use_build_context_synchronously
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                cartProvider.fetchCart();
              //  if (userModel.roleId == 2) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(CustomerMainScreen.routeName);
                // }              
            }               
          } else {
            // ignore: use_build_context_synchronously
            showCustomDialog(context, 'Lỗi', 'Đăng nhập thất bại.', true);
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          showCustomDialog(context, 'Lỗi', e.toString(), true);
        }
      }
    }
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  //ít nhất một ký tự trước và sau ký tự @,
  //có một dấu . sau ký tự @,
  //tên miền có ít nhất hai ký tự.
  //Cho phép sử dụng các ký tự đặc biệt như _, %, +, và - trong phần tên người dùng.
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Vui lòng nhập Email';
    }

    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailPattern);

    if (!regex.hasMatch(email)) {
      return 'Email không hợp lệ';
    }

    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Vui lòng nhập Password';
    }

    if (password.contains(',')) {
      return 'Không được chứa dấu ","';
    }

    if (password.contains(' ')) {
      return 'Mật khẩu không được chứa khoảng trắng';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  const SizedBox(height: 25),
                  const Icon(
                    color: ColorPalette.primaryColor,
                    FontAwesomeIcons.rightToBracket,
                    size: 50,
                  ),
                  const SizedBox(height: 25),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Đăng nhập", style: TextStyles.h4.bold),
                  ),
                  const SizedBox(height: 5),

                  // Enter your account detail
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Hãy nhập chi tiết tài khoản của bạn",
                      style: TextStyles.h5.setColor(ColorPalette.textHide),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // email textField
                  MyTextFormField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: validateEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.solidEnvelope,
                      size: kDefaultIconSize18,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // password textField
                  MyTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: !_showPass,
                    validator: validatePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.key,
                      size: kDefaultIconSize18,
                      color: ColorPalette.primaryColor,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: onToggleShowPass,
                      child: Icon(
                        _showPass
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: kDefaultIconSize18,
                        color: ColorPalette.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // forgot password?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ForgotPasswordScreen.routeName);
                        },
                        child: const Text(
                          'Quên mật khẩu?',
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationThickness: 0.8,
                              decorationColor: Colors.blue,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // sign in button
                  ButtonWidget(
                    size: 22,
                    height: 70,
                    title: 'Đăng nhập',
                    onTap: signInClicked,
                  ),
                  const SizedBox(height: 30),

                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: ColorPalette.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Dont't have an account? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Bạn chưa có tài khoản?",
                        style: TextStyles.h5,
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          'Đăng ký ngay.',
                          style: TextStyles.h5.bold.setColor(Colors.blue),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
