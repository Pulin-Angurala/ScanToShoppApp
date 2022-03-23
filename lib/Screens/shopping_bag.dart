import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:myapp/Models/product.dart';
import 'package:myapp/Screens/add_to_bag.dart';

StreamController<Product> streamController = StreamController();

class ShoppingBag extends StatefulWidget {
  static List<Product> addedProducts  = [];
  static double bagTotal = 0;

  static dynamic scannedProduct = Product(
      name: '',
      price: 0,
      imageURL: '',
      product_ID: ''
  );


  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  String data = '';

  Future<void> _scan() async{
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      if (!mounted) return;

      setState(() {
        data = barcode;
        findProduct(data.trim());
      });

    } on PlatformException {
      data = 'Failed to get platform version.';
    }
  }

  findProduct(String value) async {
    final CollectionReference productCollection =
    FirebaseFirestore.instance.collection('Products');

    try{
      await productCollection.get().then((querySnapshot) async {
        for (var element in querySnapshot.docs) {
          if (element.id == value) {
            Product product = Product(name: element['name'],
                price: element['price'], imageURL: element['img'],
                product_ID: element['product_id']);

            // print("\n\n\n\n\n"+product.product_ID+" "+product.name+""
            //     " "+product.price.toString()+" "+product.imageURL);


            ShoppingBag.scannedProduct = product;

            double total =  await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToBag(),
                )
            );


            setState(() {
              ShoppingBag.bagTotal = total;
            });
          }
        }
      });
    }
    catch(e){
      print(e);
    }
  }

  void updateBag(Product addedItem){
    setState(() {
      ShoppingBag.addedProducts.remove(
          ShoppingBag.addedProducts[ShoppingBag.addedProducts.length-1]);
      ShoppingBag.addedProducts.add(addedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('Shopping Bag'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Scrollbar(
              thickness: 10,
              radius: const Radius.circular(20),
              child:ListView.separated(
                itemBuilder: (context, index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(ShoppingBag.addedProducts[index].imageURL),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(ShoppingBag.addedProducts[index].name) ,
                    trailing: Text("\$"+bagTotalString(ShoppingBag.addedProducts[index].price),
                      style: const TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20
                      ),),
                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 30, 10),
                  );
                },
                separatorBuilder: (context, index){
                  return const Divider( indent: 30,
                    endIndent: 30,);
                },
                itemCount: ShoppingBag.addedProducts.length,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: ListTile(
                leading: const Text('Total',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                trailing: Text('\$'+bagTotalString(ShoppingBag.bagTotal),
                  style: const TextStyle(
                    fontSize: 25,),
                )
            ),
          ),
          const Divider(
            indent: 40,
            endIndent: 40,
          ),
          const SizedBox(height:40),
          Container(
            padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        _scan();
                      },
                      child: const Text('Scan'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var request = BraintreeDropInRequest(
                          tokenizationKey: 'sandbox_w369vjkv_prsgpbbszwrjdjcd',
                          collectDeviceData: true,
                          paypalRequest: BraintreePayPalRequest(
                              amount: ShoppingBag.bagTotal.toString(),
                              displayName: 'Scan to Shop'
                          ),
                          cardEnabled: true,
                        );

                        BraintreeDropInResult? result = await BraintreeDropIn.start(request);

                        if (result != null){
                          print(result.paymentMethodNonce.description);
                          print(result.paymentMethodNonce.nonce);
                          ShoppingBag.bagTotal = 0;
                          ShoppingBag.addedProducts.clear();
                        }
                      },
                      child: const Text('Checkout'),
                    ),
                  ),
                ]
            ),
          ),
        ],
      )
    );
  }

  String bagTotalString(double bagTotal){
    if (bagTotal < 10){
      return bagTotal.toStringAsPrecision(3);
    }
    else{
      return bagTotal.toStringAsPrecision(4);
    }
  }
}
