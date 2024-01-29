import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/screens/MealDetailScreen.dart';
import 'package:meals/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  void onSelectMeal(BuildContext context, Meal meals) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(meal: meals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (meals.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) => MealItem(
            meals: meals[index],
            onSelectMeal: onSelectMeal,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('List of Meals'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                'Uh-Oh... We\'re out of meals for you.',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'try a different category maybe?',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    }
  }
}
