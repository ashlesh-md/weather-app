import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/controllers/firebase_controller.dart';
import 'package:get/get.dart';

FirebaseController firebaseController = Get.put(FirebaseController());
Future createData() async {
  final docData =
      FirebaseFirestore.instance.collection('data').doc(firebaseController.id);
  final jsonData = {
    'favourites': [],
    'recent_search': [],
  };
  await docData.set(jsonData);
}

Future addDataToFavourite({required String data}) async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({
    'favourites': FieldValue.arrayUnion([data])
  });
}

Future removeDataToFavourite({required String data}) async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({
    'favourites': FieldValue.arrayRemove([data])
  });
}

Future addDataToRecentSearch({required String data}) async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({
    'recent_search': FieldValue.arrayUnion([data])
  });
}

Future removeDataToRecentSearch({required String data}) async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({
    'recent_search': FieldValue.arrayRemove([data])
  });
}

Future clearFavourite() async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({'favourites': []});
}

Future clearRecentSearch() async {
  DocumentReference docData = await FirebaseFirestore.instance
      .collection('data')
      .doc(firebaseController.id);
  DocumentSnapshot doc = await docData.get();
  docData.update({'recent_search': []});
}
