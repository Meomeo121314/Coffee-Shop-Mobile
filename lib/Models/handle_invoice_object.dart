
class HandleInvoiceObject{
  int? id;
	int? idUser;
	String? lsCartSelect;
	String? voucherAdmin;
	String? lsVoucherS;
	int? idAddress;
	double? feeService;

  HandleInvoiceObject(
      {this.id,
      this.idUser,
      this.lsCartSelect,
      this.voucherAdmin,
      this.lsVoucherS,
      this.feeService});

  HandleInvoiceObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    lsCartSelect = json['lsCartSelect'];
    voucherAdmin = json['voucherAdmin'];
    lsVoucherS =json['lsVoucherS'];
    feeService = json['feeService'] == null ? 0 : json['feeService'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idUser'] = idUser;
    data['lsCartSelect'] = lsCartSelect;
    data['voucherAdmin'] = voucherAdmin;
    data['lsVoucherS'] = lsVoucherS;
    data['feeService'] = feeService;
    return data;
  }
}
