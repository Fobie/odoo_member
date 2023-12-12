import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../models/promotion_sheet.dart';
import '../common/size_config.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({Key? key, required this.campaign}) : super(key: key);
  final Products campaign;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: MainAppBar(
          title: campaign.name,
          leadingWidget: BackButton(
            color: kPrimaryWhite,
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                    placeholder:
                    const AssetImage(AssetImagePath.c4eFadeinImg),
                    image: NetworkImage(
                      campaign.image,
                      headers: campaign.imgCookie,
                    ),
                    width: getProportionateScreenWidth(350),
                  )
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                          'Expire : ${campaign.endDate}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      campaign.termsAndConditions.isEmpty ? Container() :
                      Text(
                          'Terms and conditions',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                            fontSize: 25
                          )
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        campaign.termsAndConditions,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
