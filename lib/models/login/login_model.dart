///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class LoginModel {

  String? userId;
  String? email;
  String? createdOn;
  String? role;
  String? firstName;
  String? lastName;

  LoginModel({
    this.userId,
    this.email,
    this.createdOn,
    this.role,
    this.firstName,
    this.lastName,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId']?.toString();
    email = json['email']?.toString();
    createdOn = json['createdOn']?.toString();
    role = json['role']?.toString();
    firstName = json['firstName']?.toString();
    lastName = json['lastName']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['email'] = email;
    data['createdOn'] = createdOn;
    data['role'] = role;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    return data;
  }
}
