import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/screens/canceled_order_buy_screen.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/screens/completed_order_buy_screen.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/screens/pending_order_buy_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../../core/constants/color_constants.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});
  static const String routeName = '/main_order_history_screen';
  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreen();
}

class _OrderHistoryScreen extends State<OrderHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 0;
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
Widget build(BuildContext context) {
  return AppBarMain(
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          color: ColorPalette.backgroundScaffoldColor,
          child: const Icon(FontAwesomeIcons.angleLeft)),
    ),
    child: Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorPalette.primaryColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: TabBar(
                    isScrollable: true,
                    physics: const ScrollPhysics(),
                    dividerColor: ColorPalette.primaryColor,
                    indicator: BoxDecoration(
                      color: ColorPalette.backgroundScaffoldColor,
                      borderRadius: BorderRadius.circular(kDefaultCircle14),
                    ),
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ColorPalette.textColor,
                    controller: _tabController,
                    tabs: const [
                      Tab(
                        text: 'Chờ phê duyệt',
                      ),                      
                      Tab(
                        text: 'Hoàn thành',
                      ),                     
                      Tab(
                        text: 'Đã hủy',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              // physics: ScrollPhysics(),
              physics: const NeverScrollableScrollPhysics(),
              // physics: BouncingScrollPhysics(),
              controller: _tabController,
              children: const [
                PendingOrderScreen(),
                CompletedOrderBuyScreen(),
                CanceledOrderBuyScreen(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
