// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/comment_blog.dart';
import 'package:ila/Models/reply_blog.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Blog/editcomment.dart';
import 'package:ila/src/Blog/replycomment.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BlogComment extends StatefulWidget {
  const BlogComment({super.key});
  @override
  State<BlogComment> createState() => _BlogCommentState();
}

class _BlogCommentState extends State<BlogComment> {
  final TextEditingController _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _comment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 207, 171),
      appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          centerTitle: true,
          title: FutureBuilder<List<CommentBlog>>(
            future: APIServices().fetchCommentBlog(StaticValue.idBlog),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CommentBlog>? ls = snapshot.data!;
                return Text('${ls.length} comment',
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
          )),
      body: Stack(children: [
        Positioned.fill(
          top: 0,
          child: FutureBuilder<List<CommentBlog>>(
            future: APIServices().fetchCommentBlog(StaticValue.idBlog),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<CommentBlog>? lsCmt = snapshot.data!;

                return ListView.builder(
                    itemCount: lsCmt.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == lsCmt.length - 1) {
                        return Column(children: [
                          Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                  onDoubleTap: () {
                                    if (lsCmt[index].idAccount ==
                                        StaticValue.idAccount) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditComment(
                                                  edit: lsCmt[index])));
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
                                            backgroundImage: lsCmt[index].userAvatar == 'NoImage' || lsCmt[index].userAvatar == 'adminAvatar'
                                                ? const NetworkImage(
                                                    'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png')
                                                : NetworkImage(
                                                    '${lsCmt[index].userAvatar}'),
                                            radius: 22,
                                          ),
                                          title: Text(
                                            '${lsCmt[index].userName}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            '${lsCmt[index].comment}',
                                            overflow: TextOverflow.clip,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 75),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    lsCmt[index]
                                                        .dateCreate!
                                                        .toUtc()),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18),
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: IconButton(
                                                      style: IconButton
                                                          .styleFrom(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      icon: const Icon(
                                                        Icons.reply,
                                                        size: 25,
                                                        color: Color.fromARGB(
                                                            255, 181, 57, 5),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ReplyComment(
                                                                        idCmt: lsCmt[index]
                                                                            .id)));
                                                      },
                                                    ))),
                                          ],
                                        ),
                                        FutureBuilder<List<ReplyCommentBlog>>(
                                          future: APIServices().fetchReplyBlog(
                                              StaticValue.idBlog,
                                              lsCmt[index].id),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<ReplyCommentBlog>? lsRep =
                                                  snapshot.data!;
                                              return Row(
                                                children: [
                                                  if (lsRep.isEmpty)
                                                    Container()
                                                  else
                                                    Container(
                                                      width: 165,
                                                      height: 25,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 75),
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5)),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            )),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ReplyComment(
                                                                              idCmt: lsCmt[index].id,
                                                                            )));
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              '${lsRep.length} reply',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                    )
                                                ],
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return Center(
                                                child: LoadingAnimationWidget
                                                    .waveDots(
                                              color: Colors.blue.shade300,
                                              size: 45,
                                            ));
                                          },
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
                                    if (lsCmt[index].idAccount ==
                                        StaticValue.idAccount) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => EditComment(
                                                  edit: lsCmt[index])));
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
                                            backgroundImage: lsCmt[index]
                                                        .userAvatar !=
                                                    'adminAvatar'
                                                ? NetworkImage(
                                                    '${lsCmt[index].userAvatar}')
                                                : const NetworkImage(
                                                    'https://i.redd.it/rci9xf9x8koz.jpg'),
                                            radius: 22,
                                          ),
                                          title: Text(
                                            '${lsCmt[index].userName}',
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: Text(
                                            '${lsCmt[index].comment}',
                                            overflow: TextOverflow.clip,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 75),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    lsCmt[index]
                                                        .dateCreate!
                                                        .toUtc()),
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 18),
                                                child: SizedBox(
                                                    height: 30,
                                                    width: 30,
                                                    child: IconButton(
                                                      style: IconButton
                                                          .styleFrom(),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      icon: const Icon(
                                                        Icons.reply,
                                                        size: 25,
                                                        color: Color.fromARGB(
                                                            255, 181, 57, 5),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    ReplyComment(
                                                                        idCmt: lsCmt[index]
                                                                            .id)));
                                                      },
                                                    ))),
                                          ],
                                        ),
                                        FutureBuilder<List<ReplyCommentBlog>>(
                                          future: APIServices().fetchReplyBlog(
                                              StaticValue.idBlog,
                                              lsCmt[index].id),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<ReplyCommentBlog>? lsRep =
                                                  snapshot.data!;
                                              return Row(
                                                children: [
                                                  if (lsRep.isEmpty)
                                                    Container()
                                                  else
                                                    Container(
                                                      width: 165,
                                                      height: 25,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 75),
                                                      child: ElevatedButton(
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5)),
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                            )),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ReplyComment(
                                                                              idCmt: lsCmt[index].id,
                                                                            )));
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              '${lsRep.length} reply',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          )),
                                                    )
                                                ],
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text('${snapshot.error}');
                                            }
                                            return Center(
                                                child: LoadingAnimationWidget
                                                    .waveDots(
                                              color: Colors.blue.shade300,
                                              size: 45,
                                            ));
                                          },
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
          ),
        ),
        Positioned(
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
                    backgroundImage: NetworkImage('${StaticValue.userAvatar}'),
                    radius: 22,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 12),
                        child: SizedBox(
                          width: 270,
                          child: TextFormField(
                            onChanged: (value) {
                              _comment = value;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'^\s*')),
                            ],
                            maxLength: 200,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Comment is required';
                              }
                              return null;
                            },
                            controller: _commentController,
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
                                hintText: 'Post a comment...',
                                hintStyle: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade300)),
                          ),
                        ))),
                Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: CupertinoButton(
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            APIServices()
                                .insertComment(_commentController.text);
                            _commentController.clear();
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
            )),
      ]),
    );
  }
}
