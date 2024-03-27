import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/reply_blog.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Blog/replycomment.dart';

// ignore: must_be_immutable
class EditReply extends StatefulWidget {
  ReplyCommentBlog? reply;
  final idMC;
  EditReply({Key? key, this.reply, this.idMC}) : super(key: key);
  static BuildContext? commentContext;
  @override
  State<EditReply> createState() => _EditReplyState();
}

class _EditReplyState extends State<EditReply> {
  final TextEditingController replyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _edit;
  @override
  void initState() {
    setState(() {
      replyController.text = widget.reply!.comment.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 207, 171),
      appBar: AppBar(centerTitle: true, title: const Text('Edit')),
      body: Form(
          key: _formKey,
          child: Container(
              width: 420,
              height: 150,
              color: Colors.white,
              child: Column(
                children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('${StaticValue.userAvatar}'),
                        radius: 22,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 15, bottom: 12),
                        child: SizedBox(
                            width: 310,
                            child: TextFormField(
                              onChanged: (value) {
                                _edit = value;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    RegExp(r'^\s*')),
                              ],
                              maxLength: 200,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Comment is required';
                                }
                                return null;
                              },
                              controller: replyController,
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
                                          color:
                                              Color.fromARGB(255, 181, 57, 5),
                                          width: 2)),
                                  hintText: 'Post a comment...',
                                  hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey.shade300)),
                            ))),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                  APIServices().deleteCommentandReply(widget.reply!.id,StaticValue.idBlog);
                                });
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ReplyComment(idCmt: widget.idMC)));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      //Navigator.pop(BlogComment.commentContext!, true);
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey.shade100),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 181, 57, 5),
                                          fontSize: 16),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        APIServices().editCommentandReply(
                                            widget.reply!.id,
                                            replyController.text);
                                      });
                                      Navigator.pop(context, true);
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ReplyComment(
                                                      idCmt: widget.idMC)));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey.shade100),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10)))),
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 181, 57, 5),
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ]),
                  )
                ],
              ))),
    );
  }

  Future<void> _deleteComment() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                style: TextStyle(
                    color: Color.fromARGB(255, 181, 57, 5), fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  APIServices().deleteCommentandReply(
                      widget.reply!.id, StaticValue.idBlog);
                });
                Navigator.of(context).pop(true);
                Navigator.pop(context, true);
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) => ReplyComment(idCmt: widget.idMC)))
                    .then((value) {
                  setState(() {});
                });
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                    color: Color.fromARGB(255, 181, 57, 5), fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
