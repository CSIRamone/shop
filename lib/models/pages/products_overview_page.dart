import 'package:flutter/material.dart';

import '../../components/product_grid.dart';

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Minha Loja'),
      ),
      body: const ProductGrid(),
    );
  }
}
