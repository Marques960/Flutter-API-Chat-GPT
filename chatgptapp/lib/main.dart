//ignorances
// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables 
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

  var url = 'https://api.openai.com/v1/chat/completions';


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
      'max_tokens' : 5000,
      'model': 'gpt-3.5-turbo',
    }),
  );

  // Log the response body for debugging
  print('Response status code: ${response.statusCode}');
  print('Response body: ${response.body}');

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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ChatB(
                  text: message.text,
                  isUser: message.isUser,
                );
              } 
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter your message",
                    ),
                  ),
                ),
                IconButton(
                  onPressed:() {
                    sendMessage(messageController.text);
                    messageController.clear();
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ), 
          )
        ],
      ),
    );
  }
}

class ChatB extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatB({
    required this.text,
    required this.isUser,
  });

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if(!isUser) 
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text("AI"),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUser ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text, style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            if (isUser)
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Icon(Icons.person),
            ),
        ],
      ),
    );
  }
}