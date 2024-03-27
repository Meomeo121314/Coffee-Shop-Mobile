class Review {
  int? id;
  int? idAccount;
  int? idProduct;
  double? review;
  DateTime? createDate;
  String? userName;
  String? userAvatar;
  String? productName;
  int? idInvoice;

  Review(
      {this.id,
      this.idAccount,
      this.idProduct,
      this.review,
      this.createDate,
      this.userName,
      this.userAvatar,
      this.productName,
      this.idInvoice});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAccount = json['idAccount'];
    idProduct = json['idProduct'];
    review = json['review'] == null ? 0 : json['review'].toDouble();
    createDate = DateTime.parse(json['createDate'] as String);
    userName = json['userName'];
    userAvatar = json['userAvatar'];
    productName = json['productName'];
    idInvoice = json['idInvoice'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idAccount'] = idAccount;
    data['idProduct'] = idProduct;
    data['review'] = review;
    data['createDate'] = createDate;
    data['userName'] = userName;
    data['userAvatar'] = userAvatar;
    data['productName'] = productName;
    data['idInvoice'] = idInvoice;
    return data;
  }
}
