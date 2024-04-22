import 'package:flutter/material.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 50,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Gezecek birini mi arıyorsun?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      width: 1000,
                      child: Image.asset(
                        'assets/images/gezecek-biri.jpg',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Card(
                margin: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 50,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(
                        'Bir yerel rehbere mi ihtiyacın var?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 21),
                      ),
                    ),
                    SizedBox(
                      height: 220,
                      width: 10000,
                      child: Image.asset(
                        'assets/images/rehber.jpg',
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
