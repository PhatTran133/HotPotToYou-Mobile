import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/h_pot_model.dart';
import 'package:electronic_equipment_store/models/h_utensil_model.dart';
import 'package:electronic_equipment_store/models/hotpotflavor_model.dart';
import 'package:electronic_equipment_store/representation/screens/product_detail/product_detail.dart';
import 'package:electronic_equipment_store/representation/screens/search_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/representation/widgets/pot_card.dart';
import 'package:electronic_equipment_store/representation/widgets/product_card.dart';
import 'package:electronic_equipment_store/representation/widgets/utensil_card.dart';
import 'package:electronic_equipment_store/services/hotpot_api_service.dart';
import 'package:electronic_equipment_store/utils/asset_helper.dart';
import 'package:electronic_equipment_store/utils/image_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class UtensilScreen extends StatefulWidget {
  const UtensilScreen({super.key});

  @override
  State<UtensilScreen> createState() => _UtensilScreenState();
}

class _UtensilScreenState extends State<UtensilScreen> {
  int selectedProduct = 0;
  String searchTerm = '';
  String? selectedSize;
  HotPotFlavorModel? hotPotFlavorModel;
  List<UtensilModel> products = [];
  bool _isClearingFilters = false;
  
  Future<void> _fetchAndSetProducts({
    String? search,
  }) async {
    List<UtensilModel>? fetchedProducts = await fetchProducts(
      search: search,
      
    );

    setState(() {
      products = fetchedProducts ?? [];
    });
    _isClearingFilters = true; // Đặt cờ trước khi xóa bộ lọc
    clearFilters();
    _isClearingFilters = false; // Đặt lại cờ sau khi xóa bộ lọc
  }

  Future<List<UtensilModel>?> fetchProducts({
    String? search,
  }) async {
     switch (selectedProduct) {
      case 0:
        try {
          return await HotpotApiService.getAllUtensil(
          );
        } catch (e) {
          throw Exception('Failed to fetch products: $e');
        }
        case 2:
        try {
          return await HotpotApiService.getAllUtensil(
            search: searchTerm,
          );
        } catch (e) {
          throw Exception('Failed to fetch products: $e');
        }
// Uncomment and add cases for other product fetching scenarios if needed
// case 1:
// if (selectedCategory != null) {
// return await ApiService.getAllProductByCategoryID(selectedCategory!.categoryID);
// }
// case 2:
// return await ApiService.getAllProductByProductName(searchTerm);
}
     return null;
  }

  void clearFilters() {
    if (_isClearingFilters) return; // Kiểm tra cờ trước khi xóa bộ lọc
    setState(() {
      hotPotFlavorModel = null;
      selectedSize = null;
    });
  }

  

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    selectedProduct = 0;
    _fetchAndSetProducts(); // Gọi API khi khởi tạo
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn Loại Nồi Mà Bạn Muốn!'),),
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
                FutureBuilder<List<UtensilModel>?>(
                  future: fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<UtensilModel> products = snapshot.data ?? [];
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
                                  await HotpotApiService.getHotPotDetail(
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
                                child: UtensilCard(
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
      );
  }
}
