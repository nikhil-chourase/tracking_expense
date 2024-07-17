

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tracking_expense/data/boxes/boxes.dart';
import 'package:tracking_expense/data/model/expense_model.dart';
import 'package:tracking_expense/presentation/widgets/section_tile.dart';


class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,

        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Expense Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ValueListenableBuilder<Box<ExpenseModel>>(
                  valueListenable: Boxes.getData().listenable(),
                  builder: (context, box, _) {
                    var data = box.values.toList().cast<ExpenseModel>();

                    // Group by type and calculate totals
                    Map<String, double> weeklySummary = {};
                    Map<String, double> monthlySummary = {};
                    DateTime now = DateTime.now();
                    DateTime weekAgo = now.subtract(Duration(days: 7));
                    DateTime monthAgo = DateTime(now.year, now.month - 1, now.day);

                    for (var expense in data) {
                      if (expense.date.isAfter(weekAgo)) {
                        weeklySummary.update(expense.type!, (value) => value + expense.amount,
                            ifAbsent: () => expense.amount);
                      }
                      if (expense.date.isAfter(monthAgo)) {
                        monthlySummary.update(expense.type!, (value) => value + expense.amount,
                            ifAbsent: () => expense.amount);
                      }
                    }

                    return ListView(
                      children: [
                        SectionTitle(title: 'Weekly Summary'),
                        ...weeklySummary.entries.map((entry) => ListTile(
                              leading: Icon(Icons.currency_rupee_sharp),
                              title: Text(entry.key),
                              trailing: Text(
                                entry.value.toStringAsFixed(2),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            )),
                        SizedBox(height: 20),
                        SectionTitle(title: 'Monthly Summary'),
                        ...monthlySummary.entries.map((entry) => ListTile(
                              leading: Icon(Icons.currency_rupee_sharp),
                              title: Text(entry.key),
                              trailing: Text(
                                entry.value.toStringAsFixed(2),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                              ),
                            )),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

