import 'package:flutter/material.dart';
import 'package:meals/data/data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onFavouriteToggle,
    required this.availableMeals,
  });

  final void Function(Meal meal) onFavouriteToggle;
  final List<Meal> availableMeals;

  void _selectCaregory(BuildContext context, Category category) {
    final filteredList = availableMeals
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
          onFavouriteToggle: onFavouriteToggle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
    );
  }
}
