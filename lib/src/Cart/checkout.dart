import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/handle_invoice_object.dart';
import 'package:ila/Models/supp_cart.dart';
import 'package:ila/Models/vouchers.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Cart/selectaddress.dart';
import 'package:ila/src/Cart/selectvoucher.dart';
import 'package:ila/src/Order/ordersusscess.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckoutPage extends StatefulWidget {
  final lsIdCart;
  final idAddress;
  const CheckoutPage(
      {Key? key, required this.lsIdCart, required this.idAddress})
      : super(key: key);
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  ScrollController verticalController = ScrollController();
  dynamic isChecked;
  bool flagFirst = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (StaticValue.flagVoucherAdmin == false && StaticValue.flagSetAddress == false) {
      StaticValue.priceSumTotal = StaticValue.priceCartCheckOut;
      StaticValue.priceCartCheckOut = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Checkout',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: 0,
              left: 0,
              child: Scrollbar(
                thickness: 0,
                thumbVisibility: true,
                controller: verticalController,
                child: SingleChildScrollView(
                    controller: verticalController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 5),
                            width: double.infinity,
                            height: 120,
                            color: Colors.white,
                            child: Column(children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.asset(
                                        'images/assets/icon/1092688.png',
                                        color: const Color.fromARGB(
                                            255, 181, 57, 5),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.fitWidth,
                                      )),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Delivery Address',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              FutureBuilder(
                                  future: APIServices()
                                      .fetchUserAddress(StaticValue.idAccount),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      if (StaticValue.flagSetAddress == false) {
                                        StaticValue.idAddress =
                                            snapshot.data!.id;
                                        StaticValue.flagSetAddress = true;
                                      }
                                      return OutlinedButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2)),
                                            side: MaterialStateProperty.all(
                                                const BorderSide(
                                                    color: Colors.white)),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SelectAddress()));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  IntrinsicHeight(
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 42),
                                                          child: Text(
                                                            '${snapshot.data!.username}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ),
                                                        const VerticalDivider(
                                                          color: Colors.grey,
                                                          thickness: 0.75,
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.phone}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  StaticValue.idAddress !=
                                                          widget.idAddress
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 42),
                                                          child: SizedBox(
                                                            width: 300,
                                                            child: Text(
                                                              '${snapshot.data!.address}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ))
                                                      : FutureBuilder(
                                                          future: APIServices()
                                                              .fetchAddresswhereUser(
                                                                  widget
                                                                      .idAddress),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              return Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              42),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 300,
                                                                    child: Text(
                                                                      '${snapshot.data!.userAddress}',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ));
                                                            } else if (snapshot
                                                                .hasError) {
                                                              return Text(
                                                                  '${snapshot.error}');
                                                            }
                                                            return Container();
                                                          }),
                                                ],
                                              ),
                                              const Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 20),
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 20,
                                                      color: Colors.black,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ));
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }
                                    return Center(
                                        child: LoadingAnimationWidget
                                            .prograssiveDots(
                                      color: Colors.blue.shade300,
                                      size: 45,
                                    ));
                                  }),
                            ])),
                        const SizedBox(height: 10),
                        FutureBuilder(
                          future: APIServices().fetchCheckout(
                              StaticValue.idAccount, widget.lsIdCart),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<SupplierCart> lsCkout = snapshot.data!;
                              return ListView.builder(
                                  itemCount: lsCkout.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    caculateEachSupplierCkOut(lsCkout);
                                    return Column(
                                      children: [
                                        Container(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            width: double.infinity,
                                            color: Colors.white,
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15),
                                                      child: Image.asset(
                                                          'images/assets/icon/5594934.png',
                                                          width: 25,
                                                          height: 25,
                                                          fit: BoxFit.cover)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      lsCkout[index]
                                                          .supplierName!,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 15),
                                              for (var item
                                                  in lsCkout[index].getCarts())
                                                Row(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 16,
                                                                top: 10),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              const BoxConstraints(
                                                            minWidth: 80,
                                                            minHeight: 80,
                                                            maxWidth: 80,
                                                            maxHeight: 80,
                                                          ),
                                                          child: Image.network(
                                                              item.image!,
                                                              fit:
                                                                  BoxFit.cover),
                                                        )),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: 310,
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10),
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            item.productName!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        18),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 25),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                child: Text(
                                                                  '\$${item.priceProduct}',
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )),
                                                            Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            220),
                                                                child: Text(
                                                                  'x${item.amount}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .grey),
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              const SizedBox(height: 8),
                                              Container(
                                                  color: Colors.grey.shade200,
                                                  width: double.infinity,
                                                  height: 1),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 15),
                                                            child: Image.asset(
                                                                'images/assets/icon/5749101.png',
                                                                width: 25,
                                                                height: 25,
                                                                fit: BoxFit
                                                                    .cover,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    181,
                                                                    57,
                                                                    5))),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              'Shop Vouchers',
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black),
                                                            ))
                                                      ],
                                                    )
                                                  ]),
                                                  Column(children: [
                                                    StaticValue.flagDisplayVoucher[
                                                                lsCkout[index]
                                                                    .idSupplier] ==
                                                            false
                                                        ? TextButton(
                                                            onPressed: () {
                                                              APIServices()
                                                                  .autoCheckStartVoucher(
                                                                      2);
                                                              APIServices()
                                                                  .autoCheckEndVoucher(
                                                                      2);
                                                              showModalBottomSheet(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Container(
                                                                        color: Colors
                                                                            .white,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Positioned(
                                                                                top: 0,
                                                                                width: 422,
                                                                                height: 50,
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        color: Colors.grey.withOpacity(0.5),
                                                                                        spreadRadius: 1,
                                                                                        blurRadius: 7,
                                                                                        offset: const Offset(0, 3),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  child: FutureBuilder(
                                                                                    future: APIServices().fetchVoucherSupplier(lsCkout[index].idSupplier),
                                                                                    builder: (context, snapshot) {
                                                                                      if (snapshot.hasData) {
                                                                                        List<Vouchers> lsCkout = snapshot.data!;
                                                                                        if (lsCkout.isEmpty) {
                                                                                          return Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              const Padding(
                                                                                                padding: EdgeInsets.only(left: 18),
                                                                                                child: Text(
                                                                                                  'Supplier voucher(s)',
                                                                                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(right: 10),
                                                                                                child: IconButton(
                                                                                                    onPressed: () {
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    icon: const Icon(Icons.close, color: Colors.grey)),
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        } else {
                                                                                          return ListView.builder(
                                                                                              itemCount: lsCkout.length,
                                                                                              shrinkWrap: true,
                                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                                              itemBuilder: (context, index) {
                                                                                                return Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  children: [
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.only(left: 18),
                                                                                                      child: Text(
                                                                                                        '${lsCkout[index].supplierName} voucher(s)',
                                                                                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: const EdgeInsets.only(right: 10),
                                                                                                      child: IconButton(
                                                                                                          onPressed: () {
                                                                                                            Navigator.pop(context);
                                                                                                          },
                                                                                                          icon: const Icon(Icons.close, color: Colors.grey)),
                                                                                                    )
                                                                                                  ],
                                                                                                );
                                                                                              });
                                                                                        }
                                                                                      } else if (snapshot.hasError) {
                                                                                        return Text('${snapshot.error}');
                                                                                      }
                                                                                      return Container();
                                                                                    },
                                                                                  ),
                                                                                )),
                                                                            Positioned.fill(
                                                                              top: 60,
                                                                              child: SingleChildScrollView(
                                                                                controller: verticalController,
                                                                                scrollDirection: Axis.vertical,
                                                                                child: FutureBuilder(
                                                                                  future: APIServices().fetchVoucherSupplier(lsCkout[index].idSupplier),
                                                                                  builder: (context, snapshot) {
                                                                                    if (snapshot.hasData) {
                                                                                      List<Vouchers> lsVoucher = snapshot.data!;
                                                                                      onLoadAssignValueVoucher(lsVoucher);
                                                                                      if (lsVoucher.isEmpty) {
                                                                                        return Center(
                                                                                            child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                                                                              Image.asset('images/assets/icon/5749101.png', width: 120, height: 120, fit: BoxFit.cover,color: Colors.grey,),
                                                                                              const SizedBox(height: 10),
                                                                                              const Text('No shop vouchers yet', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500))
                                                                                            ]));
                                                                                      } else {
                                                                                        return ListView.builder(
                                                                                            itemCount: lsVoucher.length,
                                                                                            shrinkWrap: true,
                                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                                            itemBuilder: (context, index) {
                                                                                              return Column(
                                                                                                children: [
                                                                                                  StaticValue.priceSumTotal >= lsVoucher[index].condition!
                                                                                                      ? CheckboxListTile(
                                                                                                          activeColor: const Color.fromARGB(255, 181, 57, 5),
                                                                                                          checkColor: Colors.white,
                                                                                                          value: StaticValue.voucherOnSelect[lsVoucher[index].id],
                                                                                                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                                                          onChanged: (bool? value) {
                                                                                                            setState(() {
                                                                                                              setPriceCaulateVouchers(lsVoucher[index].usercreate!, lsVoucher[index].discount ?? 0, lsVoucher[index].id ?? "BLANK", lsVoucher);
                                                                                                            });
                                                                                                            Future.delayed(const Duration(seconds: 1), () {
                                                                                                              Navigator.pop(context);
                                                                                                            });
                                                                                                          },
                                                                                                          title: Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                              boxShadow: [
                                                                                                                BoxShadow(
                                                                                                                  color: Colors.grey.withOpacity(0.5),
                                                                                                                  spreadRadius: 5,
                                                                                                                  blurRadius: 7,
                                                                                                                  offset: const Offset(0, 2),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            child: Row(
                                                                                                              children: [
                                                                                                                ClipPath(
                                                                                                                  clipper: CuponClipper(),
                                                                                                                  child: Container(
                                                                                                                    color: Colors.white,
                                                                                                                    height: 100,
                                                                                                                    width: 100,
                                                                                                                    alignment: Alignment.center,
                                                                                                                    child: CircleAvatar(
                                                                                                                      backgroundImage: NetworkImage('${lsVoucher[index].supplierAvatar}'),
                                                                                                                      radius: 25,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Container(
                                                                                                                    color: Colors.white,
                                                                                                                    height: 100,
                                                                                                                    width: 215,
                                                                                                                    alignment: Alignment.center,
                                                                                                                    child: Row(
                                                                                                                      children: [
                                                                                                                        const DottedLine(direction: Axis.vertical, dashColor: Colors.grey, dashLength: 6),
                                                                                                                        Padding(
                                                                                                                            padding: const EdgeInsets.only(left: 15),
                                                                                                                            child: Column(
                                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                              children: [
                                                                                                                                Text('Discount: \$${lsVoucher[index].discount}'),
                                                                                                                                Text('Minium Require: \$${lsVoucher[index].condition}'),
                                                                                                                                lsVoucher[index].dayLeft! >= 7
                                                                                                                                    ? const Text('')
                                                                                                                                    : Text(
                                                                                                                                        '${lsVoucher[index].dayLeft} day left',
                                                                                                                                        style: const TextStyle(color: Colors.red),
                                                                                                                                      )
                                                                                                                              ],
                                                                                                                            ))
                                                                                                                      ],
                                                                                                                    )),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                      : CheckboxListTile(
                                                                                                          activeColor: const Color.fromARGB(255, 181, 57, 5),
                                                                                                          checkColor: Colors.white,
                                                                                                          value: StaticValue.voucherOnSelect[lsVoucher[index].id],
                                                                                                          checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                                                          onChanged: null,
                                                                                                          title: Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                              boxShadow: [
                                                                                                                BoxShadow(
                                                                                                                  color: Colors.grey.withOpacity(0.5),
                                                                                                                  spreadRadius: 5,
                                                                                                                  blurRadius: 7,
                                                                                                                  offset: const Offset(0, 2),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            child: Row(
                                                                                                              children: [
                                                                                                                ClipPath(
                                                                                                                  clipper: CuponClipper(),
                                                                                                                  child: Container(
                                                                                                                    color: Colors.white,
                                                                                                                    height: 100,
                                                                                                                    width: 100,
                                                                                                                    alignment: Alignment.center,
                                                                                                                    child: CircleAvatar(
                                                                                                                      backgroundImage: NetworkImage('${lsVoucher[index].supplierAvatar}'),
                                                                                                                      radius: 25,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Container(
                                                                                                                    color: Colors.white,
                                                                                                                    height: 100,
                                                                                                                    width: 215,
                                                                                                                    alignment: Alignment.center,
                                                                                                                    child: Row(
                                                                                                                      children: [
                                                                                                                        const DottedLine(direction: Axis.vertical, dashColor: Colors.grey, dashLength: 6),
                                                                                                                        Padding(
                                                                                                                            padding: const EdgeInsets.only(left: 15),
                                                                                                                            child: Column(
                                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                              children: [
                                                                                                                                Text('Discount: \$${lsVoucher[index].discount}'),
                                                                                                                                Text('Minium Require: \$${lsVoucher[index].condition}'),
                                                                                                                                lsVoucher[index].dayLeft! >= 7
                                                                                                                                    ? const Text('')
                                                                                                                                    : Text(
                                                                                                                                        '${lsVoucher[index].dayLeft} day left',
                                                                                                                                        style: const TextStyle(color: Colors.red),
                                                                                                                                      )
                                                                                                                              ],
                                                                                                                            ))
                                                                                                                      ],
                                                                                                                    )),
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      }
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
                                                                            ),
                                                                          ],
                                                                        ));
                                                                  });
                                                            },
                                                            child: const Row(
                                                              children: [
                                                                Text(
                                                                  'Select a voucher  ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .black45),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_forward_ios,
                                                                  size: 15,
                                                                  color: Colors
                                                                      .black45,
                                                                ),
                                                              ],
                                                            ))
                                                        : IconButton(
                                                            onPressed: () {
                                                              APIServices()
                                                                  .autoCheckStartVoucher(
                                                                      2);
                                                              APIServices()
                                                                  .autoCheckEndVoucher(
                                                                      2);
                                                              showModalBottomSheet(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              0)),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return Container(
                                                                        color: Colors
                                                                            .white,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            Positioned(
                                                                                top: 0,
                                                                                width: 422,
                                                                                height: 50,
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        color: Colors.grey.withOpacity(0.5),
                                                                                        spreadRadius: 1,
                                                                                        blurRadius: 7,
                                                                                        offset: const Offset(0, 3),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  child: FutureBuilder(
                                                                                    future: APIServices().fetchVoucherSupplier(lsCkout[index].idSupplier),
                                                                                    builder: (context, snapshot) {
                                                                                      if (snapshot.hasData) {
                                                                                        List<Vouchers> lsCkout = snapshot.data!;
                                                                                        return ListView.builder(
                                                                                            itemCount: lsCkout.length,
                                                                                            shrinkWrap: true,
                                                                                            physics: const NeverScrollableScrollPhysics(),
                                                                                            itemBuilder: (context, index) {
                                                                                              return Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(left: 18),
                                                                                                    child: Text(
                                                                                                      '${lsCkout[index].supplierName} voucher(s)',
                                                                                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: const EdgeInsets.only(right: 10),
                                                                                                    child: IconButton(
                                                                                                        onPressed: () {
                                                                                                          Navigator.pop(context);
                                                                                                        },
                                                                                                        icon: const Icon(Icons.close, color: Colors.grey)),
                                                                                                  )
                                                                                                ],
                                                                                              );
                                                                                            });
                                                                                      } else if (snapshot.hasError) {
                                                                                        return Text('${snapshot.error}');
                                                                                      }
                                                                                      return Container();
                                                                                    },
                                                                                  ),
                                                                                )),
                                                                            Positioned.fill(
                                                                              top: 60,
                                                                              child: SingleChildScrollView(
                                                                                controller: verticalController,
                                                                                scrollDirection: Axis.vertical,
                                                                                child: FutureBuilder(
                                                                                  future: APIServices().fetchVoucherSupplier(lsCkout[index].idSupplier),
                                                                                  builder: (context, snapshot) {
                                                                                    if (snapshot.hasData) {
                                                                                      List<Vouchers> lsVoucher = snapshot.data!;
                                                                                      onLoadAssignValueVoucher(lsVoucher);
                                                                                      return ListView.builder(
                                                                                          itemCount: lsVoucher.length,
                                                                                          shrinkWrap: true,
                                                                                          physics: const NeverScrollableScrollPhysics(),
                                                                                          itemBuilder: (context, index) {
                                                                                            return Column(
                                                                                              children: [
                                                                                                CheckboxListTile(
                                                                                                  activeColor: const Color.fromARGB(255, 181, 57, 5),
                                                                                                  checkColor: Colors.white,
                                                                                                  value: StaticValue.voucherOnSelect[lsVoucher[index].id],
                                                                                                  checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                                                                                  onChanged: (bool? value) {
                                                                                                    setState(() {
                                                                                                      setPriceCaulateVouchers(lsVoucher[index].usercreate!, lsVoucher[index].discount ?? 0, lsVoucher[index].id ?? "BLANK", lsVoucher);
                                                                                                    });
                                                                                                    Future.delayed(const Duration(seconds: 1), () {
                                                                                                      Navigator.pop(context);
                                                                                                    });
                                                                                                  },
                                                                                                  title: Container(
                                                                                                    decoration: BoxDecoration(
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          color: Colors.grey.withOpacity(0.5),
                                                                                                          spreadRadius: 5,
                                                                                                          blurRadius: 7,
                                                                                                          offset: const Offset(0, 2),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        ClipPath(
                                                                                                          clipper: CuponClipper(),
                                                                                                          child: Container(
                                                                                                            color: Colors.white,
                                                                                                            height: 100,
                                                                                                            width: 100,
                                                                                                            alignment: Alignment.center,
                                                                                                            child: CircleAvatar(
                                                                                                              backgroundImage: NetworkImage('${lsVoucher[index].supplierAvatar}'),
                                                                                                              radius: 25,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                            color: Colors.white,
                                                                                                            height: 100,
                                                                                                            width: 215,
                                                                                                            alignment: Alignment.center,
                                                                                                            child: Row(
                                                                                                              children: [
                                                                                                                const DottedLine(direction: Axis.vertical, dashColor: Colors.grey, dashLength: 6),
                                                                                                                Padding(
                                                                                                                    padding: const EdgeInsets.only(left: 15),
                                                                                                                    child: Column(
                                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                      children: [
                                                                                                                        Text('Discount: \$${lsVoucher[index].discount}'),
                                                                                                                        Text('Minium Require: \$${lsVoucher[index].condition}'),
                                                                                                                        lsVoucher[index].dayLeft! >= 7
                                                                                                                            ? const Text('')
                                                                                                                            : Text(
                                                                                                                                '${lsVoucher[index].dayLeft} day left',
                                                                                                                                style: const TextStyle(color: Colors.red),
                                                                                                                              )
                                                                                                                      ],
                                                                                                                    ))
                                                                                                              ],
                                                                                                            )),
                                                                                                      ],
                                                                                                    ),
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
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ));
                                                                  });
                                                            },
                                                            icon: Row(
                                                              children: [
                                                                Image.asset(
                                                                    'images/assets/icon/secure.png',
                                                                    width: 25,
                                                                    height: 25,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5)),
                                                                const SizedBox(
                                                                    width: 10),
                                                                const Icon(
                                                                    Icons
                                                                        .arrow_forward_ios,
                                                                    size: 15,
                                                                    color: Colors
                                                                        .black45),
                                                              ],
                                                            ))
                                                  ]),
                                                ],
                                              ),
                                              Container(
                                                  color: Colors.grey.shade200,
                                                  width: double.infinity,
                                                  height: 1),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        'Order Total: ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 15),
                                                    child: Text(
                                                      '\$${StaticValue.vPriceESupplier[lsCkout[index].idSupplier].toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          color: Color.fromARGB(
                                                              255, 181, 57, 5)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 10)
                                            ]))
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
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 45,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                          'images/assets/icon/5749101.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                          color: const Color.fromARGB(
                                              255, 181, 57, 5))),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Platform Vouchers',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ))
                                ],
                              ),
                              Row(mainAxisSize: MainAxisSize.min, children: [
                                StaticValue.flagDisplayVoucherAdmin == false
                                    ? TextButton(
                                        onPressed: () {
                                          APIServices()
                                              .autoCheckStartVoucher(0);
                                          APIServices().autoCheckEndVoucher(0);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectVouchersAdmin()));
                                        },
                                        child: const Row(
                                          children: [
                                            Text(
                                              'Select a voucher  ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black45),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 15,
                                              color: Colors.black45,
                                            ),
                                          ],
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SelectVouchersAdmin()));
                                        },
                                        icon: Row(
                                          children: [
                                            Image.asset(
                                                'images/assets/icon/secure.png',
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.cover,
                                                color: const Color.fromARGB(
                                                    255, 181, 57, 5)),
                                            const SizedBox(width: 10),
                                            const Icon(Icons.arrow_forward_ios,
                                                size: 15,
                                                color: Colors.black45),
                                          ],
                                        ))
                              ]),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          //height: 45,
                          color: Colors.white,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 5),
                                      child: Image.asset(
                                          'images/assets/icon/note-pad.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.cover,
                                          color: Colors.orange[400])),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(left: 10, top: 5),
                                      child: Text(
                                        'Payment Details',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 10),
                                      child: Text(
                                        'Total',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 10),
                                      child: Text(
                                        '\$${StaticValue.priceSumTotal}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Promotional Combos',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        '-\$${StaticValue.priceVoucherSupplier}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Total Discount Vouchers',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        '-\$${StaticValue.priceVoucherAdmin}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        'Fee Services',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Text(
                                        '\$${StaticValue.feeService.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(255, 4, 3, 3),
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(left: 15, top: 8),
                                      child: Text(
                                        'Total Payment',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 8),
                                      child: Text(
                                        '\$${StaticValue.sumCheckOut}',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 181, 57, 5)),
                                      ))
                                ],
                              ),
                              const SizedBox(height: 5)
                            ],
                          ),
                        ),
                        Container(height: 55),
                      ],
                    )),
              ),
            ),
            Positioned(
                bottom: 0,
                width: 422,
                height: 50,
                child: Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Total Payment',
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                '\$${StaticValue.sumCheckOut}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "OpenSans",
                                    color: Color.fromARGB(255, 181, 57, 5)),
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
                                    horizontal: 30, vertical: 13),
                                backgroundColor:
                                    const Color.fromARGB(255, 199, 161, 122),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                )),
                            onPressed: paymentOrder,
                            child: const Text(
                              'Place Order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      ],
                    ))),
          ],
        ));
  }

  // Widget getList(){
  //   List<Vouchers> ls = snapshot.data!
  // }

  ///Function Caculate Price Check Out Each Supplier
  ///[ls] :Para In List Cart CheckOut
  caculateEachSupplierCkOut(List<SupplierCart> ls) {
    if ((flagFirst == false && StaticValue.flagVoucherAdmin == false) &&
    (flagFirst == false && StaticValue.flagAddressCheckout == false)) {
      ///Reset Variable
      StaticValue.cPriceESupplier = {};
      StaticValue.checkedB = false;
      // 
      for (var suppC in ls) {
        StaticValue.cPriceESupplier[suppC.idSupplier] =
            caculatePriceEachSupplier(suppC.getCarts());
        StaticValue.vPriceESupplier[suppC.idSupplier] =
            caculatePriceEachSupplier(suppC.getCarts());
        StaticValue.flagDisplayVoucher[suppC.idSupplier] = false;
      }
      /*Price Fee Service*/
      StaticValue.feeService = 0;
      caculateFeeServicePrice();
      caculateSumCheckOut();
      //
      flagFirst = true;
      /*Reload Value Data*/
      StaticValue.voucherOnSelect = {};
      StaticValue.voucherOnCheckOut = {};
      StaticValue.vAdminDisplayCheck = {};
    }
  }

  void caculateFeeServicePrice() {
    StaticValue.vPriceESupplier.forEach((key, value) {
      StaticValue.feeService +=
          double.parse((2 / 100 * value).toStringAsFixed(2));
    });
  }

  double caculatePriceEachSupplier(List<Cart> ls) {
    double priceSum = 0;
    for (var itemS in ls) {
      priceSum += itemS.price ?? 0;
    }
    return priceSum;
  }

  void setPriceCaulateVouchers(int idSupplier, double priceVoucher,
      String codeVoucher, List<Vouchers> currentListVoucher) {
    var flagExCheck = StaticValue.voucherOnSelect[codeVoucher] ?? false;
    StaticValue.vPriceESupplier[idSupplier] =
        StaticValue.cPriceESupplier[idSupplier] ?? 0;
    disableCheckVoucherSupplier(currentListVoucher);
    if (!flagExCheck) {
      StaticValue.vPriceESupplier[idSupplier] =
          (StaticValue.cPriceESupplier[idSupplier] ?? 0) - priceVoucher;
      StaticValue.voucherOnSelect.update(codeVoucher, (value) => true);
      StaticValue.flagDisplayVoucher.update(idSupplier, (value) => true);
      StaticValue.priceVoucherSupplier += priceVoucher;
    } else {
      /*Disable All*/
      disableCheckVoucherSupplier(currentListVoucher);
      StaticValue.flagDisplayVoucher.update(idSupplier, (value) => false);
      StaticValue.priceVoucherSupplier -= priceVoucher;
    }
    StaticValue.feeService = 0;
    caculateFeeServicePrice();
    caculateSumCheckOut();
  }

  void onLoadAssignValueVoucher(List<Vouchers> ls) {
    for (var itemVoucher in ls) {
      if (!StaticValue.voucherOnSelect.containsKey(itemVoucher.id)) {
        StaticValue.voucherOnSelect[itemVoucher.id ?? ""] = false;
      }
    }
  }

  void disableCheckVoucherSupplier(List<Vouchers> currentListVoucher) {
    for (var itemVouchers in currentListVoucher) {
      StaticValue.voucherOnSelect[itemVouchers.id ?? ""] = false;
    }
  }

  void caculateSumCheckOut() {
    StaticValue.sumCheckOut = StaticValue.priceSumTotal +
        StaticValue.feeService -
        StaticValue.priceVoucherAdmin -
        StaticValue.priceVoucherSupplier;
  }

  void paymentOrder() {
    String queryVoucher = "";
    String voucherAdmin = "";
    /*Voucher Supplier*/
    StaticValue.voucherOnSelect.forEach((key, value) {
      if (value == true) {
        queryVoucher += "$key,";
      }
    });
    /*Voucher Admin*/
    StaticValue.vAdminDisplayCheck.forEach((key, value) {
      if (value == true) {
        voucherAdmin = key;
      }
    });
    /*Check Voucher Admin*/
    if (voucherAdmin.isEmpty) {
      voucherAdmin = "BLANK";
    }
    /*Check Voucher Supplier*/
    if (queryVoucher.isEmpty) {
      queryVoucher = "BLANK";
    } else {
      queryVoucher = queryVoucher.substring(0, queryVoucher.length - 1);
    }
    //
    HandleInvoiceObject invoice = HandleInvoiceObject();
    invoice.idUser = StaticValue.idAccount;
    invoice.idAddress = StaticValue.idAddress;
    invoice.lsCartSelect = widget.lsIdCart;
    invoice.voucherAdmin = voucherAdmin;
    invoice.lsVoucherS = queryVoucher;
    invoice.feeService = StaticValue.feeService;
    APIServices().insertInvoice(invoice);

    StaticValue.idAddress = 0;
    StaticValue.lsIdCart = '';
    voucherAdmin = '';
    queryVoucher = '';
    StaticValue.feeService = 0;

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderSuccess()));
  }
}

class CuponClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    final radius = size.height * .045;

    Path holePath = Path();

    for (int i = 1; i <= 8; i++) {
      holePath.addOval(
        Rect.fromCircle(
          center: Offset(0, (size.height * .115) * i),
          radius: radius,
        ),
      );
    }
    return Path.combine(PathOperation.difference, path, holePath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
