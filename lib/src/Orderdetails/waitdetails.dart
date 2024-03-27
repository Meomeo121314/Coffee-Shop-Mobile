// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/handle_status_object.dart';
import 'package:ila/Models/invoice_details.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Category/supplierpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class WaitDetails extends StatefulWidget {
  final idInvc;
  const WaitDetails({
    Key? key,
    required this.idInvc,
  }) : super(key: key);

  @override
  State<WaitDetails> createState() => _WaitDetailsState();
}

class _WaitDetailsState extends State<WaitDetails> {
  ScrollController verticalController = ScrollController();
  var ratingStar;

  @override
  void initState() {
    super.initState();
    setState(() {
      ratingStar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Order Details',
            style: TextStyle(fontSize: 22),
          ),
        ),
        body: SingleChildScrollView(
            controller: verticalController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                FutureBuilder<List<InvoiceDetails>>(
                  future: APIServices().fetchUserInvoiceDetails(
                      widget.idInvc, StaticValue.idAccount),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<InvoiceDetails>? invList = snapshot.data!;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: invList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 18),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${invList[index].supplierName}  ',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                fixedSize: const Size(125, 0)),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupplierPage(
                                                              idSupp: invList[
                                                                      index]
                                                                  .idSupplier)));
                                            },
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Go to shop ',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 181, 57, 5),
                                                      fontSize: 18),
                                                ),
                                                Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Color.fromARGB(
                                                      255, 181, 57, 5),
                                                  size: 15,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                  Divider(
                                      color: Colors.grey.shade300, height: 0.5),
                                  for (var item in invList[index].getInvoiceS())
                                    item.isStatus == 2 || item.isStatus == 3
                                        ? SizedBox(
                                            width: double.infinity,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 15,
                                                                  top: 5),
                                                          child: Container(
                                                            foregroundDecoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              backgroundBlendMode:
                                                                  BlendMode
                                                                      .saturation,
                                                            ),
                                                            child:
                                                                ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
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
                                                          )),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            width: 310,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    top: 15),
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              '${item.productName}',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ),
                                                          SizedBox(height: 20),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20),
                                                              child: Text(
                                                                'x${item.amount}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .grey),
                                                              )),
                                                          item.productPrice ==
                                                                  item.cartPrice
                                                              ? Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20),
                                                                  child: Text(
                                                                    '\$${item.cartPrice}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        color: Colors
                                                                            .grey),
                                                                  ))
                                                              : Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              20),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        '\$${item.productPrice}',
                                                                        style: TextStyle(
                                                                            decoration: TextDecoration
                                                                                .lineThrough,
                                                                            decorationColor: Colors
                                                                                .grey,
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              5),
                                                                      Text(
                                                                        '\$${item.cartPrice}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        'Order has been canceled by the seller',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ))
                                                ]))
                                        : Column(children: [
                                            Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15, top: 8),
                                                    child: ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                        minWidth: 85,
                                                        minHeight: 85,
                                                        maxWidth: 85,
                                                        maxHeight: 85,
                                                      ),
                                                      child: Image.network(
                                                          '${item.image}',
                                                          fit: BoxFit.cover),
                                                    )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 310,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              top: 15),
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        '${item.productName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 20),
                                                        child: Text(
                                                          'x${item.amount}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey),
                                                        )),
                                                    item.productPrice ==
                                                            item.cartPrice
                                                        ? Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Text(
                                                              '\$${item.cartPrice}',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5)),
                                                            ))
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '\$${item.productPrice}',
                                                                  style: TextStyle(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      decorationColor:
                                                                          Colors
                                                                              .grey,
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  '\$${item.cartPrice}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5)),
                                                                ),
                                                              ],
                                                            ))
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  if (item.isStatus == 0)
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                right: 20),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              'Pending  ',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                  fontSize: 18),
                                                            ),
                                                            Image.asset(
                                                                'images/assets/icon/5401986.png',
                                                                width: 25,
                                                                height: 25,
                                                                fit: BoxFit
                                                                    .cover,
                                                                color: Colors
                                                                    .blueAccent)
                                                          ],
                                                        ))
                                                  else if (item.isStatus == 1)
                                                    Visibility(
                                                        visible: true,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              8),
                                                                  backgroundColor:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          199,
                                                                          161,
                                                                          122),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5))),
                                                              onPressed: () {
                                                                HandleStatusObject
                                                                    status =
                                                                    HandleStatusObject();
                                                                status.userCase =
                                                                    2;
                                                                status.statusType =
                                                                    0;
                                                                status.idInvoice =
                                                                    item.idInvoice;
                                                                status.idSupplier =
                                                                    item.idSupplier;
                                                                status.idInvoiceDetails =
                                                                    item.id;
                                                                status.idUser =
                                                                    StaticValue
                                                                        .idAccount;
                                                                setState(() {
                                                                  APIServices()
                                                                      .userConfirmInvoiceDetails(
                                                                          status);
                                                                });
                                                              },
                                                              child: Text(
                                                                'Received',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              )),
                                                        ))
                                                  else if (item.isStatus == 4 &&
                                                      item.ratingReview == 0)
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Visibility(
                                                            visible: true,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          20),
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal:
                                                                                  8,
                                                                              vertical:
                                                                                  6),
                                                                          backgroundColor: Color.fromARGB(
                                                                              255,
                                                                              199,
                                                                              161,
                                                                              122),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                  5))),
                                                                      onPressed:
                                                                          () {
                                                                        showDialog(
                                                                            context:
                                                                                context,
                                                                            builder:
                                                                                (context) {
                                                                              return Dialog(
                                                                                  backgroundColor: Colors.transparent,
                                                                                  insetPadding: EdgeInsets.all(10),
                                                                                  child: Container(
                                                                                      width: 100,
                                                                                      height: 130,
                                                                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
                                                                                      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                                                                      child: Column(children: [
                                                                                        RatingBar(
                                                                                          filledIcon: Icons.star,
                                                                                          filledColor: Color.fromARGB(200, 181, 58, 5),
                                                                                          emptyIcon: Icons.star_border,
                                                                                          emptyColor: Color.fromARGB(200, 181, 58, 5),
                                                                                          onRatingChanged: (value) {
                                                                                            ratingStar = value;
                                                                                          },
                                                                                          initialRating: 0,
                                                                                          isHalfAllowed: false,
                                                                                          alignment: Alignment.center,
                                                                                          size: 35,
                                                                                        ),
                                                                                        SizedBox(height: 15),
                                                                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                                            child: Text(
                                                                                              'Cancel',
                                                                                              style: TextStyle(color: Colors.black, fontSize: 18),
                                                                                            ),
                                                                                          ),
                                                                                          TextButton(
                                                                                              onPressed: () {
                                                                                                setState(() {
                                                                                                  if (ratingStar == null) {
                                                                                                    Navigator.pop(context, 'Submit');
                                                                                                    print(ratingStar);
                                                                                                  } else {
                                                                                                    Navigator.pop(context, 'Submit');

                                                                                                    setState(() {
                                                                                                      APIServices().userRatingProducts(item.idProduct, item.id, ratingStar);
                                                                                                      ratingStar = null;
                                                                                                    });
                                                                                                    
                                                                                                  }
                                                                                                });
                                                                                              },
                                                                                              child: Text(
                                                                                                'Submit',
                                                                                                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 181, 57, 5)),
                                                                                              ))
                                                                                        ])
                                                                                      ])));
                                                                            });
                                                                      },
                                                                      child: Text(
                                                                          'Rate',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 18))),
                                                            ))
                                                      ],
                                                    )
                                                  else if (item.isStatus == 4 &&
                                                      item.ratingReview != 0)
                                                    Visibility(
                                                        visible: true,
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 270),
                                                            child: RatingBar
                                                                .readOnly(
                                                              filledIcon:
                                                                  Icons.star,
                                                              filledColor: Color
                                                                  .fromARGB(
                                                                      200,
                                                                      181,
                                                                      58,
                                                                      5),
                                                              emptyIcon: Icons
                                                                  .star_border,
                                                              emptyColor: Color
                                                                  .fromARGB(
                                                                      200,
                                                                      181,
                                                                      58,
                                                                      5),
                                                              initialRating: item
                                                                  .ratingReview!
                                                                  .toDouble(),
                                                              maxRating: 5,
                                                              size: 25,
                                                            )))
                                                ])
                                          ]),
                                  Divider(color: Colors.grey.shade300)
                                ],
                              ),
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
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15, top: 10),
                              child: Text(
                                'Total Products',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 20, top: 10),
                              child: Text(
                                '\$${StaticValue.totalProducts}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Total Discount Vouchers',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '-\$${StaticValue.totalDiscountV}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Fee Services',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '\$${StaticValue.userFeeServices}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Refund',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                '-\$${StaticValue.totalRefund}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 4, 3, 3),
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 15, top: 8),
                              child: Text(
                                'Total Payment',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )),
                          Padding(
                              padding: EdgeInsets.only(right: 20, top: 8),
                              child: Text(
                                '\$${StaticValue.totalInvoiceDetails.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 181, 57, 5)),
                              ))
                        ],
                      ),
                      SizedBox(height: 5)
                    ],
                  ),
                ),
              ],
            )));
  }
}
