class CategoryModel {
  final String category_id;
  final String service;
  final String category;
  final String product_name;
  final String product_image;


  CategoryModel({
    required this.category_id,
    required this.service,
    required this.category,
    required this.product_name,
    required this.product_image,

  });

  factory CategoryModel.fromMap(Map<String, dynamic> data){
    return CategoryModel(
      category_id: data['category_id'],
      service: data['service'],
      category: data['category'],
      product_name: data['product_name'],
      product_image: data['product_image'],);
  }
}



