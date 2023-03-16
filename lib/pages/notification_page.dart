import 'package:Ecom_Admin/pages/product_details_page.dart';
import 'package:Ecom_Admin/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notification_model.dart';
import '../providers/notification_provider.dart';
import '../utils/constants.dart';
import 'order_page.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = '/notifications';
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.notificationList.length,
          itemBuilder: (context, index) {
            final notification = provider.notificationList[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                onTap: () {
                  _navigate(context, notification, provider);
                },
                tileColor:
                    notification.status ? null : Colors.grey.withOpacity(.5),
                title: Text(notification.type),
                subtitle: Text(notification.message),
              ),
            );
          },
        ),
      ),
    );
  }

  void _navigate(BuildContext context, NotificationModel notification,
      NotificationProvider provider) {
    String routeName = '';
    String id = '';
    switch (notification.type) {
      case NotificationType.user:
        routeName = UserListPage.routeName;
        id = notification.userModel!.userId!;
        break;
      case NotificationType.comment:
        routeName = ProductDetailsPage.routeName;
        id = notification.commentModel!.productId;
        break;
      case NotificationType.order:
        routeName = OrderPage.routeName;
        id = notification.orderModel!.orderId;
        break;
    }
    provider.updateNotificationStatus(notification.id, !notification.status);
    Navigator.pushNamed(context, routeName, arguments: id);
  }
}
