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
  final List<CategoryElement> _categoryItemList = [
    CategoryElement(
      categoryName: "Plants",
      imagePath: AssetsPath.plantsCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Abstract",
      imagePath: AssetsPath.abstractCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Sci-Fi",
      imagePath: AssetsPath.sciFiCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Animal",
      imagePath: AssetsPath.animalCategoryJpg,
    ),
    CategoryElement(
      categoryName: "City",
      imagePath: AssetsPath.cityCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Thunder",
      imagePath: AssetsPath.thunderCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Fire",
      imagePath: AssetsPath.fireCategoryJpg,
    ),
    CategoryElement(
      categoryName: "Sea",
      imagePath: AssetsPath.seaCategoryJpg,
    ),
    CategoryElement(
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
      ),
    );
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
            () => SearchResultScreen(
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
