// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  ContactUsPage({super.key});

  void _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'youssefdisvitas@gmail.com', // Enter your email address here
      queryParameters: {
        'subject': 'Message from ${_nameController.text} (${_emailController.text})',
        'body': _messageController.text,
      },
    );

    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      // Handle error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Could not launch email application.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration:const InputDecoration(labelText: 'Name',labelStyle: TextStyle(fontSize: 25)),
            ),
           const SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration:const InputDecoration(labelText: 'Email',labelStyle: TextStyle(fontSize: 25)),
            ),
          const  SizedBox(height: 8.0),
            TextField(
              controller: _messageController,
              decoration:const InputDecoration(labelText: 'Message',labelStyle: TextStyle(fontSize: 25)),
              maxLines: 5,
            ),
          const  SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:const EdgeInsets.symmetric(horizontal:15,vertical: 15)),
              onPressed: () {
                _sendEmail(context);
              },
              child:const Text('Send Email',style: TextStyle(fontSize: 25,color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}