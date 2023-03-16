import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';
import '../utils/constants.dart';
import '../utils/helper_functions.dart';

class OrderPage extends StatelessWidget {
  static const String routeName = '/order';
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.orderList.length,
          itemBuilder: (context, index) {
            final order = provider.orderList[index];
            return ListTile(
              tileColor: id == null
                  ? null
                  : id == order.orderId
                  ? Colors.grey.withOpacity(0.4)
                  : null,
              onTap: () => Navigator.pushNamed(
                  context, OrderDetailsPage.routeName,
                  arguments: order.orderId),
              title: Text(getFormattedDate(order.orderDate.timestamp.toDate(),
                  pattern: 'dd/MM/yyyy HH:mm:ss')),
              subtitle: Text(order.orderStatus),
              trailing: Text('$currencySymbol${order.grandTotal}'),
            );
          },
        ),
      ),
    );
  }
}