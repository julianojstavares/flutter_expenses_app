import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime?) onSubmit;

  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.00;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(labelText: "Título"),
              controller: _titleController,
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
              controller: _valueController,
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "Sem data"
                        : DateFormat('dd/MM/y').format(_selectedDate!)),
                  ),
                  TextButton(
                    onPressed: _datePicker,
                    child: const Text("Alterar Data"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    "Nova Transação",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
