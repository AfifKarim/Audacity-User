import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/user_list_page.dart';
import 'providers/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Audacity',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: UserListPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}