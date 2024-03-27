import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/supp_cart.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/cart/checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ScrollController verticalController = ScrollController();
  bool selected = true;
  bool flagFirst = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //clearValue
    StaticValue.mCartItem.clear();
    StaticValue.amountItemCart.clear();
    StaticValue.priceItemCart.clear();
    StaticValue.amountInCart = 0;
    flagFirst = true;
    StaticValue.checkedB = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Cart',
            style: TextStyle(fontSize: 28),
          ),
          actions: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(3, 7, 10, 3),
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: selected
                      ? const Text(
                          'Edit',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        )
                      : const Text('Done',
                          style: TextStyle(fontSize: 18, color: Colors.black))),
            )
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: 0,
              left: 0,
              child: Scrollbar(
                thumbVisibility: true,
                controller: verticalController,
                child: SingleChildScrollView(
                  controller: verticalController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: FutureBuilder(
                          future: APIServices()
                              .fetchSupplierCart(StaticValue.idAccount),
                          builder: (context,
                              AsyncSnapshot<List<SupplierCart>> snapshot) {
                            if (snapshot.hasData) {
                              List<SupplierCart> lsCart = snapshot.data!;
                              if (flagFirst) {
                                assignValueBooleanCheckBox(lsCart);
                                flagFirst = false;
                              }
                              return ListView.builder(
                                  itemCount: lsCart.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == lsCart.length - 1) {
                                      return Column(children: [
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Row(children: [
                                              Checkbox(
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 181, 57, 5),
                                                  value: StaticValue
                                                          .mMainCartCk[
                                                      lsCart[index].idSupplier],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      eventMainCheckBox(
                                                          lsCart[index]
                                                              .idSupplier,
                                                          lsCart[index]
                                                              .getCarts());
                                                    });
                                                  }),
                                              Text(
                                                '${lsCart[index].supplierName}',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                            ])),
                                        Divider(
                                            height: 0,
                                            color: Colors.grey.shade300),
                                        const SizedBox(height: 15),
                                        for (var item
                                            in lsCart[index].getCarts())
                                          Container(
                                              width: 422,
                                              height: 95,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Slidable(
                                                  key: ValueKey(item.id),
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const DrawerMotion(),
                                                    extentRatio: 0.25,
                                                    dragDismissible: true,
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          setState(() {
                                                            deleteItemInCarts(
                                                                item.id,
                                                                lsCart);
                                                            APIServices()
                                                                .deleteItemCart(
                                                                    item.id);
                                                            snapshot.data!
                                                                .removeAt(
                                                                    index);
                                                          });
                                                        },
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                199, 161, 122),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        label: 'Delete',
                                                      ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Checkbox(
                                                            activeColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    181,
                                                                    57,
                                                                    5),
                                                            value: StaticValue
                                                                    .mSubCartCkBox[
                                                                item.id],
                                                            onChanged: (value) {
                                                              setState(() {
                                                                eventSubCheckBox(
                                                                    lsCart[index]
                                                                        .idSupplier,
                                                                    item.id,
                                                                    lsCart[index]
                                                                        .getCarts());
                                                              });
                                                            }),
                                                        Container(
                                                            color: Colors.white,
                                                            width: 340,
                                                            child: Row(
                                                                children: [
                                                                  Column(
                                                                      children: [
                                                                        ConstrainedBox(
                                                                          constraints:
                                                                              const BoxConstraints(
                                                                            minWidth:
                                                                                85,
                                                                            minHeight:
                                                                                85,
                                                                            maxWidth:
                                                                                85,
                                                                            maxHeight:
                                                                                85,
                                                                          ),
                                                                          child: Image.network(
                                                                              '${item.image}',
                                                                              fit: BoxFit.cover),
                                                                        )
                                                                      ]),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              10,
                                                                          bottom:
                                                                              5),
                                                                      child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 240,
                                                                              child: Text(
                                                                                '${item.productName}',
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(fontSize: 18),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 2,
                                                                            ),
                                                                            Text(
                                                                              '\$${item.priceProduct}',
                                                                              style: const TextStyle(fontSize: 17, fontFamily: "OpenSans", color: Color.fromARGB(255, 181, 57, 5)),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 10,
                                                                            ),
                                                                            Row(children: [
                                                                              Material(
                                                                                  type: MaterialType.transparency,
                                                                                  child: Ink(
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(color: Colors.grey.shade200),
                                                                                        color: Colors.grey.shade200,
                                                                                      ),
                                                                                      child: InkWell(
                                                                                          onTap: () {
                                                                                            if (item.amount > 1) {
                                                                                              setState(() {
                                                                                                addMapperCartS(item.id, -1);
                                                                                                APIServices().updateAmount(StaticValue.idAccount, item.idProduct, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().substring(0, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().indexOf('.')), item.amount = StaticValue.mCartItem[item.id] ?? -1);
                                                                                              });
                                                                                            } else {
                                                                                              null;
                                                                                            }
                                                                                          },
                                                                                          child: (StaticValue.amountItemCart[item.id] ?? 1) >= 2
                                                                                              ? const Icon(
                                                                                                  Icons.remove,
                                                                                                  size: 22,
                                                                                                  color: Color.fromARGB(255, 181, 57, 5),
                                                                                                )
                                                                                              : Icon(
                                                                                                  Icons.remove,
                                                                                                  size: 22,
                                                                                                  color: Colors.grey.shade400,
                                                                                                )))),
                                                                              const Padding(padding: EdgeInsets.only(left: 10)),
                                                                              Text(
                                                                                StaticValue.amountItemCart[item.id].toString(),
                                                                                style: const TextStyle(fontSize: 15),
                                                                              ),
                                                                              const Padding(padding: EdgeInsets.only(left: 10)),
                                                                              Material(
                                                                                  type: MaterialType.transparency,
                                                                                  child: Ink(
                                                                                      decoration: BoxDecoration(
                                                                                        border: Border.all(color: Colors.grey.shade200),
                                                                                        color: Colors.grey.shade200,
                                                                                      ),
                                                                                      child: InkWell(
                                                                                          onTap: () async {
                                                                                            if (item.amount < 50) {
                                                                                              setState(() {
                                                                                                addMapperCartS(item.id, 1);
                                                                                                APIServices().updateAmount(StaticValue.idAccount, item.idProduct, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().substring(0, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().indexOf('.')), item.amount = StaticValue.mCartItem[item.id] ?? 1);
                                                                                              });
                                                                                            } else {
                                                                                              null;
                                                                                            }
                                                                                          },
                                                                                          child: item.amount >= 50
                                                                                              ? Icon(
                                                                                                  Icons.add,
                                                                                                  size: 22,
                                                                                                  color: Colors.grey.shade400,
                                                                                                )
                                                                                              : const Icon(
                                                                                                  Icons.add,
                                                                                                  size: 22,
                                                                                                  color: Color.fromARGB(255, 181, 57, 5),
                                                                                                ))))
                                                                            ])
                                                                          ]))
                                                                ]))
                                                      ]))),
                                        const Divider(height: 8),
                                        Container(height: 50)
                                      ]);
                                    } else {
                                      return Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Row(
                                            children: [
                                              Checkbox(
                                                  activeColor:
                                                      const Color.fromARGB(
                                                          255, 181, 57, 5),
                                                  value: StaticValue
                                                          .mMainCartCk[
                                                      lsCart[index].idSupplier],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      eventMainCheckBox(
                                                          lsCart[index]
                                                              .idSupplier,
                                                          lsCart[index]
                                                              .getCarts());
                                                    });
                                                  }),
                                              Text(
                                                      '${lsCart[index].supplierName}  ',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 0,
                                          color: Colors.grey.shade300,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        for (var item
                                            in lsCart[index].getCarts())
                                          Container(
                                            width: 422,
                                            height: 95,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Slidable(
                                                key: ValueKey(item.id),
                                                endActionPane: ActionPane(
                                                  motion: const DrawerMotion(),
                                                  extentRatio: 0.25,
                                                  dragDismissible: true,
                                                  children: [
                                                    SlidableAction(
                                                      onPressed: (context) {
                                                        setState(() {
                                                          deleteItemInCarts(
                                                              item.id, lsCart);
                                                          APIServices()
                                                              .deleteItemCart(
                                                                  item.id);
                                                          snapshot.data!
                                                              .removeAt(index);
                                                        });
                                                      },
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              199,
                                                              161,
                                                              122),
                                                      foregroundColor:
                                                          Colors.white,
                                                      icon: Icons.delete,
                                                      label: 'Delete',
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Checkbox(
                                                        key: Key(item.idSupplier
                                                            .toString()),
                                                        activeColor: const Color
                                                            .fromARGB(
                                                            255, 181, 57, 5),
                                                        value: StaticValue
                                                                .mSubCartCkBox[
                                                            item.id],
                                                        onChanged: (value) {
                                                          setState(() {
                                                            eventSubCheckBox(
                                                                lsCart[index]
                                                                    .idSupplier,
                                                                item.id,
                                                                lsCart[index]
                                                                    .getCarts());
                                                          });
                                                        }),
                                                    Container(
                                                      color: Colors.white,
                                                      width: 340,
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              ConstrainedBox(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                  minWidth: 85,
                                                                  minHeight: 85,
                                                                  maxWidth: 85,
                                                                  maxHeight: 85,
                                                                ),
                                                                child: Image.network(
                                                                    '${item.image}',
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    bottom: 5),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  width: 240,
                                                                  child: Text(
                                                                    '${item.productName}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            18),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Text(
                                                                  '\$${item.priceProduct}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5)),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Material(
                                                                      type: MaterialType
                                                                          .transparency,
                                                                      child:
                                                                          Ink(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border:
                                                                              Border.all(color: Colors.grey.shade200),
                                                                          color: Colors
                                                                              .grey
                                                                              .shade200,
                                                                        ),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (item.amount >
                                                                                1) {
                                                                              setState(() {
                                                                                addMapperCartS(item.id, -1);
                                                                                APIServices().updateAmount(StaticValue.idAccount, item.idProduct, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().substring(0, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().indexOf('.')), item.amount = StaticValue.mCartItem[item.id] ?? -1);
                                                                              });
                                                                            } else {
                                                                              null;
                                                                            }
                                                                          },
                                                                          child: (StaticValue.amountItemCart[item.id] ?? 1) >= 2
                                                                              ? const Icon(
                                                                                  Icons.remove,
                                                                                  size: 22,
                                                                                  color: Color.fromARGB(255, 181, 57, 5),
                                                                                )
                                                                              : Icon(
                                                                                  Icons.remove,
                                                                                  size: 22,
                                                                                  color: Colors.grey.shade400,
                                                                                ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10)),
                                                                    Text(
                                                                      StaticValue
                                                                          .amountItemCart[
                                                                              item.id]
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const Padding(
                                                                        padding:
                                                                            EdgeInsets.only(left: 10)),
                                                                    Material(
                                                                      type: MaterialType
                                                                          .transparency,
                                                                      child:
                                                                          Ink(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          // set the border
                                                                          border:
                                                                              Border.all(color: Colors.grey.shade200),
                                                                          // background color
                                                                          color: Colors
                                                                              .grey
                                                                              .shade200,
                                                                        ),
                                                                        child: InkWell(
                                                                            onTap: () async {
                                                                              if (item.amount < 50) {
                                                                                setState(() {
                                                                                  addMapperCartS(item.id, 1);
                                                                                  APIServices().updateAmount(StaticValue.idAccount, item.idProduct, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().substring(0, (item.priceProduct * StaticValue.mCartItem[item.id]!).toString().indexOf('.')), item.amount = StaticValue.mCartItem[item.id] ?? 1);
                                                                                });
                                                                              } else {
                                                                                null;
                                                                              }
                                                                            },
                                                                            child: item.amount >= 50
                                                                                ? Icon(
                                                                                    Icons.add,
                                                                                    size: 22,
                                                                                    color: Colors.grey.shade400,
                                                                                  )
                                                                                : const Icon(
                                                                                    Icons.add,
                                                                                    size: 22,
                                                                                    color: Color.fromARGB(255, 181, 57, 5),
                                                                                  )),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        const Divider(height: 8)
                                      ]);
                                    }
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
                    ],
                  ),
                ),
              ),
            ),
            selected
                ? Positioned(
                    bottom: 0,
                    width: 415,
                    height: 50,
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor:
                                      const Color.fromARGB(255, 181, 57, 5),
                                  value: StaticValue.checkedB,
                                  onChanged: (value) {
                                    setState(() {
                                      StaticValue.checkedB =
                                          !StaticValue.checkedB;
                                      checkAllItemOrNot(StaticValue.checkedB);
                                    });
                                  },
                                ),
                                const Text(
                                  'All',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '\$${StaticValue.priceCartCheckOut}',
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: "OpenSans",
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 13),
                                        backgroundColor: const Color.fromARGB(
                                            255, 199, 161, 122),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        )),
                                    onPressed: () {
                                      checkCheckboxBeforeCheckout();
                                    },
                                    child: const Text(
                                      'Checkout',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )),
                              ],
                            )
                          ],
                        )))
                : Positioned(
                    bottom: 0,
                    width: 415,
                    height: 50,
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor:
                                      const Color.fromARGB(255, 181, 57, 5),
                                  value: StaticValue.checkedB,
                                  onChanged: (value) {
                                    setState(() {
                                      StaticValue.checkedB =
                                          !StaticValue.checkedB;
                                      checkAllItemOrNot(StaticValue.checkedB);
                                    });
                                  },
                                ),
                                const Text(
                                  'All',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 199, 161, 122))),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 199, 161, 122)),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        checkCheckboxBeforeInsertWatchlist();
                                      });
                                    },
                                    child: const Text('Move to Favourites list',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 199, 161, 122),
                                            fontSize: 16))),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8.5),
                                          backgroundColor: const Color.fromARGB(
                                              255, 199, 161, 122),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          )),
                                      onPressed: () {
                                        setState(() {
                                          checkCheckboxBeforeDelete();
                                        });
                                      },
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      )),
                                )
                              ],
                            )
                          ],
                        ))),
          ],
        ));
  }

  void addMapperCartS(int idCart, int descItem) {
    if (!StaticValue.mCartItem.containsKey(idCart)) {
      StaticValue.mCartItem[idCart] = StaticValue.amountItemCart[idCart] ?? 1;
    }
    //
    StaticValue.mCartItem.update(
        idCart, (value) => (StaticValue.mCartItem[idCart] ?? 1) + descItem);
    StaticValue.amountItemCart[idCart] =
        (StaticValue.amountItemCart[idCart] ?? 1) + descItem;
    //
    if (StaticValue.amountItemCart[idCart] == 0) {
      StaticValue.amountItemCart[idCart] = 1;
      StaticValue.mCartItem[idCart] = 1;
    }
    caculateSumTotalInCart();
  }

  void eventMainCheckBox(int idSupplierM, List<Cart> ls) {
    var flagSet = StaticValue.mMainCartCk[idSupplierM] == true ? false : true;
    for (var itemInCart in ls) {
      StaticValue.mSubCartCkBox[itemInCart.id] = flagSet;
    }
    StaticValue.mMainCartCk[idSupplierM] = flagSet;
    checkItemCkAll();
    caculateSumTotalInCart();
  }

  void eventSubCheckBox(int idSupplier, int idItemCart, List<Cart> ls) {
    int countRun = 0;
    int countTrue = 0;
    int countFalse = 0;
    var flagSet = StaticValue.mSubCartCkBox[idItemCart] == true ? false : true;
    StaticValue.mSubCartCkBox[idItemCart] = flagSet;
    //
    for (var itemCart in ls) {
      countRun = countRun + 1;
      if (StaticValue.mSubCartCkBox[itemCart.id] == true) {
        countTrue = countTrue + 1;
      } else if (StaticValue.mSubCartCkBox[itemCart.id] == false) {
        countFalse = countFalse + 1;
      }
    }
    //Checked
    if (countRun == countTrue) {
      StaticValue.mMainCartCk[idSupplier] = true;
      //Unchecked
    } else if (countRun == countFalse) {
      StaticValue.mMainCartCk[idSupplier] = false;
    } else {
      StaticValue.mMainCartCk[idSupplier] = false;
    }
    //
    checkItemCkAll();
    caculateSumTotalInCart();
  }

  assignValueBooleanCheckBox(List<SupplierCart> ls) {
    /*
    @Clear Item Static Value Cart
    */
    StaticValue.mMainCartCk = {};
    StaticValue.amountInCart = 0;
    StaticValue.mSubCartCkBox = {};
    StaticValue.priceItemCart = {};
    StaticValue.amountItemCart = {};

    //
    for (var element in ls) {
      StaticValue.mMainCartCk[element.idSupplier] = false;
      for (var itemSub in element.getCarts()) {
        StaticValue.amountInCart += 1;
        StaticValue.mSubCartCkBox[itemSub.id] = false;
        //ForTotal
        StaticValue.priceItemCart[itemSub.id] = itemSub.priceProduct;
        StaticValue.amountItemCart[itemSub.id] = itemSub.amount;
      }
    }
  }

  checkAllItemOrNot(bool flagAll) {
    if (flagAll) {
      StaticValue.mMainCartCk.updateAll((key, value) => value = true);
      StaticValue.mSubCartCkBox.updateAll((key, value) => value = true);
    } else {
      StaticValue.mMainCartCk.updateAll((key, value) => value = false);
      StaticValue.mSubCartCkBox.updateAll((key, value) => value = false);
    }
    caculateSumTotalInCart();
  }

  checkItemCkAll() {
    int countCheck = 0;
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        countCheck = countCheck + 1;
      }
    });
    //
    if (countCheck == StaticValue.amountInCart) {
      StaticValue.checkedB = true;
    } else {
      StaticValue.checkedB = false;
    }
    caculateSumTotalInCart();
  }

  caculateSumTotalInCart() {
    double sumCaculate = 0;
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        sumCaculate += (StaticValue.priceItemCart[key] ?? 0) *
            (StaticValue.amountItemCart[key] ?? 1);
      }
    });
    StaticValue.priceCartCheckOut = sumCaculate;
  }

  deleteItemInCarts(int idCart, List<SupplierCart> ls) {
    if (ls.isEmpty) {
      StaticValue.mMainCartCk = {};
      StaticValue.mSubCartCkBox = {};
    } else {
      StaticValue.mSubCartCkBox.remove(idCart);
      StaticValue.mMainCartCk.forEach((key, value) {
        var objectContains = ls.where((element) => element.idSupplier == key);
        if (objectContains.isEmpty) {
          StaticValue.mMainCartCk.remove(key);
        } else {}
        //
      });
    }
    //
    caculateSumTotalInCart();
  }

  deletemultiProductsinCart() {
    String lsCartRemove = "";
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        lsCartRemove += "$key-";
      }
    });
    //
    if (lsCartRemove.substring(lsCartRemove.length - 1) == '-') {
      lsCartRemove = lsCartRemove.substring(0, lsCartRemove.length - 1);
    }
    APIServices().deletemultiItemCart(lsCartRemove);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CartPage()));
    flagFirst = true;
    //
    StaticValue.priceCartCheckOut = 0;
  }

  checkCheckboxBeforeDelete() {
    int countCheck = 0;
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        countCheck = countCheck + 1;
      }
    });
    //

    if (countCheck >= 1) {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  width: 100,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: [
                      Text('Do you want to remove $countCheck item?',
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'No'),
                            child: const Text(
                              'No',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'OK');
                                setState(() {
                                  deletemultiProductsinCart();
                                });
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 181, 57, 5),
                                ),
                              )),
                        ],
                      )
                    ],
                  )),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  width: 100,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(140, 0, 0, 0)),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/assets/icon/no-message.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      const Text("Please select product(s)",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  )),
            );
          });
    }
  }

  selectmultiProductstoCheckout() {
    String lsIdCart = "";
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        lsIdCart += "$key-";
      }
    });
    //
    if (lsIdCart.substring(lsIdCart.length - 1) == '-') {
      lsIdCart = lsIdCart.substring(0, lsIdCart.length - 1);
    }
    //APIServices().fetchCheckout(lsIdCart);
    StaticValue.lsIdCart = lsIdCart;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CheckoutPage(
                lsIdCart: lsIdCart, idAddress: StaticValue.idAddress)));
    flagFirst = true;
    //
    //StaticValue.priceCartCheckOut = 0;
    StaticValue.checkedB = false;
    StaticValue.priceVoucherAdmin = 0;
    StaticValue.priceVoucherSupplier = 0;
    StaticValue.flagVoucherAdmin = false;
    StaticValue.flagAddressCheckout = false;
    StaticValue.feeService = double.parse(
        (StaticValue.priceCartCheckOut * 2 / 100).toStringAsFixed(2));
    StaticValue.sumCheckOut =
        StaticValue.feeService + StaticValue.priceCartCheckOut;
    StaticValue.flagDisplayVoucherAdmin = false;
    StaticValue.flagSetAddress = false;
  }

  checkCheckboxBeforeCheckout() {
    int countCheck = 0;
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        countCheck = countCheck + 1;
      }
    });
    //

    if (countCheck >= 1) {
      setState(() {
        selectmultiProductstoCheckout();
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  width: 100,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(140, 0, 0, 0)),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/assets/icon/no-message.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      const Text("Please select product(s)",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  )),
            );
          });
    }
  }

  insertmultiProductstoWatchlist() {
    String lsIdProducts = "";
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        lsIdProducts += "$key,";
      }
    });

    if (lsIdProducts.substring(lsIdProducts.length - 1) == ',') {
      lsIdProducts = lsIdProducts.substring(0, lsIdProducts.length - 1);
    }
    APIServices().insertMultiWatchList(lsIdProducts, StaticValue.idAccount);
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CartPage()));
    flagFirst = true;
    //
    StaticValue.priceCartCheckOut = 0;
  }

  checkCheckboxBeforeInsertWatchlist() {
    int countCheck = 0;
    StaticValue.mSubCartCkBox.forEach((key, value) {
      if (value == true) {
        countCheck = countCheck + 1;
      }
    });
    //

    if (countCheck >= 1) {
      setState(() {
        insertmultiProductstoWatchlist();
      });
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  width: 100,
                  height: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white70),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/assets/icon/652757.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      const Text("Added to watchlist",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.center),
                    ],
                  )),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(seconds: 3), () {
              Navigator.of(context).pop(true);
            });
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                  width: 100,
                  height: 125,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(140, 0, 0, 0)),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Image.asset(
                        'images/assets/icon/no-message.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      const Text("Please select product(s)",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.center),
                    ],
                  )),
            );
          });
    }
  }
}
