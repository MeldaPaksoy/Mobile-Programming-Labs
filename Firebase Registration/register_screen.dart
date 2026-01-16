import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  bool _isLoading = false;

  // Function to register a new user
  void _register() async {
    // Start loading indicator
    setState(() {
      _isLoading = true;
    });

    // Check if passwords match
    if (_passwordController.text.isEmpty || _usernameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all the fields!')));
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Register user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Set the username in displayName
        await user.updateProfile(displayName: _usernameController.text);
      }

      // Navigate to home screen after successful registration
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Handle registration error (e.g., email already in use)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
    } finally {
      // Stop loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView( // Add this widget to make the screen scrollable
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Centered Register title
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Register',
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
            SizedBox(height: 16.0),

            // Confirm Password input field
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            // Username input field
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),

            // Register button (blue and wide)
            _isLoading
                ? CircularProgressIndicator()
                : SizedBox(
              width: double.infinity, // Makes the button as wide as the container
              child: ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Blue color for the button
                  padding: EdgeInsets.symmetric(vertical: 16.0), // Adjust padding
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Register', style: TextStyle(color: Colors.white)),
              ),
            ),

            // Navigate to login page if user already has an account
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text('Already have an account? Login'),
            ),

            // Display the pencil image below the form
            SizedBox(height: 20.0),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2k7cVBHp15DrnXV6eRKnF1p3AFwnENFGzJpS7ShS30qbBKDyJ',
              height: 150.0, // Adjust the height as needed
            ),
          ],
        ),
      ),
    );
  }
}
