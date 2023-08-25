import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/pages/auth_page.dart';
import 'package:shop/models/pages/products_overview_page.dart';

import '../auth.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    return auth.isAuth ? ProductsOverviewPage() : AuthPage();
  }
}
