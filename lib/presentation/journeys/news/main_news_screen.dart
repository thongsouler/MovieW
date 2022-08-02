import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/news/news_screen.dart';

class MainNewsScreen extends StatefulWidget {
  const MainNewsScreen({ Key? key }) : super(key: key);

  @override
  State<MainNewsScreen> createState() => _MainNewsScreenState();
}

class _MainNewsScreenState extends State<MainNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Entertainment News"),),
      body: SafeArea(child: Entertainment(post: fetchPostEntertainment())),
      
    );
  }
}