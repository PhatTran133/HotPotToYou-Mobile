import 'dart:io';

import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/representation/screens/splash_screen.dart';
import 'package:electronic_equipment_store/routes.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/cart_provider.dart';
import 'package:electronic_equipment_store/utils/local_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalStorageHelper.initLocalStorageHelper();
  await LocalStorageHelper.initSearchBox();
  await Hive.openBox('userBox');
  await Hive.openBox('tokenBox');
  await initializeDateFormatting('vi_VN', null);

  // ẩn status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Vô hiệu hóa kiểm tra chứng chỉ SSL
  if (Platform.isAndroid) {
    // For Android
    HttpOverrides.global = MyHttpOverrides();
  }
  runApp(  
      MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ), 
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child:
          const MyApp(), // child là MyApp nghĩa là có thể truy cập AuthProvider từ bất kỳ widget nào bên trong MyApp),
    ),
    );
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      debugShowCheckedModeBanner: false,
      title: 'ES app',
      theme: ThemeData(
        textTheme: TextTheme(bodyLarge: TextStyles.defaultStyle),
        iconTheme: const IconThemeData(
            color: ColorPalette.primaryColor, size: kDefaultIconSize18),
        scaffoldBackgroundColor: ColorPalette.backgroundScaffoldColor,
        colorScheme: ColorScheme.fromSeed(
            primary: ColorPalette.primaryColor,
            seedColor: ColorPalette.backgroundScaffoldColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}