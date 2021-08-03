
class Collector {
  final String uid;
  final String orgName;
  final String domain;
  final String availability;
  final String role;

  Collector(
      {required this.uid,
      required this.orgName,
      required this.domain,
      required this.availability,
      required this.role});

  Collector.fromJson(Map<String, Object?> json, String reference)
      : this(
          uid: reference,
          orgName: json['orgName']! as String,
          domain: json['domain']! as String,
          availability: json['availability']! as String,
          role: json['role']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'orgName': orgName,
      'domain': domain,
      'availability': availability,
      'role': role,
    };
  }
}
