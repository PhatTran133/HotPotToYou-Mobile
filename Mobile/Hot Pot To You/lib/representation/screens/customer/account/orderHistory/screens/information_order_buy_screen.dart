import 'package:auto_size_text/auto_size_text.dart';
import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/services/authorized_api_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../../models/order_model.dart';

class InforMationOrderBuyScreen extends StatefulWidget {
  final OrderBuyModel order;
  const InforMationOrderBuyScreen({super.key, required this.order});

  @override
  State<InforMationOrderBuyScreen> createState() =>
      _InforMationOrderBuyScreenState();
}

class _InforMationOrderBuyScreenState extends State<InforMationOrderBuyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                color: ColorPalette.backgroundScaffoldColor,
                child: const Icon(FontAwesomeIcons.angleLeft)),
          ),
          title: const Center(child: Text('Thông tin đơn hàng')),
          backgroundColor: ColorPalette.backgroundScaffoldColor,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Text(
                      'Thông tin nhận hàng',
                      style: TextStyles.defaultStyle.setTextSize(20).bold,
                    ),
                    Text(
                      '${widget.order.orderBuyID}',
                      style: TextStyles.defaultStyle.setTextSize(20).bold,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kDefaultCircle14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.solidUser,
                                size: 14,
                              ),
                              const SizedBox(width: 10),
                              Text(widget.order.customerName),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(FontAwesomeIcons.locationDot, size: 14),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 250,
                                child: AutoSizeText(
                                  widget.order.customerAddress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Ngày đặt hàng',
                      style: TextStyles.defaultStyle.setTextSize(20).bold,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kDefaultCircle14),
                      ),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(widget.order.dateOrder),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Sản phẩm',
                      style: TextStyles.defaultStyle.setTextSize(20).bold,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kDefaultCircle14),
                      ),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: AuthorizedApiService
                                .getAllOrderBuyDetailByOrderBuyID(
                                    widget.order.orderBuyID),
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
                                      margin: const EdgeInsets.only(top: 10),
                                      height: 110,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorPalette.textHide),
                                        borderRadius: BorderRadius.circular(
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
                                              detail
                                                  .productImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          // productName, price
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: 230,
                                                  child: AutoSizeText(
                                                    detail
                                                        .productName,
                                                    minFontSize: 16,
                                                    style: TextStyles.h5.bold,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(
                                                    detail
                                                        .price,
                                                  ),
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
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 0.5,
                            color: ColorPalette.textHide,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Thành tiền'),
                                Text(
                                  NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(widget.order.total),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
