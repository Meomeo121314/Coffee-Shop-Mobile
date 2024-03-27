class Blogs {
  int? id;
  //String? userCreate;
  String? title;
  String? image;
  String? description;
  DateTime? createDate;
  //int? idAccount;
  //bool? isStatus;
  String? userType;

  Blogs(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.createDate,
      this.userType});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    createDate = DateTime.parse(json['createDate'] as String);
    userType = json['userType'];
    //isStatus = json['isStatus'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['description'] = description;
    data['createDate'] = createDate;
    data['userType'] = userType;
    //data['isStatus'] = isStatus;
    return data;
  }
}
