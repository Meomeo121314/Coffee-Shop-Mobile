class InvoiceDetails {
  int idSupplier;
  String? supplierName;
  double? feeService;
  double? totalDiscountV;
  List<Invoice>? lsInvoiceS;

  InvoiceDetails(
      {required this.idSupplier,
      this.supplierName,
      this.feeService,
      this.totalDiscountV,
      this.lsInvoiceS});

  factory InvoiceDetails.fromJson(Map<String, dynamic> json) => InvoiceDetails(
        idSupplier: json["idSupplier"],
        supplierName: json["supplierName"],
        feeService:
            json['feeService'] == null ? 0 : json['feeService'].toDouble(),
        totalDiscountV: json['totalDiscountV'] == null
            ? 0
            : json['totalDiscountV'].toDouble(),
        lsInvoiceS: List<Invoice>.from(
            json["lsInvoiceS"].map((x) => Invoice.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "idSupplier": idSupplier,
        "supplierName": supplierName,
        "feeService": feeService,
        "totalDiscountV": totalDiscountV,
        "lsInvoiceS": List<dynamic>.from(lsInvoiceS!.map((x) => x.toJson())),
      };
  List<Invoice> getInvoiceS() => lsInvoiceS!;
}

class Invoice {
  int? id;
  int? idInvoice;
  int? idCart;
  int? isStatus;
  double? cartPrice;
  double? productPrice;
  int? ratingReview;
  int? amount;
  int? idSupplier;
  //Product
  String? productName;
  String? image;
  int? idProduct;

  Invoice(
      {this.id,
      this.idInvoice,
      this.idCart,
      this.isStatus,
      this.cartPrice,
      this.productPrice,
      this.ratingReview,
      this.amount,
      this.idSupplier,
      this.productName,
      this.image,
      this.idProduct});

  factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        id: json['id'],
        idInvoice: json['idInvoice'],
        idCart: json['idCart'],
        isStatus: json['isStatus'],
        cartPrice: json['cartPrice'] == null ? 0 : json['cartPrice'].toDouble(),
        productPrice:
            json['productPrice'] == null ? 0 : json['productPrice'].toDouble(),
        ratingReview: json['ratingReview'],
        amount: json['amount'],
        idSupplier: json['idSupplier'],
        productName: json['productName'],
        image: json['image'],
        idProduct: json['idProduct'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "idInvoice": idInvoice,
        "idCart": idCart,
        "isStatus": isStatus,
        "cartPrice": cartPrice,
        "productPrice": productPrice,
        "ratingReview": ratingReview,
        "amount": amount,
        "idSupplier": idSupplier,
        "productName": productName,
        "image": image,
        "idProduct": idProduct,
      };
}
