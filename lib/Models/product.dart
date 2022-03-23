import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/Services/product_database_service.dart';

class Product {
   String name = '';
   double price = 0;
   String imageURL = '';
   String product_ID = '0';

   Product({
     required this.name,
     required this.price,
     required this.imageURL,
     required this.product_ID,
   });
 }

 void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();


   Product product = Product(
     name: 'Apple',
     price: 2.99,
     imageURL: 'https://images.unsplash.com/photo-1619546813926-a78fa6372cd2?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2940&q=80',
     product_ID: '65112112108101',
   );

   Product product1 = Product(
     name: 'Orange',
     price: 4.99,
     imageURL: 'https://media.istockphoto.com/photos/orange-picture-id185284489?k=20&m=185284489&s=612x612&w=0&h=LLY2os0YTG2uAzpBKpQZOAC4DGiXBt1jJrltErTJTKI=',
     product_ID: '7911497110103101',
   );

   Product product2 = Product(
     name: 'Mango',
     price: 6.99,
     imageURL: 'https://media.istockphoto.com/photos/one-mango-with-leaves-isolated-on-a-white-background-picture-id1198706343?k=20&m=1198706343&s=612x612&w=0&h=Og6pKph23_l6NQuOhlV5r2msw3hldvsrEryRNNrOhWE=',
     product_ID: '7797110103111',
   );

   Product product3 = Product(
     name: 'Up & Go',
     price: 5.50,
     imageURL: 'https://d3fa68hw0m2vcc.cloudfront.net/57d/137528819.jpeg',
     product_ID: '851123871111',
   );

   Product product4 = Product(
     name: 'Bread',
     price: 4.50,
     imageURL: 'https://bisspackaging.co.uk/wp-content/uploads/2018/01/17511-packet-bread-glossy_1050x1050.jpg',
     product_ID: '6611410197100',
   );

   Product product5 = Product(
     name: 'Bluebird Twisties',
     price: 1.00,
     imageURL: 'https://static.countdown.co.nz/assets/product-images/zoom/9400566007801.jpg',
     product_ID: '84119105115116105101115',
   );

   Product product6 = Product(
     name: 'Weet-Bix',
     price: 7.00,
     imageURL: 'https://weetbix.co.nz/wp-content/uploads/2018/12/weet-bix-nz.png',
     product_ID: '8710110111666105120',
   );

   ProductDatabaseService productDatabaseService = ProductDatabaseService(product.product_ID);
   productDatabaseService.addProduct(product.name, product.price, product.imageURL, product.product_ID);
   productDatabaseService.addProduct(product1.name, product1.price, product1.imageURL, product1.product_ID);
   productDatabaseService.addProduct(product2.name, product2.price, product2.imageURL, product2.product_ID);
   productDatabaseService.addProduct(product3.name, product3.price, product3.imageURL, product3.product_ID);
   productDatabaseService.addProduct(product4.name, product4.price, product4.imageURL, product4.product_ID);
   productDatabaseService.addProduct(product5.name, product5.price, product5.imageURL, product5.product_ID);
   productDatabaseService.addProduct(product6.name, product6.price, product6.imageURL, product6.product_ID);
 }
