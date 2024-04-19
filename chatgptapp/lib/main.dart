//ignorances
// ignore_for_file: unused_import 
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_typing_uninitialized_variables
// ignore_for_file: unused_local_variable
// ignore_for_file: avoid_print
// ignore_for_file:
// ignore_for_file:


//imports
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//api key
const apiKey =  "sk-proj-zCUKD1xSoAnBfSy0eK0xT3BlbkFJInYYJYu7QlwVutvGS3ZN";

void main() {
  runApp(MaterialApp(home: ChatScreen(),));
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({
    required this.text,
    required this.isUser
  });
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatSceeenState();
}

class _ChatSceeenState extends State<ChatScreen> {

  var url = 'https://api.openai.com/v1/engines/davinci-codex/complet';

  TextEditingController messageController = TextEditingController();
  List<ChatMessage> chatMessages = [];

  void sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'prompt' : message,
        'max_tokens' : 50,
      }),
    );

    //if true
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      setState(() {
        chatMessages.add(ChatMessage(text: message, isUser: true));
        chatMessages.add(ChatMessage(
          text: jsonResponse['choices'][0]['text'],
          isUser: false,
        ));
      });
    } 
    //else
    else {
      print("Request Error");  
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ChatGPT App",
        ),
      ),
    );
  }
}
