class HandleStatusObject {
  int? userCase;
  int? statusType;
  int? idInvoice;
  int? idSupplier;
  int? idInvoiceDetails;
  int? idUser;

  HandleStatusObject(
      {this.userCase,
      this.statusType,
      this.idInvoice,
      this.idSupplier,
      this.idInvoiceDetails,
      this.idUser});

  HandleStatusObject.fromJson(Map<String, dynamic> json) {
    userCase = json['userCase'];
    statusType = json['statusType'];
    idInvoice = json['idInvoice'];
    idSupplier = json['idSupplier'];
    idInvoiceDetails = json['idInvoiceDetails'];
    idUser = json['idUser'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userCase'] = userCase;
    data['statusType'] = statusType;
    data['idInvoice'] = idInvoice;
    data['idSupplier'] = idSupplier;
    data['idInvoiceDetails'] = idInvoiceDetails;
    data['idUser'] = idUser;
    return data;
  }
}
