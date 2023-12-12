import 'package:package_info_plus/package_info_plus.dart';

enum Flavor {
  development,
  staging,
  release,
}

class FlavorConfig {
  static Flavor? appFlavor;
  static PackageInfo? appInfo;

  static String get apiEndpoint {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://c4e.apexintegra.com';
      case Flavor.development:
      default:
        return 'http://dev.apexintegra.com';
    }
  }

  static String get mAppAName {
    switch (appFlavor) {
      case Flavor.staging:
        return "C4E Rewards [staging]";
      case Flavor.development:
      default:
        return "C4E Rewards [dev]";
    }
  }

  static String get mAppMode {
    switch (appFlavor) {
      case Flavor.staging:
        return "Staging";
      case Flavor.development:
      default:
        return "Developement";
    }
  }
}
