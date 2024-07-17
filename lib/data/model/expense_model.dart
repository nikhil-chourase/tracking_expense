// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {


  @HiveField(0)
  double amount;

   @HiveField(1)
  DateTime date;
  

  @HiveField(2)
  String description;

  @HiveField(3)
  String? type;




  ExpenseModel({
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
  });
    
}
