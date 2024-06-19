// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/representation/screens/customer/customer_main_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/button_widget.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/authorized_api_service.dart';
import 'package:electronic_equipment_store/services/cart_provider.dart';
import 'package:electronic_equipment_store/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/textstyle_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Checkout extends StatefulWidget {
  final HotpotModel? productModel;
  const Checkout({
    super.key,
    this.productModel,
  });
  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String paymentMethod = 'Tiền mặt';
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: AuthProvider.userModel!.Name);
  TextEditingController phoneController =
      TextEditingController(text: AuthProvider.userModel!.Phone);
  TextEditingController addressController =
      TextEditingController(text: AuthProvider.userModel!.Address);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    List<HotpotModel> cartItemsToDisplay = cartProvider.cartItems;
    if(widget.productModel != null){
      cartItemsToDisplay = [widget.productModel!];
    }
    

    double calculateTotalPayment() {
      return cartItemsToDisplay.fold<double>(
        0,
        (total, cartItem) =>
            total + (cartItem.quantityUserWantBuy! * cartItem.Price),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundScaffoldColor,
        centerTitle: true,
        title: Text(
          'Đặt Hàng',
          style: TextStyles.defaultStyle.bold.setTextSize(19),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Text(
                    'Thông tin nhận hàng',
                    style: TextStyles.defaultStyle.setTextSize(20).bold,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(kDefaultCircle14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
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
                                  Expanded(
                                    child: isEditing
                                        ? TextFormField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              hintText: 'Tên',
                                            ),
                                          )
                                        : Text(nameController.text),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.phone,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: isEditing
                                        ? TextFormField(
                                            controller: phoneController,
                                            decoration: const InputDecoration(
                                              hintText: 'Số điện thoại',
                                            ),
                                          )
                                        : Text(phoneController.text),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.locationArrow,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: isEditing
                                        ? TextFormField(
                                            controller: addressController,
                                            decoration: const InputDecoration(
                                              hintText: 'Địa chỉ',
                                            ),
                                          )
                                        : Text(addressController.text),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isEditing = !isEditing;
                            });
                            if (!isEditing) {}
                          },
                          icon: Icon(isEditing ? Icons.save : Icons.edit),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sản phẩm',
                    style: TextStyles.defaultStyle.setTextSize(20).bold,
                  ),
                  const SizedBox(height: 10),
                  //item
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cartItemsToDisplay.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItemsToDisplay[index];
                      return Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(kDefaultCircle14),
                        ),
                        child: Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.only(top: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(kDefaultCircle14),
                              ),
                              elevation: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 10),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(kDefaultCircle14),
                                    child: cartItem.ImageUrl != null
                                        ? Image.network(
                                            cartItem.ImageUrl!,
                                            cacheHeight: 80,
                                            cacheWidth: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: 80,
                                            height: 80,
                                            color: Colors
                                                .grey, // Màu nền của hình ảnh trống
                                          ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AutoSizeText(
                                            cartItem.Name,
                                            minFontSize: 16,
                                            style: TextStyles.h6.bold,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AutoSizeText(
                                            'Số lượng: ${cartItem.quantityUserWantBuy!}',
                                            minFontSize: 14,
                                            style: TextStyles.h6,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          AutoSizeText.rich(
                                            TextSpan(
                                              children: [
                                                const TextSpan(
                                                  text: 'Giá: ',
                                                ),
                                                TextSpan(
                                                  text: NumberFormat.currency(
                                                          locale: 'vi_VN',
                                                          symbol: 'vnđ')
                                                      .format(cartItem.Price),
                                                  style: TextStyles
                                                      .defaultStyle.bold
                                                      .setColor(Colors.red),
                                                ),
                                              ],
                                            ),
                                            minFontSize: 14,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Row(
                                    children: [
                                      Text('Tổng số tiền'),
                                    ],
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'vi_VN', symbol: 'vnđ')
                                        .format(cartItem.quantityUserWantBuy! *
                                            cartItem.Price),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          // thanh toán
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kDefaultCircle14),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phương thức thanh toán',
                          style: TextStyles.h5.bold,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                      title: const Text('Tiền mặt'),
                                      onTap: () {
                                        setState(() {
                                          paymentMethod = 'Tiền mặt';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('Chuyển Khoản'),
                                      onTap: () {
                                        setState(() {
                                          paymentMethod = 'Chuyển Khoản';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                    ListTile(
                                      title: const Text('VnPAY'),
                                      onTap: () {
                                        setState(() {
                                          paymentMethod = 'VnPAY';
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(paymentMethod),
                        ),
                      ],
                    ),
                    const Divider(
                      color: ColorPalette.primaryColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tổng thanh toán',
                          style: TextStyles.h5.bold.setColor(Colors.red),
                        ),
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ')
                              .format(calculateTotalPayment()),
                          style: TextStyles.h5.bold.setColor(Colors.red),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ButtonWidget(
                  title: 'Đặt Hàng',
                  size: 22,
                  height: 70,
                  onTap: () async {
                    if (nameController.text.trim() == '') {
                      showCustomDialog(context, "Làm ơn thêm tên người nhận",
                          'Bạn chưa có tên người nhận', true);
                    } else if (phoneController.text.trim() == '') {
                      showCustomDialog(context, "Làm ơn thêm số điện thoại",
                          'Bạn chưa có số điện thoại người nhận', true);
                    } else if (addressController.text.trim() == '') {
                      showCustomDialog(context, "Làm ơn thêm địa chỉ",
                          'Bạn chưa có địa chỉ nhận hàng', true);
                    } else {
                      int orderId = await AuthorizedApiService.createOrder(
                          nameController.text.trim(),
                          phoneController.text.trim(),
                          addressController.text.trim(),
                          paymentMethod,
                          cartProvider.cartItems);
                      if (paymentMethod == 'Tiền mặt') {
                        AuthorizedApiService.deleteCart();
                        //Chuyển trang
                        // ignore: use_build_context_synchronously
                        showCustomDialog(context, 'Thành công',
                            "Bạn đã đặt hàng thành công!", false);
                        await Future.delayed(Duration(seconds: 5));
                        // ignore: use_build_context_synchronously
                        Provider.of<CartProvider>(context, listen: false)
                            .clearCart();
                        // ignore: use_build_context_synchronously
                        Navigator.popUntil(context,
                            ModalRoute.withName(CustomerMainScreen.routeName));
                      } else if (paymentMethod == 'VnPAY') {
                        String urlCheckOutByVnPay =
                            await AuthorizedApiService.checkOutByVnPay(orderId);
                        if (await canLaunchUrl(Uri.parse(urlCheckOutByVnPay))) {
                          await launchUrl(Uri.parse(urlCheckOutByVnPay));
                        } else {
                          // ignore: use_build_context_synchronously
                          showCustomDialog(context, 'Lỗi', 'Không thể mở Url thanh toán VNPay : $urlCheckOutByVnPay', true);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
