import 'dart:math';
import 'package:electronic_equipment_store/representation/screens/widgets/app_bar_main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/dismension_constants.dart';
import '../../core/constants/textstyle_constants.dart';
import '../../utils/local_storage_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _focusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];
  String searchTerm = "";

  bool showAllSearchHistory = false;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    searchHistory = LocalStorageHelper.getSearchHistory();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _selectSearchHistory(String searchTerm) {
    _searchController.text = searchTerm;
    _onSearch(_searchController.text);
  }

  void _onSearch(String searchTerm) {
    if (searchTerm.isNotEmpty) {
      if (searchHistory.contains(searchTerm)) {
        searchHistory.remove(searchTerm);
      }

      searchHistory.insert(0, searchTerm);
      LocalStorageHelper.setSearchHistory(searchHistory);
    }

    Navigator.of(context).pop(searchTerm);
  }
  @override
  Widget build(BuildContext context) {
    return AppBarMain(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          FontAwesomeIcons.angleLeft,
          size: kDefaultIconSize18,
        ),
      ),
      titleAppbar: 'Tìm kiếm',
      child: GestureDetector(
        onTap: () {
          if (_focusNode.hasFocus) {
            _focusNode.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    focusNode: _focusNode,
                    controller: _searchController,
                    enableSuggestions: true,
                    onSubmitted: _onSearch,
                    autofocus: true,
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
                          borderSide:
                              const BorderSide(color: ColorPalette.primaryColor),
                          borderRadius: BorderRadius.circular(14)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: kItemPadding10),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // nội dung tìm kiếm gần đây
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Nội dung tìm kiếm gần đây',
                        style: TextStyles.h5.bold,
                      ),
                    ],
                  ),

                  // lịch sử tìm kiếm
                  if (searchHistory.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: showAllSearchHistory
                              ? searchHistory.length
                              : min(searchHistory.length, 5),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: ColorPalette.hideColor),
                                ),
                              ),
                              child: ListTile(
                                onTap: () {
                                  _selectSearchHistory(searchHistory[index]);
                                },
                                horizontalTitleGap: 30,
                                leading: const Icon(
                                  FontAwesomeIcons.clockRotateLeft,
                                  size: kDefaultIconSize18,
                                ),

                                // xóa từng thằng
                                trailing: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      searchHistory.removeAt(index);
                                      LocalStorageHelper.setSearchHistory(
                                          searchHistory);
                                    });
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.xmark,
                                    size: kDefaultIconSize18,
                                  ),
                                ),
                                iconColor: ColorPalette.primaryColor,
                                title: Text(
                                  searchHistory[index],
                                  style:
                                      TextStyles.defaultStyle.setTextSize(18),
                                ),
                              ),
                            );
                          },
                        ),

                        // Thu gọn và Hiển thị thêm
                        const SizedBox(height: 10),
                        if (searchHistory.length > 5)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showAllSearchHistory = !showAllSearchHistory;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 13, right: 13, top: 5, bottom: 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorPalette.primaryColor),
                                    color: ColorPalette.backgroundScaffoldColor,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Text(
                                    showAllSearchHistory
                                        ? "Thu gọn"
                                        : "Hiển thị thêm",
                                    style: TextStyles.defaultStyle.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 10),

                        // Xóa lịch sử tìm kiếm
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              searchHistory.clear();
                              LocalStorageHelper.setSearchHistory(
                                  searchHistory);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 13, right: 13, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                      color: ColorPalette.primaryColor),
                                ),
                                child: Text(
                                  "Xóa nội dung tìm kiếm gần đây",
                                  style: TextStyles.defaultStyle.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
