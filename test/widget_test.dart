import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_manager_app/main.dart';

void main() {
  testWidgets('Add, edit, and remove a recipe', (WidgetTester tester) async {
    await tester.pumpWidget(RecipeManagerApp());

    // Verify that the app starts with no recipes
    expect(find.text('No recipes yet'), findsOneWidget);

    // Add a new recipe
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'New Recipe');
    await tester.enterText(find.byType(TextField).at(1), 'A tasty new recipe');
    await tester.tap(find.text('Add Recipe'));
    await tester.pumpAndSettle();

    expect(find.text('New Recipe'), findsOneWidget);
    expect(find.text('No recipes yet'), findsNothing);

    // Edit the recipe
    await tester.tap(find.text('New Recipe'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Updated Recipe');
    await tester.tap(find.text('Save Changes'));
    await tester.pumpAndSettle();

    expect(find.text('Updated Recipe'), findsOneWidget);
    expect(find.text('New Recipe'), findsNothing);

    // Delete the recipe
    await tester.tap(find.text('Updated Recipe'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Updated Recipe'), findsNothing);
    expect(find.text('No recipes yet'), findsOneWidget);
  });
}
