sealed class RecipeStep {
  const RecipeStep();
}

class IngredientStep extends RecipeStep {
  const IngredientStep({required this.name, required this.amount});

  final String name, amount;
}

class InstructionStep extends RecipeStep {
  const InstructionStep({required this.instruction});

  final String instruction;
}
