import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/blogs.dart';
import 'package:ila/Models/categories.dart';
import 'package:ila/Models/products.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/main.dart';
import 'package:ila/src/Blog/blogpage.dart';
import 'package:ila/src/Blog/blogdetails.dart';
import 'package:ila/src/Category/categorypage.dart';
import 'package:ila/src/Cart/cartpage.dart';
import 'package:ila/src/Category/productdetails.dart';
import 'package:ila/src/Profile/favoritelist.dart';
import 'package:ila/src/Order/orderpage.dart';
import 'package:ila/src/Profile/profilepage.dart';
import 'package:ila/src/searchpage.dart';
import 'package:intl/intl.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Home extends StatelessWidget {
  const Home({super.key, int? idUser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSwatch(backgroundColor: Colors.grey.shade100)),
      home: const HomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final List<String> imagesList = [
    "https://i.pinimg.com/564x/b1/b0/ad/b1b0add4d209c73445b9a70832652f2c.jpg",
    "https://i.pinimg.com/564x/ff/ee/53/ffee531b4587508b55863f729b37096e.jpg",
    "https://i.pinimg.com/564x/87/d7/eb/87d7eb57283afcee3d5437cbf07c3e31.jpg",
    "https://i.pinimg.com/564x/d1/c8/93/d1c89356cae6997d236a217bf65b79cb.jpg",
    "https://i.pinimg.com/564x/54/c5/b0/54c5b0476d71d1c3ad7682bd3c4e0782.jpg",
    "https://i.pinimg.com/564x/03/e1/0f/03e10f76d1715dc1581f94a4b536b863.jpg"
  ];

  List<int> verticalData = [];
  List<int> horizontalData = [];

  final int increment = 10;

  bool isLoadingVertical = false;
  bool isLoadingHorizontal = false;

  @override
  void initState() {
    _loadMoreVertical();
    _loadMoreHorizontal();

    super.initState();
  }

  Future _loadMoreVertical() async {
    setState(() {
      isLoadingVertical = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));

    verticalData.addAll(
        List.generate(increment, (index) => verticalData.length + index));

    setState(() {
      isLoadingVertical = false;
    });
  }

  Future _loadMoreHorizontal() async {
    setState(() {
      isLoadingHorizontal = true;
    });

    // Add in an artificial delay
    await Future.delayed(const Duration(seconds: 2));

    horizontalData.addAll(
        List.generate(increment, (index) => horizontalData.length + index));

    setState(() {
      isLoadingHorizontal = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 75,
        backgroundColor: const Color.fromARGB(136, 219, 193, 172),
        title: Container(
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            height: 45,
            child: CupertinoButton(
                padding: const EdgeInsets.only(left: 15, bottom: 2),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SearchPage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.search,
                                  size: 20,
                                  color: Colors.black,
                                )),
                          ),
                          TextSpan(
                            text: 'Search...',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
        actions: [
          IconButton(
              onPressed: () {
                APIServices().autoUpdateItemInCart(StaticValue.idAccount);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: Image.asset(
                'images/assets/icon/5594947.png',
                height: 35,
                width: 35,
              )),
          IconButton(
              icon: const Icon(Icons.menu_rounded),
              iconSize: 35,
              onPressed: () {
                _openEndDrawer();
              }),
        ],
      ),
      body: LazyLoadScrollView(
        isLoading: isLoadingVertical,
        onEndOfPage: () => _loadMoreVertical(),
        child: Scrollbar(
          thickness: 0,
          child: ListView(children: [
            Column(
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    height: 205,
                    viewportFraction: 0.77,
                    autoPlayAnimationDuration: const Duration(milliseconds: 80),
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: imagesList
                      .map(
                        (item) => Center(
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      .toList(),
                ),
                Container(
                  width: 420,
                  color: const Color.fromARGB(51, 219, 193, 172),
                  child: FutureBuilder<List<Categories>>(
                    future: APIServices().fetchCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Categories>? cateList = snapshot.data;
                        return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 10 / 7,
                              crossAxisCount: 3,
                            ),
                            shrinkWrap: true,
                            //scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cateList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListCategory(
                                cate: cateList[index],
                              );
                            });
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return Center(
                          child: LoadingAnimationWidget.threeArchedCircle(
                        color: Colors.blue.shade300,
                        size: 45,
                      ));
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Blog Coffe",
                          style:
                              TextStyle(fontSize: 32, fontFamily: "SingleDay"),
                        )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BlogPage()),
                              );
                            },
                            child: const Row(
                              children: [
                                Text('View All ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 181, 57, 5))),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 17,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                ),
                              ],
                            )),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5
                ),
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: LazyLoadScrollView(
                      isLoading: isLoadingHorizontal,
                      scrollDirection: Axis.horizontal,
                      onEndOfPage: () => _loadMoreHorizontal(),
                      child: Scrollbar(
                        thickness: 0,
                        child: FutureBuilder<List<Blogs>>(
                          future: APIServices().fetchBlogs(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Blogs>? blogList = snapshot.data;
                              return ListView.builder(
                                  itemCount: blogList!.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(children: [
                                              BlogCoffee(
                                                blog: blogList[index],
                                              )
                                            ])),
                                      ],
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            return Center(
                                child: LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.blue.shade300,
                              size: 45,
                            ));
                          },
                        ),
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Today's Suggestions",
                          style:
                              TextStyle(fontSize: 32, fontFamily: "SingleDay"),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder<List<Products>>(
                  future: APIServices().fetchProducts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Products>? proList = snapshot.data;
                      return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 8.2 / 10,
                            crossAxisCount: 2,
                          ),
                          shrinkWrap: true,
                          //scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: proList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Suggest(
                                    pro: proList[index],
                                  ),
                                )
                              ],
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                      color: Colors.blue.shade300,
                      size: 45,
                    ));
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 181, 57, 5),
                ), //BoxDecoration
                child: OutlinedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 2)),
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Color.fromARGB(255, 181, 57, 5))),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 181, 57, 5)),
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()));
                    },
                    child: Row(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${StaticValue.userAvatar}'),
                              radius: 42,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${StaticValue.userFullName}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text("${StaticValue.userPhone}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ))
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ))),
            ListTile(
              leading: Image.asset('images/assets/icon/12315409.png',
                  width: 25, height: 25, fit: BoxFit.cover),
              title: const Text(' Your Order '),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const OrderPage()));
              },
            ),
            ListTile(
              leading: Image.asset(
                'images/assets/icon/10630352.png',
                width: 25,
                height: 25,
                fit: BoxFit.cover,
              ),
              title: const Text(' Favorite List '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                StaticValue.idAccount = null;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
      ),
      endDrawerEnableOpenDragGesture: false, //Draw
    );
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogDetails(
                        idBlg: blog!.id!,
                      )));
        },
        child: Container(
          color: Colors.white,
          width: 135,
          height: 210,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                blog!.image!,
                width: 135,
                height: 135,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 4),
                  width: 135,
                  height: 55,
                  child: Text(blog!.title!,
                      maxLines: 2, style: GoogleFonts.openSans(fontSize: 16))),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text(
                  DateFormat('dd/MM/yyyy').format(blog!.createDate!.toUtc()),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Suggest extends StatelessWidget {
  Products? pro;

  Suggest({
    this.pro,
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {
          
          APIServices().autoStartEndDiscountUsers();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => ProductDetailsPage(idPro: pro!.id!))));
        },
        child: Container(
          width: 170,
          height: 240,
          color: Colors.white,
          child: Column(
            children: [
              Image.network(pro!.image!,
                  width: 172, height: 160, fit: BoxFit.cover),
              const SizedBox(height: 2),
              Container(
                  padding: const EdgeInsets.only(left: 4),
                  width: 172,
                  height: 42,
                  child: Text(pro!.title!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(fontSize: 16))),
              const SizedBox(height: 2),
              Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Text('\$${pro!.finalPrice!.toString()}',
                          style: GoogleFonts.openSans(
                              fontSize: 17,
                              color: const Color.fromARGB(255, 181, 57, 5)))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
  
}

// ignore: must_be_immutable
class ListCategory extends StatelessWidget {
  Categories? cate;

  ListCategory({
    this.cate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 120,
              width: 120,
              child: CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CategoryPage(idCate: cate!.id!)));
                },
                child: Column(
                  children: <Widget>[
                    Image.asset(
                        'images/assets/icon/tea-coffee-mug-hot-heart-256.webp',
                        width: 40,
                        height: 40,
                        color: const Color.fromARGB(255, 181, 57, 5),
                        fit: BoxFit.cover),
                    Text(cate!.title!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.openSans(
                            fontSize: 15, color: Colors.black))
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

