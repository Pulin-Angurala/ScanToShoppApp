import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Models/app_user.dart';
import 'package:myapp/Screens/add_to_bag.dart';
import 'package:myapp/Screens/login.dart';
import 'package:myapp/Screens/settings.dart';
import 'package:myapp/Screens/shopping_bag.dart';
import 'package:myapp/Screens/sign_up.dart';
import 'package:myapp/Services/user_authorisation.dart';
import 'package:provider/provider.dart';
import 'Screens/home.dart';
import 'Screens/receipts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'balsamiq'),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('You have an error! ${snapshot.error.toString()}');
            return const Text('Something went wrong');
          }
          else if (snapshot.hasData) {
            return StreamProvider<AppUser?>.value(
              initialData: null,
                value: UserAuthorisation().user,
                child: const LoginScreen()
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      routes: {
        '/home': (context) => const Home(),
        '/sign_up': (context) => const SignUp(),
        '/login': (context) => const LoginScreen(),
        '/shopping_bag': (context) => ShoppingBag(),
        '/add_to_bag': (context) =>  AddToBag(),
        '/receipts' : (context) => const Receipts(),
        '/settings': (context) => Settings(),
      }
      );
    }
}