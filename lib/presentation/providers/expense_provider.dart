
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tracking_expense/data/boxes/boxes.dart';
import 'package:tracking_expense/constants/color.dart';
import 'package:tracking_expense/data/model/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  

  
   void addExpense(ExpenseModel expense) {
    final box = Boxes.getData();
    box.add(expense);
    expense.save();
    notifyListeners();
  }

  void delete(ExpenseModel expenseModel) async{
    await expenseModel.delete();
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }
  
}


