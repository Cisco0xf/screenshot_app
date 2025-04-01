import 'package:just_audio/just_audio.dart';
import 'package:screenshotapp/constants/pathes.dart';

// Just Play Audio :)

class PlayAudio {
  static Future<void> get play async {
    final AudioPlayer player = AudioPlayer();

    await player.setAsset(Paths.piskImageSound);
    await player.play();
  }
}
