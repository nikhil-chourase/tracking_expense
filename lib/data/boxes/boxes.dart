


import 'package:hive/hive.dart';
import 'package:tracking_expense/data/model/expense_model.dart';

class Boxes{

  static Box<ExpenseModel> getData() => Hive.box<ExpenseModel>('expenses');

}

