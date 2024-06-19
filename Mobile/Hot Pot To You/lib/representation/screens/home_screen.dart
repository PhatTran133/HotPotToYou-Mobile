import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/models/category_model.dart';
import 'package:electronic_equipment_store/models/feedback_model.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_detail_model.dart';
import 'package:electronic_equipment_store/models/product_image_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/representation/screens/product_detail/product_detail.dart';
import 'package:electronic_equipment_store/representation/screens/search_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/representation/widgets/product_card.dart';
import 'package:electronic_equipment_store/services/api_service.dart';
import 'package:electronic_equipment_store/utils/asset_helper.dart';
import 'package:electronic_equipment_store/utils/image_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override     
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categories = [];
  CategoryModel? selectedCategory;
  int selectedProduct = 0;
  String searchTerm = '';

  Future<List<HotpotModel>?> fetchProducts() async {
    switch (selectedProduct) {
      case 0:
        return await ApiService.getAllProduct();
    //   case 1:
    //     if (selectedCategory != null) {
    //       return await ApiService.getAllProductByCategoryID(
    //           selectedCategory!.categoryID);
    //     }
    //   case 2:
    //     return await ApiService.getAllProductByProductName(searchTerm);
     }
    return null;
  }

  Future<void> _loadCategories() async {
    try {
      List<CategoryModel>? fetchedCategories =
          await ApiService.getAllCategory();
      setState(() {
        if (fetchedCategories != null) {
          categories = fetchedCategories;
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error loading categories: $e');
    }
  }

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _loadCategories();
    selectedProduct = 0;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSearchTap() async {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
    final result = await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const SearchScreen()));
    if (result != null && result is String) {
      setState(() {
        searchTerm = result;
        selectedProduct = 2;
      });
    }
  }

  void _openShowModalBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultCircle14)),
        backgroundColor: ColorPalette.backgroundScaffoldColor,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 250,
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Loại sản phẩm',
                            style: TextStyles.h5.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      selectedCategory = category;
                                      selectedProduct = 1;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: ColorPalette.primaryColor,
                                      borderRadius: BorderRadius.circular(
                                          kDefaultCircle14),
                                    ),
                                    child: Text(
                                      category.categoryName,
                                      style: TextStyles
                                          .defaultStyle.whiteTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Khác',
                            style: TextStyles.h5.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProduct = 0;
                              });
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: ColorPalette.primaryColor,
                                  borderRadius:
                                      BorderRadius.circular(kDefaultCircle14)),
                              child: Text(
                                'Tất cả sản phẩm',
                                style: TextStyles.defaultStyle.whiteTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return AppBarMain(
      leading: ImageHelper.loadFromAsset(AssetHelper.imageLogo),
      titleAppbar: "Hot Pot To You",
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                //search
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: TextEditingController(text: searchTerm),
                        focusNode: _focusNode,
                        onTap: _handleSearchTap,
                        decoration: InputDecoration(
                          hintText: 'Bạn muốn tìm tên sản phẩm gì?',
                          hintStyle: TextStyles.defaultStyle,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(kTopPadding8),
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: ColorPalette.primaryColor,
                              size: kDefaultIconSize18,
                            ),
                          ),
                          filled: true,
                          fillColor: ColorPalette.hideColor,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: ColorPalette.primaryColor),
                            borderRadius:
                                BorderRadius.circular(kDefaultCircle14),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.circular(kDefaultCircle14),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: kItemPadding10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // filter category
                    GestureDetector(
                      onTap: _openShowModalBottomSheet,
                      child: const Icon(
                        FontAwesomeIcons.sliders,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Sản phẩm',
                      style: TextStyles.h5.bold,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<HotpotModel>?>(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<HotpotModel> products = snapshot.data ?? [];
                      if (products.isEmpty) {
                        return const Center(child: Text('Không có sản phẩm'));
                      } else {
                        return GridView.builder(
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 10,
                          ),
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: ((context, index) {
                            return Transform.translate(
                              offset: Offset(0, index.isOdd ? 0.0 : 0.0),
                              child: GestureDetector(
                                onTap: () async {
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

                                HotpotModel hotpotModel = 
                                await ApiService.getHotPotDetail(
                                  products[index].ID

                                );
                                  // ProductModel productModel =
                                  //     await ApiService.getProductByID(
                                  //         products[index].ID);
                                  // List<ProductDetailModel> productDetail =
                                  //     await ApiService
                                  //         .getListProductDetailByProductByID(
                                  //             products[index].ID);
                                  // List<FeedbackModel> feedbackProduct =
                                  //     await ApiService.getFeedbackByProductID(
                                  //         products[index].ID);
                                  // List<ProductImageModel> productImages =
                                  //     await ApiService
                                  //         .getAllProductImgByProductID(
                                  //             products[index].ID);
                                  // CategoryModel categoryModel =
                                  //     await ApiService.getCategoryNameByID(
                                  //         productModel.categoryID!);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  await Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (context) => ProductDetail(
                                        hotpotModel: hotpotModel
                                        // productImageModel: productImages,
                                        // productModel: productModel,
                                        // productDetails: productDetail,
                                        // feedbackList: feedbackProduct,
                                        // categoryModel: categoryModel,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                 child: ProductCard(
                                 product: products[index],
                                 ),
                              ),
                            );
                          }),
                        );
                      }
                    } else {
                      return const Text('Không có dữ liệu sản phẩm');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
