class CustomerModel{
  int ID;
  String Name;
  String Address;
  String Email;
  String Phone;
  String AvatarUrl;
  DateTime YearOfBirth;
  String Gender;
  bool Status;
  int? UserID;
CustomerModel({
    required this.ID,
    required this.Name,
    required this.Address,
    required this.Email,
    required this.Phone,
    required this.AvatarUrl,
    required this.YearOfBirth,
    required this.Gender,
    required this.Status,
    this.UserID,
  });
  factory CustomerModel.fromJson(Map<dynamic, dynamic> json) {
    return CustomerModel(
      ID: json['id'],
      Name: json['name'],
      Email: json['email'],
      Phone: json['phone'],
      Address: json['address'],
      YearOfBirth: DateTime.parse(json['yearOfBirth']) ,
      AvatarUrl: json['avatarUrl'],
      Gender: json['gender'],
      Status: json['status'],
    );
  }
  Map<dynamic, dynamic> toJson() {
    return {
      'id': ID,
      'email': Email,
      'name': Name,
      'phone' : Phone,
      'address' :Address,
      'yearOfBirth' : YearOfBirth.toString(),
      'gender' : Gender,
      'status': Status,
    };
  }

}