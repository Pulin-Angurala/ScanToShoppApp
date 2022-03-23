import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Services/user_authorisation.dart';

class Settings extends StatelessWidget {
  final UserAuthorisation _auth = UserAuthorisation();
  Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
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
      body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          children: [
            Row(
              children: const [
                Icon(Icons.person, color: Colors.blue,),
                SizedBox(width: 10,),
                Text(
                  'Account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 14,
              thickness: 2,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 20,),
                  Text(
                    'Password & Security',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Phone Number',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Payment Method',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Language',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),
                  ),
                ]
            ),
            const SizedBox(height: 30,),
            Row(
              children: const [
                Icon(Icons.volume_up_outlined, color: Colors.lightGreen,),
                SizedBox(width: 10,),
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.lightGreen,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 14,
              thickness: 2,
            ),
            const SizedBox(height: 20,),
            const Text(
              'Sound',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Banners',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Vibration',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              padding: const EdgeInsets.fromLTRB(130, 50, 130, 20),
              child: ElevatedButton(
                onPressed: () {
                  showLogoutAlert(context);
                },
                child: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: const Size(100, 20)
                ),
              ),
            ),
          ]
      ),
    );
  }

  void showLogoutAlert(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Logout'),
      content: const Text('Are you sure?'),
      actions: [
        CupertinoButton(
            child: const Text('Yes'),
            onPressed: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, '/login');
            }
        ),
        CupertinoButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            }
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        }
    );
  }
}
