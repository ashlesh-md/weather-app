import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/controllers/firebase_controller.dart';
import 'package:firebase_crud/firebase/crud.dart';
import 'package:firebase_crud/views/main_page.dart';
import 'package:firebase_crud/views/phone-auth-verification-main/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(myApp());
}

class myApp extends StatelessWidget {
  FirebaseController firebaseController = Get.put(FirebaseController());

  myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          scaffoldBackgroundColor: Colors.transparent),
      home: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/splash/background_android.png"),
          fit: BoxFit.cover,
        )),
        child: AnimatedSplashScreen(
          splash: 'assets/splash/logo_splash.png',
          splashIconSize: 250,
          backgroundColor: Colors.transparent,
          nextScreen: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (FirebaseFirestore.instance.collection('data').doc(
                          FirebaseAuth.instance.currentUser!.phoneNumber
                              .toString()) ==
                      firebaseController.id) {
                    createData();
                  }

                  return MainAppPage();
                } else {
                  return LoginScreen();
                }
              }),
          splashTransition: SplashTransition.scaleTransition,
          duration: 5000,
        ),
      ),
    );
  }
}
