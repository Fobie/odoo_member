import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key});

  @override
  CartCounterState createState() => CartCounterState();
}

class CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              numOfItems++;
            });
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
      ],
    );
  }

  // SizedBox buildOutlineButton({IconData? icon, VoidCallback? press}) {
  //   return SizedBox(
  //     width: 40,
  //     height: 32,

  //       padding: EdgeInsets.zero,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(13),
  //       ),
  //       onPressed: press,
  //       child: Icon(icon),
  //     ),
  //   );
}
