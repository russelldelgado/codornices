import 'dart:convert';

class Codornis {
  int? id;
  String? semana;
  int? numeroAves;
  String? alimento;
  double? canitdadAlimento;
  int? huevos;
  int? avesMuertas;
  int userId;

  Codornis({
    this.id,
    this.semana,
    this.numeroAves,
    this.alimento,
    this.canitdadAlimento,
    this.huevos,
    this.avesMuertas,
    required this.userId,
  });

  Codornis copyWith({
    int? id,
    String? semana,
    int? numeroAves,
    String? alimento,
    double? canitdadAlimento,
    int? huevos,
    int? avesMuertas,
    int? userId,
  }) {
    return Codornis(
      id: id ?? this.id,
      semana: semana ?? this.semana,
      numeroAves: numeroAves ?? this.numeroAves,
      alimento: alimento ?? this.alimento,
      canitdadAlimento: canitdadAlimento ?? this.canitdadAlimento,
      huevos: huevos ?? this.huevos,
      avesMuertas: avesMuertas ?? this.avesMuertas,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'semana': semana,
      'numeroAves': numeroAves,
      'alimento': alimento,
      'canitdadAlimento': canitdadAlimento,
      'huevos': huevos,
      'avesMuertas': avesMuertas,
      'userId': userId,
    };
  }

  factory Codornis.fromMap(Map<String, dynamic> map) {
    return Codornis(
      id: map['id']?.toInt(),
      semana: map['semana'],
      numeroAves: map['numeroAves']?.toInt(),
      alimento: map['alimento'],
      canitdadAlimento: map['canitdadAlimento']?.toDouble(),
      huevos: map['huevos']?.toInt(),
      avesMuertas: map['avesMuertas']?.toInt(),
      userId: map['userId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Codornis.fromJson(String source) =>
      Codornis.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Codornis(id: $id, semana: $semana, numeroAves: $numeroAves, alimento: $alimento, canitdadAlimento: $canitdadAlimento, huevos: $huevos, avesMuertas: $avesMuertas, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Codornis &&
        other.id == id &&
        other.semana == semana &&
        other.numeroAves == numeroAves &&
        other.alimento == alimento &&
        other.canitdadAlimento == canitdadAlimento &&
        other.huevos == huevos &&
        other.avesMuertas == avesMuertas &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        semana.hashCode ^
        numeroAves.hashCode ^
        alimento.hashCode ^
        canitdadAlimento.hashCode ^
        huevos.hashCode ^
        avesMuertas.hashCode ^
        userId.hashCode;
  }
}
