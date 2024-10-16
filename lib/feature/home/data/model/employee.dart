import "package:flutter/foundation.dart" show immutable;

const String employeeTable = "employee";

class EmployeeFields {
  static final List<String> values = [
    id,
    name,
    nip,
  ];
  static const String id = "_id";
  static const String name = "name";
  static const String position = "position";
  static const String nip = "nip";
}

@immutable
class Employee {
  final int? id;
  final String name;
  final String nip;

  const Employee({
    this.id,
    required this.name,
    required this.nip,
  });

  Employee copy({
    int? id,
    String? name,
    String? nip,
  }) =>
      Employee(
        id: id ?? this.id,
        name: name ?? this.name,
        nip: nip ?? this.nip,
      );

  Map<String, Object?> toJson() => {
        EmployeeFields.id: id,
        EmployeeFields.name: name,
        EmployeeFields.nip: nip,
      };

  factory Employee.fromJson(Map<String, Object?> json) => Employee(
        id: json[EmployeeFields.id] != null
            ? json[EmployeeFields.id] as int?
            : null,
        name: json[EmployeeFields.name] as String,
        nip: json[EmployeeFields.nip] as String,
      );
}
