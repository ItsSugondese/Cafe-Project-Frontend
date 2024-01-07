class TransactionRequest {
  int? id;
  int orderId;
  int memberId;

  TransactionRequest({
    this.id,
    required this.orderId,
    required this.memberId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = id;
    data['OrderId'] = orderId;
    data['MemberId'] = memberId;
    return data;
  }
}
