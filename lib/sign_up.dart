import 'package:ecomatesg/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'FirebaseHelper/firestore.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  Future<void> _register(BuildContext context) async {
      // Implement your sign-up logic here
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      // Add your sign-up functionality
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        );

        if (context.mounted) {
          FirestoreCollectionHelper.addUser(name);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(currPoints: 0.0, name: name)),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _errorMessage = 'The password is too weak';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _errorMessage = 'The account already exists for that email';
          });
        } else {
          setState(() {
            _errorMessage = 'Name, email or password cannot be empty';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'Error signing up: $e';
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.teaGreen,
      appBar: AppBar(
        backgroundColor: App.cornsilk,
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'EcoMateSG',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Robotos',
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _register(context);
              },
              style: ElevatedButton.styleFrom(
                primary: App.papayaWhip,
              ),
              child: const Text('Sign Up'),
            ),
            SizedBox(height: 16.0),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous page (login page)
              },
              child: const Text('Already have an account? Sign In'),
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
