import 'package:flutter/material.dart';
import 'package:meals/data/data.dart';
import 'package:meals/models/meals.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    if (meals.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (context, index) => Text(
            meals[index].title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
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
