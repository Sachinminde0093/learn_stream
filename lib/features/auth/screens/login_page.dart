import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _numberControler;
  late TextEditingController _otpController;
  late FirebaseAuth auth;
  String verification = '';

  @override
  void initState() {
    super.initState();

    _numberControler = TextEditingController();
    _otpController = TextEditingController();
    auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 450,
              color: Colors.teal[400],

              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child:Column(

                  children: [
                    const Text("Enter your number"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _numberControler,

                      decoration: const InputDecoration(constraints: BoxConstraints(),border:OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(),
                          hintText: "Enter Number With Country Code"
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await auth.verifyPhoneNumber(
                                phoneNumber: "+91${_numberControler.text}",
                                verificationCompleted:
                                    (PhoneAuthCredential phoneAuthCredential) async {
                                  await auth
                                      .signInWithCredential(phoneAuthCredential);
                                },
                                verificationFailed: (error) {
                                  throw Exception(error.message);
                                },
                                codeSent: (verificationId, forceResendingToken) {
                                  verification = verificationId;

                                },
                                codeAutoRetrievalTimeout: (verificationId) {});
                          } on FirebaseAuthException catch(e){
                            debugPrint(e.toString());
                          }
                        },
                        child: const Text("Get Otp")),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Enter Otp"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: _otpController,
                      decoration: const InputDecoration(constraints: BoxConstraints(),border:OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(),
                        hintText: "Enter Your Otp Here...",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {

                          try {
                            PhoneAuthCredential creds = PhoneAuthProvider.credential(
                                verificationId: verification,
                                smsCode: _otpController.text);

                            User? user =
                                (await auth.signInWithCredential(creds)).user;
                            debugPrint(user.toString());

                          } on FirebaseAuthException catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        child: const Text("Login"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
