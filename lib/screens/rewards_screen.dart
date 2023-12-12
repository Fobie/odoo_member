import 'package:c4e_rewards/common/common_widget.dart';
import 'package:c4e_rewards/custom_decoratoin.dart';
import 'package:c4e_rewards/generated/gen_l10n/app_localizations.dart';
import 'package:c4e_rewards/models/promotion_sheet.dart';
import 'package:c4e_rewards/models/result_status.dart';
import 'package:c4e_rewards/view_models/product_list_vm.dart';
import 'package:c4e_rewards/view_models/user_vm.dart';
import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:c4e_rewards/widgets/reward_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {

  Future<ResultStatus> _fetchPromoSheet(BuildContext context,
      {bool forceFetch = false}) async {
    return await Provider.of<ProductListVM>(context, listen: false)
        .getProductAds(forceFetch);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchPromoSheet(context),
        builder: (context, snapshot){
          return Selector<ProductListVM, List<Products>>(
              builder: (context, sheet, child){
                return Scaffold(
                  appBar: MainAppBar(
                      title: AppLocalizations.of(context)!.rewardsAppBarTitle
                  ),
                  body: Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: ListView.builder(
                          itemCount: sheet.length,
                          itemBuilder: (context, index){
                            return RewardItem(rewards: sheet[index],);
                          }
                      )
                  ),
                );
              }, selector: (context, provider)=> provider.productAdsForReward,
          );
        }
    );
  }
}
