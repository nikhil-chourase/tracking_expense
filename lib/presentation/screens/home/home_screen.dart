
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_expense/data/users/user_providers.dart';
import 'package:tracking_expense/presentation/screens/features/add_expense_screen.dart';
import 'package:tracking_expense/data/boxes/boxes.dart';
import 'package:tracking_expense/presentation/screens/features/edit_expense_screen.dart';
import 'package:tracking_expense/presentation/providers/expense_provider.dart';
import 'package:tracking_expense/data/model/expense_model.dart';
import 'package:tracking_expense/presentation/notification/notification_service.dart';
import 'package:tracking_expense/presentation/screens/features/summary_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   DateTime? _selectedDate;
  bool _sortAscending = true;

  AuthService authService = AuthService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationService().scheduleDailyNotification();
    // NotificationService().scheduleMinuteNotification();
  }

  

  @override
  Widget build(BuildContext context) {

  final provider = Provider.of<ExpenseProvider>(context, listen: false);





    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
      backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SummaryScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _sortAscending ? Icons.arrow_upward : Icons.arrow_downward,
            ),
            onPressed: () {
              setState(() {
                _sortAscending = !_sortAscending;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder<Box<ExpenseModel>>(
          valueListenable: Boxes.getData().listenable(), 
          builder: (context, box, _) { 
        
            var data = box.values.toList().cast<ExpenseModel>();
        
             if (_selectedDate != null) {
              data = data
                  .where((expense) =>
                      DateFormat('yyyy-MM-dd').format(expense.date) ==
                      DateFormat('yyyy-MM-dd').format(_selectedDate!))
                  .toList();
            }
        
            data.sort((a, b) => _sortAscending
                ? a.date.compareTo(b.date)
                : b.date.compareTo(a.date));
        
        
            return ListView.builder(
              itemCount: box.length,
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (Context, index){
                return  Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                  child: Card(
                    color: provider.getRandomColor(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                      
                              SizedBox(
                                width: MediaQuery.of(context).size.width/1.5,
                                child: Text(
                                data[index].description.toString(),
                                maxLines: 2,overflow: TextOverflow.ellipsis,
                               style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  height: 1.5),),
                              ),
                      
                              
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  provider.delete(data[index]);
                  
                                },
                                child: const Icon(Icons.delete ,color: Colors.grey,)),
                  
                              const SizedBox(width: 15,),
                              InkWell(
                                onTap: (){
                                   Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditExpenseScreen(expense: data[index]),
                                    ),
                                  );
                  
                                },
                                child: const Icon(Icons.edit)),
                  
                            ],
                          ),
                      
                          Text(data[index].amount.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                          const SizedBox(height: 5,),
                  
                          Text(DateFormat('yyyy-MM-dd').format(data[index].date), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                  
                        ],
                      ),
                    ),
                  ),
                );
              }
            
            );
           },
        
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

}

