import 'package:flutter/material.dart';

class itemModel {
  final String name;
  final String description;
  final int price;
  final int categoryId;
  final String image;
  final double rating;
  final String review;
  final List<Color> fcolor;
  final List<String> size;

  itemModel({
    required this.description,
    required this.price,
    required this.categoryId,
    required this.name,
    required this.image,
    required this.rating,
    required this.review,
    required this.fcolor,
    required this.size,
  });
}

List<itemModel> itemC = [
  itemModel(
    name: "Vans shoesx12",
    description: "new model ",
    price: 145,
    categoryId: 1,
    image: 'assets/vansone.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "t-shirt ",
    description:
        "new model nkjcjhvjdvv h jkvjkv jjfkn jkfjkd fjkdjf kjkjf dk,kjdfjfnj jkdkn",
    price: 30,
    categoryId: 2,
    image: 'assets/vanda.avif',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.black, Colors.orange, Colors.grey],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "t-shirt ",
    description: "new model ",
    price: 245,
    categoryId: 2,
    image: 'assets/kidvans.avif',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.purple, Colors.yellow, Colors.pink],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "vans globe",
    description: "new model ",
    price: 45,
    categoryId: 2,
    image: 'assets/vanse.webp',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.green, Colors.blueAccent, Colors.brown],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "vans",
    description: "new model ",
    price: 345,
    categoryId: 2,
    image: 'assets/vanswhite.jpg',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: " t-shirt 89skate ",
    description: "new model ",
    price: 345,
    categoryId: 2,
    image: 'assets/nik.jpg',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "t-shirt kids",
    description: "new model ",
    price: 345,
    categoryId: 2,
    image: 'assets/gro.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "t-shirt",
    description: "new model ",
    price: 35,
    categoryId: 2,
    image: 'assets/nity.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "n",
    description: "new model ",
    price: 345,
    categoryId: 2,
    image: 'assets/watch.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "Gucci",
    description: "new model ",
    price: 345,
    categoryId: 1,
    image: 'assets/wshoes.jpg',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "Dolce Gabbana ",
    description: "new model ",
    price: 450,
    categoryId: 1,
    image: 'assets/DG xe3.jpg',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "yves saint laurent  ",
    description: "new model ",
    price: 450,
    categoryId: 1,
    image: 'assets/zz.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "yves saint laurent  ",
    description: "new model ",
    price: 50,
    categoryId: 1,
    image: 'assets/zx.webp',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
];
