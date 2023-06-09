import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  // final Function removeItem;

  const MealItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.affordability,
    required this.complexity,
    required this.duration,
    // required this.removeItem
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(MealDetailScreen.routeName, arguments: id)
        .then((result) => {
              if (result != null)
                {
                  // removeItem(result);
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(
                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    width: 300,
                    color: const Color.fromRGBO(86, 196, 154, 0.7),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 26,
                          color: Color(0xFF2F4F4F),
                          fontWeight: FontWeight.w600),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.schedule),
                        const SizedBox(width: 6),
                        Text('$duration min',
                            style: const TextStyle(color: Color(0xFF2F4F4F))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.work, color: Color(0xFF2F4F4F)),
                        const SizedBox(width: 6),
                        Text(complexityText,
                            style: const TextStyle(color: Color(0xFF2F4F4F))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        const Icon(Icons.attach_money),
                        const SizedBox(width: 6),
                        Text(affordabilityText,
                            style: const TextStyle(color: Color(0xFF2F4F4F))),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
