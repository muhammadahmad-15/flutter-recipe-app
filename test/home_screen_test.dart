import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_manager_app/screens/home_screen.dart';

void main() {
  group('HomeScreen Logic', () {
    late HomeScreen homeScreen;

    setUp(() {
      homeScreen = HomeScreen();
    });

    test('Adding a recipe updates recipes list', () {
      final initialRecipesLength = homeScreen.recipes.length;

      final newRecipe = {'name': 'Pizza', 'description': 'Delicious pizza recipe'};
      homeScreen.addRecipe(newRecipe);

      expect(homeScreen.recipes.length, initialRecipesLength + 1);
      expect(homeScreen.recipes.last, newRecipe);
    });

    test('Editing a recipe updates the specified recipe', () {
      final index = 0;
      final originalRecipe = homeScreen.recipes[index];

      final updatedRecipe = {
        'name': 'Updated Spaghetti Bolognese',
        'description': 'A classic Italian pasta dish with a twist.',
      };
      homeScreen.editRecipe(index, updatedRecipe);

      expect(homeScreen.recipes[index], updatedRecipe);
      expect(homeScreen.recipes[index], isNot(originalRecipe));
    });

    test('Deleting a recipe removes it from recipes list', () {
      final index = homeScreen.recipes.indexOf(homeScreen.recipes[homeScreen.recipes.length - 1]);
      final deletedRecipe = homeScreen.recipes[index];
      final initialRecipesLength = homeScreen.recipes.length;

      homeScreen.deleteRecipe(index);

      expect(homeScreen.recipes, isNot(contains(deletedRecipe)));
      expect(homeScreen.recipes.length, equals(initialRecipesLength - 1));
    });

    test('Searching recipes updates filtered recipes list', () {
      homeScreen.searchRecipes('cake');

      expect(homeScreen.filteredRecipes!.length, equals(1));
      expect(homeScreen.filteredRecipes!.first['name'], equals('Spaghetti Bolognese'));

      homeScreen.searchRecipes('Nonexistent');

      expect(homeScreen.filteredRecipes!.isEmpty, isTrue);
    });
  });
}
