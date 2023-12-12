import 'package:c4e_rewards/common/common_widget.dart';
import 'package:c4e_rewards/common/size_config.dart';
import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/models/app_user.dart';
import 'package:c4e_rewards/models/promotion_sheet.dart';
import 'package:c4e_rewards/view_models/user_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({super.key, required this.rewards});
  final Products rewards;

  Future<void> _fetchMemberPoint(BuildContext context) async {
    await Provider.of<UserVM>(context, listen: false)
        .fetchMemberPoint()
        .then((result) {
      if (!result.status) {
        showInfoSnackBar(context, result.message, result.status);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchMemberPoint(context),
        builder: (context, snapshot){
          return Selector<UserVM, AppUser>(
              builder: (context, user, child){
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: FadeInImage(
                              placeholder:
                              const AssetImage(AssetImagePath.c4eFadeinImg),
                              image: NetworkImage(rewards.image),
                              width: getProportionateScreenWidth(110),
                            )
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(5),
                        ),
                        Container(
                          width: getProportionateScreenWidth(260),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rewards.name,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    overflow: TextOverflow.ellipsis
                                ),
                              ),
                              Text(
                                  "Expire - ${rewards.endDate}"
                              ),
                              Text('${rewards.targetPoint} Points', style: Theme.of(context).textTheme.titleLarge,),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: 130,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constraints) => Container(
                                          width: user.loyaltyPoints >= rewards.targetPoint ? 130 : (user.loyaltyPoints / rewards.targetPoint) * 130,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('${user.loyaltyPoints} / ${rewards.targetPoint}')
                                ],
                              )

                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              selector: (context, provider) => provider.user
          );
        }
    );
  }
}
