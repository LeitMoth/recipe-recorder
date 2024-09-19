import 'package:flutter/material.dart';

typedef StepAddedCallback = Function(
    String ingredient,
    String amount,
    TextEditingController ingredientController,
    TextEditingController amountController);

class StepDialog extends StatelessWidget {
  StepDialog({super.key, required this.onStepAdded});

  final StepAddedCallback onStepAdded;

  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Ingredient/Instruction'),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(
          key: const Key("IngredientField"),
          controller: _ingredientController,
          decoration: const InputDecoration(hintText: "Ingredient name or instruction"),
        ),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(hintText: "Amount (leave blank for instruction)"),
        )
      ]),
      actions: <Widget>[
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        // https://api.flutter.dev/flutter/widgets/ListenableBuilder-class.html
        ListenableBuilder(
          // https://api.flutter.dev/flutter/foundation/Listenable/Listenable.merge.html
          listenable:
              Listenable.merge([_ingredientController, _amountController]),
          builder: (BuildContext context, Widget? child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: _ingredientController.text.isNotEmpty
                  ? () {
                      onStepAdded(
                          _ingredientController.text,
                          _amountController.text,
                          _ingredientController,
                          _amountController);
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),

        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
