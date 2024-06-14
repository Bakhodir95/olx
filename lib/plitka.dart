import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:olx/databases.dart';
import 'package:olx/imagebases.dart';

class Plitka extends StatefulWidget {
  bool revers;
  Plitka({super.key, required this.revers});

  @override
  State<Plitka> createState() => _PlitkaState();
}

class _PlitkaState extends State<Plitka> {
  List products = [];
  int current = 0;
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
                ? GridView.builder(
                    reverse: widget.revers,
                    itemCount: 40,
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3 / 5),
                    itemBuilder: (ctx, index) {
                      return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white), child: Itemwidget(image: Imagebases.carImageUrls[index], name: Databases.products[index]["name"], city: Databases.products[index]["city"], price: Databases.products[index]["price"]));
                    })
                : GridView.builder(
                    reverse: widget.revers,
                    itemCount: products.length,
                    padding: const EdgeInsets.all(15),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 3 / 5),
                    itemBuilder: (ctx, index) {
                      return Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white), child: Itemwidget(image: Imagebases.carImageUrls[index], name: products[index]["name"], city: products[index]["city"], price: products[index]["price"]));
                    })),
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
  Itemwidget({super.key, required this.image, required this.name, required this.city, required this.price});
  bool islike = false;
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.name,
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                    ),
                    const Gap(10),
                    Text(
                      widget.price,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                    ),
                    const Gap(5),
                    Text(
                      widget.city,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                    ),
                  ],
                ),
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
