import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class APIs {
  static final CollectionReference _productss =
      FirebaseFirestore.instance.collection('usersCollection');

  static Future<void> createOrUpdate(Map<String, dynamic> map) async {
    try {
      await _productss.add(map);
    } catch (e) {
      debugPrint('e = $e');
    }
  }

  static Future<void> update(String id, Map<String, dynamic> map) async {
    try {
      await _productss.doc(id).set(map);
    } catch (e) {
      debugPrint('update = $e');
    }
  }

  // Deleteing a product by id
  static Future<void> deleteProduct(String productId) async {
    // _productss = FirebaseFirestore.instance.collection('usersCollection');
    await _productss
        .doc('id')
        .collection('usersCollection')
        .doc(productId)
        .delete();
  }
}
