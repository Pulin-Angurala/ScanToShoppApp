import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Services/user_authorisation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final UserAuthorisation _auth = UserAuthorisation();
  final _formKey = GlobalKey<FormState>();

  String error = '';
  String fullName = '';
  String email = '';
  String password = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Sign Up'),
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
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your full name': null,
                  onChanged: (val){
                    setState(() => fullName = val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Balsamiq',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  validator: (val) => val!.length < 10 ? 'Enter a phone number of 10 digits': null,
                  onChanged: (val){
                    setState(() => phoneNumber = val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Balsamiq',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your email': null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontFamily: 'Balsamiq',
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 50.0),
                TextFormField(
                  validator: (val) => val!.length < 6 ? 'Enter a password of at least 6 characters': null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Balsamiq',
                    ),
                  ),
                ),
                const SizedBox(height: 70.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      dynamic result = await _auth.signInWithEmailAndPass(email, password);

                      if (result == null){
                        setState(() => error = 'Please supply a valid email');
                      }
                      else{
                        Navigator.pushNamed(context, '/login');
                      }
                    }
                  },
                  child: const Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                  ),
                ),
                const SizedBox(height: 12.0,),
                Text(
                  error,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}