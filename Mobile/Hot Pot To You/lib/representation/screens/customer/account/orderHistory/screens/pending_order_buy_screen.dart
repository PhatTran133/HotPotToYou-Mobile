import 'package:auto_size_text/auto_size_text.dart';
import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/models/order_model.dart';
import 'package:electronic_equipment_store/representation/screens/customer/account/orderHistory/screens/information_order_buy_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/button_widget.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/authorized_api_service.dart';
import 'package:electronic_equipment_store/utils/dialog_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PendingOrderScreen extends StatefulWidget {
  const PendingOrderScreen({super.key});

  @override
  State<PendingOrderScreen> createState() => _PendingOrderScreenState();
}

class _PendingOrderScreenState extends State<PendingOrderScreen> {
  void _navigateToInformationScreen(OrderBuyModel order) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => InforMationOrderBuyScreen(order: order),
      ),
    );
  }

  Future<void> _cancelOrder(int orderBuyID) async {
    try {
      await AuthorizedApiService.updateStatusOrder(orderBuyID, 3);
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      showCustomDialog(context, "Lỗi", "Hủy đơn hàng không thành công", true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(
          future: AuthorizedApiService.getAllOrderBuyByCustomerIDAndStaus(
              AuthProvider.userModel!.ID,2),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<OrderBuyModel>? orders = snapshot.data;
              if (orders == null) {
                return Center(
                    child: Text('Không có đơn hàng nào.',
                        style: TextStyles.h5.bold));
              } else if (orders.isEmpty) {
                return Center(
                    child: Text('Không có đơn hàng nào.',
                        style: TextStyles.h5.bold));
              } else {
                return ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _navigateToInformationScreen(orders[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(kDefaultCircle14),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orders[index].status == 2
                                          ? "Chờ xác nhận"
                                          : "Thành Công",
                                      style: TextStyles.h5.bold,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: ColorPalette.textHide,
                              ),
                              FutureBuilder(
                                future: AuthorizedApiService
                                    .getAllOrderBuyDetailByOrderBuyID(
                                        orders[index].orderBuyID),
                                builder: ((context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<ProductModel>? orderDetails =
                                        snapshot.data;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: orderDetails!.map((detail) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          height: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: ColorPalette.textHide),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    kDefaultCircle14),
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(width: 10),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        kDefaultCircle14),
                                                child: Image.network(
                                                  cacheHeight: 80,
                                                  cacheWidth: 80,
                                                  detail.productImage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              // productName, price
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 200,
                                                      child: AutoSizeText(
                                                        detail
                                                            .productName,
                                                        minFontSize: 16,
                                                        style: TextStyles
                                                            .h5.bold,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Số lượng ${detail.quantityUserWantBuy}',
                                                      style: TextStyles
                                                          .defaultStyle.bold,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                                }),
                              ),
                              const SizedBox (
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Thành tiền'),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'vi_VN', symbol: 'vnđ')
                                          .format(orders[index].total),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 0.5,
                                color: ColorPalette.textHide,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ButtonWidget(
                                    onTap: () async {
                                      if (orders[index].status == 2) {
                                        {
                                          await _cancelOrder(
                                              orders[index].orderBuyID);
                                        }
                                      } else {
                                        showCustomDialog(context, "Lỗi",
                                            "Bạn không thể hủy đơn hàng", true);
                                      }
                                    },
                                    title: 'Hủy đơn hàng',
                                    size: 18,
                                    width: 150,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }
          },
        ),
      ),
    );
  }
}
