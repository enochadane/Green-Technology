class User {
  final String uid;
  final String name;
  final String phone;
  final String password;
  final List<Map<String, dynamic>> comments;
  final Map<String, dynamic> profile;
  final String role;

  User({
    required this.uid,
    required this.name,
    required this.phone,
    required this.password,
    required this.comments,
    required this.role,
    required this.profile,
  });

  User.fromJson(Map<String, dynamic> json, String reference)
      : this(
            uid: reference,
            name: json['name']! as String,
            phone: json['phone']! as String,
            password: json['password']! as String,
            comments: json['comments']! as List<Map<String, dynamic>>,
            role: json['role']! as String,
            profile: json['profile'] as Map<String, dynamic>);

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'phone': phone,
      'password': password,
      'comments': comments,
      'profile': profile,
      'role': role,
    };
  }

  @override
  String toString() =>
      '{ "uid": $uid, "phone": $phone, "password": $password, "comments": $comments, "profile": $profile, "role": $role }';
}
