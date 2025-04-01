import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshotapp/commons/navigator_key.dart';
import 'package:screenshotapp/presentation_layer/main_widget.dart';
import 'package:screenshotapp/state_management_layer/providers.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: ToastificationWrapper(
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo,
              brightness: Brightness.dark,
            ),
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}
