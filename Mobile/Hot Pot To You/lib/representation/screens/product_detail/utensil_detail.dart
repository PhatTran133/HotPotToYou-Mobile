import 'package:auto_size_text/auto_size_text.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/h_pot_model.dart';
import 'package:electronic_equipment_store/models/h_utensil_model.dart';
import 'package:electronic_equipment_store/representation/screens/customer/checkout.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/button_widget.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/cart_provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/textstyle_constants.dart';

class UtenstilDetail extends StatefulWidget {
  final UtensilModel utensilModel;

  const UtenstilDetail({
    super.key,
    required this.utensilModel,
  });
  static const String routeName = '/utensil_detail';
  @override
  State<UtenstilDetail> createState() => _UtenstilDetailState();
}

class _UtenstilDetailState extends State<UtenstilDetail> {
  final TextEditingController _quantityController =
      TextEditingController(text: '1');
  int quantityUserWantBy = 1;
  double rating = 5;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final UtensilModel utensilModel = widget.utensilModel;

    Size size = MediaQuery.of(context).size;

    return AppBarMain(
      titleAppbar: 'Chi tiết sản phẩm',
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          color: ColorPalette.backgroundScaffoldColor,
          child: const Icon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
      ),
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  children: [
                    AspectRatio(
                      aspectRatio: 13 / 9,
                      child: Image.network(widget.utensilModel.ImageUrl,
                          fit: BoxFit.cover),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(kDefaultCircle14),
                          color: ColorPalette.hideColor),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name product
                            AutoSizeText(
                              maxLines: 1,
                              utensilModel.Name,
                              style: TextStyles.h4.bold,
                              minFontSize: 25,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // description
                            // ExpandableText(
                            //   potModel.Description ?? 'N/A',
                            //   expandText: 'Xem thêm',
                            //   linkColor: Colors.blue,
                            //   collapseText: 'Thu gọn',
                            //   maxLines: 2,
                            //   style: TextStyles.defaultStyle.setColor(
                            //     ColorPalette.grey3,
                            //   ),
                            // ),
                            // const SizedBox(height: 10),
                            AutoSizeText(
                              maxLines: 1,
                              utensilModel.Size,
                              style: TextStyles.h6,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            AutoSizeText(
                              maxLines: 1,
                              utensilModel.material,
                              style: TextStyles.h6,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            // cục ở dưới màn hình Mua
            Container(
              decoration: const BoxDecoration(
                color: ColorPalette.backgroundScaffoldColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(kDefaultCircle14),
                  topRight: Radius.circular(kDefaultCircle14),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorPalette.hideColor,
                      borderRadius: BorderRadius.circular(kDefaultCircle14),
                      border: Border.all(color: ColorPalette.textHide),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Giá Thành',
                                    style: TextStyles.defaultStyle.bold,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  ' ${NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(utensilModel.Price)}',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    'Số lượng',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        if (quantityUserWantBy > 1) {
                                          quantityUserWantBy--;
                                          _quantityController.text =
                                              quantityUserWantBy.toString();
                                        }
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      controller: _quantityController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          quantityUserWantBy =
                                              int.tryParse(value) ?? 1;
                                          _quantityController.text =
                                              quantityUserWantBy.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quantityUserWantBy++;
                                        _quantityController.text =
                                            quantityUserWantBy.toString();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Thành Tiền',
                                    style: TextStyles.defaultStyle.bold,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Text(
                                  ' ${NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(utensilModel.Price * quantityUserWantBy)}',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ButtonWidget(
                                      title: 'Thêm vào giỏ hàng',
                                      onTap: () {
                                        if (authProvider.isLoggedIn) {
                                          final productAlreadyInCart =
                                              cartProvider.isProductInCart(
                                                  utensilModel.ID);
                                          // if (hotpotModel.quantity > 0) {
                                          if (cartProvider.cartHotPotItems.isEmpty) {
                                             ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Vui Lòng Chọn Lẩu Trước.'),
                                              ),
                                            );
                                          }else{
                                            if (productAlreadyInCart) {
                                            cartProvider.addQuantityUtensilInCart(
                                                utensilModel, quantityUserWantBy);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Sản phẩm đã được cập nhật trong giỏ hàng.'),
                                              ),
                                            );
                                          } else {
                                            cartProvider.addUtensilToCart
                                            (
                                                utensilModel, quantityUserWantBy);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Sản phẩm đã được thêm vào giỏ hàng.'),
                                            ));
                                          }
                                          }
                                          // } else if (productModel.quantity <= 0) {
                                          //   ScaffoldMessenger.of(context)
                                          //       .showSnackBar(const SnackBar(
                                          //     backgroundColor: Colors.red,
                                          //     content: Text(
                                          //       'Sản phẩm đã hết hàng bạn không thể bỏ vào giỏ hàng.',
                                          //     ),
                                          //   ));
                                          // }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(
                                              'Đăng nhập để sử dụng giỏ hàng.',
                                            ),
                                          ));
                                        }
                                      },
                                      height: 70,
                                      size: 15,
                                    ),
                                  ),
                                  // ButtonWidget(
                                  //   title: 'Mua Ngay',
                                  //   onTap: () {
                                  //     if (authProvider.isLoggedIn) {
                                  //       HotpotModel newProduct = HotpotModel(
                                  //         ID: hotpotModel.ID,
                                  //         Name: hotpotModel.Name,
                                  //         Size: hotpotModel.Size,
                                  //         Description: hotpotModel.Description,
                                  //         Price: hotpotModel.Price,
                                  //         ImageUrl: hotpotModel.ImageUrl,
                                  //         quantityUserWantBuy:
                                  //             quantityUserWantBy,
                                  //       );
                                  //       // TODO
                                  //       Navigator.of(context).push(
                                  //           CupertinoPageRoute(
                                  //               builder: ((context) => Checkout(
                                  //                   productModel:
                                  //                       newProduct))));
                                  //     } else {
                                  //       ScaffoldMessenger.of(context)
                                  //           .showSnackBar(const SnackBar(
                                  //         backgroundColor: Colors.red,
                                  //         content: Text(
                                  //           'vui lòng đăng nhập để mua hàng.',
                                  //         ),
                                  //       ));
                                  //     }
                                  //   },
                                  //   color: Colors.orange,
                                  //   height: 70,
                                  //   width: 130,
                                  //   size: 15,
                                  // )
                                ],
                              ),
                              // add to cart button

                              const SizedBox(height: 10),
                            ],
                          ),
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
    );
  }
}
