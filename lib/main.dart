import 'package:flutter/material.dart';
import 'package:product_list_app/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Productos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProductListScreen(),
    );
    // TODO: implement build
  }
}
