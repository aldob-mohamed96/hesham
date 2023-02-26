
import 'dart:developer';

 import 'package:flick_video_player/flick_video_player.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/presentation/common/widget/full_error_screen.dart';
import 'package:hesham/features/presentation/common/widget/loading_widget.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/main_scaffold_auth.dart';
import '../home/home_screen.dart';
import 'package:screen_capture_event/screen_capture_event.dart';
class ClassScreenShow extends StatelessWidget {
  const ClassScreenShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageClassScreenShow();
  }
}
class PageClassScreenShow extends StatelessWidget {
  const PageClassScreenShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(create: (_) => instance<HomeBloc>(),child:const  ItemsShow() ,);
  }
}
class ItemsShow extends StatelessWidget {
  const ItemsShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Lesson lesson=ModalRoute.of(context)!.settings.arguments as Lesson;
    return  VideoShow(lesson: lesson,);
  }
}

class VideoShow extends StatefulWidget {
  final Lesson lesson;
  const VideoShow({Key? key,required this.lesson}) : super(key: key);

  @override
  State<VideoShow> createState() => _VideoShowState();
}

class _VideoShowState extends State<VideoShow> {

  FlickManager? flickManager;
  late YoutubePlayerController _controller ;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  bool _isPlayerReady = false;
  bool isValid=true;
   @override
  void initState() {

    super.initState();
    try {


      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.lesson.video)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;
      isValid=true;
    }catch(e)
     {
       isValid=false;
     }

  }
  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


    @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.isRecording!=current.isRecording,
  builder: (context, state) {
    return state.isRecording? Center(child: Container(
      height: context.height/2,
      width: context.width,
      color: Colors.white,)):SizedBox(
      height: context.width,
      child:isValid?
      YoutubePlayerBuilder(

        builder: (context, player){return Column(children: [player,],);},
      //onExitFullScreen: () {SystemChrome.setPreferredOrientations(DeviceOrientation.values);},
        player: YoutubePlayer(
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
            topActions: <Widget>[
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _controller.metadata.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

            ],
          onEnded: (value){context.read<HomeBloc>().add(AttendanceLessonEvent(widget.lesson));},
          onReady :()
          {
            _isPlayerReady = true;
           },
          controller: _controller,

          


        ),
      ):
      Scaffold(body: FullErrorScreen(retryActionFunction: ()=>Navigator.of(context,rootNavigator: true).pop(), error: "error")),
    );
  },
);
  }

}


