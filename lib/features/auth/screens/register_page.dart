import 'package:flutter/material.dart';
import 'package:learn_stream/features/auth/services/auth_services.dart';
import 'package:learn_stream/models/user_model.dart';
import 'package:learn_stream/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "./register-page";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _numberControler;
  late TextEditingController _otpController;

  AuthServices authServices = AuthServices();

  @override
  void initState() {
    super.initState();

    _numberControler = TextEditingController();
    _otpController = TextEditingController();
  }

  void sendData() {
    authServices.sendUserData(context);
  }

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
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _numberControler,
                          decoration: const InputDecoration(
                              constraints: BoxConstraints(),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "Enter Number "),
                          keyboardType: const TextInputType.numberWithOptions(),
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
                        TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                              constraints: BoxConstraints(),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "Enter OTP "),
                          keyboardType: const TextInputType.numberWithOptions(),
                          validator: (value) {
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
                        TextFormField(
                          controller: _otpController,
                          decoration: const InputDecoration(
                              constraints: BoxConstraints(),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "Enter OTP "),
                          keyboardType: const TextInputType.numberWithOptions(),
                          validator: (value) {
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
                            onPressed: () {
                              String id = Provider.of<UserProvider>(context,
                                      listen: false)
                                  .user
                                  .firebaseId;

                              print(id);
                              if (formKey.currentState!.validate()) {
                                String id = Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user
                                    .firebaseId;

                                print(id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("id")),
                                );
                                sendData();
                              }
                            },
                            child: const Text("Next")),
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
