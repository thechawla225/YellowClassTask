import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'MovieModel.dart';
import 'Screens/HomePage.dart';
import 'Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ankit_chawla/Providers/GoogleSignInProvider.dart';
import 'package:ankit_chawla/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ankit_chawla/MovieModel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('movies');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<GoogleSignInProvider>(context);
            if (provider.isSigningIn) {
              return showLoading();
            } else if (snapshot.hasData) {
              return MyHomePage();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

Widget showLoading() => Container(
      color: Colors.red,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          )),
        ],
      ),
    );
