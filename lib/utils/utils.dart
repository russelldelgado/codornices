import 'package:email_validator/email_validator.dart';

String? validarCorreoElectronico({required String valor}) {
  if (valor.length == 0 || valor.isEmpty)
    return 'El campo no puede estar vacio';
  final bool _isValid = EmailValidator.validate(valor);
  if (!_isValid) {
    return "Correo invalido";
  }
  return null;
}

String? isDigit({required String c}) {
  if (c.length == 0) {
    return 'El campo no puede estar vacio';
  }
  bool digito = c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  if (!digito) {
    return "El valor tiene que ser numérico";
  }
  return null;
}

String? validateNoVacio({required String valor}) {
  if (valor.length == 0) {
    return 'El campo no puede estar vacio';
  }
  return null;
}
