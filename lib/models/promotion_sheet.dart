class Products {
  final int id;
  final String name;
  final String type;
  final int targetPoint;
  final String endDate;
  final String termsAndConditions;
  final String image;
  final Map<String, String> imgCookie;

  Products({
    required this.id,
    required this.name,
    required this.type,
    required this.targetPoint,
    required this.endDate,
    required this.termsAndConditions,
    required this.image,
    required this.imgCookie,
  });

  factory Products.fromJson(Map<String, dynamic> data) => Products(
      id: data["id"],
      name: data["name"],
      type: data["type"],
      targetPoint: data["target_point"],
      endDate: data["expire_date"],
      termsAndConditions: data["terms_condition"],
      image: data["image"],
      imgCookie: data["sessionId"]);
}