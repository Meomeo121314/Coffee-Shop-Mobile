class CommentBlog {
  int? id;
  String? comment;
  int? timeSpace;
  DateTime? dateCreate;
  int? idAccount;
  String? userName;
  String? userAvatar;
  int? countSubC;

  CommentBlog(
      {this.id,
      this.comment,
      this.timeSpace,
      this.dateCreate,
      this.idAccount,
      this.userName,
      this.userAvatar,
      this.countSubC});

  factory CommentBlog.fromJson(Map<String, dynamic> json) => CommentBlog(
        id: json["id"],
        comment: json["comment"],
        timeSpace: json["timeSpace"],
        dateCreate: DateTime.parse(json['dateCreate'] as String),
        idAccount: json["idAccount"],
        userName: json["userName"],
        userAvatar: json["userAvatar"],
        countSubC: json["countSubC"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "timeSpace": timeSpace,
        "dateCreate": dateCreate,
        "idAccount": idAccount,
        "userName": userName,
        "userAvatar":userAvatar,
        "countSubC": countSubC,
      };
}

