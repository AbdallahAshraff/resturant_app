import 'package:flutter/material.dart';
import 'package:resturant_app/screens/homepage.dart';
import 'package:resturant_app/screens/login.dart';
import 'package:resturant_app/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );
 runApp(const ResturantApp());
}


class ResturantApp extends StatelessWidget {
  const ResturantApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
