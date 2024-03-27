// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/invoice_details.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Category/supplierpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CancelDetails extends StatefulWidget {
  final idInvc;
  const CancelDetails({
    Key? key,
    required this.idInvc,
  }) : super(key: key);
  @override
  State<CancelDetails> createState() => _CancelDetailsState();
}

class _CancelDetailsState extends State<CancelDetails> {
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
            style: TextStyle(fontSize: 25),
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
                                    SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15, top: 5),
                                                      child: Container(
                                                        foregroundDecoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          backgroundBlendMode:
                                                              BlendMode
                                                                  .saturation,
                                                        ),
                                                        child: ConstrainedBox(
                                                          constraints:
                                                              BoxConstraints(
                                                            minWidth: 85,
                                                            minHeight: 85,
                                                            maxWidth: 85,
                                                            maxHeight: 85,
                                                          ),
                                                          child: Image.network(
                                                              '${item.image}',
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      )),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: 310,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                top: 15),
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          '${item.productName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: Text(
                                                            'x${item.amount}',
                                                            style: TextStyle(
                                                                fontSize: 16,
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
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ],
                                                              ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    'Order has been canceled by the seller',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ]))
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
