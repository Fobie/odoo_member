import 'package:flutter/material.dart';

import '../app_entry.dart';
import '../../flavor_config.dart';

main() {
  FlavorConfig.appFlavor = Flavor.staging;
  preLoadingBeforeApp();
  runApp(const MyApp());
}
