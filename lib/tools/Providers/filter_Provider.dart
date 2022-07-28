import 'package:flutter/cupertino.dart';

/// This is a view model for filtes screen
/// it can :
/// - `add category`
/// - `remove category`
/// - `clear the list of the chosen category`
class FilterProvider extends ChangeNotifier {
  late Map<String, dynamic> chosenCategories;
  FilterProvider(this.chosenCategories);

  addCategory(String key, String value) {
    chosenCategories[key].add(value);
    notifyListeners();
  }

  removeCategory(String key, String value) {
    chosenCategories[key].remove(value);
    notifyListeners();
  }
  clearCategory(String key) {
    chosenCategories[key].clear();
    notifyListeners();
  }
}
