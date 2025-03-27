class Addproductmodel {
  final productid;
  final String service;
  final String category;
  final String product_name;
  final String product_image;
  final String shopid;
  final String Productprice;

  Addproductmodel({
    this.productid,
    required this.service,
    required this.category,
    required this.product_name,
    required this.product_image,
    required this.shopid,
    required this.Productprice,
  });

  factory Addproductmodel.fromMap(Map<String, dynamic> data) {
    return Addproductmodel(
      productid: data['productid'],
      service: data['service'],
      category: data['category'],
      product_name: data['product_name'],
      product_image: data['product_image'],
      shopid: data['shopid'],
      Productprice: data['Productprice'],
    );
  }
}
