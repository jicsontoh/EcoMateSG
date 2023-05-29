import 'package:ecomatesg/main.dart';
import 'package:ecomatesg/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'FirebaseHelper/firestore.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  String _errorMessage = '';

  Future<void> _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Map<String, dynamic>? user = await FirestoreCollectionHelper.getLoggedInUser();

      if (user != null) {
        int currPoints = user["PlasticBagSavings"] + user["TransportSavings"];

        // Authentication successful, navigate to the home page
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(currPoints: currPoints.toDouble(), name: user["Name"])),
          );
        }
      }

    } catch (e) {
      if (e is FirebaseAuthException) {
        final FirebaseAuthException authException = e;
        if (authException.code == 'user-not-found') {
          setState(() {
            _errorMessage = 'No user found for that email';
          });
        } else if (authException.code == 'wrong-password') {
          setState(() {
            _errorMessage = 'Wrong password provided for that user';
          });
        } else if (email == '' || password == '') {
          setState(() {
            _errorMessage = 'Username or password cannot be empty';
          });
        }
        else {
          setState(() {
            _errorMessage = 'Login failed. Error: ${authException.code}';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.teaGreen,
      appBar: AppBar(
        backgroundColor: App.cornsilk,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.energy_savings_leaf,
              color: Colors.black,
              size: deviceWidth(context) * 0.3
            ),
            const Padding(
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
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(
                primary: App.papayaWhip,
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              child: const Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );

  }
}