class Categories {
  int? id;
  String? title;
  // DateTime? createDate;
  // bool? isActive;
  Categories({
    this.id,
    this.title,
    // this.createDate,
    // this.isActive,
  });

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    // createDate = DateTime.parse(json['createDate'] as String);
    // isActive = json['isActive'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    // data['createDate'] = createDate;
    // data['isActive'] = isActive;
    return data;
  }
}