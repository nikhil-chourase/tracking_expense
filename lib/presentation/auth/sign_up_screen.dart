
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking_expense/constants/constants.dart';
import 'package:tracking_expense/data/users/user_providers.dart';
import 'package:tracking_expense/presentation/auth/login_screen.dart';



class SignUpScreen extends StatelessWidget {

   SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

 

  final _formKey = GlobalKey<FormState>();

  


  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context,listen: false);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: null,
        title: Text(
          'Expense Tracker',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: size.width/15),
          child: Form(
            key: _formKey,
            child: Column(
                children: [
                  SizedBox(height: size.height/5,),
            
                  TextFormField(
                            
                    controller: _nameController,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Name',
                      // errorText:   nameError ? 'email cannot be empty' : null,
                    ),
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                  
                    
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                   TextFormField(
                             
                     controller: _emailController,
                     decoration: kTextFieldDecoration.copyWith(
                       hintText: 'Email',
                      //  errorText:   emailError ? 'email cannot be empty' : null,
                     ),
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return  'Please enter a valid email';
                        }
                        return null;
                      },
                     
                     style: TextStyle(color: Colors.black),
                   ),
                  const SizedBox(height: 20),
                  TextFormField(
                            
                    controller: _passwordController,
                    obscureText: true,
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Password',
                      // errorText: passwordError ? 'email cannot be empty' : null,
                    ),
                     validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: size.height/4),
                  ElevatedButton(
                    onPressed: () async{
                      // Implement login logic here

                      if(_formKey.currentState!.validate()){
                    

                          bool success = await authService.registerUser(
                            _nameController.text, 
                            _emailController.text, 
                            _passwordController.text
                          );
                          if(success){
            
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User registered successfully')),
                            );
                          }
            
                       
                      }
                        
                    },
                    child: Text('Signup'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      fixedSize: Size(size.width/2, size.height/15),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder( // Rectangle shape
                      borderRadius: BorderRadius.circular(10),
                     ),
                    ),
                  ),
            
                  SizedBox(height: size.height/100),
                  GestureDetector(
                    onTap: () =>  Navigator.of(context).pop(),
                    child: Text.rich(
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Login',
                                    style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize: 14),
                                  ),
                                  
                                ],
                              ),
                            ),
                  ),
            
                ],
              ),
          ),
        ),
      ),
    );
  }
}