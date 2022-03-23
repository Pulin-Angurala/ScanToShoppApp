import 'package:cloud_firestore/cloud_firestore.dart';

class ProductDatabaseService{
  String product_id = '';

  ProductDatabaseService(this.product_id);

  final CollectionReference productCollection = FirebaseFirestore.instance.collection('Products');

  void addProduct(String name, double price, String img, String product_id) async {
    if (this.product_id != '') {
      return await productCollection.doc(product_id).set({
        'name': name,
        'price': price,
        'img': img,
        'product_id': product_id,
      });
    }
  }

  Stream<QuerySnapshot> get productDetails {
    return productCollection.snapshots();
  }
}