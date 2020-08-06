import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("درباره ما"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("About us"),
      ),
    );
  }
}
