import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/presentation/screens/search_result_screen.dart';
import 'package:flutter_wallpaper_app/presentation/utils/app_color.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSearchFiled(),
    );
  }

  Widget _buildSearchFiled() {
    final focusNode = FocusNode();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              focusNode: focusNode,
              controller: _searchTEController,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.primaryYellowColor,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (searchKeyword) {
                Get.to(
                  () => SearchResultScreen(searchKeyword: searchKeyword),
                );
              },
              maxLength: 35,
              decoration: InputDecoration(
                counterStyle: TextStyle(
                  color: AppColor.primaryYellowColor,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    focusNode.unfocus();
                    Get.to(
                      () => SearchResultScreen(
                        searchKeyword:
                            _searchTEController.text.toString().trim(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search,
                    color: AppColor.primaryYellowColor,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.primaryYellowColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.primaryYellowColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchTEController.dispose();
  }
}
