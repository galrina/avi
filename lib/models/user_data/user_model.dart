class UserDataModel {
  String? userId;
  String? userEmail;
  bool? isLoggedIn;
  String? firstName;
  String? lastName;
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

  bool? isLogin() {
    return isLoggedIn;
  }


  String? getEmail() {
    return userEmail;
  }


  setLogin(bool isLogin) {
    isLoggedIn = isLogin;
  }



  setUserId(String id) {
    this.userId = id;
  }


  setUserEmail(String email) {
    this.userEmail = email;
  }

  Map<String, dynamic> toMap(UserDataModel user) => {
    'id': user.userId,
    'email': user.userEmail,
    'isLoggedIn': user.isLoggedIn,
    'firstName': user.firstName,
    'lastName': user.lastName,
  };

  factory UserDataModel.fromJson(Map<String, dynamic> jsonData) {
    return UserDataModel(
      userId: jsonData['id'],
      userEmail: jsonData['email'],
      isLoggedIn: jsonData['isLoggedIn'],
      firstName: jsonData['firstName'],
      lastName: jsonData['lastName'],
    );
  }
}