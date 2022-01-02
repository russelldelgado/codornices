import 'package:flutter/material.dart';

class RegistroDiarioPage extends StatefulWidget {
  static const String route = "registroDiario";

  RegistroDiarioPage({Key? key}) : super(key: key);

  @override
  _RegistroDiarioPageState createState() => _RegistroDiarioPageState();
}

class _RegistroDiarioPageState extends State<RegistroDiarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Registro diario page"),
    ));
  }
}
