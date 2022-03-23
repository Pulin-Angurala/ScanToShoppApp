import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Receipts extends StatefulWidget {
  const Receipts({Key? key}) : super(key: key);

  @override
  _ReceiptsState createState() => _ReceiptsState();
}

class _ReceiptsState extends State<Receipts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Receipts'),
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
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          children: const [
            CupertinoSearchTextField(),
          ],
        ),
      )
    );
  }
}