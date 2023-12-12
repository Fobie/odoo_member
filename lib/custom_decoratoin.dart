import 'package:c4e_rewards/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../common/size_config.dart';

InputDecoration getInputDecoration({
  required String hint,
  required String label,
  required bool showSurfixIco,
  Widget? prefixWidget,
  IconData? surfixButIcon,
  VoidCallback? surfixButAction,
}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      hintText: hint,
      labelText: label,
      prefix: prefixWidget,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        // borderSide:
        //     const BorderSide(color: Color.fromRGBO(103, 58, 183, 1), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10.0),
      ),
      suffixIcon: showSurfixIco
          ? IconButton(
              icon: Icon(surfixButIcon),
              iconSize: 30,
              onPressed: surfixButAction,
            )
          : null);
}

InputDecoration getTxtCtrlDecoration({
  required String hint,
  required String label,
  String? error,
}) {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    errorText: error,
    hintText: hint,
    labelText: label,
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: 1.2,
      fontSize: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      // borderSide:
      //     const BorderSide(color: Color.fromRGBO(103, 58, 183, 1), width: 2.0),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade400),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}
// ButtonStyle getElevatedButtonStyle(BuildContext context) {
//   return ElevatedButton.styleFrom(
//       padding: EdgeInsets.symmetric(
//           horizontal: getProportionateScreenWidth(60), vertical: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(25.0),
//       ),
//       primary: Theme.of(context).colorScheme.primary);
// }

ButtonStyle getDialogElevatedStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
      // padding: EdgeInsets.symmetric(
      //   horizontal: getProportionateScreenWidth(120 / 2),
      //   // vertical: getProportionateScreenHeight(20),
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary);
}

ButtonStyle getNewElevatedButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary);
}

ButtonStyle getDialogOutLineStyle(BuildContext context) {
  return OutlinedButton.styleFrom(
      // padding: EdgeInsets.symmetric(
      //   horizontal: getProportionateScreenWidth(120 / 2),
      //   vertical: getProportionateScreenHeight(20),
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: Theme.of(context).colorScheme.primary);
}

ButtonStyle getNewOutLineButtonStyle(BuildContext context) {
  return OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      // padding: EdgeInsets.symmetric(
      //   horizontal: getProportionateScreenWidth(75),
      //   vertical: getProportionateScreenHeight(20),
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: Theme.of(context).colorScheme.primary);
}

Route createRoute(Widget routedWidget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routedWidget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      final tween = Tween(begin: begin, end: end);
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

TextStyle pageHeaderTextStyle(BuildContext context) {
  return TextStyle(
    color: Theme.of(context).colorScheme.secondary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );
}

TextStyle formTextStyle(BuildContext context,
    {FontWeight fontWeight = FontWeight.w600,
    double letterSpacing = 1.1,
    Color? textColor,
    double fontSize = 14}) {
  return TextStyle(
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
    fontSize: fontSize,
    color: textColor ?? Theme.of(context).colorScheme.onBackground,
  );
}

TextStyle optionTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Colors.black54,
  );
}

Widget skeletonCarousel(BuildContext context, {double height = 280}) {
  return SkeletonItem(
    child: Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(15),
      ),
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, realIndex) => Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SizedBox(
                width: double.infinity,
                height: getProportionateScreenHeight(250),
              ),
            ),
            options: CarouselOptions(
                // aspectRatio: 2 / 1,
                height: getProportionateScreenHeight(height),
                enlargeCenterPage: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true),
          )
        ],
      ),
    ),
  );
}

Widget blankCarousel(BuildContext context,
    {VoidCallback? function, bool? hasError}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: getProportionateScreenHeight(10),
      horizontal: getProportionateScreenHeight(10),
    ),
    child: Card(
      color: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: double.infinity,
        height: getProportionateScreenHeight(280),
        child: Center(
          child: function == null
              ? const Text("No promotion found")
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Error while data fetching"),
                    ElevatedButton(
                      onPressed: function,
                      child: const Text("refresh"),
                    )
                  ],
                ),
        ),
      ),
    ),
  );
}

Widget homeTitleTextWidget({required String text}) {
  return Padding(
    padding: EdgeInsets.only(left: 10, bottom: 10),
    child: Text(
      text,
      style: homeTitleStyle,
    ),
  );
}
