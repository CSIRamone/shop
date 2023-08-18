import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';

import '../models/product.dart';
import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Exclusão'),
                    content: Text('Confirma a Exclusao desse Produto'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ProductList>(
                        context,
                        listen: false,
                      ).deleteProduct(product);
                    } catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
