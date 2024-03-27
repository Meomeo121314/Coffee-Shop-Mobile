class InvoicesView {
  int? id;
  int? idAccount;
  String? address;
  double? totalPrice;
  String? idPayment;
  String? idVoucherS;
  String? idVoucherA;
  DateTime? createDate;
  int? isStatus;
  String? codeInvoice;
  int? quantity;
  //view
  String? userName;
  String? userPhone;
  double? totalDiscountV;
  double? profitsAdmin;

  InvoicesView(
      {this.id,
      this.idAccount,
      this.address,
      this.totalPrice,
      this.idPayment,
      this.idVoucherS,
      this.idVoucherA,
      this.createDate,
      this.isStatus,
      this.codeInvoice,
      this.quantity,
      this.userName,
      this.userPhone,
      this.totalDiscountV,
      this.profitsAdmin});

  InvoicesView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAccount = json['idAccount'];
    address = json['address'];
    totalPrice = json['totalPrice'] == null ? 0 : json['totalPrice'].toDouble();
    idPayment = json['idPayment'];
    idVoucherS = json['idVoucherS'];
    idVoucherA = json['idVoucherA'];
    createDate = json['createDate'] == null ? DateTime.now() : DateTime.parse(json['createDate'] as String) ; 
    isStatus = json['isStatus'];
    codeInvoice = json['codeInvoice'];
    quantity = json['quantity'];
    userName = json['userName'];
    userPhone = json['userPhone'];
    totalDiscountV =
        json['totalDiscountV'] == null ? 0 : json['totalDiscountV'].toDouble();
    profitsAdmin =
        json['profitsAdmin'] == null ? 0 : json['profitsAdmin'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idAccount'] = idAccount;
    data['address'] = address;
    data['totalPrice'] = totalPrice;
    data['idPayment'] = idPayment;
    data['idVoucherS'] = idVoucherS;
    data['idVoucherA'] = idVoucherA;
    data['createDate'] = createDate;
    data['isStatus'] = isStatus;
    data['codeInvoice'] = codeInvoice;
    data['quantity'] = quantity;
    data['userName'] = userName;
    data['userPhone'] = userPhone;
    data['totalDiscountV'] = totalDiscountV;
    data['profitsAdmin'] = profitsAdmin;

    return data;
  }
}
