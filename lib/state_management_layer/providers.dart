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


/* 
[1] Finish everthing in the project        [Done]
[2] Push project to gihub                  [Done]
[3] Write ReadMe file                      [Done]
[4] Create a video                         []
[5] Write the post of this video           []
[6] push this video to LinkedIn            []
[7] Close LinkedIn for 3 Dayes at least    []
 */
