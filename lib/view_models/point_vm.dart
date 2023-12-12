import 'package:c4e_rewards/common/custom_helper.dart';
import 'package:c4e_rewards/models/point_history.dart';
import 'package:c4e_rewards/models/result_status.dart';
import 'package:c4e_rewards/services/product_by_cat_service.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PointVM extends ChangeNotifier {
  PointVM({bool initLocale = false}) {
    _isLanguageSetToBurmese = initLocale;
  }
  bool _isLanguageSetToBurmese = false;

  List<PointHistory> get pointHistory => _pointHistory;

  final List<PointHistory> _pointHistory = [];
  Future<ResultStatus> getPointHistory(bool forceFetch) async {
    ResultStatus result = ResultStatus();
    if (_pointHistory.isEmpty || forceFetch) {
      result = await ProductService().getPointHistory();
      if (result.status) {
        var listedData = result.data;
        dispose();
        _pointHistory.addAll(listedData);
        notifyListeners();
      }
    }
    return result;
  }

  String get localeName => _isLanguageSetToBurmese ? 'my' : 'en';
  bool get isLanguageSetToBurmese => _isLanguageSetToBurmese;

  void changeLocale() {
    _isLanguageSetToBurmese = !_isLanguageSetToBurmese;
    LocalStorageManager.saveData(CachedKey.locale, _isLanguageSetToBurmese);
    notifyListeners();
  }
}