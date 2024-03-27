import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/address.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/src/Cart/selectaddress.dart';

class EditAddress extends StatefulWidget {
  final Address add;
  const EditAddress({Key? key, required this.add}) : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController addressController = TextEditingController();
  bool light = false;
  var _checkvisible = true;
  @override
  void initState() {
    setState(() {
      if (widget.add.status == true) {
        light = true;
        _checkvisible = false;
      } else {
        _checkvisible = true;
        light = false;
      }
      addressController.text = widget.add.userAddress.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'Edit Address',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 15, left: 25),
                child: Text(
                  'Contact',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                color: Colors.white,
                height: 50,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: SizedBox(
                              width: 380,
                              child: TextFormField(
                                // initialValue: widget.nameA,
                                controller: addressController,
                                decoration: InputDecoration(
                                  hintText: 'Adddress',
                                  hintStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontFamily: "OpenSans",
                                      height: 2),
                                  isDense: true, // Added this
                                  contentPadding: const EdgeInsets.all(5),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                )),
            Visibility(
                visible: _checkvisible,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 15, left: 25),
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade600),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        color: Colors.white,
                        height: 50,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(left: 21),
                                    child: Text(
                                      'Set as Default Adddress',
                                      style: TextStyle(fontSize: 16),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Switch(
                                    activeColor: const Color.fromARGB(
                                        255, 199, 161, 122),
                                    inactiveTrackColor: Colors.grey.shade300,
                                    inactiveThumbColor: Colors.grey,
                                    value: light,
                                    onChanged: (bool value) {
                                      setState(() {
                                        light = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 138, vertical: 10),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  )),
                              onPressed: () {
                                setState(() {
                                  APIServices().deleteAddress(widget.add.id);
                                });
                                Navigator.of(context).pop();
                                Navigator.pop(SelectAddress.currentContext!, true);
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectAddress()));
                              },
                              child: const Text(
                                'Delete Address',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              )),
                        )
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 170, vertical: 10),
                          backgroundColor:
                              const Color.fromARGB(255, 199, 161, 122),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          )),
                      onPressed: () {
                        setState(() {
                          StaticValue.idAddress = widget.add.id;
                          APIServices()
                              .updateAddress(addressController.text, light);
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectAddress()));
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                )
              ],
            )
          ],
        ));
  }

  // Future<void> _deleteAddress(BuildContext context) {
  //   return
  //   }
}
