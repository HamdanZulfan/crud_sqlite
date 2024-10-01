import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/item_provider.dart';
import 'screens/item_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ItemProvider()..fetchItems(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ItemListScreen(),
      ),
    );
  }
}
