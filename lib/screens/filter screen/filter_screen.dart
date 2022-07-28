import 'package:flutter/material.dart';
import 'package:flutter_task/constants.dart';
import 'package:flutter_task/screens/filter%20screen/widgets/stateful_bottomSheet_item.dart';
import 'package:flutter_task/tools/Providers/filter_Provider.dart';
import 'package:flutter_task/tools/app_localizer.dart';
import 'package:flutter_task/tools/formater.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<FilterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          getLang(context, "filter"),
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, provider.chosenCategories),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // search bar to search for a specific category
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(width: 1, color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(getLang(context, "search")),
                ],
              ),
            ),
          ),
          //===================================
          // to choose a location
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(width: 1, color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(getLang(context, "location")), Icon(!(AppLocale.of(context).locale.languageCode == "en") ? Icons.arrow_forward : Icons.arrow_back)]),
            ),
          ),
          //===================================
          // to show the chosen category
          Card(
            child: TextFormField(
              initialValue: "${getLang(context, provider.chosenCategories["product"])}/مرسيدس/${getLang(context, provider.chosenCategories["payment"])} ✅",
              enabled: false,
              decoration: InputDecoration(
                labelText: getLang(context, "category"),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          //===================================
          // categories banel
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    children: List.generate(4, (index) {
                  String label = properite.keys.elementAt(index);
                  String title = "";
                  if (provider.chosenCategories[label]!.isNotEmpty) {
                    title = Formater.formateCategoriesItemsStrings(provider.chosenCategories[label]);
                  }
                  return Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        onTap: () {
                          if (title == "") {
                            showBottomSheet(
                              context: context,
                              builder: (_) => SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: properite[label]!
                                            .map(
                                              (value) => StatefulBottomSheetItem(
                                                value,
                                                (value) {
                                                  if (provider.chosenCategories[label].contains(value))
                                                    provider.removeCategory(label, value);
                                                  else
                                                    provider.addCategory(label, value);
                                                },
                                                provider.chosenCategories[label].contains(value),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            provider.clearCategory(label);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            trailing: Icon(
                              title == "" ? Icons.arrow_drop_down_sharp : Icons.close,
                              color: title == "" ? Colors.grey : Colors.red,
                            ),
                            leading: Icon(
                              Icons.check_circle_rounded,
                              size: 20,
                              color: title == "" ? Colors.grey : Colors.green,
                            ),
                            title: Text(
                              title != "" ? title : getLang(context, label),
                              style: TextStyle(fontWeight: title != "" ? FontWeight.bold : null, color: title != "" ? Colors.black : Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
                })),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

