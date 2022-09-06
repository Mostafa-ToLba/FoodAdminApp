class UserModel{

  String? email;
  String? name;
  String? phone;
  String? uId;
  String? osUserID;
  String? password;
  String? AdminOrUser;

  UserModel({ this.email,this.osUserID, this.phone, this.name, this.uId,this.password,this.AdminOrUser});

  UserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    phone=json['phone'];
    uId=json['uId'];
    email=json['email'];
    osUserID=json['osUserID'];
    password=json['password'];
    AdminOrUser=json['AdminOrUser'];
  }

  Map<String,dynamic>toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'osUserID':osUserID,
      'password':password,
      'AdminOrUser':AdminOrUser,
    };
  }

}
