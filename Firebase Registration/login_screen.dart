import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  // Function to log in the user
  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Log in the user with Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to home screen after successful login
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle login error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView( // Make the page scrollable
        child: Center( // Center horizontally
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 16.0), // Adjusted padding for centering
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Align the elements to the top
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Centered Login title
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 40.0), // Space between title and email input

                // Email input field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.0),

                // Password input field
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),

                // Forgot password text button
                TextButton(
                  onPressed: () {
                    // Handle forgot password functionality here
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),

                SizedBox(height: 20.0),

                // Login button (wide and blue)
                _isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity, // Makes the button as wide as the container
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Blue color for the button
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text('Login', style: TextStyle(color: Colors.white)),
                  ),
                ),

                SizedBox(height: 15.0),

                // Create new user button (wide and orange)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Orange color for the button
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text('Create new user', style: TextStyle(color: Colors.white)),
                  ),
                ),

                SizedBox(height: 15.0),

                // Continue as guest button (wide and grey)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle guest login here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey, // Grey color for the button
                      padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: Text('Continue as guest', style: TextStyle(color: Colors.white)),
                  ),
                ),

                // Display the pencil image below the form
                SizedBox(height: 30.0),
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2k7cVBHp15DrnXV6eRKnF1p3AFwnENFGzJpS7ShS30qbBKDyJ',
                  height: 150.0, // Adjust the height as needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
