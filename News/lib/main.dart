import 'package:daily_news/controller/custom_page_transition_builder.dart';
import 'package:daily_news/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xff171717),
        ),
        fontFamily: 'OpenSans',
        primaryColor: Color(0xff171717),
        canvasColor: Color(0xff171717),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomPageTransitionBuilder(),
          },
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: 'Neuton',
          ),
          subtitle1: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          caption: TextStyle(
            color: Colors.white.withAlpha(180),
          ),
        ),
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? HomePage()
          : LoginScreen(),
    );
  }
}
