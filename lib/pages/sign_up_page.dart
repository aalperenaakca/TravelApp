import 'package:flutter/material.dart';
import 'package:gezi/widgets/sign_up_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        title: const Text('Kayıt ol'),
      ),
      body: const SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
