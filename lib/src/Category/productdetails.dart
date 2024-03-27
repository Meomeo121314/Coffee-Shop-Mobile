import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/object_message.dart';
import 'package:ila/Models/products.dart';
import 'package:ila/Models/watchlist.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Category/proreview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  final idPro;

  const ProductDetailsPage({
    Key? key,
    required this.idPro,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

// ignore: must_be_immutable
class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final List<String> imagesList = [];
  ScrollController verticalController = ScrollController();
  CarouselController buttonCarouselController = CarouselController();
  int quantity = 0;
  bool isSelected = true;
  
  List<bool> test =[];
  Future<List<Watchlist>> checkWatchlist = APIServices().fetchWatchlist(StaticValue.idAccount);
  Future<void> loadJsonData() async {
    Products pro = await APIServices().fetchProductsDetails(widget.idPro);
    setState(() {
      imagesList.add(pro.image!);
      imagesList.add(pro.image1!);
      imagesList.add(pro.image2!);
      imagesList.add(pro.image3!);
    });
  }

  @override
  void initState() {
    super.initState();
    loadJsonData();
    checkWatchlist.then((value) {
      value.forEach((element) {
        if (element.idProduct == widget.idPro) {
          setState(() {
            isSelected = element.statusWatchlist;
          });
        }
      });
    });
    print(isSelected);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: FutureBuilder(
          future: APIServices().fetchProductsDetails(widget.idPro),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            if(snapshot.data != null){
                return Stack(children: [
                Positioned.fill(
                    top: 0,
                    child: Column(
                      children: [
                        Container(
                            height: 480,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    CarouselSlider(
                                        carouselController:
                                            buttonCarouselController,
                                        options: CarouselOptions(
                                            height: 320,
                                            autoPlay: false,
                                            enlargeCenterPage: true,
                                            viewportFraction: 1.55),
                                        items: imagesList
                                            .map((item) => Center(
                                                child: Image.network(item,
                                                    fit: BoxFit.cover)))
                                            .toList()),
                                    Positioned(
                                      top: 25,
                                      left: 10,
                                      child: IconButton(
                                        icon:
                                            const Icon(Icons.arrow_back_sharp),
                                        iconSize: 30,
                                        color: Colors.black,
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      right: 20,
                                      child: IconButton(
                                        icon: isSelected == true
                                            ? const Icon(
                                                Icons.favorite_border_sharp)
                                            : const Icon(Icons.favorite_sharp),
                                        iconSize: 30,
                                        color: Colors.black,
                                        onPressed: () {
                                          setState(() {
                                            isSelected = !isSelected;
                                            if (isSelected == true) {
                                              setState(() {
                                                APIServices()
                                                    .deleteWatchList(
                                                        widget.idPro,
                                                        StaticValue.idAccount)
                                                    .then((value) {
                                                  if (value.body == "true") {
                                                    var snackdemo =
                                                        const SnackBar(
                                                      content: Text(
                                                          'Delete Products Into WatchList'),
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              199, 161, 122),
                                                      elevation: 10,
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      margin: EdgeInsets.all(5),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            snackdemo);
                                                  }
                                                });
                                              });
                                            } else {
                                              APIServices()
                                                  .insertWatchList(widget.idPro,
                                                      StaticValue.idAccount)
                                                  .then((value) {
                                                if (value.flagMessage == true) {
                                                  var snackdemo = SnackBar(
                                                    content:
                                                        Text(value.message),
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 199, 161, 122),
                                                    elevation: 10,
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackdemo);
                                                }
                                              });
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Positioned(
                                        top: 140,
                                        left: 15,
                                        child: SizedBox(
                                            height: 38,
                                            width: 38,
                                            child: IconButton(
                                              style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black12),
                                              padding: const EdgeInsets.all(0),
                                              icon: const Icon(
                                                  Icons.chevron_left_outlined,
                                                  size: 35,
                                                  color: Colors.black),
                                              onPressed: () =>
                                                  buttonCarouselController
                                                      .nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      10),
                                                          curve: Curves.linear),
                                            ))),
                                    Positioned(
                                        top: 140,
                                        right: 20,
                                        child: SizedBox(
                                            height: 38,
                                            width: 38,
                                            child: IconButton(
                                              style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.black12),
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              icon: const Icon(
                                                Icons.chevron_right_outlined,
                                                size: 35,
                                                color: Colors.black,
                                              ),
                                              onPressed: () =>
                                                  buttonCarouselController
                                                      .nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      10),
                                                          curve: Curves.linear),
                                            ))),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.topCenter,
                                  width: 380,
                                  color: Colors.white,
                                  child: Text(
                                    '${snapshot.data!.title}',
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Row(
                                    children: [
                                      snapshot.data!.price ==
                                              snapshot.data!.finalPrice
                                          ? Text(
                                              '\$${snapshot.data!.price}',
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Color.fromARGB(
                                                      255, 181, 57, 5)),
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  '\$${snapshot.data!.price}',
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Color.fromARGB(
                                                              255, 181, 57, 5),
                                                      fontSize: 22,
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5)),
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '\$${snapshot.data!.finalPrice}',
                                                  style: const TextStyle(
                                                      fontSize: 22,
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5)),
                                                ),
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                                '${snapshot.data!.saleNumbers} Sold',
                                                style: const TextStyle(
                                                    fontSize: 22,
                                                    color: Colors.black)))
                                      ],
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReviewPage(
                                                              idP: snapshot
                                                                  .data!.id)));
                                            },
                                            child: const Text('View Review',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 90, 169, 228)))))
                                  ],
                                )
                              ],
                            )),
                        Container(
                            width: 380,
                            height: 300,
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: SingleChildScrollView(
                              controller: verticalController,
                              scrollDirection: Axis.vertical,
                              child: Text(
                                '${snapshot.data!.description}',
                                overflow: TextOverflow.clip,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ))
                      ],
                    )),
                Positioned(
                    bottom: 0,
                    width: 422,
                    height: 65,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 12)),
                                  quantity > 0
                                      ? IconButton(
                                          icon: const Icon(Icons.remove),
                                          color: const Color.fromARGB(
                                              255, 199, 161, 122),
                                          onPressed: () =>
                                              setState(() => quantity--),
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade100))
                                      : IconButton(
                                          icon: Icon(
                                            Icons.remove,
                                            color: Colors.grey.shade300,
                                          ),
                                          onPressed: () {},
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade100)),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 8)),
                                  Text(
                                    quantity.toString(),
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 8)),
                                  quantity >= 50
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.grey.shade300,
                                          ),
                                          onPressed: () {},
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade100))
                                      : IconButton(
                                          icon: const Icon(Icons.add),
                                          color: const Color.fromARGB(
                                              255, 199, 161, 122),
                                          onPressed: () =>
                                              setState(() => quantity++),
                                          style: IconButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade100)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 260,
                                padding: const EdgeInsets.only(right: 35),
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 199, 161, 122)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      )),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (quantity > 0) {
                                          setState(() {
                                            Future<ObjectMessage> insertPro =
                                                APIServices().insertCartProduct(
                                                    widget.idPro, quantity);
                                            insertPro.then((data) {
                                              if (data.flagMessage == true) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2), () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      });
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        insetPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Container(
                                                            width: 100,
                                                            height: 130,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white70),
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20,
                                                                    20,
                                                                    20,
                                                                    20),
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'images/assets/icon/652757.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                const Text(
                                                                    "Added to cart",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .black),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2), () {
                                                        Navigator.of(context)
                                                            .pop(true);
                                                      });
                                                      return Dialog(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        insetPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Container(
                                                            width: 100,
                                                            height: 130,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Colors
                                                                    .white70),
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20,
                                                                    20,
                                                                    20,
                                                                    20),
                                                            child: Column(
                                                              children: [
                                                                Image.asset(
                                                                  'images/assets/icon/652759.png',
                                                                  width: 50,
                                                                  height: 50,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                    data
                                                                        .message,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .black),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center),
                                                              ],
                                                            )),
                                                      );
                                                    });
                                              }
                                            });
                                          });
                                        } else {
                                          null;
                                        }
                                      });
                                    },
                                    child: const Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ]);
          
            } else{
              return SizedBox();
            } } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return Center(
                child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.blue.shade300,
              size: 45,
            ));
          }),
    );
  }
}
