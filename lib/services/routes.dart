import '../flavor_config.dart';

String mainAPI = FlavorConfig.apiEndpoint;
String db = "dev"; //eCommerceDev
//old api http://128.199.144.93
//  String mainAPI = 'http://10.0.2.2:8888'; // LOCAL
String loginApi = '$mainAPI/mobile/authenticate';
String signUpApi = '$mainAPI/mobile/signup';
String changePasswordApi = "$mainAPI/mobile/change_password";
String userDetailApi = "$mainAPI/mobile/get_user_detail";
String updateUserDetailApi = "$mainAPI/mobile/update_user";
String searchUserApi = "$mainAPI/mobile/search_user";
String verifyPhApi = "$mainAPI/mobile/verify_phone";
String resetPasswordApi = "$mainAPI/mobile/reset_password";

String getCategoryApi = '$mainAPI/mobile/get_category';
String getProductListApi = '$mainAPI/mobile/get_product_list';
String getProductBestSellerApi = '$mainAPI/mobile/get_product_best_seller';
String getProductRecentViewApi = '$mainAPI/mobile/products/recently_viewed';
String getProductDetailWithProductTempIdApi = '$mainAPI/mobile/get_product';
String getProductDetailWithIdApi = '$mainAPI/mobile/get_product_details';
String getProductDetailWithAttrApi =
    '$mainAPI/mobile/get_combination_info_mobile';
String addToCartApi = '$mainAPI/mobile/cart/update';
String getCartDataApi = '$mainAPI/mobile/cart';
String getWishListApi = '$mainAPI/mobile/wishlist'; // wish = fav
String addWishListApi = '$mainAPI/mobile/wishlist/add';
String removeWishListApi = '$mainAPI/mobile/wishlist/remove';

String getCountryApi = '$mainAPI/mobile/get_country';
String addressApi = '$mainAPI/mobile/address_form';
String checkOutApi = '$mainAPI/mobile/checkout_check';

String checkOutConfirmOrderApi = '$mainAPI/mobile/confirm_order';
String checkOutPaymentApi = '$mainAPI/mobile/payment/transaction/';
String checkOutPaymentFeedBackApi = '$mainAPI/payment/transfer/feedbackmobile';
String createOrderApi = '$mainAPI/payment/kbzpay/precreateorder';
String createQueryOrderApi = '$mainAPI/payment/kbzpay/queryorder';
String confirmOrderInServerApi = '$mainAPI/payment/transfer/feedbackmobile';

String promotionSheetsApi = '$mainAPI/mobile/promotion_template';

String pointHistoryApi = '$mainAPI/mobile/get_point_history';

String orderCountApi = '$mainAPI/mobile/my/home';
