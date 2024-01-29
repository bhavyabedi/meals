import 'package:flutter/material.dart';
import 'package:meals/data/data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/screens/MealsScreen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  void _selectCaregory(BuildContext context, Category category) {
    final filteredList = dummyMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filteredList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Category'),
      ),
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: availableCategories
            .map(
              (category) => CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCaregory(
                    context,
                    category,
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
