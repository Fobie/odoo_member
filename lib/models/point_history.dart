class PointHistory {
  final int partnerId;
  final String name;
  final int loyaltyPoint;
  final int amount;
  final DateTime date;

  PointHistory({
    required this.partnerId,
    required this.name,
    required this.loyaltyPoint,
    required this.amount,
    required this.date
  });

  factory PointHistory.fromJson(Map<String, dynamic> data) => PointHistory(
      partnerId: data["partner_id"],
      name: data["name"],
      loyaltyPoint: data["loyalty_points"],
      amount: data["amount"],
    date: data["date_order"]
  );
}