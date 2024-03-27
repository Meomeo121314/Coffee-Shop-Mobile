class Products {
  int? id;
  String? title;
  String? image;
  String? image1;
  String? image2;
  String? image3;
  String? description;
  double? price;
  double? finalPrice;
  int? idProducts;
  int? isActive;
  int? idcate;
  String? cateName;
  String? supplierName;
  String? supplierAvatar;
  int? saleNumbers;

  Products(
      {this.id,
      this.image,
      this.title,
      this.image1,
      this.image2,
      this.image3,
      this.description,
      this.price,
      this.finalPrice,
      this.idProducts,
      this.isActive,
      this.idcate,
      this.cateName,
      this.supplierName,
      this.supplierAvatar,this.saleNumbers});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    description = json['description'];
    price = json['price'] == null ? 0 : json['price'].toDouble();
    finalPrice = json['finalPrice'] == null ? 0 : json['finalPrice'].toDouble();
    idProducts = json['idProducts'];
    isActive = json['isActive'];
    idcate = json['idcate'];
    cateName = json['cateName'];
    supplierName = json['supplierName'];
    supplierAvatar = json['supplierAvatar'];
    saleNumbers = json['saleNumbers'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['description'] = description;
    data['price'] = price;
    data['finalPrice'] = finalPrice;
    data['idProducts'] = idProducts;
    data['isActive'] = isActive;
    data['idcate'] = idcate;
    data['cateName'] = cateName;
    data['supplierName'] = supplierName;
    data['supplierAvatar'] = supplierAvatar;
    data['saleNumbers'] = saleNumbers;
    return data;
  }
}
