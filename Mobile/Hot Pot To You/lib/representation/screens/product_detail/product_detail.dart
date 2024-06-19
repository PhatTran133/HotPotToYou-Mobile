import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:electronic_equipment_store/models/category_model.dart';
import 'package:electronic_equipment_store/models/feedback_model.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_detail_model.dart';
import 'package:electronic_equipment_store/models/product_image_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/representation/screens/customer/checkout.dart';
import 'package:electronic_equipment_store/representation/screens/product_detail/widgets/image_slider.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/button_widget.dart';
import 'package:electronic_equipment_store/representation/widgets/indicator_widget.dart';
import 'package:electronic_equipment_store/services/api_service.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/cart_provider.dart';
import 'package:electronic_equipment_store/utils/asset_helper.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../../core/constants/textstyle_constants.dart';

class ProductDetail extends StatefulWidget {
  final HotpotModel hotpotModel;
  // final ProductModel productModel;
  // final List<ProductDetailModel> productDetails;
  // final List<ProductImageModel> productImageModel;
  // final List<FeedbackModel> feedbackList;
  // final CategoryModel categoryModel;
  const ProductDetail({
    super.key,
    required this.hotpotModel,
    // required this.productModel,
    // required this.productDetails,
    // required this.productImageModel,
    // required this.feedbackList,
    // required this.categoryModel,
  });
  static const String routeName = '/product_detail';
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final CarouselController _controller = CarouselController();
  final TextEditingController _quantityController =
      TextEditingController(text: '1');
  final TextEditingController _feedbackController = TextEditingController();

  int _currentImage = 0;
  int quantityUserWantBy = 1;
  double rating = 5;

  @override
  void initState() {
    super.initState();
  }

  // Widget buildRatingHeader() {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Row(
  //           children: [
  //             const Icon(
  //               FontAwesomeIcons.solidStar,
  //               color: Colors.amber,
  //             ),
  //             const SizedBox(width: 10),
  //             Text(
  //               'Khách hàng đánh giá',
  //               style: TextStyles.h5.bold,
  //             ),
  //           ],
  //         ),
  //         Text(
  //           '${widget.feedbackList.length} đánh giá',
  //           style: TextStyles.defaultStyle.setColor(Colors.blue),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget buildFeedbackList() {
  //   if (widget.feedbackList.isEmpty) {
  //     return const Column(
  //       children: [
  //         Row(
  //           children: [
  //             SizedBox(width: 10),
  //             Text('Chưa có đánh giá nào'),
  //           ],
  //         ),
  //         SizedBox(height: 10),
  //       ],
  //     );
  //   } else {
  //     return Column(
  //       children: widget.feedbackList.map((feedback) {
  //         return buildFeedbackItem(feedback);
  //       }).toList(),
  //     );
  //   }
  // }

