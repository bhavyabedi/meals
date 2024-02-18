import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meals.dart';
import 'package:meals/provider/favourite_meals_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;
  final Icon favouriteIcon = const Icon(Icons.star);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteMeals = ref.watch(favoriteMealsProvider);
    final isFavourite = favouriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded = ref
                  .read(favoriteMealsProvider.notifier)
                  .toggleMealsFavourite(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      wasAdded ? 'Meal Added as Favourite' : 'Meal Removed'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) => RotationTransition(
                turns: Tween(begin: 0.6, end: 1.0).animate(animation),
                child: child,
              ),
              child: Icon(
                isFavourite ? Icons.star : Icons.star_border,
                key: ValueKey(isFavourite),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Hero(
                tag: meal.id,
                child: Image.network(
                  meal.imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final ingredient in meal.ingredients)
                        Text(
                          ingredient,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
              for (final step in meal.steps)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  child: Text(
                    '- $step',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
