
class ReplyCommentBlog {
  int? id;
	String? comment;
	int? timeSpace;
	DateTime? dateCreate;
	int? idAccount;
	String? userName;
  String? userAvatar;
	String? userReply;
	//formMain
	int? idMainC;
	int? idBlog;
	int? idReply;

  ReplyCommentBlog(
      {this.id,
      this.comment,
      this.timeSpace,
      this.dateCreate,
      this.idAccount,
      this.userName, this.userAvatar,
      this.userReply,
      this.idMainC,this.idBlog,this.idReply});


  factory ReplyCommentBlog.fromJson(Map<String, dynamic> json) => ReplyCommentBlog(
        id: json["id"],
        comment: json["comment"],
        timeSpace: json["timeSpace"],
        dateCreate: DateTime.parse(json['dateCreate'] as String),
        idAccount: json["idAccount"],
        userName: json["userName"],
        userAvatar:json['userAvatar'],
        userReply: json["userReply"],
        idMainC: json["idMainC"],
        idBlog:json["idBlog"],
        idReply: json["idReply"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "timeSpace": timeSpace,
        "dateCreate": dateCreate,
        "idAccount": idAccount,
        "userName": userName,
        "userAvatar":userAvatar,
        "userReply": userReply,
        "idMainC": idMainC,
        "idBlog": idBlog,
        "idReply": idReply,
      };
}