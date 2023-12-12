import 'package:c4e_rewards/generated/gen_l10n/app_localizations.dart';
import 'package:c4e_rewards/models/app_user.dart';
import 'package:c4e_rewards/models/point_history.dart';
import 'package:c4e_rewards/models/result_status.dart';
import 'package:c4e_rewards/view_models/point_vm.dart';
import 'package:c4e_rewards/widgets/custom_main_appbar.dart';
import 'package:c4e_rewards/widgets/history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {



  Future<ResultStatus> _fetchPointHistory(BuildContext context,
      {bool forceFetch = false}) async {
    // AppUser appUser = AppUser();
    return await Provider.of<PointVM>(context, listen: false)
        .getPointHistory(forceFetch);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchPointHistory(context),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return Selector<PointVM, List<PointHistory>>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (context, provider) => provider.pointHistory,
            builder: (context, point, child){
              return Scaffold(
                  appBar: MainAppBar(
                      title: AppLocalizations.of(context)!.historyAppBarTitle
                  ),
                  body: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'All transactions',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            IconButton(
                                onPressed: (){
                                  showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime.now(),
                                      lastDate:
                                      DateTime.now().add(const Duration(days: 7)));
                                },
                                icon: Icon(Icons.calendar_month)
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: point.isNotEmpty ?
                          ListView.builder(
                              itemCount: point.length,
                              itemBuilder: (context, index){
                                return HistoryItem(points: point[index]);
                              }
                          )
                              : Center(
                            child: Text(
                              AppLocalizations.of(context)!.noHistoryLabel,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                      )

                    ],
                  )
              );
            },

          );
        }
    );
  }
}
