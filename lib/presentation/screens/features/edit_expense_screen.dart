// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tracking_expense/data/model/expense_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class EditExpenseScreen extends StatefulWidget {
  final ExpenseModel expense;

  EditExpenseScreen({
    Key? key,
    required this.expense,
  }) : super(key: key);

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();

}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedType;

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController(text: widget.expense.amount.toString());
    descriptionController = TextEditingController(text: widget.expense.description);
    dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.expense.date));
    selectedType = widget.expense.type;
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,

      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('Edit Expense'),
        backgroundColor: Colors.grey.shade900,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                color: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null) {
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            setState(() {
                              dateController.text = formattedDate;
                            });
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: selectedType,
                        decoration: InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: ['Food', 'Transport', 'Shopping', 'Others']
                            .map((type) => DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedType = value;
                          });
                        },
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          final DateTime parsedDate =
                              DateFormat('yyyy-MM-dd').parse(dateController.text);

                          widget.expense.amount = double.parse(amountController.text);
                          widget.expense.description = descriptionController.text;
                          widget.expense.date = parsedDate;
                          widget.expense.type = selectedType;

                          widget.expense.save();

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
