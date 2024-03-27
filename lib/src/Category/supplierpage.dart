import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/pro_cate.dart';
import 'package:ila/Models/products.dart';
import 'package:ila/src/Category/productdetails.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class SupplierPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final idSupp;
  const SupplierPage({Key? key, required this.idSupp}) : super(key: key);
  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  ScrollController verticalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: verticalController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<List<Products>>(
              future: APIServices().fetchProductSupplier(widget.idSupp),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<Products>? ls = snapshot.data;
                    for (var itemls in ls!) {
                      return SizedBox(
                        height: 366,
                        width: double.infinity,
                        child: Stack(
                          children: [
                            (itemls.supplierAvatar != 'No Image' &&
                                        itemls.supplierAvatar != '' &&
                                        itemls.supplierAvatar != null) ==
                                    false
                                ? Image.asset(
                                    'images/assets/z5091968669411_7ee17c9250dd22a86153ab88031ebcf6.jpg',
                                    width: 422,
                                    height: 320,
                                    fit: BoxFit.fill)
                                : Image.network(itemls.supplierAvatar!,
                                    height: 320, width: 422, fit: BoxFit.fill),
                            Positioned(
                              top: 30,
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
                            Positioned(
                                top: 270,
                                right: 40,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  width: 330,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 2,
                                        offset: const Offset(2, 5),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/assets/icon/040_-_Tick-256.webp',
                                              width: 20,
                                              height: 20,
                                              fit: BoxFit.cover,
                                              color: const Color.fromARGB(
                                                  255, 181, 57, 5),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Text(
                                                "iLA's partner",
                                                style: TextStyle(
                                                    fontSize: 22,
                                                    color: Color.fromARGB(
                                                        255, 181, 57, 5)),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          itemls.supplierName!,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ]),
                                )),
                          ],
                        ),
                      );
                    }
                  } else {
                    return SizedBox();
                  }
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
            FutureBuilder(
              future: APIServices().fetchProductCategory(widget.idSupp),
              builder:
                  (context, AsyncSnapshot<List<ProductCategory>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              snapshot.data![index].getProducts().isEmpty
                                  ? const Visibility(visible: false,child: Text(''),)
                                  : Row(
                                      children: [
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,left: 15),
                                            child: Text(
                                              '${snapshot.data![index].cateName}',
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                              for (var item
                                  in snapshot.data![index].getProducts())
                                SizedBox(
                                  width: double.infinity,
                                  height: 195,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      onTap: () {
                                        APIServices()
                                            .autoStartEndDiscountUsers();
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ProductDetailsPage(
                                                idPro: item.id);
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 250,
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 15),
                                                child: Text(
                                                  "${item.title}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 22),
                                                ),
                                              ),
                                              Container(
                                                width: 250,
                                                padding: const EdgeInsets.only(
                                                    top: 5, left: 15),
                                                child: Text(
                                                  "${item.description}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, top: 25),
                                                child: Text(
                                                  "\$${item.price}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5)),
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 11),
                                                child: Image.network(
                                                  "${item.image}",
                                                  width: 130,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                            ],
                          );
                        });
                  } else {
                    return SizedBox();
                  }
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
          ],
        ),
      ),
    );
  }
}
