import 'package:badges/badges.dart';
 import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/font_manager.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../business_logic/bloc/auth/auth/authentication_bloc.dart';
import '../../../business_logic/bloc/auth/auth/authentication_state.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/langauge_cubit.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../../business_logic/cubit/notification/notification_cubit.dart';
import '../../../domain/entities/user.dart';
import '../../routes/app_routes.dart';
import 'arrow_back_icon.dart';
import 'icon_langauge.dart';

class MainScaffold extends StatelessWidget {
  final Widget widget;

  const MainScaffold({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final num constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(0.5, 1.0);
    return MediaQuery(
        data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor as double?),
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(

              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.1, 0.5, 0.7, 0.9],
                      colors: [
                        ColorManager.primaryColor,
                        ColorManager.primaryColorLight,
                        ColorManager.transparentColor,
                        ColorManager.primaryColor,
                      ],
                    )
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    const Positioned(
                        left: 0,
                        top: 50,
                        child:IconButtonLangauge()
                    ),
                    SafeArea(child: widget),
                  ],
                ),
              ),
            )));
  }
}
class HomeScaffold extends StatefulWidget {
  final Widget widget;

  const HomeScaffold({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold>  with SingleTickerProviderStateMixin {
 late Animation<double> _animation;
 late AnimationController _animationController;
  @override
  void initState(){

    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);


    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final num constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(0.5, 1.0);
    return MediaQuery(
        data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor as double?),
        child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(


              appBar: AppBar(
                 title: Text("الهاشمي",style: TextStyle(color: ColorManager.whiteColor),),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading:    BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    User user= context.select((AuthenticationBloc auth) => auth.user);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(Icons.person,color: ColorManager.whiteColor,size: 20,),

                        Text(AppLocalizationsImpl.of(context)!.translate(user.name), style:Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorManager.whiteColor,fontSize: FontSize.fontSize10,overflow: TextOverflow.ellipsis)),



                      ],
                    );
                  },
                ),
                backgroundColor: ColorManager.primaryColor,
                actions: [
                  NotificationIcon(),
                  PopupMenuButton(
                    iconSize: AppSize.appSize20,
                    onSelected: (value) {

                    },
                    shape:const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                    ),
                    itemBuilder: (ctx) => [
                      _buildPopupMenuItemLang(),
                      _buildPopupMenuItemSupport(),
                      _buildPopupMenuItemLogout()

                    ],
                  )
                ],
              ),
              resizeToAvoidBottomInset: false,
              body: widget.widget,

            )));
  }
 PopupMenuItem _buildPopupMenuItemLang() {
   final res= context.read<LangaugeCubit>().state.locale.languageCode;
   return PopupMenuItem(
     onTap: ()async{
       if(res=="en")
       {
         await context.read<LangaugeCubit>().changeAppLangauge(LangaugeCode.ar);
       }
       else
         {
           await context.read<LangaugeCubit>().changeAppLangauge(LangaugeCode.en);
         }
     },
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Icon(

           Icons.language,
           color: ColorManager.primaryColor,
           size: 20,
         ),
         Text(res=="en"?"العربية":"English",style:const TextStyle(fontSize: 12),),

       ],
     ),
   );
 }
 PopupMenuItem _buildPopupMenuItemLogout() {
   return PopupMenuItem(
     onTap: ()async{
       context.read<HomeBloc>().add(const LogoutEvent());
     },
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Icon(
           Icons.logout,
           color: ColorManager.primaryColor,
           size: 20,

         ),
         Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.logout),style: const TextStyle(fontSize: 12),),

       ],
     ),
   );
 }
 PopupMenuItem _buildPopupMenuItemSupport() {
   return PopupMenuItem(
     onTap: ()async{
      Navigator.of(context).pushNamed(Routes.contact);
     },
     child: GestureDetector(
       onTap: ()=>Navigator.of(context).pushNamed(Routes.contact),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           Icon(
             Icons.chat,
             color: ColorManager.primaryColor,
             size: 20,

           ),
           Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.contactUs),style: const TextStyle(fontSize: 12)),

         ],
       ),
     ),
   );
 }
}

class CustomAppBar extends PreferredSize{
  const CustomAppBar({required Widget child, required Size preferredSize}) :
        super(child: child, preferredSize: preferredSize);

}
appBar(BuildContext context){

  return CustomAppBar(child:
  Container(

    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center
      ,children: [

      BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
         User user= context.select((AuthenticationBloc auth) => auth.user);
          return SizedBox(
            width: AppSize.appSize100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 CircleAvatar(
                    child:const Icon(Icons.person),
                    radius: AppSize.appSize20,
                    foregroundColor: ColorManager.primaryColor,
                    backgroundColor:ColorManager.whiteColor ,
                  ),


                Text(AppLocalizationsImpl.of(context)!.translate(user.name), style:Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorManager.whiteColor,overflow: TextOverflow.ellipsis)),



              ],
            ),
          );
        },
      ),



      Container(
        padding: const EdgeInsets.only(bottom:  AppPadding.appPadding12,top: AppPadding.appPadding12  ),
        height: AppSize.appSize50,
        child:Row(children: [IconButtonLangauge()],),
      ),
    ],),
    decoration: BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  tileMode: TileMode.clamp,
  colors: [
  ColorManager.primaryColorLight,
  ColorManager.primaryColor,

  ]),

        borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(AppSize.appSize20),bottomRight: Radius.circular(AppSize.appSize20))
    ),
    padding:const EdgeInsets.all(AppPadding.appPadding10),
    height: context.height*AppSize.appSize0_15,
    width: context.width,
  ), preferredSize: const Size.fromHeight(AppSize.appSize90),);
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.appPadding10,horizontal: AppPadding.appPadding10),
      child: SizedBox(
        height: AppSize.appSize40,
        width: AppSize.appSize40,
        child: BlocBuilder<NotificationCubit, NotificationState>(
          buildWhen: (previous, current) => previous.countNotification!=current.countNotification,
          builder: (context, state) {
            return Badge(
              showBadge: state.countNotification!=0,
              position: BadgePosition.topStart(start: AppSize.appSize10),
              badgeContent:
              Text(state.countNotification.toString(),style: Theme.of(context).textTheme.bodyText2!.copyWith(color: ColorManager.whiteColor),),
              alignment: Alignment.topRight,
              toAnimate: true,
              badgeColor: Colors.red,
              animationType: BadgeAnimationType.slide,
              animationDuration:const Duration(seconds: AppValue.appValue1),
              child: IconButton(
                icon: Icon(Icons.notification_important, color: ColorManager.whiteColor,size: AppSize.appSize30,),
                onPressed: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    instance<NotificationCubit>().clearNotification();
                    Navigator.of(context).pushNamed(Routes.notes);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
