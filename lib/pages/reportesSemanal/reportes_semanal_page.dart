import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/pages/reportesSemanal/list_view_reporte_widget.dart';
import 'package:flutter/material.dart';

class ReporteSemanalPage extends StatefulWidget {
  static const String route = "reporteSemanal";

  ReporteSemanalPage({Key? key}) : super(key: key);

  @override
  _ReporteSemanalPageState createState() => _ReporteSemanalPageState();
}

class _ReporteSemanalPageState extends State<ReporteSemanalPage> {
  late List<Codornis> listaCodornices;

  @override
  void initState() {
    listaCodornices = _generateItems();
    super.initState();
  }

  List<Codornis> _generateItems() {
    return List.generate(10, (int index) {
      return Codornis(
        id: index,
        alimento: 'Pienso',
        avesMuertas: 10,
        canitdadAlimento: index * 100.0,
        huevos: index * 2,
        numeroAves: 100,
        semana: DateTime.now().toLocal().toString().split('-')[1] +
            '-' +
            DateTime.now().toLocal().toString().split('-')[2].split(' ').first +
            '-' +
            DateTime.now().toLocal().toString().split('-').first,
      );
    });
  }

  double calcularIndiceDeMortalidad({required List<Codornis> codornices}) {
    int codornicesMuertas = 0;
    codornices.map((e) {
      codornicesMuertas += e.avesMuertas ?? 0;
    }).toList();
    int codornicesTotales = 0;
    codornices.map((e) {
      codornicesTotales += e.numeroAves ?? 0;
    }).toList();
    print(codornicesTotales);
    print(codornicesMuertas);
    double procentajeMortalidad = (codornicesMuertas / codornicesTotales) * 100;
    print(procentajeMortalidad);
    print(codornicesMuertas % codornicesTotales);
    print(codornicesTotales % codornicesMuertas);
    return procentajeMortalidad;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      disabledColor: Colors.grey,
                      elevation: 0,
                      color: Colors.deepPurple,
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Text(
                            'Salir',
                            style: TextStyle(color: Colors.white),
                          )),
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Text(
                'REPORTE SEMANAL',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image(
                  image: AssetImage('assets/codornis.png'),
                ),
              ),
              Text(
                  'Indice de mortalidad ${calcularIndiceDeMortalidad(codornices: listaCodornices)}%'),
            ]),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListReporteSemanal(
                    codornices: listaCodornices,
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      )),
    );
  }
}
