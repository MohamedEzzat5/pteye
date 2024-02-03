class UserModel{
  final String? id;
  final String? userName;
  final String? email;
  final String? password;
  final String? phoneNumber;

  UserModel({
    this.phoneNumber,
    this.email,
    this.password,
    this.userName,
    this.id,
  });

  toJson(){
    return{
      'userName' : userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,

    };
  }

}