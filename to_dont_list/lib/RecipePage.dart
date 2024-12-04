import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/RecipeName.dart';
import 'package:to_dont_list/widgets/name_dialog.dart';
import 'package:to_dont_list/widgets/recipeName_widget.dart';

class Recipepage extends StatefulWidget {
  const Recipepage({super.key});

  @override
  State<Recipepage> createState() => _RecipepageState();
}

class _RecipepageState extends State<Recipepage> {

  final List<RecipeName> recipes = [];


  void _handleNewRecipe(
      String recipeName,
      TextEditingController recipeController,
      ) {
    setState(() {
      recipes.add(RecipeName(name: recipeName));

      recipeController.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> recipeWidgets = [];
    for (int i = 0; i < recipes.length; ++i) {
      recipeWidgets.add(RecipeNameWidget(
          name: recipes[i]
          ));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Recorder'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: recipeWidgets,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return NameDialog(onRecipeAdded: _handleNewRecipe);
                  });
            }));


  }
}