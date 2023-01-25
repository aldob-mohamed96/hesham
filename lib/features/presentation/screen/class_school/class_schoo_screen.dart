
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/dialog_snackbar.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../common/widget/full_error_screen.dart';
import '../../common/widget/loading_widget.dart';
import '../../common/widget/main_scaffold_auth.dart';
import '../home/home_screen.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageClassScreen();
  }
}
class PageClassScreen extends StatelessWidget {
  const PageClassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   BlocProvider.value(value: instance<HomeBloc>(),
    child:const  HomeScaffold(widget:Content() ,),);
  }
}
class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: BlocBuilder<HomeBloc, HomeState>(
           builder: (context, state) {
             return const Items();



  },
),), onRefresh: ()async{
      Courses courses=ModalRoute.of(context)!.settings.arguments as Courses;
      context.read<HomeBloc>().add(ShowDataCourse(courses));
    });
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height/2,
      child: FullEmptyScreen(retryActionFunction: (){
        Courses courses=ModalRoute.of(context)!.settings.arguments as Courses;
        context.read<HomeBloc>().add(ShowDataCourse(courses));
      },),
    );
  }
}
class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return FullErrorScreen(error: state.failure.message,retryActionFunction: (){
            Courses courses=ModalRoute.of(context)!.settings.arguments as Courses;
            context.read<HomeBloc>().add(ShowDataCourse(courses));
          },);
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: context.height-AppSize.appSize60,
      width: context.width,
      padding:const EdgeInsets.all(AppPadding.appPadding8),
          child: BlocBuilder<HomeBloc, HomeState>(

  builder: (context, state) {
    Courses courses=ModalRoute.of(context)!.settings.arguments as Courses;
    return ListView.builder(
              itemCount:courses.lessons.length ,
              padding:const EdgeInsets.only(bottom:AppSize.appSize50),
              physics:const AlwaysScrollableScrollPhysics(),
              itemBuilder:(context,index){
              return  SizedBox(
                height: AppSize.appSize70,
                width: context.width,
                child: Card(
                  child: SizedBox(
                    height: AppSize.appSize70,
                    child: ListTile(
                      onTap:  ()=>showBottomSheet(context,courses.lessons[index],instance<HomeBloc>()),
                      title: Text( AppLocalizationsImpl.of(context)!.translate(courses.lessons[index].title), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: ColorManager.blackColor,fontSize: FontSize.fontSize14),)
                      ,leading: CircleAvatar(
                        backgroundColor: ColorManager.primaryColorgreen,
                        child: Text(courses.lessons[index].id.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.whiteColor),),),
                        trailing: Icon(Icons.arrow_forward_ios,color:ColorManager.primaryColorgreen,size: AppSize.appSize26),
                    ),

                  ),
                ),
              );
          });

  },

),
    
    );
  }
}


showBottomSheet(BuildContext mainContext,Lesson lesson,HomeBloc homeBloc)async
{

  await showModalBottomSheet(
    elevation: AppSize.appSize9,
    enableDrag: true,
    useRootNavigator: true,
    context: mainContext,
    clipBehavior: Clip.antiAlias,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSize.appSize10),
      ),
    ),
    backgroundColor: ColorManager.whiteColor,
    builder: (BuildContext context) {
      return SizedBox( height: AppSize.appSize100,
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              MaterialClass(lesson: lesson,),
              HomeWorkAnswer(homeBloc:homeBloc,lesson:lesson),
              VideoMaterialClass(lesson: lesson),

          ],),
        ),
      );
    },

  );


}

showBottomSheetUpload(BuildContext mainContext,Lesson lesson,HomeBloc homeBloc)async
{

  await showModalBottomSheet(
    elevation: AppSize.appSize9,
    enableDrag: true,
    useRootNavigator: true,
    context: mainContext,
    clipBehavior: Clip.antiAlias,
    shape:const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppSize.appSize10),
      ),
    ),
    backgroundColor: ColorManager.whiteColor,
    builder: (BuildContext context) {
      return BlocProvider.value(
   value: homeBloc,
  child: SizedBox( height: AppSize.appSize100,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.appPadding10),
            child: Center(child:  _UploadButton(lesson: lesson,),),
          )
        ),
      ),
);
    },

  );


}

