import 'package:flutter/material.dart';

class GuideWidget extends StatefulWidget {
  const GuideWidget({super.key});

  @override
  State<GuideWidget> createState() => _GuideWidgetState();
}

class _GuideWidgetState extends State<GuideWidget> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Center(child: SingleChildScrollView(child: Column())));
  }
}
