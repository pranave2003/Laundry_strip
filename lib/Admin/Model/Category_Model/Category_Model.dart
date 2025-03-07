class Service_category {
  final String Service;
  final String Category;
  final String Product_Name;
  final String Product_Image;

  final String Id;

  Service_category({
    required this.Service,
    required this.Category,
    required this.Product_Name,
    required this.Product_Image,
    required this.Id,

  });

  factory Service_category.fromJson(Map<String, String> json) {
    return Service_category(
        Service: json["trade"] ?? "",
        Category: json["linkedin"] ?? "",
        Product_Name: json["linkedin"] ?? "",
        Product_Image: json["linkedin"] ?? "",
        Id: json["github"] ?? "");
  }
}



