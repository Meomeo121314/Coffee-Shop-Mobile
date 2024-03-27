import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/invoice_view.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Order/cancelled.dart';
import 'package:ila/src/Order/completed.dart';
import 'package:ila/src/Order/waitconfirm.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderState();
}

class _OrderState extends State<OrderPage> with TickerProviderStateMixin {
  TabController? _listViewController;
  ScrollController verticalController = ScrollController();
  @override
  void initState() {
    super.initState();
    _listViewController = TabController(length: 3, vsync: this);
    APIServices().fetchUserInvoice(StaticValue.idAccount, 0);
    APIServices().fetchUserInvoice(StaticValue.idAccount, 1);
    APIServices().fetchUserInvoice(StaticValue.idAccount, 9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Your Order',
            style: TextStyle(fontSize: 25),
          ),
          bottom: TabBar(
            indicatorColor: const Color.fromARGB(255, 181, 57, 5),
            dividerColor: Colors.grey.shade200,
            labelColor: const Color.fromARGB(255, 181, 57, 5),
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
            controller: _listViewController,
          )),
      body: TabBarView(controller: _listViewController, children: [
        SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<InvoicesView>>(
            future: APIServices().fetchUserInvoice(StaticValue.idAccount, 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<InvoicesView>? invList = snapshot.data!;
                if (invList.isEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('images/assets/icon/2829412.png',
                                width: 120, height: 120, fit: BoxFit.cover),
                            const SizedBox(height: 10),
                            const Text('No Orders Yet',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.grey))
                          ]));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: invList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            WaitConfirm(invP: invList[index]),
                            const SizedBox(height: 5)
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
        SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<InvoicesView>>(
            future: APIServices().fetchUserInvoice(StaticValue.idAccount, 1),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<InvoicesView>? invList = snapshot.data!;
                if (invList.isEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('images/assets/icon/2829412.png',
                                width: 120, height: 120, fit: BoxFit.cover),
                            const SizedBox(height: 10),
                            const Text('No Orders Yet',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.grey))
                          ]));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: invList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CompletedPage(invC: invList[index]),
                            const SizedBox(height: 5)
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
        SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<InvoicesView>>(
            future: APIServices().fetchUserInvoice(StaticValue.idAccount, 9),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<InvoicesView>? invList = snapshot.data!;
                if (invList.isEmpty) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('images/assets/icon/2829412.png',
                                width: 120, height: 120, fit: BoxFit.cover),
                            const SizedBox(height: 10),
                            const Text('No Orders Yet',
                                style:
                                    TextStyle(fontSize: 25, color: Colors.grey))
                          ]));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: invList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CancelPage(invCan: invList[index]),
                            const SizedBox(height: 5)
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
      ]),
    );
  }
}