class _UploadButton extends StatelessWidget {
  final Lesson lesson;
  const _UploadButton({Key? key,required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Visibility(
            visible: state.file==null,
            replacement:SizedBox(
              width: context.width * AppSize.appSize0_40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor:ColorManager.primaryColorgreen,

              ),
                onPressed: ()=>context.read<HomeBloc>().add(SheetLessonEvent(lesson,state.file!)),
                child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.save)),
              ),
            ) ,
            child: SizedBox(
              width: context.width * AppSize.appSize0_80,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:ColorManager.primaryColorgreen,

                  ),
                  onPressed: ()=>context.read<HomeBloc>().add(const PickFile()),
                  child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.uploadFile)),
                ),
              ),
          );
        });
  }
}
class HomeWorkAnswer extends StatelessWidget {
  final HomeBloc homeBloc;
  final Lesson lesson;
  const HomeWorkAnswer({Key? key,required this.homeBloc,required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
  value: homeBloc ,
  child: BlocConsumer<HomeBloc, HomeState>(
  listener: (context,state){
      {
        if(state.statePage==StatePage.data)
        {
          if(state.isUploaded==true)
          {

            instance<ShowMessage>().showSnakeBar(context,AppStrings.success);

            Navigator.pushReplacementNamed(context, Routes.homeRoot);

          }
          else
          {
            instance<ShowMessage>().dismissDialogValue(context);

          }
        }
        if(state.statePage==StatePage.error)
        {
          if(state.failure.code==2020) {
            instance<ShowMessage>().showErrorPopupRetry(context, state.failure.message, () async {{await openAppSettings();}});
          }else
            {
              instance<ShowMessage>().showErrorPopUpOk(context, state.failure.message);
            }
        }

        if(state.statePage==StatePage.loading)
        {
          instance<ShowMessage>().showModal(context);
        }

  }},
  builder: (context, state) {
    return GestureDetector(
      onTap: ()async{


        showBottomSheetUpload(context,lesson,homeBloc);

      },
      child: SizedBox(
        height: AppSize.appSize80,
        width: context.width*AppSize.appSize0_30,
        child: Card(
          color: ColorManager.primaryColorgreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.upload_rounded,size: AppSize.appSize20,color: ColorManager.whiteColor,),
              Text( AppLocalizationsImpl.of(context)!.translate('upload'), textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: FontSize.fontSize12),)

            ],
          ),),
      ),
    );
  },
),
);
  }
}


class MaterialClass extends StatelessWidget {
  final Lesson lesson;
  const MaterialClass({Key? key,required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).pushNamed(Routes.classScreenMaterialShow,arguments: lesson),
      child: SizedBox(
        height: AppSize.appSize80,
        width: context.width*AppSize.appSize0_30,
        child: Card(
          color: ColorManager.primaryColorgreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.picture_as_pdf,size: AppSize.appSize20,color: ColorManager.whiteColor,),
              Text( AppLocalizationsImpl.of(context)!.translate('material'),  textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: FontSize.fontSize12),)

            ],
          ),),
      ),
    );
  }
}
class VideoMaterialClass extends StatelessWidget {
  final Lesson lesson;
  const VideoMaterialClass({Key? key,required this.lesson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).pushNamed(Routes.classScreenShow,arguments: lesson),
      child: SizedBox(
        height: AppSize.appSize80,
        width: context.width*AppSize.appSize0_30,
        child: Card(
          color: ColorManager.primaryColorgreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.video_collection_rounded,size: AppSize.appSize20,color: ColorManager.whiteColor,),
              Text( AppLocalizationsImpl.of(context)!.translate('video'),  textAlign: TextAlign.center,style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: FontSize.fontSize12),)

            ],
          ),),
      ),
    );
  }
}
class HomeWorkQuestion extends StatelessWidget {
  const HomeWorkQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: SizedBox(
        height: AppSize.appSize80,
        width: context.width*AppSize.appSize0_30,
        child: Card(
          color: ColorManager.primaryColorgreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.download,size: AppSize.appSize20,color: ColorManager.whiteColor,),
              Text( AppLocalizationsImpl.of(context)!.translate('download'), style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white,fontSize: FontSize.fontSize12),)

            ],
          ),),
      ),
    );
  }
}