import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_widget.dart';
import '../../common/size_config.dart';
import '../../generated/gen_l10n/app_localizations.dart';
import '../../screens/color_palettes_screen.dart';
import '../../view_models/product_list_vm.dart';
import '../../widgets/list_tile_option.dart';

class AppSettingsScreen extends StatefulWidget {
  static String routeName = "/settings";
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final localizeText = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                Consumer<ProductListVM>(
                  builder: (context, userProvider, child) =>
                      SwitchListTile.adaptive(
                    title: const Text("မြန်မာသာသာဖြင့်အသုံးပြုမည်"),
                    value: userProvider.isLanguageSetToBurmese,
                    onChanged: (value) => userProvider.changeLocale(),
                  ),
                ),
                if (kDebugMode)
                  ListTileOption(
                      icon: Icons.color_lens,
                      title: "App Colors",
                      tapHandler: () => Navigator.of(context)
                          .pushNamed(ColorPalettesScreen.routeName),
                      color: Theme.of(context).colorScheme.primary)
              ]),
            ),
            backArrowWithLabel(context, localizeText.settingsLabel),
          ],
        ),
      ),
    );
  }
}
