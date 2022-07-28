import 'package:flutter/material.dart';
import 'package:flutter_task/screens/product%20screen/widgets/category_button.dart';
import 'package:flutter_task/screens/product%20screen/widgets/filter_button.dart';
import 'package:flutter_task/tools/Providers/filter_Provider.dart';
import 'package:flutter_task/tools/Providers/product_screen_provider.dart';
import 'package:flutter_task/tools/app_localizer.dart';
import 'package:flutter_task/tools/formater.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../filter screen/filter_screen.dart';
import '../filter screen/widgets/stateful_bottomSheet_item.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductScreenProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // The home screen
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // the product properites filter
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductScreenProvider>(
                        builder: (context, provider, child) => Row(
                          children: properites.map(
                            (label) {
                              // to chek if there are any chosen categories
                              bool check = provider.chosenCategories[label].isNotEmpty;

                              return Card(
                                color: check ? Colors.white : Colors.blue[100],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: check ? const BorderSide(width: 1, color: Colors.orange) : BorderSide.none),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Row(
                                    children: [
                                      Text(check ? Formater.formateCategoriesItemsStrings(provider.chosenCategories[label]) : getLang(context, label)),
                                      GestureDetector(
                                        onTap: () async {
                                          if (!check) {
                                            // show the sheet to select the wanted categories
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
                                            // clear all chosen categories from the list
                                            provider.clearCategory(label);
                                          }
                                        },
                                        child: Icon(
                                          check ? Icons.close : Icons.arrow_drop_down,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    //============================
                    // the products categories filter
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Consumer<ProductScreenProvider>(
                        builder: (BuildContext context, provider, Widget? child) => Row(
                          children: types
                              .map(
                                (e) => CategoryButton(
                                  getLang(context, e),
                                  //to change the selected product category
                                  () => provider.changeProductType(e),
                                  isSelected: provider.productType == e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    //============================
                    // the state category filter
                    Consumer<ProductScreenProvider>(
                      builder: (BuildContext context, provider, Widget? child) => Row(
                        children: states
                            .map(
                              (e) => CategoryButton(
                                getLang(context, e),
                                //to change the selected payment category
                                () => provider.changePaymentState(e),
                                isSelected: provider.paymentState == e,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    //============================
                    // the products list
                    /*
                      Note:
                      it is empty because there are no data yet
                    */
                  ],
                ),
              ),
            ),
            //======================================
            //Floating action bar for filter buttons
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue),
              margin: const EdgeInsets.only(bottom: 10),
              width: 270,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // to go to the filtes screen
                  FilterButton(
                    'filter',
                    Icons.filter_alt_outlined,
                    () async => provider.setChosenCategories = (await Navigator.of(context).push<Map<String, dynamic>>(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => FilterProvider(provider.chosenCategories),
                          builder: ((context, child) => const FilterScreen()),
                        ),
                      ),
                    ))!,
                  ),
                  const SizedBox(child: VerticalDivider(width: 10, thickness: 2, color: Colors.white), height: 15),
                  //============================================
                  // to order the list of the data
                  FilterButton('order', Icons.swap_vert, () {}),
                  const SizedBox(child: VerticalDivider(width: 10, thickness: 2, color: Colors.white), height: 15),
                  //============================================
                  // to save the chosen categories
                  FilterButton('save', Icons.restore, () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
