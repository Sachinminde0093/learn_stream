import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_stream/features/auth/screens/register_page.dart';
import 'package:learn_stream/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../customWidgets/bottom_bar.dart';

class AuthServices {
  late String verificationId;

  late FirebaseAuth auth;

  AuthServices() {
    auth = FirebaseAuth.instance;
  }

  void signIn(BuildContext context, String number) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: "+91$number",
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            // throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
    }
  }

  void verifyOtp(BuildContext context, String otp) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);

      User? user = (await auth.signInWithCredential(creds)).user;
      debugPrint(user.toString());
      debugPrint(user?.email);

      if (user?.email == null) {
        print(user?.uid);
        // ignore: use_build_context_synchronously
        // Provider.of<UserProvider>(context, listen: false)
        //     .setUser(({}));

        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, RegisterPage.routeName, (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void sendUserData(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, BottomBar.routeName, (route) => false);
  }
}
