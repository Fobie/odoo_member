import 'package:flutter/foundation.dart';

import '../models/product_detail.dart';
import 'package:flutter/material.dart';

import '../models/result_status.dart';
import '../services/product_detail_service.dart';
import '../models/product_detail_with_attr_model.dart';

class DetailProductVM extends ChangeNotifier {
  ProductDetail? _currentProduct;
  ProductDetail? get currentProduct => _currentProduct;

  ValueNotifier<bool> get showConbinationAlert => _showConbinationAlert;
  final ValueNotifier<bool> _showConbinationAlert = ValueNotifier(false);

  Future<ResultStatus> fetchProductDetailByProdID(String prodId) async {
    ResultStatus result =
        await ProductDetailService().getDetailProducts(prodId);
    if (result.status) {
      _currentProduct = result.data;
    }
    return result;
  }

  void resetValue() {
    _currentProduct = null;
    showConbinationAlert.value = false;
  }

  void updateSelectedId({
    required int templateIndex,
    required int attributeIndex,
    required int id,
  }) {
    final currentAttribute = _currentProduct!
        .productTmplAttributeLines[templateIndex].values[attributeIndex];

    for (var element
        in _currentProduct!.productTmplAttributeLines[templateIndex].values) {
      if (element.id == currentAttribute.id) {
        _currentProduct!.productTmplAttributeLines[templateIndex]
                .values[attributeIndex] =
            element.copyWith(selectedId: currentAttribute.id, selected: true);
      } else {
        final length = _currentProduct!
            .productTmplAttributeLines[templateIndex].values.length;
        for (var i = 0; i < length; i++) {
          final currentValue = _currentProduct!
              .productTmplAttributeLines[templateIndex].values[i];
          if (currentValue.id != id) {
            _currentProduct!
                    .productTmplAttributeLines[templateIndex].values[i] =
                currentValue.copyWith(selectedId: 0, selected: false);
          }
        }
      }
    }
    notifyListeners();
  }

  Future<ResultStatus> getCombinationProductInfo() async {
    List<int> combinations = [];
    for (var attribute in _currentProduct!.productTmplAttributeLines) {
      for (var value in attribute.values) {
        if (value.selectedId != 0 && value.selectedId != null) {
          combinations.add(value.selectedId!);
        }
      }
    }
    final result = await ProductDetailService.getProductDetailWithAttrCheck(
        currentProduct!.productTmplId, currentProduct!.productId, combinations);
    ProductWithAttribute productWithAttribute = result.data;
    if (result.status) {
      if (!productWithAttribute.isCombinationPossible) {
        _showConbinationAlert.value = true;
      } else {
        _showConbinationAlert.value = false;
      }
      notifyListeners();
      _currentProduct = _currentProduct?.copyWith(
          price: productWithAttribute.price,
          image1920: productWithAttribute.isCombinationPossible
              ? productWithAttribute.images[0]
              : null);
    }

    return result;
  }

  // void getAttrProduct() async {
  //   if (_productVariants.isNotEmpty) {
  //     List<int> comList = [];

  //     for (var element in _productVariants) {
  //       comList.add(element.selectedIndex);
  //     }

  //     ProductDetailService productDetailService = ProductDetailService();

  //     _productWithAttribute =
  //         await productDetailService.getProductDetailWithAttrCheck(
  //             _currentProduct!.productTmplId,
  //             _currentProduct!.productId,
  //             comList);

  //     if (_productWithAttribute!.isCombinationPossible) {
  //       _showConbinationAlert.value = false;
  //       _currentProduct!.image1920 = _productWithAttribute!.images[0];
  //       _currentProduct!.productId = _productWithAttribute!.id;
  //     } else {
  //       _showConbinationAlert.value = true;
  //     }

  //     notifyListeners();
  //   }
  // }
}
