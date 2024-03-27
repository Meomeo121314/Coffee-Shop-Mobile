import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/review.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ReviewPage extends StatefulWidget {
  final idP;
  const ReviewPage({Key? key, required this.idP}) : super(key: key);
  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  ScrollController verticalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(136, 219, 193, 172),
        centerTitle: true,
        title: const Text(
          'Review Product',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        controller: verticalController,
        child: SingleChildScrollView(
          controller: verticalController,
          scrollDirection: Axis.vertical,
          child: FutureBuilder<List<Review>>(
            future: APIServices().fetchReview(widget.idP),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Review>? lsR = snapshot.data!;
                if (lsR.isEmpty) {
                  return Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        const SizedBox(height: 20),
                        Image.asset('images/assets/icon/641854.png',
                            width: 120, height: 120, fit: BoxFit.cover),
                        const SizedBox(height: 20),
                        const Text('No review product',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500))
                      ]));
                } else {
                  return ListView.builder(
                      itemCount: lsR.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            const SizedBox(height: 8),
                            CardReviewPage(review: lsR[index])
                          ],
                        );
                      });
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Center(
                  child: LoadingAnimationWidget.prograssiveDots(
                color: Colors.blue.shade300,
                size: 45,
              ));
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardReviewPage extends StatelessWidget {
  Review? review;

  CardReviewPage({
    this.review,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: InkWell(
        splashColor: Colors.white,
        onTap: () {},
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(review!.userAvatar!),
                        radius: 25,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        review!.userName!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            RatingBar.readOnly(
                              size: 22,
                              filledIcon: Icons.star,
                              filledColor: Colors.amber,
                              emptyIcon: Icons.star_border,
                              emptyColor: Colors.amber,
                              initialRating: review!.review!,
                              maxRating: 5,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            if (review!.review! == 1)
                              const Row(
                                children: [
                                  Text(
                                    'Terrible',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.sentiment_very_dissatisfied_outlined,
                                    color: Colors.red,
                                    size: 20,
                                  )
                                ],
                              )
                            else if (review!.review! == 2)
                              Row(
                                children: [
                                  Text(
                                    'Bad',
                                    style: TextStyle(
                                        color: Colors.redAccent.shade200,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.redAccent.shade200,
                                    size: 20,
                                  )
                                ],
                              )
                            else if (review!.review! == 3)
                              Row(
                                children: [
                                  Text(
                                    'OK',
                                    style: TextStyle(
                                        color: Colors.amber.shade600,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.sentiment_neutral,
                                    color: Colors.amber.shade600,
                                    size: 20,
                                  )
                                ],
                              )
                            else if (review!.review! == 4)
                              const Row(
                                children: [
                                  Text(
                                    'Good',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.sentiment_satisfied_alt,
                                    color: Colors.lightGreen,
                                    size: 20,
                                  )
                                ],
                              )
                            else if (review!.review! == 5)
                              const Row(
                                children: [
                                  Text(
                                    'Excellent',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.sentiment_very_satisfied_outlined,
                                    color: Colors.green,
                                    size: 20,
                                  )
                                ],
                              )
                          ],
                        )),
                    const SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        DateFormat('dd/MM/yyyy')
                            .format(review!.createDate!.toUtc()),
                        style: const TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

enum SingingCharacter { five, four, three, two, one, zero }

class Star extends StatefulWidget {
  const Star({super.key});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> {
  SingingCharacter? _character = SingingCharacter.zero;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 330,
        child: Column(
          children: [
            RadioListTile<SingingCharacter>(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color.fromARGB(255, 199, 161, 122);
                  }
                  return Colors.black;
                },
              ),
              title: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                ],
              ),
              value: SingingCharacter.five,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            RadioListTile<SingingCharacter>(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color.fromARGB(255, 199, 161, 122);
                  }
                  return Colors.black;
                },
              ),
              title: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                ],
              ),
              value: SingingCharacter.four,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            RadioListTile<SingingCharacter>(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color.fromARGB(255, 199, 161, 122);
                  }
                  return Colors.black;
                },
              ),
              title: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                ],
              ),
              value: SingingCharacter.three,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            RadioListTile<SingingCharacter>(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color.fromARGB(255, 199, 161, 122);
                  }
                  return Colors.black;
                },
              ),
              title: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                ],
              ),
              value: SingingCharacter.two,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            RadioListTile<SingingCharacter>(
              fillColor: MaterialStateColor.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Color.fromARGB(255, 199, 161, 122);
                  }
                  return Colors.black;
                },
              ),
              title: Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.yellow.shade600),
                ],
              ),
              value: SingingCharacter.one,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                });
              },
            ),
            Divider(
              height: 0,
              color: Colors.grey.shade300,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 75),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 199, 161, 122)),
                          //backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          )),
                      onPressed: () => Navigator.pop(context),
                      child: const Column(
                        children: [
                          Text(
                            'Clear',
                            style: TextStyle(
                                color: Color.fromARGB(255, 199, 161, 122),
                                fontSize: 18),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 85),
                          backgroundColor:
                              const Color.fromARGB(255, 199, 161, 122),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1),
                          )),
                      onPressed: () {},
                      child: const Column(
                        children: [
                          Text(
                            'OK',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      )),
                )
              ],
            )
          ],
        ));
  }
}
