class Product {
  int? id;
  String? name;
  String? desc;
  double? price;
  String? color;
  String? image;

  Product({this.id, this.name, this.desc, this.price, this.color, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    price = double.parse(json['price'].toString());
    color = json['color'];
    image = json['image'];
  }
}
