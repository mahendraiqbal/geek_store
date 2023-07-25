import 'package:commerce/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:commerce/provider/product_provider.dart';
import 'package:get/get.dart';
import 'package:chucker_flutter/chucker_flutter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        ChuckerFlutter.navigatorObserver,
      ],
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const HomePage(),
      },
    );
  }
}
