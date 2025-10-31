import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final client = Supabase.instance.client;

Future<void> googleLogin() async {
    final webClientId = dotenv.env['CLIENT_ID']!;
    final GoogleSignIn signIn = GoogleSignIn.instance;
    // At the start of your app, initialize the GoogleSignIn instance
    unawaited(
      signIn.initialize(
        serverClientId: webClientId,
      ),
    );
    // Perform the sign in
    final googleAccount = await signIn.authenticate();
    final googleAuthorization = await googleAccount
        .authorizationClient
        .authorizationForScopes(['email', 'profile']);
    final googleAuthentication = googleAccount.authentication;
    final idToken = googleAuthentication.idToken;
    final accessToken = googleAuthorization?.accessToken;
    if (idToken == null) {
      throw 'No ID Token found.';
    }
    client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Live MART",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                onPressed: () => context.push('/login'),
                icon: const Icon(Icons.email),
                label: const Text("Login with Email"),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: googleLogin,
                icon: const Icon(Icons.login),
                label: const Text("Login with Google"),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => context.push('/signup'),
                child: const Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
