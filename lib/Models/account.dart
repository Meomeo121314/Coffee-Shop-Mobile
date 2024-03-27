class Account {
  int? id;
  String? avatar;
  String? username;
  String? password;
  String? name;
  String? phone;
  //  String? email;
  String? address;
  //  DateTime? createDate;
  bool? isActive;
  int? idType;
  String? saltKey;
  bool? flagLogin;
  Account(
      {this.id,
      this.avatar,
      this.username,
      this.password,
      this.name,
      this.phone,
      this.address,
      this.isActive,
      this.idType,
      this.saltKey,
      this.flagLogin});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    username = json['username'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    isActive = json['isActive'];
    idType = json['idType'];
    saltKey = json['saltKey'];
    flagLogin = json['flagLogin'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['isActive'] = isActive;
    data['idType'] = idType;
    data['saltKey'] = saltKey;
    data['flagLogin'] = flagLogin;
    return data;
  }
}
