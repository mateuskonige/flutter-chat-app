import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  final TextEditingController _messageController = TextEditingController();

  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  void sendMessag() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(receiverEmail)));
  }
}
