import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/address.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Cart/checkout.dart';
import 'package:ila/src/Cart/editaddress.dart';
import 'package:ila/src/Cart/newaddress.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({super.key});
  static BuildContext? currentContext;
  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  ScrollController verticalController = ScrollController();
  // ignore: prefer_typing_uninitialized_variables
  int? selectedValue;

  setContext(BuildContext contextItem) {
    setState(() {
      SelectAddress.currentContext = contextItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 219, 193, 172),
        centerTitle: true,
        title: const Text(
          'Address Selection',
          style: TextStyle(fontSize: 25),
        ),
        
      ),
      body: SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 15, left: 25),
                  child: Text(
                    'Address',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      FutureBuilder<List<Address>>(
                        future: APIServices().fetchAddress(StaticValue.idAccount),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Address>? addList = snapshot.data;
                            StaticValue.flagAddressCheckout = true;
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: addList!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      RadioListTile(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                            (Set<MaterialState> states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
                                                return const Color.fromARGB(
                                                    255, 181, 57, 5);
                                              }
                                              return Colors.black;
                                            },
                                          ),
                                          title: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IntrinsicHeight(
                                                      child: Row(
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: 250,
                                                        child: Text(
                                                          '${addList[index].userAddress}',
                                                          overflow:
                                                              TextOverflow.clip,
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                                  TextButton(
                                                      onPressed: () {
                                                        setContext(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EditAddress(
                                                                        add: addList[
                                                                            index])));
                                                      },
                                                      child: const Text(
                                                        'Edit',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    181,
                                                                    57,
                                                                    5)),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              snapshot.data![index].status ==
                                                      true
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 50,
                                                          height: 22,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5),
                                                                  )),
                                                          child: const Text(
                                                            'Default',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        181,
                                                                        57,
                                                                        5)),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : const Row()
                                            ],
                                          ),
                                          groupValue: selectedValue,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedValue = val!;
                                            });
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            StaticValue.idAddress = snapshot.data![index].id;
                                            StaticValue.flagAddressCheckout = true;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CheckoutPage(
                                                          lsIdCart: StaticValue
                                                              .lsIdCart,
                                                          idAddress: StaticValue.idAddress
                                                        )));
                                          },
                                          value: snapshot.data![index].id),
                                      const SizedBox(height: 5),
                                      Divider(
                                        height: 0,
                                        indent: 65,
                                        color: Colors.grey.shade300,
                                      ),
                                    ],
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NewAddress()));
                                },
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Color.fromARGB(255, 181, 57, 5),
                                    ),
                                    Text(
                                      ' Add New Address',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 181, 57, 5)),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      )
                    ],
                  )),
            ],
          )),
    );
  }
  

}
