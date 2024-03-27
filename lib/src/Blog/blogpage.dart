import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/blogs.dart';
import 'package:ila/src/Blog/blogdetails.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  ScrollController verticalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Blog Coffee',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Blogs>>(
            future: APIServices().fetchBlogs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Blogs>? blogList = snapshot.data;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 8.7 / 10.2,
                      crossAxisCount: 2,
                    ),
                    shrinkWrap: true,
                    //scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: BlogCoffee(
                                blog: blogList[index],
                              ))
                        ],
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue.shade300,
                size: 45,
              ));
            },
          ),
        ));
  }
}

// ignore: must_be_immutable
class BlogCoffee extends StatelessWidget {
  Blogs? blog;

  BlogCoffee({
    this.blog,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 165,
      height: 220,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlogDetails(idBlg: blog!.id!)));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Image.network(
                    blog!.image!,
                    width: 157,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                ],
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 4),
                  width: 165,
                  height: 45,
                  child: Text(
                    blog!.title!,
                    maxLines: 2,
                    style:
                        const TextStyle(fontSize: 16, fontFamily: "OpenSans"),
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(blog!.createDate!.toUtc()),
                  style: const TextStyle(
                      fontFamily: "OpenSans", color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
