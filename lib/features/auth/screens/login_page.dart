import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:learn_stream/features/auth/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "./login-papge";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _numberControler;
  late TextEditingController _otpController;
  late FirebaseAuth auth;
  String verification = '';
  bool _idDisable = true;
  // final String _countryCode = "+91";

  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();

    _numberControler = TextEditingController();
    _otpController = TextEditingController();
    auth = FirebaseAuth.instance;
  }

  void signInUser() {
    authServices.signIn(context, _numberControler.text);
  }

  void verifyOtp() {
    authServices.verifyOtp(context, _otpController.text);
  }

  final countryPicker = const FlCountryCodePicker();
  final countryPickerWithParams = const FlCountryCodePicker(
    favorites: ['IN', 'PH', 'US'],
    showDialCode: true,
    showSearchBar: true,
  );

  @override
  void dispose() {
    super.dispose();

    _numberControler.clear();
    _otpController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              height: 450,
              color: Colors.teal[400],
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Center(
                  child: Form(
                      key: formKey,
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _numberControler,
                              decoration: const InputDecoration(
                                  constraints: BoxConstraints(),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Enter Number "),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              onChanged: (value) => {
                                if (_idDisable == false)
                                  {
                                    setState(() {
                                      _idDisable = true;
                                    })
                                  }
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Enter Number";
                                } else if (value.length < 10) {
                                  return "Number is to Short";
                                } else if (value.length > 10) {
                                  return "Number is to long";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: _idDisable
                                    ? () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            _idDisable = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Otp Send ')),
                                          );
                                          signInUser();
                                        }
                                      }
                                    : null,
                                child: const Text("Get Otp")),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _otpController,
                              decoration: const InputDecoration(
                                  constraints: BoxConstraints(),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                  hintText: "Enter OTP "),
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              validator: _idDisable
                                  ? null
                                  : (value) {
                                      if (value == null) {
                                        return "Enter otp";
                                      } else if (value.length < 6) {
                                        return "OTP is to Short";
                                      } else if (value.length > 6) {
                                        return "OTP is to long";
                                      }
                                      return null;
                                    },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: _idDisable
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text('Verifying otp')),
                                          );
                                          verifyOtp();
                                        }
                                      },
                                child: const Text("Verify OTP")),
                          ],
                        ),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
