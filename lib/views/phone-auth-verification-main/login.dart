import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/controllers/firebase_controller.dart';
import 'package:firebase_crud/views/main_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
  static TextEditingController phoneController = TextEditingController();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController otpController = TextEditingController();
  FirebaseController firebaseController = FirebaseController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splash/background_android.png"),
                fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.mobile_friendly_outlined,
              color: Colors.white,
              size: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: LoginScreen.phoneController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.white, fontSize: 22),
                      hintText: 'Phone Number',
                      prefix: Padding(
                        padding: EdgeInsets.all(4),
                        child: Text('+91'),
                      ),
                    ),
                    maxLength: 10,
                    keyboardType: TextInputType.phone,
                  ),
                  Visibility(
                    visible: otpVisibility,
                    child: TextField(
                      controller: otpController,
                      decoration: const InputDecoration(
                        hintText: 'OTP',
                        prefix: Padding(
                          padding: EdgeInsets.all(4),
                          child: Text(''),
                        ),
                      ),
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: 200,
                    color: Colors.purple[400],
                    onPressed: () {
                      if (otpVisibility) {
                        verifyOTP();
                      } else {
                        loginWithPhone();
                      }
                    },
                    child: Text(
                      otpVisibility ? "Verify" : "Login",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91${LoginScreen.phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white.withOpacity(0.5),
            textColor: Colors.deepPurple,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainAppPage(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white.withOpacity(0.5),
            textColor: Colors.deepPurple,
            fontSize: 16.0,
          );
        }
      },
    );
  }
}
