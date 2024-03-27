class Vouchers {
  String? id;
  double? condition;
  double? discount;
  int? usercreate;
  DateTime? startDate;
  DateTime? endDate;
  //bool? isActive;
  //View
  int? dayLeft;
  int? timeExpiered;
  //Supplier
  String? supplierName;
  String? supplierAvatar;

  Vouchers(
      {this.id,
      this.condition,
      this.discount,
      this.usercreate,
      this.startDate,
      this.endDate,
      this.dayLeft,
      this.timeExpiered,this.supplierName,this.supplierAvatar});

  Vouchers.fromJson(Map<String, dynamic> json) {
    id = json['id']; 
    condition = json['condition'] == null ? 0 : json['condition'].toDouble();
    discount =  json['discount'] == null ? 0 : json['discount'].toDouble();
    usercreate = json['usercreate'] == null ? 0 : int.parse(json['usercreate'] as String);
    startDate =  DateTime.parse(json['startDate'] as String);
    endDate = DateTime.parse(json['endDate'] as String);
    dayLeft = json['dayLeft'];
    timeExpiered = json['timeExpiered'];
    supplierName = json['supplierName'];
    supplierAvatar = json['supplierAvatar'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['condition'] = condition;
    data['discount'] = discount;
    data['usercreate'] = usercreate;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['dayLeft'] = dayLeft;
    data['timeExpiered'] = timeExpiered;
    data['supplierName']=supplierName;
    data['supplierAvatar']=supplierAvatar;
    return data;
  }
}
