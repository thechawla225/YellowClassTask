import 'package:flutter/material.dart';
import 'package:ankit_chawla/Providers/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: MediaQuery.of(context).size.height * 0.39),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie_creation_rounded,
                  color: Colors.white,
                  size: 43,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  "Movies",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'ProximaNova',
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
              },
              child: Container(
                height: 50,
                width: 250,
                child: Center(
                    child: Text("Sign in with Google",
                        style: TextStyle(
                          fontFamily: 'ProximaNova',
                          color: Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ))),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            )
          ],
        ),
      )),
    );
  }
}
