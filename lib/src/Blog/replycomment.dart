import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/reply_blog.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Blog/blogcomment.dart';
import 'package:ila/src/Blog/editreply.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReplyComment extends StatefulWidget {
  final idCmt;
  const ReplyComment({Key? key, required this.idCmt}) : super(key: key);
  @override
  State<ReplyComment> createState() => _BlogCommentState();
}

class _BlogCommentState extends State<ReplyComment> {
  final TextEditingController _replyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _reply;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 207, 171),
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          centerTitle: true,
          title: FutureBuilder<List<ReplyCommentBlog>>(
            future:
                APIServices().fetchReplyBlog(StaticValue.idBlog, widget.idCmt),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ReplyCommentBlog>? ls = snapshot.data!;
                return Text('${ls.length} reply',
                    style: const TextStyle(fontSize: 25));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(
                  child: LoadingAnimationWidget.waveDots(
                color: Colors.blue.shade300,
                size: 45,
              ));
            },
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const BlogComment()));
          }),
          ),
      body: Stack(children: [
        Positioned.fill(
            top: 0,
            child: FutureBuilder<List<ReplyCommentBlog>>(
              future: APIServices()
                  .fetchReplyBlog(StaticValue.idBlog, widget.idCmt),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ReplyCommentBlog>? lsRep = snapshot.data!;

                  return ListView.builder(
                      itemCount: lsRep.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == lsRep.length - 1) {
                          return Column(children: [
                            Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                    onDoubleTap: () {
                                      if (lsRep[index].idAccount ==
                                          StaticValue.idAccount) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => EditReply(
                                                    reply: lsRep[index],
                                                    idMC: widget.idCmt)));
                                      } else {
                                        null;
                                      }
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: lsRep[index]
                                                          .userAvatar !=
                                                      'adminAvatar'
                                                  ? NetworkImage(
                                                      '${lsRep[index].userAvatar}')
                                                  : const NetworkImage(
                                                      'https://i.redd.it/rci9xf9x8koz.jpg'),
                                              radius: 22,
                                            ),
                                            title: Text(
                                              '${lsRep[index].userName}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              '${lsRep[index].comment}',
                                              overflow: TextOverflow.clip,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 75),
                                                child: Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(lsRep[index]
                                                          .dateCreate!
                                                          .toUtc()),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ))),
                            Container(height: 70)
                          ]);
                        } else {
                          return Column(children: [
                           Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                    onDoubleTap: () {
                                      if (lsRep[index].idAccount ==
                                          StaticValue.idAccount) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => EditReply(
                                                    reply: lsRep[index],
                                                    idMC: widget.idCmt)));
                                      } else {
                                        null;
                                      }
                                    },
                                    child: SizedBox(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: CircleAvatar(
                                              backgroundImage: lsRep[index]
                                                          .userAvatar !=
                                                      'adminAvatar'
                                                  ? NetworkImage(
                                                      '${lsRep[index].userAvatar}')
                                                  : const NetworkImage(
                                                      'https://i.redd.it/rci9xf9x8koz.jpg'),
                                              radius: 22,
                                            ),
                                            title: Text(
                                              '${lsRep[index].userName}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              '${lsRep[index].comment}',
                                              overflow: TextOverflow.clip,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 75),
                                                child: Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(lsRep[index]
                                                          .dateCreate!
                                                          .toUtc()),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                    ))),
                          ]);
                        }
                      });
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Center(
                    child: LoadingAnimationWidget.waveDots(
                  color: Colors.blue.shade300,
                  size: 45,
                ));
              },
            )),
        Form(
            key: _formKey,
            child: Positioned(
                bottom: 0,
                width: 420,
                height: 75,
                child: Container(
                  width: 420,
                  color: Colors.white,
                  child: Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${StaticValue.userAvatar}'),
                        radius: 22,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 12),
                        child: SizedBox(
                          width: 270,
                          child: TextFormField(
                            onChanged: (value) {
                              _reply = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'^\s*')),
                            ],
                            maxLength: 200,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Reply is required';
                              }
                              // else if (RegExp(r"\s").hasMatch(value!)) {
                              //   return 'Please enter valid ply';
                              // }
                              return null;
                            },
                            controller: _replyController,
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400,
                                        width: 1.5)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 181, 57, 5),
                                        width: 2)),
                                hintText: 'Post a reply...',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade300)),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: CupertinoButton(
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                APIServices().insertReply(
                                    widget.idCmt,
                                    widget.idCmt,
                                    widget.idCmt,
                                    _replyController.text);
                                _replyController.clear();
                              }
                            });
                          },
                          child: Image.asset(
                            'images/assets/icon/icons_send-256.webp',
                            width: 35,
                            height: 35,
                            color: const Color.fromARGB(255, 181, 57, 5),
                          ),
                        )),
                  ]),
                )))
      ]),
    );
  }
}
