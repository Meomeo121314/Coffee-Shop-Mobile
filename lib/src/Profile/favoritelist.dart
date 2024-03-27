import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/watchlist.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Category/productdetails.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  ScrollController verticalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text('Favorites list', style: TextStyle(fontSize: 25)),
        ),
        body: SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Watchlist>>(
            future: APIServices().fetchWatchlist(StaticValue.idAccount),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Watchlist>? wList = snapshot.data!;
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 8 / 11.88, crossAxisCount: 2),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Card(
                                semanticContainer: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                ProductDetailsPage(
                                                    idPro: wList[index].idProduct!))));
                                  },
                                  child: Container(
                                    width: 170,
                                    //height: 320,
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Image.network(wList[index].productImage!,
                                            width: 172,
                                            height: 160,
                                            fit: BoxFit.cover),
                                        const SizedBox(height: 2),
                                        Container(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            width: 172,
                                            height: 42,
                                            child: Text(
                                              '${wList[index].productName}',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                  fontSize: 16),
                                            )),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: wList[index].discountPrice! == 0
                                                ? Row(children: [
                                                    Text(
                                                        '\$${wList[index].productPrice! - wList[index].discountPrice!}',
                                                        style: GoogleFonts.openSans(
                                                                fontSize: 17,
                                                                color: const Color.fromARGB(255,181,57,5)))
                                                  ])
                                                : Row(children: [
                                                    Text(
                                                        '\$${wList[index].productPrice! - wList[index].discountPrice!}',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontSize: 17,
                                                                color: const Color
                                                                    .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5))),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      '\$${wList[index].productPrice!}',
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor:
                                                              Colors.grey,
                                                          fontSize: 15,
                                                          color: Colors.grey),
                                                    ),
                                                  ])),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    '${wList[index].saleNumbers} sold',
                                                    style: GoogleFonts.trochut(
                                                        fontSize: 17))
                                              ]),
                                        ),
                                        Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          APIServices().deleteWatchList(wList[index].idProduct,StaticValue.idAccount);
                                                          wList.removeAt(index);
                                                        });
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete,
                                                          color: Colors.white),
                                                      style:
                                                          IconButton.styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5))),
                                                ])),

                                        // Image.asset(
                                        //   'images/assets/icon/8664938_trash_can_delete_remove_icon.png',
                                        //   width: 20,
                                        //   height: 20,
                                        //   fit: BoxFit.cover,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
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
        ));
  }
}
