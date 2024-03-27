class Address {
  int? id;
  //int? idAccount;
  String? userAddress;
  bool? status;
  Address({this.id, this.userAddress, this.status});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userAddress = json['userAddress'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userAddress'] = userAddress;
    data['status'] = status;
    return data;
  }
}
