import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('About The App'),
      ),
      body: ListView(
        padding:const EdgeInsets.symmetric(horizontal: 10),
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       const SizedBox(
          height: 200,
          width: 200,
          child:  Image(image: AssetImage("assets/icon.jpg"))),
        text('App Name : Funny Maze Puzzles'),
        text('App Version : 1.0'),
        text('Developer: Youssef Ben Attar'),
        text('youssefdisvitas@gmail.com'),
        //text("It also allows users to draw over templates."),
        text('© 2024 Youssef Ben Attar. All rights reserved.'),
      ],)
    );
  }
Text text(String text){
  return Text(text,style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold));
}

}