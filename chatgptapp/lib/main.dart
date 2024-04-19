// ignore_for_file: unused_import, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

//api key
const apiLey =  "sk-proj-zCUKD1xSoAnBfSy0eK0xT3BlbkFJInYYJYu7QlwVutvGS3ZN";

void main() {
  runApp(MaterialApp(home: ChatScreen(),));
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatSceeenState();
}

class _ChatSceeenState extends State<ChatScreen> {
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder(

    );
  }
}
