import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/vouchers.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Cart/checkout.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SelectVouchersAdmin extends StatefulWidget {
  const SelectVouchersAdmin({super.key});

  @override
  State<SelectVouchersAdmin> createState() => _SelectVouchersAdminState();
}

class _SelectVouchersAdminState extends State<SelectVouchersAdmin> {
  ScrollController verticalController = ScrollController();
  dynamic isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Select Vouchers',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Scrollbar(
            thickness: 0,
            thumbVisibility: true,
            controller: verticalController,
            child: SingleChildScrollView(
              controller: verticalController,
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<Vouchers>>(
                future: APIServices().fetchVoucherAdmin(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Vouchers>? lsVoucher = snapshot.data!;
                    onloadAssignKeyVoucherAdmin(lsVoucher);
                    if (lsVoucher.isEmpty) {
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Image.asset(
                              'images/assets/icon/5749101.png',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 10),
                            const Text('No admin vouchers yet',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w500))
                          ]));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: lsVoucher.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                StaticValue.priceSumTotal >=
                                        lsVoucher[index].condition!
                                    ? CheckboxListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 181, 57, 5),
                                        checkColor: Colors.white,
                                        value: StaticValue.vAdminDisplayCheck[
                                            lsVoucher[index].id],
                                        checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            onCheckSelectVoucher(
                                                lsVoucher,
                                                lsVoucher[index].id ?? "",
                                                lsVoucher[index].discount ?? 0);
                                          });
                                          Future.delayed(
                                              const Duration(seconds: 1), () {
                                            Navigator.of(context).pop();
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckoutPage(
                                                            lsIdCart:
                                                                StaticValue
                                                                    .lsIdCart,
                                                            idAddress: StaticValue
                                                                .idAddress)));
                                          });
                                        },
                                        title: SizedBox(
                                          height: 90,
                                          child: Row(
                                            children: [
                                              ClipPath(
                                                clipper: CuponClipper(),
                                                child: Container(
                                                    color: const Color.fromARGB(
                                                        255, 199, 161, 122),
                                                    width: 90,
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5),
                                                            child: Text('\$',
                                                                style: GoogleFonts
                                                                    .josefinSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15))),
                                                        Text(
                                                            '${lsVoucher[index].discount}',
                                                            style: GoogleFonts
                                                                .josefinSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25)),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 8),
                                                            child: Text('OFF',
                                                                style: GoogleFonts
                                                                    .josefinSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            11)))
                                                      ],
                                                    )),
                                              ),
                                              Container(
                                                  color: Colors.white,
                                                  width: 215,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 25),
                                                          child: Column(
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'YOUR PURCHASE ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    TextSpan(
                                                                      text:
                                                                          '\$${lsVoucher[index].condition}',
                                                                      style: GoogleFonts.truculenta(
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5)),
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            ' OR MORE',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'Valid form ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                      text: DateFormat('dd-MM-yyyy').format(lsVoucher[
                                                                              index]
                                                                          .startDate!
                                                                          .toLocal()),
                                                                      style: GoogleFonts.truculenta(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            ' to ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                        text: DateFormat('dd-MM-yyyy').format(lsVoucher[index]
                                                                            .endDate!
                                                                            .toLocal()),
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.w500))
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    : CheckboxListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 181, 57, 5),
                                        checkColor: Colors.white,
                                        value: StaticValue.vAdminDisplayCheck[
                                            lsVoucher[index].id],
                                        checkboxShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        onChanged: null,
                                        title: SizedBox(
                                          height: 90,
                                          child: Row(
                                            children: [
                                              ClipPath(
                                                clipper: CuponClipper(),
                                                child: Container(
                                                    color: const Color.fromARGB(
                                                        255, 199, 161, 122),
                                                    width: 90,
                                                    alignment: Alignment.center,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5),
                                                            child: Text('\$',
                                                                style: GoogleFonts
                                                                    .josefinSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            15))),
                                                        Text(
                                                            '${lsVoucher[index].discount}',
                                                            style: GoogleFonts
                                                                .josefinSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        25)),
                                                        Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 8),
                                                            child: Text('OFF',
                                                                style: GoogleFonts
                                                                    .josefinSans(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            11)))
                                                      ],
                                                    )),
                                              ),
                                              Container(
                                                  color: Colors.white,
                                                  width: 215,
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 25),
                                                          child: Column(
                                                            children: [
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'YOUR PURCHASE ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                    TextSpan(
                                                                      text:
                                                                          '\$${lsVoucher[index].condition}',
                                                                      style: GoogleFonts.truculenta(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color: const Color
                                                                              .fromARGB(
                                                                              255,
                                                                              181,
                                                                              57,
                                                                              5)),
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            ' OR MORE',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500)),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text.rich(
                                                                TextSpan(
                                                                  children: [
                                                                    TextSpan(
                                                                        text:
                                                                            'Valid form ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                      text: DateFormat('dd-MM-yyyy').format(lsVoucher[
                                                                              index]
                                                                          .startDate!
                                                                          .toLocal()),
                                                                      style: GoogleFonts.truculenta(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w500),
                                                                    ),
                                                                    TextSpan(
                                                                        text:
                                                                            ' to ',
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                12)),
                                                                    TextSpan(
                                                                        text: DateFormat('dd-MM-yyyy').format(lsVoucher[index]
                                                                            .endDate!
                                                                            .toLocal()),
                                                                        style: GoogleFonts.truculenta(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500))
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                Container(height: 5)
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
            )));
  }

  void onloadAssignKeyVoucherAdmin(List<Vouchers> ls) {
    StaticValue.flagVoucherAdmin = true;
    for (var voucherAdmin in ls) {
      if (!StaticValue.vAdminDisplayCheck.containsKey(voucherAdmin.id)) {
        StaticValue.vAdminDisplayCheck[voucherAdmin.id ?? ""] = false;
      }
    }
  }

  void onCheckSelectVoucher(
    List<Vouchers> ls, String codeVoucher, double priceVoucher) {
    var flagExCheck = StaticValue.vAdminDisplayCheck[codeVoucher] ?? false;
    if (!flagExCheck) {
      disableAdminVoucherCheck(ls);
      StaticValue.vAdminDisplayCheck.update(codeVoucher, (value) => true);
      StaticValue.priceVoucherAdmin = priceVoucher;
      StaticValue.flagDisplayVoucherAdmin = true;
    } else {
      /*Disable All*/
      disableAdminVoucherCheck(ls);
      StaticValue.vAdminDisplayCheck.update(codeVoucher, (value) => false);
      StaticValue.priceVoucherAdmin = 0;
      StaticValue.flagDisplayVoucherAdmin = false;
    }
    caculateSumCheckOut();
  }

  void disableAdminVoucherCheck(List<Vouchers> ls) {
    for (var itemVouchers in ls) {
      StaticValue.vAdminDisplayCheck[itemVouchers.id ?? ""] = false;
    }
  }

  void caculateSumCheckOut() {
    StaticValue.sumCheckOut = StaticValue.priceSumTotal +
        StaticValue.feeService -
        StaticValue.priceVoucherAdmin -
        StaticValue.priceVoucherSupplier;
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
