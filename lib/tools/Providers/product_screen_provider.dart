import 'package:flutter/cupertino.dart';

/// This is a view model for filtes screen
/// it can :
/// - `add category`
/// - `remove category`
/// - `clear the list of the chosen category`
/// - `change the payment category`
/// - `change the product category`
/// - `reset the hole data of the categories`
class ProductScreenProvider extends ChangeNotifier {
  String productType = "cars";
  String paymentState = "sale";
  Map<String, dynamic> chosenCategories = {"world": [], "price": [], "model": [], "date": [], "product": "sale", "payment": "cars"};
  void changeProductType(String value) {
    productType = value;
    chosenCategories["product"] = value;
    notifyListeners();
  }

  void changePaymentState(String value) {
    paymentState = value;
    chosenCategories["payment"] = value;
    notifyListeners();
  }

  set setChosenCategories(Map<String, dynamic> data) {
    chosenCategories = data;
    notifyListeners();
  }

  clearCategory(String key) {
    chosenCategories[key].clear();
    notifyListeners();
  }

  addCategory(String key, String value) {
    chosenCategories[key].add(value);
    notifyListeners();
  }

  removeCategory(String key, String value) {
    chosenCategories[key].remove(value);
    notifyListeners();
  }
}
