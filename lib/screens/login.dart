import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturant_app/screens/homepage.dart';
import 'package:resturant_app/screens/signup.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned(
            top: 37,
            left: 27,
            child: IconButton(
              onPressed: () {
                // Handle back button press
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 38,
              padding: EdgeInsets.only(left: 15),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 200), // Adjust spacing as needed
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 36.41,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 31),

                  // Email field
                  Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9796A1),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),

                  // Password field
                  Text(
                    'Password',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9796A1),
                    ),
                  ),
                  SizedBox(height: 12),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
          
                  SizedBox(height: 20),

                  // Log in button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle login
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE724C),
                        fixedSize: Size(248, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Log in',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 28),

                  // Already have an account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ', style: TextStyle(color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          // Handle sign up
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text('Sign Up', style: TextStyle(color: Color(0xFFFE724C))),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Sign in with line
                  Divider(thickness: 1, color: Colors.grey[300]),

                  SizedBox(height: 28),

                  // Social buttons

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

