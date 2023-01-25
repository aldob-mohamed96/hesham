import 'package:badges/badges.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
 import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/font_manager.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesham/features/presentation/screen/home/drawer.dart';

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

class MainScaffold extends StatefulWidget {
  final Widget widget;

  const MainScaffold({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  void initState(){
    disableScreen();

    super.initState();


  }
  disableScreen()async{
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
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

              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,

                      end: Alignment.topRight,
                      colors: <Color>[ColorManager.primaryColor, ColorManager.primaryColorgreen]),


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
                    SafeArea(child: widget.widget),
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

class _HomeScaffoldState extends State<HomeScaffold>   {

  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  void initState(){
    disableScreen();


    super.initState();


  }
 disableScreen()async{
   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
 }
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final num constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(0.5, 1.0);
    return MediaQuery(data: mediaQueryData.copyWith(textScaleFactor: constrainedTextScaleFactor as double?),
        child: WillPopScope(
          onWillPop: ()async=>true,
          child: Scaffold(
            key: _scaffoldKey,
            drawer:const DrawerData(),
            body: Container(
             height: context.height,
             width: context.width,
             decoration:const BoxDecoration(image: DecorationImage(image: AssetImage(ImagesAssetsManage.backImages,),fit: BoxFit.fill),),

             child:  SingleChildScrollView(
               child: Column(children: [
                 SizedBox(
                     height: context.height*AppSize.appSize0_15,
                     child: Header(globalKey:_scaffoldKey ,))
                 ,
                 SizedBox(
                     height: context.height*AppSize.appSize0_85,
                     child: widget.widget)

               ],),
             )),
          )

        ));
  }
}
class Header extends StatelessWidget {
  final GlobalKey<ScaffoldState> globalKey;
  const Header({Key? key,required this.globalKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding:const EdgeInsets.all(15),
      height: context.height*AppSize.appSize0_15,
      width: context.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(ImagesAssetsManage.logoImages,width:AppSize.appSize150,),
          const NotificationIcon(),
          GestureDetector(child:const Icon(Icons.menu,color: Colors.white,),onTap: (){
            globalKey.currentState!.openDrawer();
          },)
        ],),
    );
  }
}


class HomeScaffoldInternal extends StatefulWidget {
  final Widget widget;

  const HomeScaffoldInternal({
    Key? key,
    required this.widget,
  }) : super(key: key);

  @override
  State<HomeScaffoldInternal> createState() => _HomeScaffoldInternal();
}

class _HomeScaffoldInternal extends State<HomeScaffoldInternal>  with SingleTickerProviderStateMixin {
 late Animation<double> _animation;
 late AnimationController _animationController;
  @override
  void initState(){
    disableScreen();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);


    super.initState();


  }
 disableScreen()async{
   await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
 }
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final num constrainedTextScaleFactor =
        mediaQueryData.textScaleFactor.clamp(0.5, 1.0);
    return MediaQuery(
        data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor as double?),
        child: Scaffold(


          appBar: AppBar(
            elevation: 0,

             title: SizedBox(child: Image.asset(ImagesAssetsManage.logoImages,width: context.width/2,),),
            centerTitle: true,
            automaticallyImplyLeading: true,
            backgroundColor: ColorManager.primaryColor,),


          body: Container(child: widget.widget,
        ),

        ));
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
 PopupMenuItem _buildPopupMenuItemDeleteAccount() {
   return PopupMenuItem(
     onTap: ()async{
       context.read<HomeBloc>().add(const LogoutEvent());
     },
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Icon(
           Icons.remove_circle,
           color: ColorManager.primaryColor,
           size: 20,

         ),
         Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.deleteAccount),style: const TextStyle(fontSize: 12),),

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
              child: GestureDetector(
                onTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    instance<NotificationCubit>().clearNotification();
                    Navigator.of(context).pushNamed(Routes.notes);
                  });
                },
                child: Icon(
                   Icons.notification_important, color: ColorManager.whiteColor,size: AppSize.appSize30,),
              ),


            );
          },
        ),
      ),
    );
  }
}
