class SupplierCart {
  int idSupplier;
  String? supplierName;
  List<Cart>? lsCartS;

  SupplierCart({required this.idSupplier, this.supplierName, this.lsCartS});

  factory SupplierCart.fromJson(Map<String, dynamic> json) => SupplierCart(
        idSupplier: json["idSupplier"],
        supplierName: json["supplierName"],
        lsCartS: List<Cart>.from(json["lsCartS"].map((x) => Cart.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "idSupplier": idSupplier,
        "supplierName": supplierName,
        "lsCartS": List<dynamic>.from(lsCartS!.map((x) => x.toJson())),
      };
  List<Cart> getCarts() => lsCartS!;
}

class Cart {
  int id;
  int? idAccount;
  int? idProduct;
  int? idSupplier;
  String? productName;
  String? image;
  late int amount;
  double? price;
  bool? status;
  double priceProduct = 0;
  Cart({
    required this.id,
    this.idAccount,
    this.idProduct,
    this.idSupplier,
    this.productName,
    this.image,
    required this.amount,
    this.price,
    this.status,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        idAccount: json['idAccount'],
        idProduct: json['idProduct'],
        idSupplier: json['idSupplier'],
        productName: json['productName'],
        image: json['image'],
        amount: json['amount'],
        price: json['price'] == null ? 0 : json['price'].toDouble(),
        status: json['status'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "idAccount": idAccount,
        "idProduct": idProduct,
        "idSupplier": idSupplier,
        "productName": productName,
        "image": image,
        "amount": amount,
        "price": price,
        "status": status,
      };
}
