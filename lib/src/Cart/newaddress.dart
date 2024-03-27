import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/src/Cart/selectaddress.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key});

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String? _address;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'New Address',
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 15, left: 25),
                    child: Text(
                      'Contact',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    color: Colors.white,
                    height: 75,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 5),
                                child: SizedBox(
                                  width: 380,
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _address = value;
                                    },
                                    inputFormatters: [
                                      FilteringTextInputFormatter.deny(
                                          RegExp(r'^\s*')),
                                    ],
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return 'Address is required please enter';
                                      } 
                                      return null;
                                    },
                                    onTapOutside: (event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
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
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                      ),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )),
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
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                APIServices().insertAddress(
                                    addressController.text, false);
                              });
                              Navigator.pop(context);
                              Navigator.pop(context, false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SelectAddress()));
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    )
                  ],
                )
              ],
            )));
  }
}
