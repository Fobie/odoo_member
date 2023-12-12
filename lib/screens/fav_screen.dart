// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../view_models/wish_list_vm.dart';
// import '../view_models/product_list_vm.dart';
// import '../widgets/app_drawer.dart';
// import '../view_models/category_list_vm.dart';
// import '../widgets/fav_list_widgets/empty_fav.dart';
// import '../widgets/fav_list_widgets/fav_list_grid.dart';
// import '../widgets/product_overview_widget/product_ov_item_grid.dart';

// class FavouriteScreen extends StatelessWidget {
//   static String routeName = '/favourite';

//   const FavouriteScreen({
//     super.key,
//   });

//   Future<void> _fetchWishList(BuildContext context) async {
//     await Provider.of<WishListVM>(context, listen: false).fetchWishList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final catData = Provider.of<CategoryListVM>(context);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         centerTitle: true,
//         title: Text("Favourite", style: Theme.of(context).textTheme.headline5),
//       ),
//       drawer: AppDrawer(),
//       body: FutureBuilder(
//         future: _fetchWishList(context),
//         builder: (ctx, snapshot) =>
//             snapshot.connectionState == ConnectionState.waiting
//                 ? const Center(
//                     child: CircularProgressIndicator(),
//                   )
//                 : RefreshIndicator(
//                     onRefresh: () => _fetchWishList(context),
//                     child: Consumer<WishListVM>(
//                       builder: (ctx, wishData, _) {
//                         return wishData.commonWishList.isEmpty
//                             ? EmptyFav()
//                             : // Text("wishData.wishList");
//                             FavListGrid(
//                                 prodFavList: wishData.commonWishList,
//                                 // catIDs: catData.CatIDs,
//                               );
//                       },
//                     ),
//                   ),
//       ),
//     );
//   }
// }
