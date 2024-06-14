import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:olx/databases.dart';
import 'package:olx/imagebases.dart';

class Galary extends StatefulWidget {
  const Galary({super.key});

  @override
  State<Galary> createState() => _GalaryState();
}

class _GalaryState extends State<Galary> {
  int current = 0;

  List products = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(10),
        TextField(
          onTap: () {
            current = 1;
            setState(() {});
          },
          onChanged: (vale) {
            products = [];
            for (var i = 0; i < Databases.products.length; i++) {
              if (Databases.products[i]["name"].contains(vale)) {
                products.add(Databases.products[i]);
              }
            }
            setState(() {});
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        Expanded(
          child: current == 0
              ? ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    for (var i = 0; i < Databases.products.length; i++)
                      Column(
                        children: [Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white), height: 380, child: Itemwidget(image: Imagebases.carImageUrls[i % 30], name: Databases.products[i]["name"], city: Databases.products[i]["city"], price: Databases.products[i]["price"])), const Gap(20)],
                      )
                  ],
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    for (var i = 0; i < products.length; i++)
                      Column(
                        children: [Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white), height: 380, child: Itemwidget(image: Imagebases.carImageUrls[i % 30], name: products[i]["name"], city: products[i]["city"], price: products[i]["price"])), const Gap(20)],
                      )
                  ],
                ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Itemwidget extends StatefulWidget {
  String image;
  String name;
  String city;
  String price;
  bool islike = false;

  Itemwidget({super.key, required this.image, required this.name, required this.city, required this.price});
  @override
  State<Itemwidget> createState() => _ItemwidgetState();
}

class _ItemwidgetState extends State<Itemwidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 2,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  FadeInImage(
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.image),
                    placeholder: const AssetImage(
                      "images/loading.gif",
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 40,
                      decoration: BoxDecoration(color: Colors.cyanAccent[700], borderRadius: BorderRadius.circular(5)),
                      child: const Text("TOP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              )),
          const Gap(15),
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  const Gap(10),
                  Text(
                    widget.price,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const Gap(5),
                  Text(
                    widget.city,
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    widget.islike = !widget.islike;
                    setState(() {});
                  },
                  child: widget.islike
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon((Icons.favorite)))
            ],
          ))
        ],
      ),
    );
  }
}
