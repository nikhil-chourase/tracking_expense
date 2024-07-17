import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tracking_expense/data/users/user_providers.dart';
import 'package:tracking_expense/presentation/auth/login_screen.dart';
import 'package:tracking_expense/presentation/providers/expense_provider.dart';
import 'package:tracking_expense/presentation/screens/home/home_screen.dart';
import 'package:tracking_expense/data/model/expense_model.dart';
import 'package:tracking_expense/presentation/notification/notification_service.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(ExpenseModelAdapter());

  await Hive.openBox<ExpenseModel>('expenses');

  await NotificationService().init();

  await Firebase.initializeApp();


  runApp(
    const MyApp(),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
         ChangeNotifierProvider(create: (context) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => AuthService()),

      ],
      child: Consumer<AuthService>(
        builder: (context,authService, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: authService.isUserLoggedIn() ? HomeScreen() : LoginScreen(),
          );
        }
      ),
    );
  }
}





