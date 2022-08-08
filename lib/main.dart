import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screens.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/reqistration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          textTheme:
              const TextTheme(bodyText1: TextStyle(color: Colors.black))),
      initialRoute: const WelcomeScreen().route,
      routes: {
        const WelcomeScreen().route: (context) => const WelcomeScreen(),
        const RegistrationScreen().route: (context) =>
            const RegistrationScreen(),
        const LoginScreen().route: (context) => const LoginScreen(),
        const ChatScreen().route :(context) => const ChatScreen()
      },
    );
  }
}
