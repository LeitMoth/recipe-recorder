import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/step.dart';

typedef StepProgressCallback = Function(RecipeStep step, bool completed);
typedef StepRemovedCallback = Function(RecipeStep step);

class RecipeStepWidget extends StatelessWidget {
  RecipeStepWidget(
      {required this.step,
      required this.completed,
      required this.onProgressChanged,
      required this.onDeleteStep})
      : super(key: ObjectKey(step));

  final RecipeStep step;
  final bool completed;

  final StepProgressCallback onProgressChanged;
  final StepRemovedCallback onDeleteStep;

  TextStyle? _getTextStyle(BuildContext context) {
    if (!completed) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  TextStyle? _getAmountTextStyle(BuildContext context) {
    if (!completed) {
      return const TextStyle(fontWeight: FontWeight.w700);
    }

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    onTap() {
      onProgressChanged(step, completed);
    }

    onLongPress() {
      onDeleteStep(step);
    }

    return switch (step) {
      IngredientStep(name: String name, amount: String amount) => ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          leading: Text(amount, style: _getAmountTextStyle(context)),
          title: Text(
            name,
            style: _getTextStyle(context),
          ),
        ),
      InstructionStep(instruction: String instruction) => ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          title: Text(
            instruction,
            style: _getTextStyle(context),
          ),
        )
    };
  }
}
