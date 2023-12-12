import 'dart:ffi';

import 'package:c4e_rewards/models/point_history.dart';
import 'package:flutter/material.dart';

import '../../models/result_status.dart';
import '../common/custom_helper.dart';
import '../constants.dart';
import '../services/product_by_cat_service.dart';
import '../models/promotion_sheet.dart';

class ProductListVM extends ChangeNotifier {
  ProductListVM({bool initLocale = false}) {
    _isLanguageSetToBurmese = initLocale;
  }
  bool _isLanguageSetToBurmese = false;

  List<Products> get productAdsForBanner => _productAdsForBanner;
  List<Products> get productAdsForCampaign => _productAdsForCampaign;
  List<Products> get productAdsForReward => _productAdsForReward;

  final List<Products> _productAdsForBanner = [];
  final List<Products> _productAdsForCampaign = [];
  final List<Products> _productAdsForReward = [];
  Future<ResultStatus> getProductAds(bool forceFetch) async {
    ResultStatus result = ResultStatus();
    if (_productAdsForBanner.isEmpty || forceFetch) {
      result = await ProductService().getProductAds();
      if (result.status) {
        dispose();
        List<Products> fetchedData = result.data;
          // Banner
          List<Products> filteredDataForBanner = fetchedData.where((data) => data.type.contains("03_banner")).toList();
          _productAdsForBanner.addAll(filteredDataForBanner);
          // Rewards
          List<Products> filteredDataForReward = fetchedData.where((data) => data.type.contains("01_reward")).toList();
          _productAdsForReward.addAll(filteredDataForReward);
          // Campaign
          List<Products> filteredDataForCampaign = fetchedData.where((data) => data.type.contains("02_campaing")).toList();
          _productAdsForCampaign.addAll(filteredDataForCampaign);

        // print(_productAdsForBanner);

        notifyListeners();
      }
    }
    return result;
  }

  // List<PointHistory> get pointHistory => _pointHistory;
  //
  // final List<PointHistory> _pointHistory = [];
  // Future<ResultStatus> getPointHistory(bool forceFetch, int partnerId) async {
  //   ResultStatus result = ResultStatus();
  //   if (_pointHistory.isEmpty || forceFetch) {
  //     result = await ProductService().getPointHistory(partnerId);
  //     if (result.status) {
  //       print(result.data);
  //       _pointHistory.addAll(result.data);
  //       notifyListeners();
  //     }
  //   }
  //   return result;
  // }

  String get localeName => _isLanguageSetToBurmese ? 'my' : 'en';
  bool get isLanguageSetToBurmese => _isLanguageSetToBurmese;

  void changeLocale() {
    _isLanguageSetToBurmese = !_isLanguageSetToBurmese;
    LocalStorageManager.saveData(CachedKey.locale, _isLanguageSetToBurmese);
    notifyListeners();
  }
}
