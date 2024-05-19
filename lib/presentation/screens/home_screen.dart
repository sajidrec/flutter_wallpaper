
import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_app/data/models/category_element_model.dart';
import 'package:flutter_wallpaper_app/presentation/screens/search_result_screen.dart';
import 'package:flutter_wallpaper_app/presentation/utils/assets_path.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CategoryElementModel> _categoryItemList = [
    CategoryElementModel(
      categoryName: "Plants",
      imagePath: AssetsPath.plantsCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Abstract",
      imagePath: AssetsPath.abstractCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Sci-Fi",
      imagePath: AssetsPath.sciFiCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Animal",
      imagePath: AssetsPath.animalCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "City",
      imagePath: AssetsPath.cityCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Thunder",
      imagePath: AssetsPath.thunderCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Fire",
      imagePath: AssetsPath.fireCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Sea",
      imagePath: AssetsPath.seaCategoryJpg,
    ),
    CategoryElementModel(
      categoryName: "Stars",
      imagePath: AssetsPath.starsCategoryJpg,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: _buildScrollableImageSection(),
    ));
  }

  Widget _buildScrollableImageSection() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 5,
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      shrinkWrap: true,
      itemCount: _categoryItemList.length,
      itemBuilder: (context, index) => _buildCategoryElement(
        onTapFunction: () {
          Get.to(
            SearchResultScreen(
              searchKeyword: _categoryItemList[index].categoryName,
            ),
          );
        },
        categoryName: _categoryItemList[index].categoryName,
        imageUrl: _categoryItemList[index].imagePath,
      ),
    );
  }

  Widget _buildCategoryElement({
    required String imageUrl,
    required String categoryName,
    required VoidCallback onTapFunction,
  }) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Stack(
        // fit: StackFit.expand,
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.25),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Center(
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
