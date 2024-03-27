// ignore_for_file: unused_field

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Utils/staticvalue.dart';
import 'package:ila/main.dart';
import 'package:ila/src/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart' as path;
import 'package:wc_form_validators/wc_form_validators.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? avt;
  String? _avatar;
  final _formKey = GlobalKey<FormState>();
  bool name = true;
  bool phone = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController cfPassController = TextEditingController();
  bool oldPassVisible = true;
  bool newPassVisible = true;
  bool cfPassVisible = true;
  var _visibleChangePass = false;
  String checkPass = "false";
  String changePass = "false";
  @override
  void initState() {
    super.initState();
    oldPassVisible;
    newPassVisible;
    cfPassVisible;
    _visibleChangePass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(136, 219, 193, 172),
          centerTitle: true,
          title: const Text(
            'My Profile',
            style: TextStyle(fontSize: 28),
          ),
          leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
            // Navigator.pop(context);
            // Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));
          },),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.only(left: 18, top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                width: 400,
                child: FutureBuilder(
                    future: APIServices().fetchProfile(StaticValue.idAccount),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          image: avt == null
                                              ? DecorationImage(
                                                  image: snapshot
                                                              .data!.avatar ==
                                                          'NoImage'
                                                      ? const NetworkImage(
                                                          'https://kennyleeholmes.com/wp-content/uploads/2017/09/no-image-available.png')
                                                      : NetworkImage(snapshot
                                                          .data!.avatar
                                                          .toString()),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: FileImage(avt!),
                                                  fit: BoxFit.cover)),
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                  child: Container(
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: IntrinsicHeight(
                                                          child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              CupertinoButton(
                                                                  child: Column(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          radius:
                                                                              35,
                                                                          child:
                                                                              const Icon(
                                                                            Icons.camera_alt,
                                                                            size:
                                                                                35,
                                                                            color:
                                                                                Colors.black,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        const Text(
                                                                          "Take a photo",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w400),
                                                                        )
                                                                      ]),
                                                                  onPressed:
                                                                      () {
                                                                    takeAvatar(
                                                                        snapshot
                                                                            .data!
                                                                            .avatar);

                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                            ],
                                                          ),
                                                          VerticalDivider(
                                                            color: Colors
                                                                .grey.shade300,
                                                          ),
                                                          Column(
                                                            children: [
                                                              CupertinoButton(
                                                                  child: Column(
                                                                      children: [
                                                                        CircleAvatar(
                                                                          backgroundColor: Colors
                                                                              .grey
                                                                              .shade300,
                                                                          radius:
                                                                              35,
                                                                          child: const Icon(
                                                                              Icons.image,
                                                                              size: 35,
                                                                              color: Colors.black),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        const Text(
                                                                          "Pick a photo",
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.w400),
                                                                        )
                                                                      ]),
                                                                  onPressed:
                                                                      () {
                                                                    chooseAvatar(
                                                                        snapshot
                                                                            .data!
                                                                            .avatar);

                                                                    Navigator.pop(
                                                                        context);
                                                                  })
                                                            ],
                                                          )
                                                        ],
                                                      ))));
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white54,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          alignment: Alignment.centerLeft,
                                          width: 175,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AnimatedCrossFade(
                                                  duration: const Duration(
                                                      milliseconds: 450),
                                                  firstChild: Text(
                                                    '${snapshot.data!.name}',
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  secondChild: SizedBox(
                                                    width: 250,
                                                    child: TextFormField(
                                                        textCapitalization:
                                                            TextCapitalization
                                                                .words,
                                                        maxLength: 25,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .deny(RegExp(
                                                                  r'^\s*')),
                                                        ],
                                                        validator: (valueName) {
                                                          if (valueName !=
                                                                  null &&
                                                              valueName
                                                                  .isEmpty) {
                                                            return 'Name is required';
                                                          } else if (!RegExp(
                                                                  r'^[a-z A-Z]+$')
                                                              .hasMatch(
                                                                  valueName!)) {
                                                            return 'Only text';
                                                          } else if (RegExp(
                                                                  r" \s")
                                                              .hasMatch(
                                                                  valueName)) {
                                                            return 'No spam space';
                                                          }
                                                          return null;
                                                        },
                                                        controller:
                                                            nameController,
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            181,
                                                                            57,
                                                                            5),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5),
                                                                  width: 1.5)),
                                                        )),
                                                  ),
                                                  crossFadeState: name
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState
                                                          .showSecond,
                                                ),
                                              ]),
                                        ),
                                        Column(
                                          children: [
                                            AnimatedCrossFade(
                                              duration: const Duration(
                                                  milliseconds: 450),
                                              firstChild: GestureDetector(
                                                onTap: () {
                                                  nameController.text =
                                                      snapshot.data!.name!;
                                                  setState(() {
                                                    name = !name;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 28,
                                                ),
                                              ),
                                              secondChild: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      name = !name;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              APIServices()
                                                                  .updateProfileName(
                                                                      nameController
                                                                          .text);
                                                              name = !name;
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.check,
                                                          size: 28,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.close,
                                                        size: 28,
                                                      ),
                                                    ],
                                                  )),
                                              crossFadeState: name
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          alignment: Alignment.centerLeft,
                                          width: 175,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AnimatedCrossFade(
                                                  duration: const Duration(
                                                      milliseconds: 400),
                                                  firstChild: Text(
                                                    '${snapshot.data!.phone}',
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  secondChild: SizedBox(
                                                    width: 250,
                                                    child: TextFormField(
                                                        maxLength: 10,
                                                        validator:
                                                            Validators.compose([
                                                          Validators.required(
                                                              'Phone is required'),
                                                        ]),
                                                        controller:
                                                            phoneController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          enabledBorder:
                                                              UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            181,
                                                                            57,
                                                                            5),
                                                                    width: 1.5),
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          181,
                                                                          57,
                                                                          5),
                                                                  width: 1.5)),
                                                        )),
                                                  ),
                                                  crossFadeState: phone
                                                      ? CrossFadeState.showFirst
                                                      : CrossFadeState
                                                          .showSecond,
                                                ),
                                              ]),
                                        ),
                                        Column(
                                          children: [
                                            AnimatedCrossFade(
                                              duration: const Duration(
                                                  milliseconds: 450),
                                              firstChild: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    phoneController.text =
                                                        snapshot.data!.phone!;
                                                    phone = !phone;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.edit,
                                                  size: 28,
                                                ),
                                              ),
                                              secondChild: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      phone = !phone;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              APIServices()
                                                                  .updateProfilePhone(
                                                                      phoneController
                                                                          .text);
                                                              phone = !phone;
                                                            }
                                                          });
                                                        },
                                                        icon: const Icon(
                                                          Icons.check,
                                                          size: 28,
                                                        ),
                                                      ),
                                                      const Icon(
                                                        Icons.close,
                                                        size: 28,
                                                      ),
                                                    ],
                                                  )),
                                              crossFadeState: phone
                                                  ? CrossFadeState.showFirst
                                                  : CrossFadeState.showSecond,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return Center(
                          child: LoadingAnimationWidget.prograssiveDots(
                        color: Colors.blue.shade300,
                        size: 45,
                      ));
                    }),
              ),
              const SizedBox(height: 20),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Column(
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _visibleChangePass = !_visibleChangePass;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Change password',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              _visibleChangePass == false
                                  ? const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 30,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.keyboard_arrow_up_rounded,
                                      size: 30,
                                      color: Colors.black,
                                    ),
                            ],
                          )),
                      Visibility(
                          visible: _visibleChangePass,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: 350,
                                        child: TextField(
                                            controller: oldPassController,
                                            obscureText: oldPassVisible,
                                            onTapOutside: (event) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15),
                                              suffixIcon: IconButton(
                                                icon: Icon(oldPassVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      oldPassVisible =
                                                          !oldPassVisible;
                                                    },
                                                  );
                                                },
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              hintText: 'Current password',
                                              hintStyle: const TextStyle(
                                                  color: Colors.black26),
                                            )),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: 350,
                                        child: TextField(
                                            controller: newPassController,
                                            obscureText: newPassVisible,
                                            onTapOutside: (event) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15),
                                              suffixIcon: IconButton(
                                                icon: Icon(newPassVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      newPassVisible =
                                                          !newPassVisible;
                                                    },
                                                  );
                                                },
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              hintText: 'New password',
                                              hintStyle: const TextStyle(
                                                  color: Colors.black26),
                                            )),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        width: 350,
                                        child: TextFormField(
                                            controller: cfPassController,
                                            obscureText: cfPassVisible,
                                            onTapOutside: (event) {
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            decoration: InputDecoration(
                                              errorStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15),
                                              suffixIcon: IconButton(
                                                icon: Icon(cfPassVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off),
                                                onPressed: () {
                                                  setState(
                                                    () {
                                                      cfPassVisible =
                                                          !cfPassVisible;
                                                    },
                                                  );
                                                },
                                              ),
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              hintText: 'Confirm new password',
                                              hintStyle: const TextStyle(
                                                  color: Colors.black26),
                                            )),
                                      ),
                                    ]),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          )),
                                        ),
                                        child: const Text(
                                          'Save',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 181, 57, 5)),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if (oldPassController.text ==
                                                newPassController.text) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .white70),
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(20,
                                                                  20, 20, 20),
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                'images/assets/icon/1651334.png',
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Text(
                                                                  "New password no same current password",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ],
                                                          )),
                                                    );
                                                  });
                                            } else if (newPassController.text !=
                                                cfPassController.text) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    Future.delayed(
                                                        const Duration(
                                                            seconds: 2), () {
                                                      Navigator.of(context)
                                                          .pop(true);
                                                    });
                                                    return Dialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      insetPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Colors
                                                                  .white70),
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(20,
                                                                  20, 20, 20),
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                'images/assets/icon/1651334.png',
                                                                width: 50,
                                                                height: 50,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              const Text(
                                                                  "Confirm password no match new password",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .black),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ],
                                                          )),
                                                    );
                                                  });
                                            } else {
                                              var checkCurrrentPass =
                                                  APIServices()
                                                      .checkCurrentPassword(
                                                          StaticValue.idAccount,
                                                          oldPassController
                                                              .text);
                                              checkCurrrentPass.then((value) {
                                                if (value.body == "true") {
                                                  var changePass = APIServices()
                                                      .changeUserPassword(
                                                          StaticValue.idAccount,
                                                          oldPassController
                                                              .text,
                                                          newPassController
                                                              .text);
                                                  changePass.then((value) {
                                                    if (value.body == "true" &&
                                                        oldPassController
                                                                .text !=
                                                            newPassController
                                                                .text &&
                                                        newPassController
                                                                .text ==
                                                            cfPassController
                                                                .text) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 2),
                                                                () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(true);
                                                            });
                                                            return Dialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              insetPadding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Container(
                                                                  width: 100,
                                                                  height: 150,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                      color: Colors
                                                                          .white70),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .fromLTRB(
                                                                          20,
                                                                          20,
                                                                          20,
                                                                          20),
                                                                  child: Column(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        'images/assets/icon/2072683.png',
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            50,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      const Text(
                                                                          "Success change password",
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: Colors.black),
                                                                          textAlign: TextAlign.center),
                                                                    ],
                                                                  )),
                                                            );
                                                          });
                                                    }
                                                  });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        Future.delayed(
                                                            const Duration(
                                                                seconds: 2),
                                                            () {
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        });
                                                        return Dialog(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          insetPadding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          child: Container(
                                                              height: 150,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white70),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      20,
                                                                      20,
                                                                      20,
                                                                      20),
                                                              child: Column(
                                                                children: [
                                                                  Image.asset(
                                                                    'images/assets/icon/1651334.png',
                                                                    width: 50,
                                                                    height: 50,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  const Text(
                                                                      "Your current password is incorrect",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          color: Colors
                                                                              .black),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center),
                                                                ],
                                                              )),
                                                        );
                                                      });
                                                }
                                              });
                                            }
                                            // oldPassController.clear();
                                            // newPassController.clear();
                                            // cfPassController.clear();
                                          });
                                        }),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          )),
                    ],
                  )),
              const SizedBox(height: 30),
              SizedBox(
                height: 55,
                width: 395,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                  ),
                  onPressed: () {
                    StaticValue.idAccount = null;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  chooseAvatar(deav) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);

    final filePath = pickedFile!.path;
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);

    setState(() {
      avt = File(compressedImage!.path);
    });
    UploadTask? uploadTask;
    final metadata = SettableMetadata(contentType: "image/jpeg");
    if (avt != null) {
       if(deav != 'NoImage' && deav != null && deav != ' '){
        final ra = FirebaseStorage.instance.refFromURL(deav.toString());
      await ra.delete();
      }
      final avtar = File(avt!.path);
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(avtar.path));
      uploadTask = ref.putFile(avtar,metadata);
      await uploadTask.whenComplete(() async {
        var url = await ref.getDownloadURL();
        APIServices().updateProfileAvatar(url.toString());
      
          StaticValue.userAvatar = url.toString();
      

        // ignore: body_might_complete_normally_catch_error
      }).catchError((onError) {
        // ignore: avoid_print
        print(onError);
      });
      print(StaticValue.userAvatar);
    }

  }

  takeAvatar(deav) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 30);

    final filePath = pickedFile!.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";

    final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        minWidth: 900, minHeight: 900, quality: 50);
    setState(() {
      avt = File(compressedImage!.path);
    });
    UploadTask? uploadTask;
    final metadata = SettableMetadata(contentType: "image/jpeg");
    if (avt != null) {
      if(deav.toString() != 'NoImage' && deav != null && deav.toString() != ' '){
        final ra = FirebaseStorage.instance.refFromURL(deav.toString());
      await ra.delete();
      }
      final avtar = File(avt!.path);
      final ref =
          FirebaseStorage.instance.ref().child(path.basename(avtar.path));
      uploadTask = ref.putFile(avtar,metadata);
      await uploadTask.whenComplete(() async {
        var url = await ref.getDownloadURL();
        APIServices().updateProfileAvatar(url.toString());
        StaticValue.userAvatar = url.toString();
        // ignore: body_might_complete_normally_catch_error
      }).catchError((onError) {
        // ignore: avoid_print
        print(onError);
      });
      print(StaticValue.userAvatar);
    }
    
  }
}
