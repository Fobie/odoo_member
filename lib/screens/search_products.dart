// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';

// import '../view_models/product_list_vm.dart';
// import '../widgets/product_overview_widget/product_ov_item_grid.dart';

// class SearchProducts extends StatefulWidget {
//   static String routeName = "/search";
//   const SearchProducts({Key? key}) : super(key: key);

//   @override
//   State<SearchProducts> createState() => _SearchProductsState();
// }

// class _SearchProductsState extends State<SearchProducts> {
//   Future<void> _searchProductbyCatID(
//       BuildContext context, String searchContext, int? catId) async {
//     await Provider.of<ProductListVM>(context, listen: false)
//         .SearchAndFetchProduct(searchContext, catId);
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   final fieldText = TextEditingController();

//   String searchText = "";
//   bool _isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final catProps =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).primaryColor,
//         title: Container(
//           width: double.infinity,
//           height: 40,
//           decoration: BoxDecoration(
//               color: Colors.white, borderRadius: BorderRadius.circular(5)),
//           child: Center(
//             child: TextField(
//               controller: fieldText,
//               onSubmitted: (val) => {
//                 searchText = val,
//                 setState(() {
//                   _isLoading = true;
//                   _searchProductbyCatID(context, searchText, catProps["catId"]);
//                 })
//               },
//               decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.search),
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.clear),
//                     onPressed: () {
//                       fieldText.clear();
//                       Provider.of<ProductListVM>(context, listen: false)
//                           .clearSerach();
//                     },
//                   ),
//                   hintText: catProps["catId"] == null
//                       ? 'Search proucts'
//                       : 'Search ${catProps["catName"]}',
//                   border: InputBorder.none),
//             ),
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//               // child: Lottie.asset('assets/animation/purple_dot_loading.json',
//               //     width: 250, height: 100),
//             )
//           : Consumer<ProductListVM>(
//               builder: (context, productsData, child) =>
//                   productsData.SearchProductList.isEmpty
//                       ? const Center(
//                           child: Text("No Seach Result"),
//                         )
//                       : Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: GridView(
//                             gridDelegate:
//                                 const SliverGridDelegateWithMaxCrossAxisExtent(
//                               maxCrossAxisExtent: 200,
//                               childAspectRatio: 0.8,
//                             ),
//                             children: List.generate(
//                               productsData.SearchProductList.length,
//                               (index) => ProductOvItemGrid(
//                                 product: productsData.commmonSearchList[index],
//                                 alreadyAddCartorNot: false,
//                               ),
//                             ),
//                           ),
//                         ),
//             ),
//     );
//   }
// }
