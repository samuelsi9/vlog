import 'package:flutter/material.dart';
import 'package:vlog/Models/model.dart';
import 'package:vlog/Utils/colors.dart';
import 'package:vlog/presentation/cart/card.dart';

class Detail extends StatefulWidget {
  final itemModel ecom;

  Detail({super.key, required this.ecom});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int currentIndex = 0;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 0;
  int addflagItemcard = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbackgroundColor2,
        title: Text("Detail Product"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.shopping_bag, size: 28),
              Positioned(
                right: -3,
                top: -3,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ProfileScreen()),
                        );
                      },
                      child: Text(
                        " $addflagItemcard",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: fbackgroundColor2,
            height: size.height * 0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      widget.ecom.image,
                      height: size.height * 0.4,
                      width: size.width * 0.85,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          margin: EdgeInsets.only(right: 4),
                          height: 7,
                          width: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: index == currentIndex
                                ? Colors.blue
                                : Colors.grey.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "H&M",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black26,
                      ),
                    ),

                    const SizedBox(width: 5),
                    const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 16, 14, 9),
                      size: 17,
                    ),
                    Text(widget.ecom.rating.toString()),
                    Text(
                      "(${widget.ecom.review})",
                      style: TextStyle(color: Colors.black26),
                    ),

                    Row(
                      children: [
                        Text(
                          " \$${widget.ecom.price.toString()}.00",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.pink,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(Icons.favorite_border),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  " ${widget.ecom.description}",
                  style: (TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width / 2.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Text(
                            "Color",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: widget.ecom.fcolor.asMap().entries.map((
                                entry,
                              ) {
                                final int index = entry.key;
                                final color = entry.value;
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                    right: 10,
                                  ),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: color,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedColorIndex = index;
                                        });
                                      },
                                      child: Icon(
                                        Icons.check,
                                        color: selectedColorIndex == index
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(), // ✅ plus de crochets extérieurs
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width / 2.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Text(
                            "Size",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: widget.ecom.size.asMap().entries.map((
                                entry,
                              ) {
                                final int index = entry.key;
                                final String size = entry.value;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSizeIndex = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                      top: 10,
                                    ),
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: selectedSizeIndex == index
                                          ? Colors.black
                                          : Colors.white,
                                      border: Border.all(
                                        color: selectedSizeIndex == index
                                            ? Colors.black
                                            : Colors.black12,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: selectedSizeIndex == index
                                              ? Colors.white
                                              : Colors.black12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(), // ✅ plus de crochets extérieurs
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag, color: Colors.black),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            addflagItemcard++;
                          });
                        },
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: -1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(color: Colors.white, letterSpacing: -1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
