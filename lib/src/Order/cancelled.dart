// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/invoice_details.dart';
import 'package:ila/Models/invoice_view.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Orderdetails/canceldetails.dart';
import 'package:intl/intl.dart';

class CancelPage extends StatelessWidget {
  InvoicesView? invCan;

  CancelPage({
    this.invCan,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: InkWell(
          splashColor: Colors.white,
          onTap: () {
            Future<List<InvoiceDetails>> ls = APIServices().fetchUserInvoiceDetails(invCan!.id!, StaticValue.idAccount);
            ls.then((value) {
              caculateTotalInvoiceDetails(value, invCan!.id!);
              APIServices().autoCheckConfirmUser(invCan!.id);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CancelDetails(idInvc: invCan!.id!)));
            });
            
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            invCan!.codeInvoice!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset(
                                  'images/assets/icon/6572927.png',
                                  width: 35,
                                  height: 35,
                                  fit: BoxFit.cover,
                                  color: const Color.fromARGB(255, 181, 57, 5)))
                        ],
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      invCan!.userName!,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 0.75,
                                  ),
                                  Text(
                                    invCan!.userPhone!,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(invCan!.address!,
                                  style: const TextStyle(fontSize: 18)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade300, indent: 0, endIndent: 0),
                Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${invCan!.quantity!} item',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        RichText(
                            text: TextSpan(
                                text: 'Order total: ',
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                                children: <TextSpan>[
                              TextSpan(
                                text: '\$${invCan!.totalPrice!}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 181, 57, 5)),
                              )
                            ])),
                      ],
                    )),
                Divider(color: Colors.grey.shade300),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          'Order time',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          DateFormat('dd/MM/yyyy')
                              .format(invCan!.createDate!.toUtc()),
                          style:
                              const TextStyle(fontSize: 15, color: Colors.grey),
                        ))
                  ],
                ),
                Divider(color: Colors.grey.shade300),
                Container(
                  padding: const EdgeInsets.only(top: 3),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: const Text(
                    'View order details',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
  caculateTotalInvoiceDetails(List<InvoiceDetails> ls, int idnv) {
    StaticValue.totalDiscountV = 0;
    StaticValue.totalInvoiceDetails = 0;
    StaticValue.totalProducts = 0;
    StaticValue.totalRefund = 0;
    StaticValue.userFeeServices = 0;
    //
    ls.forEach((element) {
      for (var item in element.getInvoiceS()) {
        //
        if (item.isStatus == 2 || item.isStatus == 3) {
          StaticValue.totalRefund += item.cartPrice! * item.amount!;
        }
        StaticValue.totalProducts += item.cartPrice! * item.amount!;
        //
        if (element.totalDiscountV != 0) {
          StaticValue.totalDiscountV = element.totalDiscountV!;
        }
        //
        if (element.feeService != 0) {
          StaticValue.userFeeServices = element.feeService!;
        }
      }
    });

    StaticValue.totalInvoiceDetails = StaticValue.totalProducts -
        StaticValue.totalRefund +
        StaticValue.userFeeServices -
        StaticValue.totalDiscountV;

    if (StaticValue.totalInvoiceDetails < 0) {
      StaticValue.totalInvoiceDetails = 0;
    }
  }

}
