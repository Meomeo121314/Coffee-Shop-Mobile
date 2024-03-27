import 'package:flutter/material.dart';
import 'package:ila/API/api_services.dart.dart';
import 'package:ila/Models/supplier.dart';
import 'package:ila/src/Category/supplierpage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final idCate;
  const CategoryPage({Key? key, required this.idCate}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ScrollController verticalController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(136, 219, 193, 172),
            centerTitle: true,
            title: FutureBuilder<List<Supplier>>(
              future: APIServices().fetchSupplier(widget.idCate),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Supplier>? ls = snapshot.data;
                  if (ls != null) {
                    for (var itemls in ls){
                      return Text(itemls.cateName!,
                              style: const TextStyle(fontSize: 25));
                    }
                          
                  } else {
                    return Container();
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return Container();
              },
            )),
        body: SingleChildScrollView(
            controller: verticalController,
            scrollDirection: Axis.vertical,
            child: FutureBuilder<List<Supplier>>(
              future: APIServices().fetchSupplier(widget.idCate),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    List<Supplier> suppList = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: suppList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(children: [
                            const SizedBox(height: 8),
                            CardSupplier(
                              supp: suppList[index],
                            )
                          ]);
                        });
                  } else {
                    return SizedBox();
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
            )));
  }
}

// ignore: must_be_immutable
class CardSupplier extends StatelessWidget {
  Supplier? supp;

  CardSupplier({
    this.supp,
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
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SupplierPage(idSupp: supp!.id)));
        },
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  (supp!.image == 'No Image' ||
                          supp!.image == '' ||
                          supp!.image == null)
                      ? Image.asset(
                          'images/assets/z5091968669411_7ee17c9250dd22a86153ab88031ebcf6.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover)
                      : Image.network(supp!.image.toString(),
                          width: 100, fit: BoxFit.cover),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, left: 18),
                    child: Text(supp!.title!,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
