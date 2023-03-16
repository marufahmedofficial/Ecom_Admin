import 'package:Ecom_Admin/pages/notification_page.dart';
import 'package:Ecom_Admin/pages/order_details_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'pages/add_product_page.dart';
import 'pages/category_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/launcher_page.dart';
import 'pages/login_page.dart';
import 'pages/order_page.dart';
import 'pages/product_details_page.dart';
import 'pages/product_repurchase_page.dart';
import 'pages/report_page.dart';
import 'pages/settings_page.dart';
import 'pages/user_list_page.dart';
import 'pages/view_product_page.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application...
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: EasyLoading.init(),
      initialRoute: LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => const LauncherPage(),
        LoginPage.routeName: (_) => const LoginPage(),
        DashboardPage.routeName: (_) => const DashboardPage(),
        AddProductPage.routeName: (_) => const AddProductPage(),
        ViewProductPage.routeName: (_) => const ViewProductPage(),
        ProductDetailsPage.routeName: (_) => const ProductDetailsPage(),
        CategoryPage.routeName: (_) => const CategoryPage(),
        ProductRepurchasePage.routeName: (_) => const ProductRepurchasePage(),
        OrderPage.routeName: (_) => const OrderPage(),
        OrderDetailsPage.routeName: (_) => const OrderDetailsPage(),
        NotificationPage.routeName: (_) => const NotificationPage(),
        UserListPage.routeName: (_) => const UserListPage(),
        ReportPage.routeName: (_) => const ReportPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
      },
    );
  }
}
