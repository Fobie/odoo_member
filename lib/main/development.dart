import 'package:flutter/widgets.dart';

import '../app_entry.dart';
import '../../flavor_config.dart';

void main() {
  FlavorConfig.appFlavor = Flavor.development;
  preLoadingBeforeApp();
  runApp(const MyApp());
}
