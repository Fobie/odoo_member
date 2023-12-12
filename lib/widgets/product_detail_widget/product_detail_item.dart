import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../common/common_widget.dart';
import '../../custom_decoratoin.dart';
import '../../models/product_detail.dart';
import '../../common/size_config.dart';
import '../../view_models/detail_product_vm.dart';
import '../../models/product_detail_with_attr_model.dart';

class ProductDetailItem extends StatefulWidget {
  final String productTmplId;
  // final ProductByCat product;
  // final wishListforIcon prdwish;

  const ProductDetailItem({
    super.key,
    required this.productTmplId,
  });

  Future<void> _fetchDetailProduct(BuildContext context) async {
    await Provider.of<DetailProductVM>(context, listen: false)
        .fetchProductDetailByProdID(productTmplId)
        .then((result) {
      if (!result.status) {
        showMessage(context, result.message, result.status);
      }
    });
  }

  @override
  State<ProductDetailItem> createState() => _ProductDetailItemState();
}

class _ProductDetailItemState extends State<ProductDetailItem> {
  String customText = '';
  String customNote = "";
  String typeAttrName = "";
  bool othertrueData = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._fetchDetailProduct(context),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<DetailProductVM>(
              builder: (ctx, productProvider, child) {
                return productProvider.currentProduct == null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "No product found with scanned barcode ${widget.productTmplId}",
                            style: optionTextStyle(),
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image
                            _image(productProvider.currentProduct!),
                            const SizedBox(height: 5),
                            // Name // Dun wanna rebuild
                            _title(productProvider.currentProduct!.name),
                            // Price
                            _price(
                                productProvider.currentProduct!.priceCurrency,
                                productProvider.currentProduct!.price
                                    .toString()),
                            Visibility(
                              visible:
                                  productProvider.showConbinationAlert.value,
                              child: const Text(
                                "Your selectection  is not available",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            // Attributes
                            // getAttrListWidget(productProvider.productVariants),
                            if (productProvider.currentProduct!
                                .theme_prime_description.isNotEmpty)
                              _themePrimeDescription(productProvider
                                  .currentProduct!.theme_prime_description),
                            // sale description
                            if (productProvider
                                .currentProduct!.saleDescription.isNotEmpty)
                              _saleDescription(productProvider
                                  .currentProduct!.saleDescription)
                          ],
                        ),
                      );
              },
            ),
    );
  }

  Widget getAttrListWidget(List<ProductVariant> pCList) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < pCList.length; i++) {
      list.add(showVariantSelector(i, pCList));
    }
    return Column(children: list);
  }

  Widget showVariantSelector(int i, List<ProductVariant> prdAtrribute) {
    return Row(
      children: [
        Text(
          prdAtrribute[i].name,
          style: const TextStyle(
              color: Colors.purple, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: prdAtrribute[i]
                .attributes
                .map(
                  (data) => Column(
                    children: [
                      Consumer<DetailProductVM>(
                        builder: (context, prdValue, child) => prdAtrribute[i]
                                    .displayType ==
                                'color'
                            ? Padding(
                                // Color show
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(data.hexColor)),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Checkbox(
                                    checkColor: MaterialStateColor.resolveWith(
                                      (states) => data.name != "Black"
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255),
                                    ),
                                    fillColor: MaterialStateColor.resolveWith(
                                      (states) => data.name == "Black"
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : Color(int.parse(data.hexColor)),
                                    ),
                                    onChanged: (value) {
                                      // duplicated
                                      setState(
                                        () {
                                          selectionFilter(
                                              prdAtrribute, data, i);
                                          // prdValue.getAttrProduct();
                                        },
                                      );
                                    },
                                    value: data.checked,
                                  ),
                                ),
                              )
                            : prdAtrribute[i].displayType == 'select'
                                // Select Show
                                ? Checkbox(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 10, 108, 188)),
                                    value: data.checked,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectionFilter(
                                              prdAtrribute, data, i);

                                          if (i == 0) {
                                            // check if leg type changed
                                            customNote = data.name;
                                          } else {
                                            customNote = "";
                                          }
                                        },
                                      );
                                      if (customNote == "Custom") {
                                        // prdValue.getAttrProduct();
                                      } else {
                                        customText = "";
                                        // prdValue.getAttrProduct();
                                      }
                                    },
                                  )
                                // Radio show
                                : Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 10, 108, 188)),

                                    value: data.index, // index id of steel
                                    groupValue: prdAtrribute[i]
                                        .selectedIndex, // current selected index id of Leg, colour or size

                                    onChanged: (index) {
                                      setState(
                                        () {
                                          prdAtrribute[i].selectedIndex =
                                              data.index;
                                          if (i == 0) {
                                            // check if leg type changed
                                            customNote = data.name;
                                          } else {
                                            customNote = "";
                                          }
                                        },
                                      );
                                      // print(customNote);
                                      if (customNote == "Custom") {
                                        // prdValue.getAttrProduct();
                                      } else {
                                        customText = "";
                                        // prdValue.getAttrProduct();
                                      }
                                    },
                                  ),
                      ),
                      data.extra == 0.0
                          ? const Text("  "
                              // style: TextStyle(color: Colors.red),
                              )
                          : Text(
                              "  +\$ ${data.extra}",
                              style: const TextStyle(color: Colors.red),
                            ),
                      prdAtrribute[i].displayType == 'color'
                          ? const Text("")
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(5)),
                              child: Text(data.name),
                            ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget showRadioOrSelector(int i, List<ProductVariant> pCList) {
    return Column(
      // alignment: Alignment.centerLeft,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          pCList[i].name,
          style: const TextStyle(
              color: Colors.purple, fontSize: 19, fontWeight: FontWeight.bold),
        ),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Column(
            children: pCList[i]
                .attributes
                .map(
                  (data) => Row(
                    children: [
                      Consumer<DetailProductVM>(
                        builder: (ctx, prdData, _) => pCList[i].displayType ==
                                'color'
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Color(int.parse(data.hexColor)),
                                    border: Border.all(
                                        color: Colors.black, width: 2),
                                  ),
                                  child: Checkbox(
                                    checkColor: MaterialStateColor.resolveWith(
                                        (states) => data.name != "Black"
                                            ? const Color.fromARGB(255, 0, 0, 0)
                                            : const Color.fromARGB(
                                                255, 255, 255, 255)),
                                    fillColor: MaterialStateColor.resolveWith(
                                      (states) => data.name == "Black"
                                          ? const Color.fromARGB(255, 0, 0, 0)
                                          : Color(int.parse(data.hexColor)),
                                    ),
                                    onChanged: (value) {
                                      // duplicated
                                      setState(
                                        () {
                                          selectionFilter(pCList, data, i);
                                          // prdData.getAttrProduct();
                                        },
                                      );
                                    },
                                    value: data.checked,
                                  ),
                                ),
                              )
                            : pCList[i].displayType == 'select'
                                // Select Show
                                ? Checkbox(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 10, 108, 188)),
                                    value: data.checked,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectionFilter(pCList, data, i);

                                          if (i == 0) {
                                            // check if leg type changed
                                            customNote = data.name;
                                          } else {
                                            customNote = "";
                                          }
                                        },
                                      );
                                      if (customNote == "Custom") {
                                        // prdData.getAttrProduct();
                                      } else {
                                        customText = "";
                                        // prdData.getAttrProduct();
                                      }
                                    },
                                  )
                                // Radio show
                                : Radio(
                                    fillColor: MaterialStateColor.resolveWith(
                                        (states) => const Color.fromARGB(
                                            255, 10, 108, 188)),

                                    value: data.index, // index id of steel
                                    groupValue: pCList[i]
                                        .selectedIndex, // current selected index id of Leg, colour or size

                                    onChanged: (index) {
                                      setState(
                                        () {
                                          pCList[i].selectedIndex = data.index;
                                          if (i == 0) {
                                            // check if leg type changed
                                            customNote = data.name;
                                          } else {
                                            customNote = "";
                                          }
                                        },
                                      );
                                      // print(customNote);
                                      if (customNote == "Custom") {
                                        // prdData.getAttrProduct();
                                      } else {
                                        customText = "";
                                        // prdData.getAttrProduct();
                                      }
                                    },
                                  ),
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            text: pCList[i].displayType == 'color'
                                ? ""
                                : data.name,
                            style: const TextStyle(color: Colors.black),
                            children: [
                              data.extra == 0.0
                                  ? const TextSpan(
                                      text: "  ",
                                      // style: TextStyle(color: Colors.red),
                                    )
                                  : TextSpan(
                                      text: "  +\$ ${data.extra}",
                                      style: const TextStyle(color: Colors.red),
                                    )
                            ],
                          ),
                        ),
                      ),
                      //)
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  void selectionFilter(List<ProductVariant> pCList, data, int i) {
    pCList[i].selectedIndex = data.index;

    if (data.checked == false) {
      data.checked = true;
    } else {
      for (int z = 0; z < pCList[i].attributes.length; z++) {
        if (pCList[i].attributes[z].name != data.name) {
          if (pCList[i].attributes[z].checked == true) {
            // is there any checked true data except the selected item
            othertrueData = true;
          }
        }
      }
      // To make at least one option is clicked
      if (othertrueData == true) {
        data.checked = false;
        othertrueData = false;
      } else {
        data.checked = true;
      }
    }
    // If one option is checked
    // uncheck the previous checked option
    if (data.checked == true) {
      for (int z = 0; z < pCList[i].attributes.length; z++) {
        if (pCList[i].attributes[z].checked == true) {
          if (data.name != pCList[i].attributes[z].name) {
            pCList[i].attributes[z].checked = false;
          }
        }
      }
    }
  }
}

