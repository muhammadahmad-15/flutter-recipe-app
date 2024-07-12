import 'package:flutter/material.dart';
import 'package:recipe_manager_app/screens/home_screen.dart';

void main() {
  runApp(RecipeManagerApp());
}

class RecipeManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Manager App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}
