import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'approuter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: ".env",
  ); // contains SUPABASE_URL and SUPABASE_ANON_KEY

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      routerConfig: router,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();

//     client.auth.onAuthStateChange.listen((data) {
//       setState(() {
//         _userId = data.session?.user.id;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.primary,

//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(_userId ?? 'Not signed in'),
//             ElevatedButton(
//               onPressed: () async {
//                 final webClientId = dotenv.env['CLIENT_ID']!;

//                 final GoogleSignIn signIn = GoogleSignIn.instance;

//                 // At the start of your app, initialize the GoogleSignIn instance
//                 unawaited(
//                   signIn.initialize(
//                     serverClientId: webClientId,
//                   ),
//                 );

//                 // Perform the sign in
//                 final googleAccount = await signIn.authenticate();
//                 final googleAuthorization = await googleAccount
//                     .authorizationClient
//                     .authorizationForScopes(['email', 'profile']);
//                 final googleAuthentication = googleAccount.authentication;
//                 final idToken = googleAuthentication.idToken;
//                 final accessToken = googleAuthorization?.accessToken;

//                 if (idToken == null) {
//                   throw 'No ID Token found.';
//                 }

//               client.auth.signInWithIdToken(
//                   provider: OAuthProvider.google,
//                   idToken: idToken,
//                   accessToken: accessToken,
//                 );
//               },
//               child: Text('Sign in with Google'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
