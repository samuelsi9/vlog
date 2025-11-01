class FCategoryModel {
  final String name;
  final String image;

  FCategoryModel({required this.name, required this.image});
}

List<FCategoryModel> fcategory = [
  FCategoryModel(name: "Women", image: 'assets/women.jpg'),
  FCategoryModel(name: "Men", image: 'assets/man.jpg'),
  FCategoryModel(name: "Kids", image: 'assets/kids.jpg'),
  FCategoryModel(name: "Shoes", image: 'assets/shoes.jpg'),
  FCategoryModel(name: "Accessories", image: 'assets/acces.webp'),
];

List<String> filterCategory = [
  "Filter",
  "Rating",
  "Size",
  "Color",
  "Price",
  "Brand",
];
