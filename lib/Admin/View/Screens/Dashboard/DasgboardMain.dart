import 'package:flutter/material.dart';

class Dasgboardmain extends StatefulWidget {
  const Dasgboardmain({super.key});

  @override
  State<Dasgboardmain> createState() => _DasgboardmainState();
}

class _DasgboardmainState extends State<Dasgboardmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Dashboard"),
      ),
    );
  }
}
