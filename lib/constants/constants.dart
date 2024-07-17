

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;



Color backgroundColor = Color(0xFFF5F9FD);

Color primaryColor = Color(0xff0C54BE);



const kTextFieldDecoration = InputDecoration(
                hintText: '',
                filled: true,
                fillColor: Colors.white,
                hintStyle: TextStyle(color: Colors.black87),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent,),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 158, 190, 245), width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              );
