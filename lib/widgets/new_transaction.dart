import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransacton extends StatefulWidget {
  final Function addNewTransaction;
  NewTransacton(this.addNewTransaction);

  // When
  @override
  State<NewTransacton> createState() => _NewTransactonState();
}
class _NewTransactonState extends State<NewTransacton> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((PickedData) {
      if (PickedData == null) {
        return;
      } else {
        setState(() {
          _selectedDate = PickedData;
        });
      }
    });
  }

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate ==null) {
      return;
    }
    widget.addNewTransaction(enteredTitle, enteredAmount,_selectedDate);

    //context here is a special property which is  available in state class in above(12)
    Navigator.pop(context); // or Navigator.of(context).pop();
  }

  // Class element implement BuildContext class and Widget class has Element CreateElement();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              // onChanged: (value) => titleInput = value,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number, // type of the input
              onSubmitted: ((_) => _submitData()),
              // onChanged: (value) => amountInput = value,
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : (' Date Pick: ${DateFormat.yMd().format(_selectedDate!)}'
                            as String))),
                FlatButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).colorScheme.primary,
                )
              ]),
            ),
            ElevatedButton(
              // Here is a way to assign the function with arguments into onPress by using function is nested  inside anonymous function
              onPressed: _submitData,
              child: Text("Add Transaction"),
              //todo: Like internal and external style in CSS , when i use directly the style into the ElevatedButton it will have a higher priority than elevatedButtonTheme
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
