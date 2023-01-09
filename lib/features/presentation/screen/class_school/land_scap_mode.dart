import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LandScapeModeScreen extends StatefulWidget {
  const LandScapeModeScreen({Key? key,}) : super(key: key);

  @override
  State<LandScapeModeScreen> createState() => _LandScapeModeScreenState();
}

class _LandScapeModeScreenState extends State<LandScapeModeScreen> {
Future _landScape()async{
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
}
Future _setAllOrientation()async{
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

}
@override
  void dispose() {
    _setAllOrientation();
    super.dispose();
  }
  @override
  void initState() {
    
    super.initState();
    _landScape();
  }
  @override
  Widget build(BuildContext context) {
    final controller= ModalRoute.of(context)!.settings.arguments as VideoPlayerController;

    return VideoPlayer(controller);
  }
}
