// import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/pages/welcome_screen.dart';
import 'package:flutter_firestore_example/routes.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:flutter_firestore_example/utils/my_theme.dart';
import 'package:flutter_firestore_example/utils/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MyTheme(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserRepository(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<UserRepository>(context).getUserFromStorage(),
      builder: (context, snapshot) {
        return MaterialApp(
            title: 'One Green',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: Provider.of<MyTheme>(context).currentTheme(),
            initialRoute: "/welcome",
            routes: {
              "/welcome": (BuildContext context) => OnboardingScreen(),
            },
            onGenerateRoute: PageRouter.generateRoute);
      },
    );
  }
}
