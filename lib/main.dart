import 'package:flutter/material.dart';

import './dummy_code.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';
import './screens/meal_detail_screen.dart';
import 'models/meal.dart';
import './models/meal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _avaibleMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MealsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF56C49A,
            <int, Color>{
              50: Color(0xFFE5F7F1),
              100: Color(0xFFBFF0D9),
              200: Color(0xFF8BEBBF),
              300: Color(0xFF56C49A),
              400: Color(0xFF3CA883),
              500: Color(0xFF247F6B),
              600: Color(0xFF20765F),
              700: Color(0xFF1A6B52),
              800: Color(0xFF145E46),
              900: Color(0xFF0B432E),
            },
          ),
        ).copyWith(secondary: const Color(0xFF2F4F4F)),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyLarge:
                  const TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),
              bodyMedium:
                  const TextStyle(color: Color.fromRGBO(255, 254, 229, 1)),
              titleMedium: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F4F4F)),
            ),
        appBarTheme: const AppBarTheme(
            toolbarTextStyle: TextStyle(
              color: Color(0xFF2F4F4F),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            titleTextStyle: TextStyle(
              color: Color(0xFF2F4F4F),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(color: Color(0xFF2F4F4F))),
      ),

      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_avaibleMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoriesScreen(),
        );
      },
    );
  }
}
