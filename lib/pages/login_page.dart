import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                color: Theme.of(context).colorScheme.primary,
                size: 92,
              ),

              SizedBox(height: 24),

              Text(
                "Welcome back, You've been missed!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),

              SizedBox(height: 48),

              MyTextField(text: "E-mail", obscure: false),

              SizedBox(height: 12),

              MyTextField(text: "Password", obscure: true),

              SizedBox(height: 24),

              MyButton(onTap: () {}, isLoading: false, title: "Sign In"),
            ],
          ),
        ),
      ),
    );
  }
}
