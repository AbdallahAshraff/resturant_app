import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const primary = Color(0xFFFF7D31);
const shadowColor = Colors.black87;
const cardColor = Color(0xFFEDF0F3);
const supabaseUrl = 'https://cjiwdpndthsygmlqpobl.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNqaXdkcG5kdGhzeWdtbHFwb2JsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0ODU5NzAsImV4cCI6MjA0NDA2MTk3MH0.P6JvRmFVnDKXx0UbUTPKB4nVkcLGlWV-JN1jo7aTvvg';
final supabase = Supabase.instance.client;