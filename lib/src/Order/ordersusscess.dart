import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ila/src/Order/orderpage.dart';
import 'package:ila/src/home.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({super.key});

  @override
  State<OrderSuccess> createState() => _OrderState();
}

class _OrderState extends State<OrderSuccess> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 244, 207, 171),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Image.asset('images/assets/icon/720920.png',
                  width: 150, height: 150, fit: BoxFit.cover),
              const SizedBox(height: 10),
              Text('Order Success',
                  style: GoogleFonts.lemon(
                      fontSize: 25, color: Color.fromARGB(255, 181, 57, 5))),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 13),
                          backgroundColor:
                              const Color.fromARGB(255, 199, 161, 122),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(05))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: const Text('Go to homepage',
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                  const SizedBox(width: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 13),
                          backgroundColor:
                              const Color.fromARGB(255, 199, 161, 122),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderPage()));
                      },
                      child: const Text('View your order',
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                ],
              ),
            ])));
  }
}
