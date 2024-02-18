import 'package:flutter/material.dart';
import 'package:meals/models/meals.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meals,
    required this.onSelectMeal,
  });

  final Meal meals;
  final void Function(BuildContext context, Meal meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          onSelectMeal(context, meals);
        },
        child: Stack(
          children: [
            Hero(
              tag: meals.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                  meals.imageUrl,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black45,
                child: Column(
                  children: [
                    Text(
                      meals.title,
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow
                          .ellipsis, //puts ... in the end of overflows
                      softWrap: true,
                    ),
                    const Row(
                      children: [],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
