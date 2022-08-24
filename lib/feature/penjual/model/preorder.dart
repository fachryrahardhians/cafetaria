// {
//   "rulepreordermenuId": "rulepreorder1",
//  "isShowPublic": true,
//  "poDay": 1,
//  "pickupTime": "",
//  "merchantId": "",
//  "maxQty": 10
// }

class PreOrder {
  String? rulepreordermenuId;
  bool? isShowPublic;
  int? poDay;
  String? pickupTime;
  String? merchantId;
  int? maxQty;

  PreOrder(
      {this.rulepreordermenuId,
      this.isShowPublic,
      this.poDay,
      this.pickupTime,
      this.merchantId,
      this.maxQty});

  PreOrder.fromJson(Map<String, dynamic> json) {
    rulepreordermenuId = json['rulepreordermenuId'];
    isShowPublic = json['isShowPublic'];
    poDay = json['poDay'];
    pickupTime = json['pickupTime'];
    merchantId = json['merchantId'];
    maxQty = json['maxQty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rulepreordermenuId'] = rulepreordermenuId;
    data['isShowPublic'] = isShowPublic;
    data['poDay'] = poDay;
    data['pickupTime'] = pickupTime;
    data['merchantId'] = merchantId;
    data['maxQty'] = maxQty;
    return data;
  }
}
