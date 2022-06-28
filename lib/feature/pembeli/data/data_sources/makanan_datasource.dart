import 'dart:convert';

import 'package:cafetaria/feature/pembeli/data/model/makanan_model.dart';
import 'package:cafetaria/feature/pembeli/data/model/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<MakananModel> getFoodItems() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  final response = await http.get(
    Uri.parse('https://api.komplekku.com/core/api/food-beverage/v1/item'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    return MakananModel.fromJson(jsonDecode(response.body));
  } else
    return MakananModel.fromJson(jsonDecode(response.body));
}

Future<bool> addFoodOrder(OrderModel model) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");
  final String requestBody = json.encoder.convert(model.toJson());
  final response = await http.post(
    Uri.parse("https://api.komplekku.com/core/api/food-beverage/v1/order"),
    body: requestBody,
    headers: {'Authorization': 'Bearer $token'},
  );
  if (response.statusCode == 200)
    return true;
  else {
    print(response.body);
    return false;
  }
}
