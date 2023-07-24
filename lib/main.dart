import 'package:flutter/material.dart';
import 'package:shop/models/pages/product_detail_page.dart';
import 'package:shop/models/pages/products_overview_page.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //useMaterial3: true,
        primaryColor: Colors.purple.shade900,
        hintColor: Colors.amber.shade900,
        highlightColor: Colors.greenAccent,
        fontFamily: 'Lato',
      ),
      home: ProductsOverviewPage(),
      routes: {
        AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
