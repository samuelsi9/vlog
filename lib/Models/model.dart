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
    name: "n",
    description: "new model ",
    price: 345,
    categoryId: 1,
    image: 'assets/women.jpg',
    rating: 2.3,
    review: "too good ",
    fcolor: [Colors.red, Colors.blue, Colors.green],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "nike",
    description:
        "new model nkjcjhvjdvv h jkvjkv jjfkn jkfjkd fjkdjf kjkjf dk,kjdfjfnj jkdkn",
    price: 345,
    categoryId: 2,
    image: 'assets/man.jpg',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.black, Colors.orange, Colors.grey],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "nike",
    description: "new model ",
    price: 345,
    categoryId: 1,
    image: 'assets/kids.jpg',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.purple, Colors.yellow, Colors.pink],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
  itemModel(
    name: "nike",
    description: "new model ",
    price: 345,
    categoryId: 1,
    image: 'assets/women.jpg',
    rating: 2.3,
    review: "too good",
    fcolor: [Colors.green, Colors.blueAccent, Colors.brown],
    size: ["S", "M", "L", "XL"], // ✅ ajouté ici
  ),
];
