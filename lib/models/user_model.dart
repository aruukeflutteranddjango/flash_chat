class UserModel {
  final String id;
  final String email;
  final String password;
  UserModel({
    this.id,
    this.email,
    this.password,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'], email: json['email'], password: json['password']);
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'email': email, 'password': password};
}
