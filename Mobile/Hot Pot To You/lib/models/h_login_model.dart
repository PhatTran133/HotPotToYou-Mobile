class LoginModel {
  String Email;
  String Password;

  LoginModel({
    required this.Email,
    required this.Password,
  });

  // Phương thức để chuyển đổi từ JSON sang đối tượng Dart
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      Email: json['email'],
      Password: json['password'],
    );
  }
}