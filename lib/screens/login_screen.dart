import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/models/user_model.dart';
import 'package:flash_chat/screens/chat_screens.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String route = 'LoginScreen';
  const LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isClicked
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    child: Hero(
                        tag: 'logo', child: Image.asset('assets/logo.png')),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                      log(password);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                      log(password);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your password.',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Material(
                      color: Colors.lightBlueAccent,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30.0)),
                      elevation: 5.0,
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            isClicked = true;
                          });
                          if (email.isNotEmpty && password.isNotEmpty) {
                            await _login(email, password);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        child: const Text(
                          'Log In',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _login(String emailAddress, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      log('userCredential ==> $userCredential');
      await getUser(userCredential.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    } catch (e) {
      log(e);
      throw Exception(e);
    }
  }

  Future<void> getUser(String userId) async {
    final response =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userModel = UserModel.fromJson(response.data());
    setState(() {
      isClicked = false;
    });
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ChatScreen(
                  userModel: userModel,
                ))));
  }
}
