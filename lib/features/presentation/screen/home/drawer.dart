import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_state.dart';
import 'package:hesham/features/business_logic/bloc/home/home_bloc.dart';
import 'package:hesham/features/business_logic/cubit/langauge/localization/app_localizations.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enum/enums.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/bloc/auth/auth/authentication_bloc.dart';
import '../../../business_logic/cubit/langauge/langauge_cubit.dart';
import '../../routes/app_routes.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    final user= instance<AuthenticationBloc>().user;
    return Container(

      width: double.infinity,
      height: 200,
      padding:const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin:const EdgeInsets.only(bottom: 10),
            height: 70,
            child: Icon(
              Icons.person, size: 35, color: ColorManager.whiteColor,),
            decoration:const BoxDecoration(
              shape: BoxShape.circle,

            ),
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Text(
                user.name,
                style:const TextStyle(color: Colors.white, fontSize: 20),
              );
            },
          ),
          Text(
            user.email,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


class MyDrawerList extends StatelessWidget {
  const MyDrawerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang=instance<LangaugeCubit>().state.locale.languageCode;
    final user= instance<AuthenticationBloc>().user;

    return Container(
      padding:const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // shows the list of menu drawer
        children: [

          Column(children: [
            GestureDetector(child:const Item(title: AppStrings.home, icon: Icons.home),onTap: (){
              Navigator.pushReplacementNamed(context, Routes.homeRoot);
            },),
            GestureDetector(child:const Item(title: AppStrings.contactUs, icon: Icons.contacts),onTap: (){
              Navigator.pushNamed(context, Routes.contact);

            },),

            GestureDetector(
                onTap: ()async{
                    if(lang=="en")
                    {
                      await context.read<LangaugeCubit>().changeAppLangauge(LangaugeCode.ar);
                    }
                    else
                    {
                      await context.read<LangaugeCubit>().changeAppLangauge(LangaugeCode.en);
                    }


                },
                child: Item(title: lang=="en"? "en":"ar", icon: Icons.language)),
          ],),
          Column(children: [
           const Divider(),

            GestureDetector(child:const Item(title: AppStrings.logout, icon: Icons.logout),onTap: () {
              context.read<HomeBloc>().add(const LogoutEvent());
            }),
            if(user.username=="admin1")
           GestureDetector(child: const Item(title: AppStrings.deleteAccount, icon: Icons.remove_circle),onTap: (){
             context.read<HomeBloc>().add(const LogoutEvent());

           },),
          ],)


        ],
      ),
    );
  }


}

class Item extends StatelessWidget {
  final String title;
  final IconData icon;

  const Item({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          Expanded(
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              AppLocalizationsImpl.of(context)!.translate(title),
              style: const TextStyle(
                color: Colors.white,

                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DrawerData extends StatelessWidget {
  const DrawerData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: context.height*AppSize.appSize0_90,
      width: context.width*AppSize.appSize0_70,
      decoration:const BoxDecoration(
        image: DecorationImage(image: AssetImage(ImagesAssetsManage.backImages,),fit: BoxFit.fill),

        borderRadius: BorderRadius.only(
          //topRight: Radius.circular(40.0),
          //    bottomRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          bottomLeft: Radius.circular(40.0),
        ),),

      child: SingleChildScrollView(
        child: Column(
          children: [
            MyHeaderDrawer(),
            MyDrawerList(),
          ],

        ),
      ),
    );
  }
}
