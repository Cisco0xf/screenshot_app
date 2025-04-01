import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:screenshotapp/state_management_layer/pages_provider/select_screen_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_provider.dart';
import 'package:screenshotapp/state_management_layer/screenshot_manager/screenshot_settings.dart';


List<SingleChildWidget> get providers {
  List<SingleChildWidget> providers = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (context) => ManageScreenshot(),
    ),
    ChangeNotifierProvider(
      create: (context) => SelectTargetProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
    )
  ];

  return providers;
}
