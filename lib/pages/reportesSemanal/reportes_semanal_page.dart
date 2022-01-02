import 'package:flutter/material.dart';

class ReporteSemanalPage extends StatefulWidget {
  static const String route = "reporteSemanal";

  ReporteSemanalPage({Key? key}) : super(key: key);

  @override
  _ReporteSemanalPageState createState() => _ReporteSemanalPageState();
}

class _ReporteSemanalPageState extends State<ReporteSemanalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("Reporte semanal page"),
    ));
  }
}
