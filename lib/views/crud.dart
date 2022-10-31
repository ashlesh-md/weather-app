import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

main() => runApp(Crud());

class Crud extends StatefulWidget {
  const Crud({Key? key}) : super(key: key);

  @override
  _CrudState createState() => _CrudState();
}

class _CrudState extends State<Crud> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: GestureDetector(
          child: Text('Press'),
          onTap: () {
            createUser(name: 'abc');
          },
        ),
      )),
    );
  }

  Future createUser({required String name}) async {
    final docuser = FirebaseFirestore.instance.collection('users').doc();
    final jsom = {'name': name, 'age': 21, 'birthday': 30};
    await docuser.set(jsom);
  }
}
