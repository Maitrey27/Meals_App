import 'package:flutter/material.dart';

import '../widgets/meals_item.dart';

import '../meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> avialableMeals;
  CategoryMealsScreen(this.avialableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String CategoryTitle;
  List<Meal> displayedMeals;
  var _loadedinitdata = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedinitdata) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      CategoryTitle = routeArgs['title'];
      final CategoryId = routeArgs['id'];
      displayedMeals = widget.avialableMeals.where(
        (meal) {
          return meal.categories.contains(CategoryId);
        },
      ).toList();
      _loadedinitdata = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CategoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            complexity: displayedMeals[index].complexity,
            affordability: displayedMeals[index].affordability,
            //removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
