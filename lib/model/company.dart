class Company {
  final String uid;
  final String name;
  final String type;
  final double pricePerTon;

  Company(
      {required this.name,
      required this.type,
      required this.pricePerTon,
      required this.uid});

  Company.fromJson(Map<String, Object?> json, String reference)
      : this(
          uid: reference,
          name: json['name']! as String,
          type: json['type']! as String,
          pricePerTon: (json['pricePerTon']! as num).toDouble(),
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'pricePerTon': pricePerTon,
      'type': type,
    };
  }
}
