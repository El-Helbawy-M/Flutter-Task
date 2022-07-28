import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_task/screens/product%20screen/products_screen.dart';
import 'package:flutter_task/tools/Providers/product_screen_provider.dart';
import 'package:flutter_task/tools/app_localizer.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task',

      // to tell the app what the components should follow the determined language
      localizationsDelegates: const [
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      // to tell the app what the language should support
      supportedLocales: const [
        //for English "en"
        Locale("en", ""),
        //for Arabic "ar"
        Locale("ar", ""),
      ],

      // this line is just for testing
      // locale: const Locale("ar", ""),

      // this is a callback, it's executed when the user open the app or change the localaization of the mobile
      // what is it's jop?
      // : it cheks if what is the current language of the mobile and return it for the app to follow it
      // : it cheks too if the user specified any language he need even if it's not same as the mobile language is
      locale: const Locale("ar", ""),
      localeResolutionCallback: (currentLgn, supportedLgn) {
        if (currentLgn != null) {
          for (Locale locale in supportedLgn) {
            if (currentLgn.languageCode == locale.languageCode) {
              return locale;
            }
          }
        }
        return supportedLgn.first;
      },
      home: ChangeNotifierProvider<ProductScreenProvider>(
        create: (_) => ProductScreenProvider(),
        builder: ((_, child) => const MyWidget()),
      ),
    );
  }
}

