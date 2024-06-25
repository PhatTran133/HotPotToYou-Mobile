import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:electronic_equipment_store/models/category_model.dart';
import 'package:electronic_equipment_store/models/feedback_model.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/hotpotflavor_model.dart';
import 'package:electronic_equipment_store/models/hotpottype_model.dart';
import 'package:electronic_equipment_store/models/product_detail_model.dart';
import 'package:electronic_equipment_store/models/product_image_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/representation/screens/product_detail/product_detail.dart';
import 'package:electronic_equipment_store/representation/screens/search_screen.dart';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:electronic_equipment_store/representation/widgets/product_card.dart';
import 'package:electronic_equipment_store/services/api_service.dart';
import 'package:electronic_equipment_store/services/hotpot_api_service.dart';
import 'package:electronic_equipment_store/services/hotpotflavor_api_service.dart';
import 'package:electronic_equipment_store/services/hotpottype_api_service.dart';
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
  HotPotTypeModel? hotPotTypeModel;
  String? selectedSize;
  HotPotFlavorModel? hotPotFlavorModel;
  List<HotpotModel> products = [];
  bool _isClearingFilters = false;

  Future<void> _fetchAndSetProducts({
    String? search,
    String? sortBy,
    double? fromPrice,
    double? toPrice,
    int? flavorID,
    String? size,
    int? typeID,
    int? pageIndex,
    int? pageSize,
  }) async {
    List<HotpotModel>? fetchedProducts = await fetchProducts(
      search: search,
      sortBy: sortBy,
      fromPrice: fromPrice,
      toPrice: toPrice,
      flavorID: flavorID,
      size: size,
      typeID: typeID,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );

    setState(() {
      products = fetchedProducts ?? [];
    });
    _isClearingFilters = true; // Đặt cờ trước khi xóa bộ lọc
    clearFilters();
    _isClearingFilters = false; // Đặt lại cờ sau khi xóa bộ lọc
  }

  Future<List<HotpotModel>?> fetchProducts({
    String? search,
    String? sortBy,
    double? fromPrice,
    double? toPrice,
    int? flavorID,
    String? size,
    int? typeID,
    int? pageIndex,
    int? pageSize,
  }) async {
    switch (selectedProduct) {
      case 0:
        try {
          return await HotpotApiService.getAllHotPots(
            search: search,
            sortBy: sortBy,
            fromPrice: fromPrice,
            toPrice: toPrice,
            flavorID: hotPotFlavorModel?.ID,
            size: selectedSize,
            typeID: hotPotTypeModel?.ID,
            pageIndex: pageIndex,
            pageSize: pageSize,
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
      hotPotTypeModel = null;
      hotPotFlavorModel = null;
      selectedSize = null;
    });
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

  void _openShowModalBottomSheet() async {
    List<HotPotTypeModel>? potTypes;
    List<HotPotFlavorModel>? potFlavors;

    // Call API to get HotPot types
    try {
      potTypes = await HotPotTypeApiService.getAllHotPotTypes();
    } catch (e) {
      print('Error loading HotPot types: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load HotPot types. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Call API to get HotPot flavors
    try {
      potFlavors = await HotPotFlavorApiService.getAllHotPotFlavors();
    } catch (e) {
      print('Error loading HotPot flavors: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load HotPot flavors. Please try again later.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDefaultCircle14),
      ),
      backgroundColor: ColorPalette.backgroundScaffoldColor,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // List of HotPot types
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kiểu Lẩu',
                          style: TextStyles.h5.bold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: potTypes?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final type = potTypes![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hotPotTypeModel = type;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: hotPotTypeModel == type
                                        ? ColorPalette.primaryColor
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(kDefaultCircle14),
                                  ),
                                  child: Text(
                                    type.Name,
                                    style: TextStyle(
                                      color: hotPotTypeModel == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // List of HotPot flavors
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Loại Lẩu',
                          style: TextStyles.h5.bold,
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            itemCount: potFlavors?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final flavor = potFlavors![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    hotPotFlavorModel = flavor;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: hotPotFlavorModel == flavor
                                        ? ColorPalette.primaryColor
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.circular(kDefaultCircle14),
                                  ),
                                  child: Text(
                                    flavor.Name,
                                    style: TextStyle(
                                      color: hotPotFlavorModel == flavor
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // List of Fixed Size Options
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Số Lượng',
                          style: TextStyles.h5.bold,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = '1-2';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedSize == '1-2'
                                      ? ColorPalette.primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(kDefaultCircle14),
                                ),
                                child: Text(
                                  '1-2',
                                  style: TextStyle(
                                    color: selectedSize == '1-2' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = '2-3';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedSize == '2-3'
                                      ? ColorPalette.primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(kDefaultCircle14),
                                ),
                                child: Text(
                                  '2-3',
                                  style: TextStyle(
                                    color: selectedSize == '2-3' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = '3-5';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedSize == '3-5'
                                      ? ColorPalette.primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(kDefaultCircle14),
                                ),
                                child: Text(
                                  '3-5',
                                  style: TextStyle(
                                    color: selectedSize == '3-5' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = '5-7';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedSize == '5-7'
                                      ? ColorPalette.primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(kDefaultCircle14),
                                ),
                                child: Text(
                                  '5-7',
                                  style: TextStyle(
                                    color: selectedSize == '5-7' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = '7-10';
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedSize == '7-10'
                                      ? ColorPalette.primaryColor
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(kDefaultCircle14),
                                ),
                                child: Text(
                                  '7-10',
                                  style: TextStyle(
                                    color: selectedSize == '7-10' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Confirm button
                    Center(
                      child: ElevatedButton(
                        onPressed: ()  {
                          // Close the modal bottom sheet
                          Navigator.pop(context);

                          // Call fetchProducts() with selected options
                          _fetchAndSetProducts();
                        },
                        child: Text('Confirm'),

                      ),
                    ),

                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
