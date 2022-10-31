import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/add_product_page.dart';
import 'package:untitled/pages/catagory_page.dart';
import 'package:untitled/pages/dashboard_page.dart';
import 'package:untitled/pages/launcher_page.dart';
import 'package:untitled/pages/login_page.dart';
import 'package:untitled/pages/order_page.dart';
import 'package:untitled/pages/product_details_page.dart';
import 'package:untitled/pages/product_repurchase_page.dart';
import 'package:untitled/pages/report_page.dart';
import 'package:untitled/pages/settings_page.dart';
import 'package:untitled/pages/user_list_page.dart';
import 'package:untitled/pages/view_product_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LauncherPage.routeName ,
      routes: {
        LauncherPage.routeName : (_) => const LauncherPage(),
        LoginPage.routeName : (_) => const LoginPage(),
        DashboardPage.routeName : (_) => const DashboardPage(),
        AddProductPage.routeName : (_) => const AddProductPage(),
        ViewProductPage.routeName : (_) => const ViewProductPage(),
        ProductDetailsPage.routeName : (_) => const ProductDetailsPage(),
        CatagoryPage.routeName : (_) => const CatagoryPage(),
        ProductRepurchasePage.routeName : (_) => const ProductRepurchasePage(),
        OrderPage.routeName : (_) => const OrderPage(),
        UserListPage.routeName : (_) => const UserListPage(),
        ReportPage.routeName : (_) => const ReportPage(),
        SettingsPage.routeName : (_) => const SettingsPage(),

      },
    );
  }
}

