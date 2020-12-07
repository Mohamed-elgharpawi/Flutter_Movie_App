import 'package:flutter/material.dart';
import 'package:lab3/data_access_layer/network_client.dart';
import 'package:lab3/screens/movie_page.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

home: MoviePage()
    );
  }
}
