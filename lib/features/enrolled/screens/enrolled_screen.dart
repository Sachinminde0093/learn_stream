import 'package:flutter/material.dart';

class EnnrolledScreen extends StatefulWidget {
  const EnnrolledScreen({super.key});

  @override
  State<EnnrolledScreen> createState() => _EnnrolledScreenState();
}

class _EnnrolledScreenState extends State<EnnrolledScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Enrolled Screen"),
    );
  }
}
