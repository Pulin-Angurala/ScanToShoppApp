import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Models/product.dart';
import 'package:myapp/Screens/shopping_bag.dart';

class AddToBag extends StatefulWidget {

@override
  _AddToBagState createState() => _AddToBagState();
}

class _AddToBagState extends State<AddToBag> {
  Product p = ShoppingBag.scannedProduct;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(p.name),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 50,
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
          padding: const EdgeInsets.only(top: 50, left: 50, right: 50.0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(p.imageURL),
                backgroundColor: Colors.white,
              ),
              Text("\$"+p.price.toString(),
                style: const TextStyle(
                fontSize: 50,
                  height: 4,
                  color: Colors.green
              ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              ElevatedButton(onPressed: (){
                setState(() {
                  ShoppingBag.bagTotal += p.price;
                  ShoppingBag.addedProducts.add(p);
                  Navigator.pop(context, ShoppingBag.bagTotal);
                });
              },
                child: const Text('Add to bag'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightGreen,
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              },
                child: const Text('Cancel Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
