import 'package:flutter/material.dart';
import 'package:meals/data/data.dart';

import 'package:meals/models/meals.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/side_bar.dart';

final Map<Filter, bool> kInit = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInit;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavourite(Meal meal) {
    if (favouriteMeals.contains(meal)) {
      setState(() {
        favouriteMeals.remove(meal);
        _showInfoMessage('Removed from Favourites');
      });
    } else {
      setState(() {
        favouriteMeals.add(meal);
        _showInfoMessage('Added to Favourites');
      });
    }
  }

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            currentFilters: _selectedFilters,
          ),
        ),
      );
      setState(() {
        _selectedFilters = result ?? kInit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where(
      (meal) {
        if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
          return false;
        }
        if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        return true;
      },
    ).toList();
    Widget activePage = CategoriesScreen(
      onFavouriteToggle: _toggleMealFavourite,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: favouriteMeals,
        onFavouriteToggle: _toggleMealFavourite,
      );
      activePageTitle = 'Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: SideBar(
        onSelect: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
