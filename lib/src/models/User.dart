class UserModel {
  UserModel({this.username, this.email, this.phone, this.country});

  String? username;
  String? email;
  String? phone;
  String? country;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      username: json["username"],
      email: json["email"],
      phone: json["phone"],
      country: json["country"]);

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phone": phone,
        "country": country
      };
}
