import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/user_list_page.dart';
import '../providers/theme_provider.dart';

// In MyAppTheme
class MyAppTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Audacity',
          theme: themeProvider.theme,
          home: UserListPage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