Widget _image(ProductDetail product) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(getProportionateScreenHeight(50)),
      child: SizedBox(
        height: getProportionateScreenHeight(230),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage(AssetImagePath.c4eFadeinImg),
            image: NetworkImage(
              product.image1920,
              headers: product.imgCookie,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _title(String prdName) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      FittedBox(
        child: Text(
          prdName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    ],
  );
}

Widget _price(String currency, String price) {
  String currencySign = "";
  switch (currency) {
    case "USD":
      currencySign = "\$";
      break;
    case "MMK":
      currencySign = "MMK";
      break;
    case "EUR":
      currencySign = "EUR";
      break;
    default:
  }
  return Text(
    '$currencySign $price',
    style: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    //  ),
  );
}

Widget _saleDescription(String saleDes) {
  return Column(
    children: [
      const Text(
        "Sale Description :",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        saleDes,
        style: const TextStyle(fontSize: 15, color: Colors.black54
            // fontWeight: FontWeight.bold,
            ),
        //  ),
      ),
      // const Divider()
    ],
  );
}

Widget _themePrimeDescription(List<dynamic> themeParkDes) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Product Description",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        ...themeParkDes.map(
          (text) => Row(
            children: [
              Text(
                '\u2022 $text',
                style: optionTextStyle(),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    ),
  );
}
