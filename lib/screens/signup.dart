import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resturant_app/screens/login.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [

              // "Sign Up" Text
              Padding(
                padding: const EdgeInsets.only(top: 42.0, left: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 36.41,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              // Inputs Container
              Padding(
                padding: const EdgeInsets.only(top: 31.0, left: 26.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Full Name Label
                    Text(
                      'Full name',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Full Name Input
                    Container(
                      width: 324.01,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter your full name',
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Email Label
                    Text(
                      'E-mail',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Email Input
                    Container(
                      width: 324.01,
                      height: 50,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),

                    SizedBox(height: 15),

                    // Password Label
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF9796A1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 12),
                    // Password Input
                    Container(
                      width: 324.01,
                      height: 50,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Enter your password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Sign Up Button
              Container(
                width: 248,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFE724C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 28),

              // Already have an account? login Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      // Navigate to login screen
                      Navigator.pop(context);
                    },
                    child: Text(
                      'login',
                      style: TextStyle(
                        color: Color(0xFFFE724C),
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: 28),


            ],
          ),
        ),
      ),
    );
  }
}
