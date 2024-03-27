class Supplier {
  int? id;
  String? image;
  //String? avatar;
  String? title;
  String? phone;
  String? email;
  String? address;
  //  DateTime? requestDate;
  //  DateTime? createDate;
  int? isActive;
  String? cateName;

  Supplier(
      {this.id, this.image, this.title, this.phone, this.email, this.address,this.cateName});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    cateName = json['cateName'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['cateName'] = cateName;
    return data;
  }
}

class Cart {
  int? id;
  int? idAccount;
  int? idProduct;
  int? amount;
  double? price;
  bool? status;
  int? idSupplier;
  String? nameSupplier;
  int? addAmount;
}
