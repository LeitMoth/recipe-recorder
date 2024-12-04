import 'package:flutter/material.dart';

typedef RecipeAddedCallback = Function(
    String name,
    TextEditingController nameController,);

class NameDialog extends StatelessWidget {
  NameDialog({super.key,required this.onRecipeAdded});

  final RecipeAddedCallback onRecipeAdded;

  final TextEditingController _nameController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Recipe'),
      content: TextField(controller: _nameController,),
      actions: [
        ElevatedButton(
          key: const Key("OKButton"),
          style: yesStyle,
          onPressed: (){
            onRecipeAdded(
                _nameController.text, 
                _nameController);
                Navigator.pop(context);
                },
          child: const Text('OK'),
          ),
           ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ]
    );
  }
}