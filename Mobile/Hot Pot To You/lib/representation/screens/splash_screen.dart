import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../core/constants/color_constants.dart';
import '../../utils/asset_helper.dart';
import '../../utils/image_helper.dart';
import 'main_app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splash_screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  void checkUserStatus() async {
    // final ignoreIntroScreen =
    //     LocalStorageHelper.getValue('ignoreIntroScreen') as bool?;

    await Future.delayed(const Duration(seconds: 3));  


        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(MainApp.routeName);
        //TODO Thêm chức năng kiểm tra đã đăng nhập chưa để chuyển trang bằng router
  }

    

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: ColorPalette.primaryColor),
        ),
        ImageHelper.loadFromAsset(AssetHelper.imageSplash, fit: BoxFit.cover),
        const SpinKitPulse(
          color: Colors.black,
          size: 400,
        ),
      ],
    );
  }
}
