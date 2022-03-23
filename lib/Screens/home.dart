import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontFamily: 'Gluten',
        ),
        actions: [
          TextButton.icon(
          icon: const Icon(Icons.account_circle_outlined),
          onPressed: () async {
            Navigator.pushNamed(context, '/settings');
          },
          label: const Text('')
          ),
        ],
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 56),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.add_shopping_cart, size: 30,),
              onPressed: () {
                Navigator.pushNamed(context, '/shopping_bag');
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                  fixedSize: const Size(250, 100)
              ), label: const Text('Scan to Shop',
              style: TextStyle(
                fontSize: 30,
              )
            ),
            ),
           const SizedBox(height: 50),
           ElevatedButton.icon(
              icon: const Icon(Icons.receipt, size: 30,),
              onPressed: () {
                Navigator.pushNamed(context, '/receipts');
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                fixedSize: const Size(250, 100)
              ),
             label: const Text('Receipts',
               style: TextStyle(
                 fontSize: 30,
               ),
             ),
            ),
          ],
        ),
      ),
    );
  }
}
