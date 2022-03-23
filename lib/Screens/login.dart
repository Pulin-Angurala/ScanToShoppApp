import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Services/user_authorisation.dart';

class LoginScreen  extends StatefulWidget {
  const LoginScreen ({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  //text field state
  final _formKey = GlobalKey<FormState>();
  final UserAuthorisation _auth = UserAuthorisation();

  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SCAN TO SHOP'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontFamily: 'Gluten',
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your email': null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.lightGreen,
                      fontFamily: 'Balsamiq',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
               TextFormField(
                 validator: (val) => val!.length < 6 ? 'Enter a password of at least 6 characters': null,
                 onChanged: (val){
                   setState(() => password = val);
                 },
                 obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Balsamiq',
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      dynamic result = await _auth.logInWithEmailAndPass(email, password);

                      if (result == null){
                        setState(() => error = 'Failed to sign in');
                      }
                      else{
                        Navigator.pushNamed(context, '/home');
                      }
                    }// Navigator.pushNamed(context, '/home_menu');
                  },
                ),
                Text(
                  error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                  child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}