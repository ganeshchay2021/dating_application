import 'package:dating_application/core/constants/string_constants.dart';
import 'package:dating_application/core/providers/theme_provider.dart';
import 'package:dating_application/core/routes/app_routers.dart';
import 'package:dating_application/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, _) {
      return GestureDetector(
        onTap: () {
          //dissmiss keyboard when tapping outside of textfield
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: AppRouters.initialRoute,
          onGenerateRoute: AppRouters.onGeneratedRoute,
        ),
      );
    });
  }
}
