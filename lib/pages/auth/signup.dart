import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:livemart/pages/screens/welcome_screen.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<AuthResponse> _handleSignUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
        await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      throw "Sign up failed: $e";
    }

    throw 'Signup Successful';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handleSignUp,
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () async {
                await googleLogin();
              },
              icon: const Icon(Icons.login),
              label: const Text("Sign Up with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
