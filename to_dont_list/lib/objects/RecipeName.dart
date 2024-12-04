
import 'package:to_dont_list/objects/step.dart';

class RecipeName {
  RecipeName({required this.name});
  final String name;
  final List<RecipeStep> steps = [
    const InstructionStep(instruction: "Preheat Oven")
  ];
}