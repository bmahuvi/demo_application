class CartModel {
  CartModel({
    required this.id,
    required this.quantity,
    required this.title,
    required this.price,
    required this.image,
  });

  final int id;
  final int quantity;
  final String title;
  final double price;
  final String image;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        quantity: json['quantity'],
        title: json["title"],
        price: json["price"]?.toDouble(),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "title": title,
        "price": price,
        "image": image,
      };
}
