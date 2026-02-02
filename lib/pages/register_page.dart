import 'package:chat_app/components/dark_mode_switcher.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final AuthService _authService = AuthService();

  String _errorMessage = "";
  bool _isLoading = false;

  Future<void> signUserUp() async {
    if (_isLoading) return;

    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (_passwordController.text != _passwordConfirmationController.text) {
      setState(() {
        _errorMessage = "Passwords don't match.";
        _isLoading = false;
      });
      return;
    }

    try {
      await _authService.signUp(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buildRegisterForm(),
            Positioned(right: 12, top: 12, child: DarkModeSwitcher()),
            if (_isLoading)
              Container(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
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
                "Register",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),

              SizedBox(height: 48),

              MyTextField(
                controller: _emailController,
                text: "E-mail",
                obscure: false,
              ),

              SizedBox(height: 12),

              MyTextField(
                controller: _passwordController,
                text: "Password",
                obscure: true,
              ),

              SizedBox(height: 12),

              MyTextField(
                controller: _passwordConfirmationController,
                text: "Confirm Password",
                obscure: true,
              ),

              SizedBox(height: 24),

              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
              MyButton(
                onTap: () => signUserUp(),
                isLoading: _isLoading,
                title: "Sign Up",
              ),

              SizedBox(height: 24),

              Text("Already a member?"),
              GestureDetector(
                onTap: widget.onTap,
                child: Text("Login now!", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
