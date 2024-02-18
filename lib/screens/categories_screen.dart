import 'package:flutter/material.dart';
import 'package:meals/data/data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0,
      upperBound: 1,
      //Lower and upper bound values are 0,1 by default but can be changed depending upon the requirement.
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    //Needed to dispose the animation from memory to avoid memory overflow
    _animationController.dispose();
    super.dispose();
  }

  void _selectCaregory(BuildContext context, Category category) {
    final filteredList = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeIn,
          ),
        ),
        child: child,
      ),
    );
  }
}
