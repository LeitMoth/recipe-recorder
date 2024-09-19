// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/step.dart';
import 'package:to_dont_list/widgets/step_dialog.dart';
import 'package:to_dont_list/widgets/step_widget.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  final List<RecipeStep> steps = [
    const InstructionStep(instruction: "Preheat Oven")
  ];
  int stepsDone = -1;

  void _handleDeleteStep(RecipeStep step) {
    setState(() {
      steps.remove(step);
    });
  }

  void _handleProgressChange(RecipeStep step, bool completed) {
    setState(() {
      int idx = steps.indexOf(step);
      if (idx < 0 || idx == stepsDone) {
        stepsDone = -1;
      } else {
        stepsDone = idx;
      }
    });
  }

  void _handleNewStep(
      String ingredient,
      String amount,
      TextEditingController ingredientController,
      TextEditingController amountController) {
    setState(() {
      if (amount.isNotEmpty) {
        steps.add(IngredientStep(name: ingredient, amount: amount));
      } else {
        steps.add(InstructionStep(instruction: ingredient));
      }

      ingredientController.clear();
      amountController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetSteps = [];
    for (int i = 0; i < steps.length; ++i) {
      widgetSteps.add(RecipeStepWidget(
          step: steps[i],
          completed: i <= stepsDone,
          onProgressChanged: _handleProgressChange,
          onDeleteStep: _handleDeleteStep));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Recipe Recorder'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: widgetSteps,
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return StepDialog(onStepAdded: _handleNewStep);
                  });
            }));
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Recipe Recorder',
    theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
    home: const RecipeList(),
  ));
}
