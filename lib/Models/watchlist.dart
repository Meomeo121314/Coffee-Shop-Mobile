class Watchlist {
  int? id;
	int? idProduct;
	String? productName;
	double? productPrice;
	double? discountPrice;
	String? productImage;
	int? saleNumbers;
  bool statusWatchlist = false;

  Watchlist(
      {this.id,
      this.idProduct,
      this.productName,
      this.productPrice,
      this.discountPrice,
      this.productImage,
      this.saleNumbers});

  Watchlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['idProduct'];
    productName = json['productName'];
    productPrice = json['productPrice'] == null ? 0 : json['productPrice'].toDouble();
    discountPrice = json['discountPrice'] == null ? 0 : json['discountPrice'].toDouble();
    productImage = json['productImage'];
    saleNumbers = json['saleNumbers'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idProduct'] = idProduct;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['discountPrice'] = discountPrice;
    data['productImage'] = productImage;
    data['saleNumbers'] = saleNumbers;
    return data;
  }
}
