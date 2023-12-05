class UserDataModel {
  String? userId;
  String? userEmail;
  bool? isLoggedIn;
  String? firstName;
  String? lastName;
  String? role;

  /* UserDataModel(
      {this.userId,
        this.userName,
        this.fullName,
        this.userEmail,
        this.isLoggedIn,
        this.userNumber,this.authToken,});*/

  UserDataModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.userEmail,
    this.isLoggedIn,
    this.role,
  });

  String? getFirstName() {
    return firstName;
  }

  setFirstName(String firstName) {
    this.firstName = firstName;
  }

  String? getLastName() {
    return lastName;
  }

  setLastName(String lastName) {
    this.lastName = lastName;
  }

  //////////

  String? getUserId() {
    return userId;
  }

  setUserId(String id) {
    this.userId = id;
  }

  bool? isLogin() {
    return isLoggedIn;
  }

  String? getUserRole() {
    return role;
  }

  setUserRole(String userRole) {
    role = userRole;
  }

  String? getEmail() {
    return userEmail;
  }

  setUserEmail(String email) {
    this.userEmail = email;
  }

  setLogin(bool isLogin) {
    isLoggedIn = isLogin;
  }

  Map<String, dynamic> toMap(UserDataModel user) => {
        'id': user.userId,
        'email': user.userEmail,
        'isLoggedIn': user.isLoggedIn,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'role': user.role,
      };

  factory UserDataModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDataModel(
      userId: jsonData['id'],
      userEmail: jsonData['email'],
      isLoggedIn: jsonData['isLoggedIn'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
      role: jsonData['role'],
    );
  }
}
