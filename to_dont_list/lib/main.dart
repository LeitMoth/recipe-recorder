// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/step_dialog.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final List<Item> items = [const Item(name: "add more todos")];

  void _handleDeleteItem(Item item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Item item = Item(name: itemText);
      items.insert(0, item);
      textController.clear();
    });
  }

  void _handleNewStep(
      String ingredient,
      String amount,
      TextEditingController ingredientController,
      TextEditingController amountController) {
        print("Adding new step");
        
        ingredientController.clear();
        amountController.clear();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('To Do List'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return const Text("hello");
          }
          ).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    print("thing happened");
                    return StepDialog(onStepAdded: _handleNewStep);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Recipe Recorder',
    home: RecipeList(),
  ));
}
