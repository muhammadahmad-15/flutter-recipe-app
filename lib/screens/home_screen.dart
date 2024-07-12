import 'package:flutter/material.dart';
import 'recipe_detail_screen.dart';
import 'add_edit_recipe_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

  // Expose recipes for testing
  List<Map<String, String>> get recipes => _HomeScreenState.recipes;

  // Expose filteredRecipes for testing
  List<Map<String, String>>? get filteredRecipes =>
      _HomeScreenState.filteredRecipes;

  // Expose methods for testing
  void addRecipe(Map<String, String> recipe) =>
      _HomeScreenState()._addRecipe(recipe);
  void editRecipe(int index, Map<String, String> recipe) =>
      _HomeScreenState()._editRecipe(index, recipe);
  void deleteRecipe(int index) => _HomeScreenState()._deleteRecipe(index);
  void searchRecipes(String query) => _HomeScreenState()._searchRecipes(query);
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Map<String, String>> recipes = [
    {
      'name': 'Spaghetti Bolognese',
      'description': 'A classic Italian pasta dish.'
    },
    {'name': 'Chicken Curry', 'description': 'A spicy and savory dish.'},
  ];

  static List<Map<String, String>>? filteredRecipes;

  @override
  void initState() {
    super.initState();
    filteredRecipes = recipes;
  }

  void _addRecipe(Map<String, String> recipe) {
    recipes.add(recipe);
    filteredRecipes = recipes;
    if (mounted) {
      setState(() {});
    }
  }

  void _editRecipe(int index, Map<String, String> recipe) {
    recipes[index] = recipe;
    filteredRecipes = recipes;
    if (mounted) {
      setState(() {});
    }
  }

  void _deleteRecipe(int index) {
    recipes.removeAt(index);
    filteredRecipes = recipes;
    if (mounted) {
      setState(() {});
    }
  }

  void _searchRecipes(String query) {
    filteredRecipes = recipes
        .where((recipe) =>
            recipe['name']?.toLowerCase().contains(query.toLowerCase()) ??
            false)
        .toList();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Manager'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Search Recipes'),
              onChanged: _searchRecipes,
            ),
          ),
          Expanded(
            child: (filteredRecipes?.isNotEmpty ?? false)
                ? ListView.builder(
                    itemCount: filteredRecipes?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredRecipes?[index]['name'] ?? ''),
                        subtitle:
                            Text(filteredRecipes?[index]['description'] ?? ''),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RecipeDetailScreen(
                                recipe: filteredRecipes?[index],
                                onDelete: () => _deleteRecipe(index),
                                onEdit: (newRecipe) =>
                                    _editRecipe(index, newRecipe),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No recipes yet',
                      style: TextStyle(fontSize: 18),
                    )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditRecipeScreen()),
          );
          if (result != null) {
            _addRecipe(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
