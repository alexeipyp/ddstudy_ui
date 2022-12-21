abstract class DBModel<T> {
  final T id;
  DBModel({
    required this.id,
  });

  static fromMap(Map<String, dynamic> map) {}
  Map<String, dynamic> toMap() {
    return Map.fromIterable([]);
  }
}
