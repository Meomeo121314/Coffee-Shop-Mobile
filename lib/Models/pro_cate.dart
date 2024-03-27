class ProductCategory {
  int? idcate;
  String? cateName;
  List<Product>? lsProduct;

  ProductCategory({
    this.idcate,
    this.cateName,
    this.lsProduct,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        idcate: json["idcate"],
        cateName: json["cateName"],
        lsProduct: List<Product>.from(
            json["lsProduct"].map((x) => Product.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "idcate": idcate,
        "cateName": cateName,
        "lsProduct": List<dynamic>.from(lsProduct!.map((x) => x.toJson())),
      };
  List<Product> getProducts() => lsProduct!;
  
}

class Product {
  int? id;
  String? title;
  String? image;
  String? description;
  double? price;

  Product({
    this.id,
    this.image,
    this.title,
    this.description,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        image: json['image'],
        title: json['title'],
        description: json['description'],
        price: json['price'] == null ? 0 : json['price'].toDouble(),
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "description": description,
        "price": price,
      };
}
