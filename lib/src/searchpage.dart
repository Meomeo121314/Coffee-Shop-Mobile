import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/products.dart';
import 'package:ila/src/Category/productdetails.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  ScrollController verticalController = ScrollController();
  final _debouncer = Debouncer();

  List<Products> plist = [];
  List<Products> proLists = [];

  @override
  void initState() {
    super.initState();
    APIServices().fetchProducts().then((subjectFromServer) {
      setState(() {
        plist = subjectFromServer;
        proLists = plist;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: const Color.fromARGB(136, 219, 193, 172),
            // The search area here
            title: Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  autofocus: true,
                  controller: _searchController,
                  onTapOutside: ((event) {
                    FocusScope.of(context).unfocus();
                    _searchController.clear();
                  }),
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        proLists = plist
                            .where(
                              (u) => (u.title!.toLowerCase().contains(
                                    string.toLowerCase(),
                                  )),
                            )
                            .toList();
                      });
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => _searchController.clear(),
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
        body: SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.2 / 10,
                crossAxisCount: 2,
              ),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: proLists.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: searchProducts(
                        pro: proLists[index],
                      ),
                    )
                  ],
                );
              }),
        ));
  }
}

// ignore: must_be_immutable
class searchProducts extends StatelessWidget {
  Products? pro;

  searchProducts({
    this.pro,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 240,
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
                        ProductDetailsPage(idPro: pro!.id!))));
          },
          child: Column(
            children: [
              Image.network(
                pro!.image!,
                width: 172,
                height: 160,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 2,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 4),
                  width: 172,
                  height: 42,
                  child: Text(
                    pro!.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontSize: 16, fontFamily: "OpenSans"),
                  )),
              const SizedBox(
                height: 2,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                    children: [
                      Text(
                        pro!.price!.toString(),
                        style: const TextStyle(
                            fontSize: 17,
                            fontFamily: "OpenSans",
                            color: Color.fromARGB(255, 181, 57, 5)),
                      ),
                      const Icon(
                        Icons.attach_money,
                        color: Color.fromARGB(255, 181, 57, 5),
                        size: 16.5,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
