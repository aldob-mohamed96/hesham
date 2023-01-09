
import 'dart:developer';

 import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/presentation/common/widget/full_error_screen.dart';
import 'package:hesham/features/presentation/common/widget/loading_widget.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/main_scaffold_auth.dart';
import '../home/home_screen.dart';

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
  bool isValid=true;
   @override
  void initState() {

    super.initState();
    try {
      _controller = YoutubePlayerController(

        initialVideoId: YoutubePlayer.convertUrlToId(
           widget.lesson.video)!,
        flags: const YoutubePlayerFlags(

          hideThumbnail: false,

          autoPlay: false,
          mute: false,

        ),
      );
      isValid=true;
    }catch(e)
     {
       isValid=false;
     }

  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller.dispose();

    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return SizedBox(
      height: 400,
      child:isValid?
      YoutubePlayer(
        onEnded: (value){
          context.read<HomeBloc>().add(AttendanceLessonEvent(widget.lesson));
        },
        controller: _controller,
        showVideoProgressIndicator: true,

      ):
      Scaffold(body: FullErrorScreen(retryActionFunction: ()=>Navigator.of(context,rootNavigator: true).pop(), error: "error")),
    );
  },
);
  }

}


