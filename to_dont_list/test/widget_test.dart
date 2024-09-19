// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/step.dart';
import 'package:to_dont_list/widgets/step_widget.dart';

void main() {
  testWidgets(
      'An ingredient step has a text for the ingredient name, and for the amount',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: RecipeStepWidget(
                step: const IngredientStep(name: "Butter", amount: "5lb"),
                completed: false,
                onProgressChanged: (RecipeStep step, bool completed) {},
                onDeleteStep: (RecipeStep step) {}))));
    final ingredientFinder = find.text('Butter');
    final amountFinder = find.text('5lb');

    expect(ingredientFinder, findsOneWidget);
    expect(amountFinder, findsOneWidget);
  });

  testWidgets('An instruction step has a text for the instruction',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: RecipeStepWidget(
                step: const InstructionStep(instruction: "Preheat"),
                completed: false,
                onProgressChanged: (RecipeStep step, bool completed) {},
                onDeleteStep: (RecipeStep step) {}))));
    final instructionFinder = find.text('Preheat');

    expect(instructionFinder, findsOneWidget);
  });

  testWidgets('Default RecipeList has one, uncompleted, step', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecipeList()));

    final listItemFinder = find.byType(RecipeStepWidget);

    RecipeStepWidget w = tester.firstWidget(listItemFinder);

    expect(listItemFinder, findsOneWidget);
    expect(w.completed, false);
  });

  // More of an integration test, but still useful
  testWidgets('Clicking and Typing adds step to RecipeList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecipeList()));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byKey(const Key("IngredientField")), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(RecipeStepWidget);

    expect(listItemFinder, findsNWidgets(2));
  });

  testWidgets(
      'Tapping the second step in the recipe also marks the first as completed',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RecipeList()));
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    await tester.enterText(find.byKey(const Key("IngredientField")), 'hi');
    await tester.pump();
    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();

    final listItemFinder = find.byType(RecipeStepWidget);

    await tester.tap(listItemFinder.last);
    await tester.pump();
    RecipeStepWidget w = tester.firstWidget(listItemFinder);

    expect(w.completed, true);
    expect(listItemFinder, findsNWidgets(2));
  });
}
