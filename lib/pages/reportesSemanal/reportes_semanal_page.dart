import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/models/usuario_model.dart';
import 'package:codornices/pages/reportesSemanal/list_view_reporte_widget.dart';
import 'package:codornices/services/sqflite/dbGanvapp.dart';
import 'package:codornices/shared_preferences/preferencias_usuario.dart';
import 'package:flutter/material.dart';

class ReporteSemanalPage extends StatefulWidget {
  static const String route = "reporteSemanal";

  ReporteSemanalPage({Key? key}) : super(key: key);

  @override
  _ReporteSemanalPageState createState() => _ReporteSemanalPageState();
}

class _ReporteSemanalPageState extends State<ReporteSemanalPage> {
  late List<Codornis>? listaCodornices;
  late TextEditingController _fechaControladorInicio;
  late TextEditingController _fechaControladorFin;

  @override
  void initState() {
    listaCodornices = [];
    _generateItems();
    _fechaControladorInicio = TextEditingController();
    _fechaControladorInicio.text =
        DateTime.now().toLocal().toString().split(' ').first;

    _fechaControladorFin = TextEditingController();
    _fechaControladorFin.text =
        DateTime.now().toLocal().toString().split(' ').first;
    super.initState();
  }

  Future<void> _generateItems() async {
    listaCodornices = await DBAVIPRO.recuperar10Codorniss();
    if (mounted) setState(() {});
    print(listaCodornices?[0]);
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

    double procentajeMortalidad = (codornicesMuertas / codornicesTotales) * 100;
    return procentajeMortalidad.roundToDouble();
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
                  FutureBuilder(
                    future: DBAVIPRO.recuperarUsuario(Preferencias().userIdget),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Usuario usuario = snapshot.data as Usuario;
                        return Container(
                          child: Text(usuario.user!),
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  SizedBox(width: 10),
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
                  'Indice de mortalidad ${calcularIndiceDeMortalidad(codornices: listaCodornices!)}%'),
            ]),
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      await _selectDate(context, _fechaControladorInicio);
                      setState(() {});
                    },
                    child: Text('Fecha inicio'),
                  ),
                  Text(_fechaControladorInicio.text.toString())
                ],
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      await _selectDate(context, _fechaControladorFin);
                      setState(() {});
                    },
                    child: Text('Fecha fin'),
                  ),
                  Text(_fechaControladorFin.text.toString())
                ],
              ),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Colors.deepPurple,
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Text(
                        'Buscar',
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: () async {
                    print(_fechaControladorInicio.text.toString());
                    print(_fechaControladorFin.text.toString());
                    listaCodornices =
                        await DBAVIPRO.recuperarCodornicesEntreFechas(
                            fechaInicio:
                                _fechaControladorInicio.text.toString(),
                            fechaFin: _fechaControladorFin.text.toString());
                    setState(() {});
                  }),
            ]),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return ListReporteSemanal(
                    codornices: listaCodornices!,
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

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(DateTime.now().year),
        lastDate: new DateTime(DateTime.now().year + 10));
    if (picked != null) {
      controller.text = picked.toLocal().toString().split(' ').first;
    } else {
      controller.text = DateTime.now().toLocal().toString().split(' ').first;
    }
  }
}
