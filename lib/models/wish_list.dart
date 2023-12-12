// ignore_for_file: prefer_const_constructors
// ignore_for_file: sized_box_for_whitespace
// ignore_for_file: use_key_in_widget_constructors
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: deprecated_member_use
// ignore_for_file: prefer_const_declarations
// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: argument_type_not_assignable
// ignore_for_file: non_constant_identifier_names

// Fav = Wish

class WishList {
  final int id;
  final int product_tmpl_id;
  final int product_id;
  final String image_url;
  final String display_name;
  final String description_sale;
  final double price;
  final Map<String, String> imgCookie;

  WishList({
    required this.id,
    required this.product_tmpl_id,
    required this.product_id,
    required this.image_url,
    required this.display_name,
    required this.description_sale,
    required this.price,
    required this.imgCookie,
  });
  factory WishList.fromJson(Map<String, dynamic> product) => WishList(
        id: product["id"],
        product_tmpl_id: product["product_tmpl_id"],
        product_id: product["product_id"],
        image_url:
            product["image_url"] == false ? "null" : product["image_url"],
        display_name: product["display_name"],
        description_sale: product["description_sale"] == false
            ? ""
            : product["description_sale"],
        price: product["price"],
        imgCookie: product["img_cookie"],
      );
}

class WishListwithFav {
  final int id;
  final int product_tmpl_id;
  final int product_id;
  final String image_url;
  final String display_name;
  final String description_sale;
  final double price;
  final Map<String, String> imgCookie;
  late bool favStatus;

  WishListwithFav(
      {required this.id,
      required this.product_tmpl_id,
      required this.product_id,
      required this.image_url,
      required this.display_name,
      required this.description_sale,
      required this.price,
      required this.imgCookie,
      required this.favStatus});
}

// class WishListData {
//   List<WishList> wishList;
//   WishListData({required this.wishList});
// }
