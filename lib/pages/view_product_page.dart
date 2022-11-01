import 'package:flutter/material.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName = '/viewproduct';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
    );
  }
}
