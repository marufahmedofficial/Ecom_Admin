import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/authservice.dart';
import '../customwidgets/dashboard_item_view.dart';
import '../models/dashbord_model.dart';
import '../providers/order_provider.dart';
import '../providers/product_provider.dart';
import 'launcher_page.dart';

class DashboardPage extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    Provider.of<ProductProvider>(context, listen: false).getAllPurchase();
    Provider.of<OrderProvider>(context, listen: false).getOrderConstants();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(context, LauncherPage.routeName));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 1.0,
        ),
        itemCount: dashboardModelList.length,
        itemBuilder: (context, index) =>
            DashboardItemView(model: dashboardModelList[index],),
      ),
    );
  }
}