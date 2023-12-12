import 'package:c4e_rewards/models/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_detail.dart';
import '../models/result_status.dart';
import '../../common/common_widget.dart';
import '../common/size_config.dart';
import '../constants.dart';
import '../custom_decoratoin.dart';
import '../view_models/detail_product_vm.dart';
// import '../widgets/product_detail_widget/product_detail_item.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routeName = '/product-details';

  const ProductDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String productBarcode =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ViewProductDetailWidget(productImplId: productBarcode),
            backArrowWithLabel(context, "Product Detail")
          ],
        ),
      ),
    );
  }
}

class ViewProductDetailWidget extends StatefulWidget {
  final String productImplId;
  const ViewProductDetailWidget({super.key, required this.productImplId});

  @override
  State<ViewProductDetailWidget> createState() =>
      _ViewProductDetailWidgetState();
}

class _ViewProductDetailWidgetState extends State<ViewProductDetailWidget> {
  Future<ResultStatus> _fetchDetailProduct(BuildContext context) async {
    return await Provider.of<DetailProductVM>(context, listen: false)
        .fetchProductDetailByProdID(widget.productImplId)
        .then((result) => result);
  }

  Future<void> _fetchCombination() async {
    overLayLoadingSpinner(context);
    await Provider.of<DetailProductVM>(context, listen: false)
        .getCombinationProductInfo()
        .then((result) {
      Navigator.of(context).pop();
      if (!result.status) {
        showMessage(context, result.message, result.status);
      }
    });
  }

  Widget _price(String currency, String price) {
    return Text(
      '$price $currency',
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      //  ),
    );
  }

  Widget _themePrimeDescription(List<dynamic> themeParkDes) {
    return themeParkDes.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Product Description",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...themeParkDes.map(
                  (text) => Text(
                    '\u2022 $text',
                    style: optionTextStyle(),
                  ),
                ),
                const Divider()
              ],
            ),
          );
  }

  @override
  void deactivate() {
    Provider.of<DetailProductVM>(context, listen: false).resetValue();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchDetailProduct(context),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Selector<DetailProductVM, ProductDetail?>(
              selector: (context, provider) => provider.currentProduct,
              shouldRebuild: (previous, next) => previous != next,
              builder: (ctx, product, child) {
                if (product == null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "No product found with scanned barcode ${widget.productImplId}",
                        style: optionTextStyle(),
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),

                      Center(
                        child: SizedBox(
                          height: getProportionateScreenHeight(250),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage(AssetImagePath.c4eFadeinImg),
                              image: NetworkImage(
                                product.image1920,
                                headers: product.imgCookie,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      FittedBox(
                        child: Text(
                          product.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      // Price
                      _price(product.priceCurrency, product.price.toString()),

                      Selector<DetailProductVM, bool>(
                        shouldRebuild: (previous, next) => previous != next,
                        builder: (context, dontHaveComibination, child) =>
                            Visibility(
                          visible: dontHaveComibination,
                          child: const Text(
                            "Your selection  is not available",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        selector: (context, provider) =>
                            provider.showConbinationAlert.value,
                      ),
                      if (product.productTmplAttributeLines.isNotEmpty)
                        ...product.productTmplAttributeLines
                            .asMap()
                            .entries
                            .map((attribute) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            attribute.value.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width:
                                                    getProportionateScreenWidth(
                                                        15),
                                              ),
                                              ...attribute.value.values
                                                  .asMap()
                                                  .entries
                                                  .map((attributeValue) {
                                                switch (attribute
                                                    .value.displayType) {
                                                  case AttributeDisplayType
                                                      .radio:
                                                    return RadioSelectorWidget(
                                                        action:
                                                            _fetchCombination,
                                                        templateIndex:
                                                            attribute.key,
                                                        attributeIndex:
                                                            attributeValue.key,
                                                        attributeValue:
                                                            attributeValue
                                                                .value);
                                                  case AttributeDisplayType
                                                      .color:
                                                    return ColorSelectorWidget(
                                                        attributeIndex:
                                                            attributeValue.key,
                                                        action:
                                                            _fetchCombination,
                                                        templateIndex:
                                                            attribute.key,
                                                        value: attributeValue
                                                            .value);
                                                  case AttributeDisplayType
                                                      .select:
                                                    return CheckBoxSelectWidget(
                                                        attributeIndex:
                                                            attributeValue.key,
                                                        templateIndex:
                                                            attribute.key,
                                                        value: attributeValue
                                                            .value);

                                                  default:
                                                    return const SizedBox();
                                                }
                                              })
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                )),
                      _themePrimeDescription(product.theme_prime_description),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

class ColorSelectorWidget extends StatelessWidget {
  final int templateIndex;
  final int attributeIndex;
  final AttributeValue value;
  final Function action;
  const ColorSelectorWidget(
      {super.key,
      required this.attributeIndex,
      required this.templateIndex,
      required this.value,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color(int.parse(value.htmlColor)),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Checkbox(
            fillColor: MaterialStateColor.resolveWith(
              (states) => Color(int.parse(value.htmlColor)),
            ),
            onChanged: (val) {
              Provider.of<DetailProductVM>(context, listen: false)
                  .updateSelectedId(
                templateIndex: templateIndex,
                attributeIndex: attributeIndex,
                id: value.id,
              );
              action();
            },
            value: value.selected,
          ),
        ),
        Text(value.name)
      ],
    );
  }
}

class RadioSelectorWidget extends StatelessWidget {
  final int templateIndex;
  final int attributeIndex;
  final AttributeValue attributeValue;
  final Function action;
  const RadioSelectorWidget(
      {super.key,
      required this.action,
      required this.attributeIndex,
      required this.templateIndex,
      required this.attributeValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: getProportionateScreenHeight(100),
      child: Column(
        children: [
          SizedBox(
            width: getProportionateScreenWidth(50),
            child: Radio(
                value: attributeValue.id,
                groupValue: attributeValue.selectedId,
                onChanged: (val) {
                  Provider.of<DetailProductVM>(context, listen: false)
                      .updateSelectedId(
                          templateIndex: templateIndex,
                          attributeIndex: attributeIndex,
                          id: attributeValue.id);
                  action();
                }),
          ),
          Row(
            children: [
              Text(attributeValue.name),
              if (attributeValue.priceExtra > 0)
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 241, 196, 193),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                      ' +${attributeValue.priceExtra.toString()} ${attributeValue.displayCurrency}'),
                )
            ],
          )
        ],
      ),
    );
  }
}

class CheckBoxSelectWidget extends StatelessWidget {
  final AttributeValue value;
  final int templateIndex;
  final int attributeIndex;
  const CheckBoxSelectWidget(
      {super.key,
      required this.attributeIndex,
      required this.templateIndex,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Checkbox(
          onChanged: (value) {},
          value: value.selected,
        ),
        Text(value.name)
      ],
    );
  }
}
