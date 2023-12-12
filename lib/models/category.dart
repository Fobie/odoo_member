class Category {
  final int id;
  final String catName;
  final String imageUrl;
  final int parentId;
  final int websiteId;
  final int sequence;
  final int subCategoryCount;
  final int productCount;
  final Map<String, String> imgCookie;

  Category({
    required this.id,
    required this.catName,
    required this.imageUrl,
    required this.parentId,
    required this.websiteId,
    required this.sequence,
    required this.subCategoryCount,
    required this.productCount,
    required this.imgCookie,
  });

  factory Category.fromJson(Map<String, dynamic> categoryjson) => Category(
      id: categoryjson["id"],
      catName: categoryjson["name"],
      parentId:
          categoryjson["parentId"] == false ? 0 : categoryjson["parentId"],
      websiteId:
          categoryjson["websiteId"] == false ? 0 : categoryjson["websiteId"],
      sequence: categoryjson["sequence"],
      subCategoryCount: categoryjson["subCategoryCount"],
      productCount: categoryjson["productCount"],
      imageUrl: categoryjson["image_128_url"] == false
          ? ""
          : categoryjson["image_128_url"],
      imgCookie: categoryjson["img_cookie"]
      // id: categoryjson["id"],
      // catName: categoryjson["name"],
      // imageUrl: categoryjson["image_128_url"]
      // parentId:
      //     categoryjson["parentId"] == false ? 0 : categoryjson["parentId"],
      // websiteId:
      //     categoryjson["websiteId"] == false ? 0 : categoryjson["websiteId"],
      // sequence: categoryjson["sequence"],
      // subCategoryCount: categoryjson["subCategoryCount"],
      // productCount: categoryjson["productCount"],
      // image_128: categoryjson["image_128"] == false
      //     ? "null"
      //     : categoryjson["image_128"],
      // image_1920: categoryjson["image_1920"] == false
      //     ? "null"
      //     : categoryjson["image_1920"]
      );
}
