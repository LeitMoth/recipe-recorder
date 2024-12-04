import 'package:flutter/material.dart';
import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/RecipeName.dart';


class RecipeNameWidget extends StatelessWidget {
  const RecipeNameWidget(
      {super.key, required this.name,});

  final RecipeName name;
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RecipeList(),
              ),
            );
      },
      title: Text(name.name)
    );
  }
  


}