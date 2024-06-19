import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/account_tile.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/order_history_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/constants/textstyle_constants.dart';
import '../../../../utils/asset_helper.dart';
import '../../../../utils/image_helper.dart';
import '../../main_app.dart';


class AccountScreenTrue extends StatefulWidget {
  const AccountScreenTrue({super.key});
  static const String routeName = '/account_screen_true';
  @override
  State<AccountScreenTrue> createState() => _AccountScreenTrueState();
}

class _AccountScreenTrueState extends State<AccountScreenTrue> {
  late AuthProvider authProvider;

  final List _title = [
    'Quản lý đơn hàng',
    'Thông tin cá nhân',
    'Đổi mật khẩu',
    'Đăng xuất',
  ];

  final List<IconData> _iconData = [
    FontAwesomeIcons.solidFileLines,
    FontAwesomeIcons.solidUser,
    FontAwesomeIcons.key,
    FontAwesomeIcons.rightToBracket,
  ];

  void _handleLogout(BuildContext context) {
    var box = Hive.box('userBox');
    authProvider.clearUser();
    box.clear();
    Navigator.of(context).pushReplacementNamed(MainApp.routeName);
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return AppBarMain(
      leading: FractionallySizedBox(
        widthFactor: 0.8,
        heightFactor: 0.8,
        child: ImageHelper.loadFromAsset(
          AssetHelper.imageLogo,
        ),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                  Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorPalette.primaryColor,
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
                              bottom: 5,
                              right: 5,
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                  AuthProvider.userModel?.AvatarUrl ??
                                      '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // tên, gmail
                      Column(
                        children: [
                          // tên
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AuthProvider.userModel?.Name ??
                                    '',
                                // 'Tên Customer',
                                style: TextStyles.h5.setTextSize(20).bold,
                              ),
                            ],
                          ),
                          //gmail
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AuthProvider.userModel?.Email ?? '',
                                style: TextStyles.h5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kDefaultCircle14),
                      color: ColorPalette.hideColor),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _title
                        .length, // Đổi yourData thành danh sách dữ liệu của bạn
                    itemBuilder: (context, index) {
                      return AccountTile(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context)
                                .pushNamed(OrderHistoryScreen.routeName);
                          } else 
                          //if (index == 1) {
                          //   Navigator.of(context)
                          //       .pushNamed(CustomerProfileScreen.routeName);
                          // } else 
                          if (index == 3) {
                            _handleLogout(context);
                          }
                        },
                        icons: _iconData[index],
                        title: _title[index],
                        trailing:
                            index == 5 ? null : FontAwesomeIcons.angleRight,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
