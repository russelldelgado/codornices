import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/pages/registroDiario/registro_diario_page.dart';

class ListReporteSemanal extends StatefulWidget {
  final List<Codornis> codornices;

  ListReporteSemanal({
    Key? key,
    required this.codornices,
  }) : super(key: key);

  @override
  _ListReporteSemanalState createState() => _ListReporteSemanalState();
}

class _ListReporteSemanalState extends State<ListReporteSemanal> {
  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller1.addListener(_scrollListener);
    _controller2.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_controller1.position.pixels.toInt() <=
        _controller1.position.pixels.toInt() + 10) {
      print('moviendo controller');
      _controller2.animateTo(_controller1.offset,
          duration: Duration(milliseconds: 100),
          curve: Curves.fastLinearToSlowEaseIn);
    } else if (_controller2.position.pixels.toInt() <=
        _controller2.position.pixels.toInt() + 1) {
      print('moviendo controller');
      _controller1.animateTo(_controller2.offset,
          duration: Duration(milliseconds: 50),
          curve: Curves.fastLinearToSlowEaseIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      RowPersonal(
        controller: _controller1,
      ),
      Container(
          height: 500,
          child: ListView.builder(
            itemCount: widget.codornices.length,
            itemBuilder: (context, index) {
              return RowPersonalData(
                codornis: widget.codornices[index],
                controller: _controller2,
              );
            },
          ))
    ]);
  }
}

class RowPersonal extends StatelessWidget {
  final ScrollController controller;
  const RowPersonal({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        controller: controller,
        itemCount: 8,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ContainerTitleReporteSemanal(
              titulo: "Semana",
            );
          } else if (index == 1) {
            return ContainerTitleReporteSemanal(
              titulo: "N. Aves",
            );
          } else if (index == 2) {
            return ContainerTitleReporteSemanal(
              titulo: "Alimento",
            );
          } else if (index == 3) {
            return ContainerTitleReporteSemanal(
              titulo: "Cant. alimento",
            );
          } else if (index == 4) {
            return ContainerTitleReporteSemanal(
              titulo: "Huevos",
            );
          } else if (index == 5) {
            return ContainerTitleReporteSemanal(
              titulo: "Aves muertas",
            );
          } else if (index == 6) {
            return ContainerTitleReporteSemanal(
              titulo: "Precio",
            );
          } else if (index == 7) {
            return ContainerTitleReporteSemanal(
              titulo: "Huevos no viables",
            );
          } else if (index == 8) {
            return ContainerTitleReporteSemanal(
              titulo: "Editar",
            );
          }
          return Container();
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class RowPersonalData extends StatelessWidget {
  final Codornis codornis;
  final ScrollController controller;

  const RowPersonalData({
    Key? key,
    required this.codornis,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView.builder(
        controller: controller,
        itemCount: 8,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ContainerDataReporteSemanal(
              data: codornis.semana?.toString(),
            );
          } else if (index == 1) {
            return ContainerDataReporteSemanal(
              data: codornis.numeroAves?.toString(),
            );
          } else if (index == 2) {
            return ContainerDataReporteSemanal(
              data: codornis.alimento,
            );
          } else if (index == 3) {
            return ContainerDataReporteSemanal(
              data: codornis.canitdadAlimento?.toString(),
            );
          } else if (index == 4) {
            return ContainerDataReporteSemanal(
              data: codornis.huevos?.toString(),
            );
          } else if (index == 5) {
            return ContainerDataReporteSemanal(
              data: codornis.avesMuertas?.toString(),
            );
          } else if (index == 6) {
            return ContainerDataReporteSemanal(
              data: '${codornis.precioPorHuevo?.toString()}\$',
            );
          } else if (index == 7) {
            return ContainerDataReporteSemanal(
              data: codornis.huevosNoViables?.toString(),
            );
          } else if (index == 8) {
            return BotonEdit(
              codornis: codornis,
            );
          }
          return Container();
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class ContainerTitleReporteSemanal extends StatelessWidget {
  final String? titulo;
  const ContainerTitleReporteSemanal({
    Key? key,
    this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.only(left: 10, right: 15),
          child: titulo == null
              ? Container()
              : Text(
                  titulo!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}

class ContainerDataReporteSemanal extends StatelessWidget {
  final String? data;
  const ContainerDataReporteSemanal({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          padding: EdgeInsets.only(left: 10, right: 15),
          child: data == null
              ? Container(
                  child: Text('---'),
                )
              : Text(
                  data!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ],
    );
  }
}

class BotonEdit extends StatelessWidget {
  final Codornis codornis;

  const BotonEdit({
    Key? key,
    required this.codornis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Center(
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            child: Container(
                child: Text(
              'Editar',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white),
            )),
            onPressed: () async {
              Navigator.pushNamed(context, RegistroDiarioPage.route,
                  arguments: codornis);
            }),
      ),
    );
  }
}