  // Widget buildFeedbackItem(FeedbackModel feedback) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       padding: const EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(kDefaultCircle14),
  //         border: Border.all(color: ColorPalette.textHide),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 10,
  //                     backgroundImage: NetworkImage(
  //                         feedback.imgUrl ?? AssetHelper.imageAvatarDefault),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Text(
  //                     feedback.nameUser!,
  //                     style: TextStyles.defaultStyle.bold,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 10),
  //           Row(
  //             children: [
  //               RatingBar(
  //                 itemSize: 18,
  //                 initialRating: feedback.ratingPoint.toDouble(),
  //                 minRating: 1,
  //                 direction: Axis.horizontal,
  //                 allowHalfRating: false,
  //                 itemCount: 5,
  //                 itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
  //                 ratingWidget: RatingWidget(
  //                   full: const Icon(
  //                     FontAwesomeIcons.solidStar,
  //                     color: Colors.amber,
  //                   ),
  //                   half: const Icon(FontAwesomeIcons.solidStar),
  //                   empty: const Icon(
  //                     FontAwesomeIcons.star,
  //                     color: Colors.amber,
  //                   ),
  //                 ),
  //                 onRatingUpdate: (value) {},
  //                 ignoreGestures: true,
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 10),
  //           AutoSizeText(
  //             feedback.description,
  //             minFontSize: 14,
  //             maxLines: 2,
  //             overflow: TextOverflow.ellipsis,
  //             style: TextStyles.defaultStyle
  //                 .setColor(ColorPalette.textColor.withOpacity(0.6)),
  //           ),
  //           const SizedBox(height: 10),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget buildFeedBackInput(ProductModel productModel) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10.0),
  //     child: Container(
  //       padding: const EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(14),
  //         border: Border.all(color: Colors.grey[300]!),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Row(
  //                 children: [
  //                   CircleAvatar(
  //                     radius: 10,
  //                     backgroundImage:
  //                         NetworkImage(AuthProvider.userModel!.avatarUrl ?? ''),
  //                   ),
  //                   const SizedBox(width: 10),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         AuthProvider.userModel!.name,
  //                         style: const TextStyle(fontWeight: FontWeight.bold),
  //                       ),
  //                       const SizedBox(height: 5),
  //                       RatingBar(
  //                         itemSize: 18,
  //                         initialRating: rating,
  //                         minRating: 1,
  //                         direction: Axis.horizontal,
  //                         allowHalfRating: false,
  //                         itemCount: 5,
  //                         itemPadding:
  //                             const EdgeInsets.symmetric(horizontal: 2.0),
  //                         ratingWidget: RatingWidget(
  //                           full: const Icon(
  //                             FontAwesomeIcons.solidStar,
  //                             color: Colors.amber,
  //                           ),
  //                           half: const Icon(FontAwesomeIcons.solidStar),
  //                           empty: const Icon(
  //                             FontAwesomeIcons.star,
  //                             color: Colors.amber,
  //                           ),
  //                         ),
  //                         onRatingUpdate: (value) {
  //                           setState(() {
  //                             rating = value;
  //                           });
  //                         },
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               ElevatedButton(
  //                 onPressed: () {
  //                   _saveFeedback(productModel);
  //                 },
  //                 child: const Text('Lưu'),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 10),
  //           TextFormField(
  //             controller: _feedbackController,
  //             decoration: const InputDecoration(
  //               labelText: 'Nhập phản hồi của bạn',
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10))),
  //             ),
  //             maxLines: 3,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // void _saveFeedback(ProductModel productModel) {
  //   FeedbackModel newFeedback = FeedbackModel(
  //       userID: AuthProvider.userModel!.userID,
  //       productId: productModel.productID,
  //       description: _feedbackController.text,
  //       ratingPoint: rating.toInt(),
  //       nameUser: AuthProvider.userModel!.name);
  //   ApiService.saveFeedBack(newFeedback);

  //   setState(() {
  //     widget.feedbackList.add(newFeedback);
  //   });

  //   _feedbackController.clear();
  // }

  // double calculateAverageRating(List<FeedbackModel> feedbacks) {
  //   if (feedbacks.isEmpty) {
  //     return 0.0;
  //   }

  //   double totalRating = 0.0;
  //   for (var feedback in feedbacks) {
  //     totalRating += feedback.ratingPoint;
  //   }

  //   return totalRating / feedbacks.length;
  // }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final HotpotModel hotpotModel = widget.hotpotModel;
    // final ProductModel productModel = widget.productModel;
    // final List<ProductDetailModel> productDetails = widget.productDetails;
    // final List<ProductImageModel> productImages = widget.productImageModel;
    // final categoryModel = widget.categoryModel;
    
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
                  child: Image.network(widget.hotpotModel.ImageUrl,
                      fit: BoxFit.cover),
                ),
                    // load ảnh productDetail
                    // Stack(
                    //   children: [
                    //     ImageSlider(
                    //       productImages: productImages,
                    //       currentImage: _currentImage,
                    //       onPageChanged: (int index) {
                    //         setState(() {
                    //           _currentImage = index;
                    //         });
                    //       },
                    //       carouselController: _controller,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                    // cục indicator
                    // Center(
                    //   child: SizedBox(
                    //     height: 8,
                    //     child: ListView.builder(
                    //       // nằm giữa hay không là nó nằm ở shrinWrap này nè. Cho phép ListView co lại theo nội dung
                    //       shrinkWrap: true,
                    //       itemCount: productImages.length,
                    //       scrollDirection: Axis.horizontal,
                    //       itemBuilder: (context, index) {
                    //         return buildIndicator(index == _currentImage, size);
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(height: 10),
                    // information product
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
                              hotpotModel.Name,
                              style: TextStyles.h4.bold,
                              minFontSize: 25,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            // description
                            ExpandableText(
                              hotpotModel.Description ?? 'N/A',
                              expandText: 'Xem thêm',
                              linkColor: Colors.blue,
                              collapseText: 'Thu gọn',
                              maxLines: 2,
                              style: TextStyles.defaultStyle.setColor(
                                ColorPalette.grey3,
                              ),
                            ),
                            const SizedBox(height: 10),
                            AutoSizeText(
                              maxLines: 1,
                              hotpotModel.Size,
                              style: TextStyles.h6,
                              minFontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           'Thời hạn bảo hành',
                            //           style: TextStyles.h5.bold,
                            //         ),
                            //         const SizedBox(height: 5),
                            //         Text(
                            //           '${productModel.warrantyPeriod ?? productModel.warrantyPeriod.toString()} Tháng',
                            //         )
                            //       ],
                            //     ),
                            //     if (productModel.categoryID != null)
                            //       Column(
                            //         crossAxisAlignment: CrossAxisAlignment.end,
                            //         children: [
                            //           Text(
                            //             'Phân loại',
                            //             style: TextStyles.h5.bold,
                            //           ),
                            //           const SizedBox(height: 5),
                            //           Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.start,
                            //             children: [
                            //               Text(
                            //                 categoryModel.categoryName,
                            //                 style: TextStyles.h5,
                            //               ),
                            //               const SizedBox(height: 5),
                            //             ],
                            //           )
                            //         ],
                            //       ),
                            //   ],
                            // ),
            //                 const SizedBox(height: 10),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           'Thuộc tính',
            //                           style: TextStyles.h5.bold,
            //                         ),
            //                         const SizedBox(height: 5),
            //                         for (var productDetail in productDetails)
            //                           Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 '${productDetail.name}: ',
            //                                 style: TextStyles.h5.bold,
            //                               ),
            //                               const SizedBox(height: 5),
            //                               Text(
            //                                 productDetail.value,
            //                                 style: TextStyles.h5,
            //                               ),
            //                             ],
            //                           )
            //                       ],
            //                     ),
            //                   ],
            //                 ),
                            // const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                    // những bài đánh giá
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(kDefaultCircle14),
                    //       color: ColorPalette.hideColor),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       buildRatingHeader(),
                    //       const Divider(
                    //         thickness: 0.5,
                    //         color: ColorPalette.primaryColor,
                    //       ),
                    //       // List đánh giá
                    //       buildFeedbackList(),
                    //     ],
                    //   ),
                    //),
                    // const SizedBox(height: 20),
                  //   if (AuthProvider.userModel != null)
                  //     Container(
                  //       decoration: BoxDecoration(
                  //           borderRadius:
                  //               BorderRadius.circular(kDefaultCircle14),
                  //           color: ColorPalette.hideColor),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           buildFeedBackInput(productModel),
                  //         ],
                  //       ),
                  //  ),
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
                                  ' ${NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(hotpotModel.Price)}',
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
                                  ' ${NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ').format(hotpotModel.Price * quantityUserWantBy)}',
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
                                  ButtonWidget(
                                    title: 'Thêm vào giỏ hàng',
                                    onTap: () {
                                      if (authProvider.isLoggedIn) {
                                        final productAlreadyInCart =
                                            cartProvider.isProductInCart(
                                                hotpotModel.ID);
                                        // if (hotpotModel.quantity > 0) {
                                          if (productAlreadyInCart) {
                                            cartProvider
                                                .addQuantityProductInCart(
                                                    hotpotModel,
                                                    quantityUserWantBy);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Sản phẩm đã được cập nhật trong giỏ hàng.'),
                                              ),
                                            );
                                          } else {
                                            cartProvider.addToCart(hotpotModel,
                                                quantityUserWantBy);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                  'Sản phẩm đã được thêm vào giỏ hàng.'),
                                            ));
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
                                  ButtonWidget(
                                    title: 'Mua Ngay',
                                    onTap: () {
                                    if (authProvider.isLoggedIn){
                                      HotpotModel newProduct = HotpotModel(
                                          ID: hotpotModel.ID,
                                          Name: hotpotModel.Name,
                                          Size: hotpotModel.Size,
                                          Description: hotpotModel.Description,
                                          Price: hotpotModel.Price,
                                          ImageUrl: hotpotModel.ImageUrl,
                                          quantityUserWantBuy: quantityUserWantBy,
                                          );
                                          // TODO
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: ((context) => Checkout(
                                                  productModel: newProduct))));}else{
                                                    ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'vui lòng đăng nhập để mua hàng.',
                                          ),
                                        ));
                                                  }
                                    },
                                    color: Colors.orange,
                                    height: 70,
                                    width: 130,
                                    size: 15,
                                  )
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
