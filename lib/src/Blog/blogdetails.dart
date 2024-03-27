import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Blog/blogcomment.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BlogDetails extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final idBlg;
  const BlogDetails({Key? key, required this.idBlg}) : super(key: key);

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  ScrollController verticalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: verticalController,
            scrollDirection: Axis.vertical,
            child: FutureBuilder(
                future: APIServices().fetchBlogsDetails(widget.idBlg),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var dayCreate = (snapshot.data!.createDate);
                    StaticValue.idBlog = snapshot.data!.id;
                    String day = DateFormat.yMMMd('en_US').format(dayCreate!);
                    return Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          height: 320,
                          width: 420,
                          child: Stack(
                            children: <Widget>[
                              Image.network('${snapshot.data!.image}',
                                  height: 320, width: 422, fit: BoxFit.cover),
                              Positioned(
                                top: 33,
                                left: 5,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_sharp,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                            width: 360,
                            child: Text(
                              '${snapshot.data!.title}',
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      const TextSpan(text: 'Written by '),
                                      TextSpan(
                                        text: '${snapshot.data!.userType}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                            Row(
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Text(day))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                            color: Colors.black, indent: 15, endIndent: 15),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25, right: 24),
                              child: SizedBox(
                                  width: 360,
                                  child: Text(
                                    '${snapshot.data!.description}',
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(fontSize: 22),
                                  )),
                            )
                          ],
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(
                      child: LoadingAnimationWidget.prograssiveDots(
                    color: Colors.blue.shade300,
                    size: 45,
                  ));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: functionSetIDBlog,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        backgroundColor: const Color.fromARGB(255, 199, 161, 122),
        child: const Icon(Icons.comment_rounded),
      ),
    );
  }

  void functionSetIDBlog() {
    StaticValue.idBlog;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const BlogComment()));
  }
}
