import 'dart:convert';

class Codornis {
  int? id;
  String? semana;
  int? numeroAves;
  String? alimento;
  double? canitdadAlimento;
  int? huevos;
  int? avesMuertas;

  Codornis({
    this.id,
    this.semana,
    this.numeroAves,
    this.alimento,
    this.canitdadAlimento,
    this.huevos,
    this.avesMuertas,
  });

  Codornis copyWith({
    int? id,
    String? semana,
    int? numeroAves,
    String? alimento,
    double? canitdadAlimento,
    int? huevos,
    int? avesMuertas,
  }) {
    return Codornis(
      id: id ?? this.id,
      semana: semana ?? this.semana,
      numeroAves: numeroAves ?? this.numeroAves,
      alimento: alimento ?? this.alimento,
      canitdadAlimento: canitdadAlimento ?? this.canitdadAlimento,
      huevos: huevos ?? this.huevos,
      avesMuertas: avesMuertas ?? this.avesMuertas,
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
    };
  }

  factory Codornis.fromMap(Map<String, dynamic> map) {
    return Codornis(
      id: map['id']?.toInt() ?? 0,
      semana: map['semana'] ?? '',
      numeroAves: map['numeroAves']?.toInt() ?? 0,
      alimento: map['alimento'] ?? '',
      canitdadAlimento: map['canitdadAlimento']?.toDouble() ?? 0.0,
      huevos: map['huevos']?.toInt() ?? 0,
      avesMuertas: map['avesMuertas']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Codornis.fromJson(String source) =>
      Codornis.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Codornis(id: $id, semana: $semana, numeroAves: $numeroAves, alimento: $alimento, canitdadAlimento: $canitdadAlimento, huevos: $huevos, avesMuertas: $avesMuertas)';
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
        other.avesMuertas == avesMuertas;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        semana.hashCode ^
        numeroAves.hashCode ^
        alimento.hashCode ^
        canitdadAlimento.hashCode ^
        huevos.hashCode ^
        avesMuertas.hashCode;
  }
}
