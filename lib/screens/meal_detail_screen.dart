import 'package:flutter/material.dart';

import '../dummy_code.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen(this.toggleFavorite, this.isFavorite, {super.key});

  Widget _buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
        appBar: AppBar(
          title: Text(selectedMeal.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              _buildSectionTitle(context, 'Ingredients'),
              _buildContainer(
                ListView.builder(
                    itemBuilder: (ctx, index) => Card(
                          color: Theme.of(context).colorScheme.primary,
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                selectedMeal.ingredients[index],
                                style:
                                    const TextStyle(color: Color(0xFF2F4F4F)),
                              )),
                        ),
                    itemCount: selectedMeal.ingredients.length),
              ),
              _buildSectionTitle(context, 'Steps'),
              _buildContainer(ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        child: Text(
                          '# ${index + 1}',
                          style: const TextStyle(color: Color(0xFF2F4F4F)),
                        ),
                      ),
                      title: Text(
                        selectedMeal.steps[index],
                        style: const TextStyle(color: Color(0xFF2F4F4F)),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            isFavorite(mealId) ? Icons.star : Icons.star_border,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => toggleFavorite(mealId),
        ));
  }
}
