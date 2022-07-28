

/// This class is responsable of formate the output of the data
/// it can:
/// - formate categories data from [c1,c2,c3,c4] to "c1 / c2 /c3 / c4" by `formatCategoriesItemsStrings` function
class Formater {
  /// from from [c1,c2,c3,c4] => "c1 / c2 /c3 / c4"
  static String formateCategoriesItemsStrings(List<dynamic> list) {
    String value = "";
    for (int x = 0; x < list.length; x++) {
      value += " ${list[x]} ${x < list.length - 1 ? "/" : ""}";
    }
    return value;
  }
}
