import 'dart:convert';

class Usuario {
  int? id;
  String? user;
  String? password;
  Usuario({
    this.id,
    this.user,
    this.password,
  });

  Usuario copyWith({
    int? id,
    String? user,
    String? password,
  }) {
    return Usuario(
      id: id ?? this.id,
      user: user ?? this.user,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'password': password,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id']?.toInt() ?? 0,
      user: map['user'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source));

  @override
  String toString() => 'Usuario(id: $id, user: $user, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Usuario &&
        other.id == id &&
        other.user == user &&
        other.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ user.hashCode ^ password.hashCode;
}
