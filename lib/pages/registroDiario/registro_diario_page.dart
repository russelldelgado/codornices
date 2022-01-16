import 'package:codornices/models/codornis_model.dart';
import 'package:codornices/services/sqflite/dbGanvapp.dart';
import 'package:codornices/shared_preferences/preferencias_usuario.dart';
import 'package:codornices/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistroDiarioPage extends StatefulWidget {
  static const String route = "registroDiario";

  RegistroDiarioPage({Key? key}) : super(key: key);

  @override
  _RegistroDiarioPageState createState() => _RegistroDiarioPageState();
}

class _RegistroDiarioPageState extends State<RegistroDiarioPage> {
  late GlobalKey<FormState> _formKey;
  late bool enable;
  Codornis? codornis;
  late bool cargando;
  // late DateTime _dateSelected;
  late TextEditingController _fechaControlador;

  @override
  void initState() {
    enable = true;
    _formKey = GlobalKey<FormState>();
    codornis = new Codornis(userId: Preferencias().userIdget);
    cargando = false;
    _fechaControlador = TextEditingController();
    _fechaControlador.text =
        DateTime.now().toLocal().toString().split(' ').first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final codornisEditable = ModalRoute.of(context)!.settings.arguments;

    if (codornisEditable != null) {
      codornis = codornisEditable as Codornis;
      setState(() {});
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                    'REGISTRO DIARIO',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Image(
                      image: AssetImage('assets/codornis.png'),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await _selectDate(context);
                      setState(() {});
                    },
                    child: Text('Seleccione la fecha'),
                  ),
                ]),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _crearFormulario(
                        onTap: () async {},
                        enable: false,
                        controller: _fechaControlador,
                        dato: "Fecha",
                        validator: (value) {
                          // return isDigit(c: DateTime.fromMillisecondsSinceEpoch(_fechaControlador.).toString());
                        },
                        onSave: (value) => codornis?.semana = value,
                      ),
                      _crearFormulario(
                        tipoTeclado: TextInputType.number,
                        enable: enable,
                        initialValue: codornis?.numeroAves?.toString() ?? '',
                        dato: "Ingrese la cantidad de aves existentes",
                        validator: (value) {
                          return isDigit(c: value!);
                        },
                        onSave: (value) =>
                            codornis?.numeroAves = int.parse(value ?? '0'),
                      ),
                      _crearFormulario(
                        enable: enable,
                        initialValue: codornis?.alimento?.toString() ?? '',
                        dato: "Ingrese el nombre del alimento a suministrar",
                        tipoTeclado: TextInputType.emailAddress,
                        onSave: (value) => codornis?.alimento = value,
                        validator: (value) {
                          return validateNoVacio(valor: value!);
                        },
                      ),
                      _crearFormulario(
                          tipoTeclado: TextInputType.number,
                          enable: enable,
                          initialValue:
                              codornis?.canitdadAlimento?.toString() ?? '',
                          dato: "cantidad de alimento diario por ave (gr)",
                          onSave: (value) =>
                              codornis?.canitdadAlimento = double.parse(value!),
                          validator: (value) {
                            return isDigit(c: value!);
                          }),
                      _crearFormulario(
                          tipoTeclado: TextInputType.number,
                          enable: enable,
                          initialValue: codornis?.huevos?.toString() ?? '',
                          dato: "Ingrese la cantidad de huevos recolectados",
                          onSave: (value) =>
                              codornis?.huevos = int.parse(value!),
                          validator: (value) {
                            return isDigit(c: value!);
                          }),
                      _crearFormulario(
                          tipoTeclado: TextInputType.number,
                          enable: enable,
                          initialValue: codornis?.avesMuertas?.toString() ?? '',
                          dato: "Ingrese la cantidad de aves perdidas",
                          onSave: (value) =>
                              codornis?.avesMuertas = int.parse(value!),
                          validator: (value) {
                            return isDigit(c: value!);
                          }),
                      _crearFormulario(
                          tipoTeclado: TextInputType.number,
                          enable: enable,
                          initialValue:
                              codornis?.huevosNoViables?.toString() ?? '',
                          dato: "Ingrese la cantidad de huevos no viables",
                          onSave: (value) =>
                              codornis?.huevosNoViables = int.parse(value!),
                          validator: (value) {
                            return isDigit(c: value!);
                          }),
                      _crearFormulario(
                          tipoTeclado:
                              TextInputType.numberWithOptions(decimal: true),
                          enable: enable,
                          initialValue:
                              codornis?.precioPorHuevo?.toString() ?? '',
                          dato: "Ingrese el precio estimado por huevo",
                          onSave: (value) =>
                              codornis?.precioPorHuevo = double.parse(value!),
                          validator: (value) {
                            if (value!.contains(',')) {
                              return 'los decimales van con punto 0.20';
                            }
                            return isDigit(c: value);
                          }),
                      SizedBox(
                        height: 4,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                  cargando ? "Espere" : "Guardar datos",
                                  style: TextStyle(color: Colors.white),
                                )),
                            onPressed: cargando ? null : _guardarMisDatos,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (codornis?.id != null)
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              disabledColor: Colors.grey,
                              elevation: 0,
                              color: Colors.red,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  child: Text(
                                    cargando ? "Espere" : "Eliminar datos",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              onPressed: cargando ? null : _EliminarDatos,
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(DateTime.now().year),
        lastDate: new DateTime(DateTime.now().year + 10));
    if (picked != null) {
      _fechaControlador.text = picked.toLocal().toString().split(' ').first;
    } else {
      _fechaControlador.text =
          DateTime.now().toLocal().toString().split(' ').first;
    }
  }

  Widget _crearFormulario(
      {bool? enable,
      TextEditingController? controller,
      String? initialValue,
      int? maxLength,
      required String dato,
      TextInputType? tipoTeclado,
      Function(String)? onChanged,
      VoidCallback? onTap,
      String? Function(String?)? validator,
      void Function(String?)? onSave}) {
    return TextFormField(
      enabled: enable,
      controller: controller,
      initialValue: initialValue,
      onSaved: onSave,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      keyboardType: tipoTeclado ?? TextInputType.name,
      decoration: InputDecoration(
        labelText: dato,
        hintText: dato,
      ),
    );
  }

  _guardarMisDatos() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      cargando = true;
      enable = false;
    });

    _formKey.currentState!.save();

    if (codornis?.id == null) {
      ///guardo la codornis en mi base de datos

      //TODO :GUARDO DATOSN EN MI BBDD
      int response = await DBAVIPRO.insertarCodornis(codornis!);

      if (response == null || response == 0) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text(
            'Fallo al guardar los datos',
          )));
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text(
            'Guardado correctamente',
          )));
        codornis?.id = response;
      }
      setState(() {
        cargando = false;
        enable = true;
      });
      Navigator.pop(context);
    } else {
      ///se actualiza el codornis en el backend
      int response = await DBAVIPRO.updateCodornis(codornis!);

      if (response == null || response == 0) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text(
            'Fallo al guardar los datos',
          )));
        return;
      } else {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
              content: Text(
            'Actualizado correctamente',
          )));
      }
      setState(() {
        cargando = false;
        enable = true;
      });
      Navigator.pop(context);
    }
  }

  _EliminarDatos() async {
    FocusScope.of(context).unfocus();

    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      cargando = true;
      enable = false;
    });

    _formKey.currentState!.save();

    var response = await DBAVIPRO.eliminarcodornis(codornis!.id!);
    if (response == null || response == 0) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          'Fallo al eliminar los datos',
        )));
      return;
    } else {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text(
          'Eliminado correctamente',
        )));
    }
    setState(() {
      cargando = false;
      enable = true;
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
