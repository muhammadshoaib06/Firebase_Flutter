import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication_service.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String n,e,p;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register With Firebase"),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signUp(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                n = nameController.text.toString();
                e = emailController.text.toString();
                p = passwordController.text.toString();
                Navigator.pop(context);
                insertData(n,e,p);
              },
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }



  void insertData(String name, String email, String password) {

    final databaseReference = FirebaseDatabase().reference().child("user");
    databaseReference.child("$name").set({
      'email': '$email',
      'password': '$password'
    });
  }
}
