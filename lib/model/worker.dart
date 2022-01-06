import 'dart:convert';

class WorkerFields {
  static final String id = 'id';
  static final String name = 'name';
  static final String price = 'price';
  static final String date = 'date';

  static List<String> getFields() => [id, name, price, date];
}

class Worker {
  final int? id;
  final String name;
  final String price;
  final int date;

  const Worker({
    this.id,
    required this.name,
    required this.price,
    required this.date,
  });

  Worker copy({
    int? id,
    String? name,
    String? price,
    int? date,
  }) =>
      Worker(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        date: date ?? this.date,
      );

  Map<String, dynamic> toJson() => {
        WorkerFields.id: id,
        WorkerFields.name: name,
        WorkerFields.price: price,
        WorkerFields.date: date,
      };

  static Worker fromJson(Map<String, dynamic> json) => Worker(
        id: jsonDecode(json[WorkerFields.id]),
        name: json[WorkerFields.name],
        price: json[WorkerFields.price],
        date: jsonDecode(json[WorkerFields.date]),
      );
}
