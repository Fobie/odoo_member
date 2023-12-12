import 'package:flutter/material.dart';

import '../common/size_config.dart';

class ListTileOption extends StatelessWidget {
  const ListTileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.tapHandler,
    required this.color,
  });

  final IconData icon;
  final String title;
  final VoidCallback tapHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(1),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(1)),
        elevation: 2,
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                // letterSpacing: 1.2,
                fontSize: 16,
                color: Colors.black54,
              )
              //const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              ),
          onTap: tapHandler,
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
          // InkWell(
          //   onTap: tapHandler,
          //   child: Container(
          //     padding: EdgeInsets.all(
          //       getProportionateScreenWidth(8.0),
          //     ),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       color: Colors.white,
          //       boxShadow: [
          //         BoxShadow(
          //           color: const Color(0x3322292E).withOpacity(0.5),
          //           blurRadius: 5,
          //         ),
          //       ],
          //     ),
          //     child: Row(
          //       children: [
          //         Container(
          //           padding: EdgeInsets.all(
          //             getProportionateScreenWidth(8.0),
          //           ),
          //           decoration: ShapeDecoration(
          //             color: color,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(
          //                 getProportionateScreenWidth(8.0),
          //               ),
          //             ),
          //           ),
          //           child: Icon(
          //             icon,
          //             color: Colors.white70,
          //           ),
          //         ),
          //         SizedBox(
          //           width: getProportionateScreenWidth(8.0),
          //         ),
          //         Expanded(
          //           child: Text(
          //             title,
          //           ),
          //         ),
          //         const Icon(Icons.arrow_forward_ios_rounded),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
