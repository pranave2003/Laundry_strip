class Addproductmodel {
  final productid;
  final service;
  final category;
  final product_name;
  final product_image;
  final shopid;
  final Productprice;

  Addproductmodel({
    this.productid,
    this.service,
    this.category,
    this.product_name,
    this.product_image,
    this.shopid,
    this.Productprice,
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
