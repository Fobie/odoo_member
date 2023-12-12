import 'package:c4e_rewards/constants.dart';
import 'package:c4e_rewards/models/point_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem({
    super.key,
    required this.points
  });
  final PointHistory points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryWhite,
          boxShadow: [
            BoxShadow(
              offset: Offset(2.0, 2.0),
              blurRadius: 2.0,
              color: kGreyShade1
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text(
                  "Received from",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              subtitle: Text(
                  points.name,
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
              trailing: Text(
                '${points.amount} Points',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('${DateFormat.yMMMEd().format(DateTime.now()).toString()}'),
            )
          ],
        ),
      ),
    );
  }
}
