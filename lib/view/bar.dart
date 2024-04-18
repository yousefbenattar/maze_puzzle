import 'dart:io';
import 'package:flutter/material.dart';
import '../services/about.dart';
import '../services/contactus.dart';
class SideBar extends StatefulWidget {
  final String userName;
  final Function(String) onNameUpdated;

  const SideBar({
    super.key,
    required this.userName,
    required this.onNameUpdated,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  void _exitApp(BuildContext context) {
    exit(0); // Exit the app
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[

          ListTile(
            title:const Text('Contact Us',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> ContactUsPage() ));// Call function to exit app
            },
          ),
             ListTile(
            title:const Text('About Us',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (builder)=>const About() ));// Call function to exit app
            },
          ),
            ListTile(
            title:const Text('Logout',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
            onTap: () {
            _exitApp(context); // Call function to exit app
            },
          ),
        ],
      ),
    );
  }
}


