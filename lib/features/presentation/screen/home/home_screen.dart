
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/presentation/common/widget/dialog_snackbar.dart';
import 'package:hesham/features/presentation/common/widget/main_scaffold_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/bloc/home/home_bloc.dart';
import '../../../business_logic/cubit/langauge/langauge_cubit.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../routes/app_routes.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PageHome();
  }
}
class PageHome extends StatelessWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(create: (_) => instance<HomeBloc>()..add(GetHomeData()),child:const  HomeScaffold(widget:Content() ,),);
  }
}
class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: BlocListener<HomeBloc, HomeState>(
         listener: (context, state)
              {
                if(state.statePage==StatePage.data)
                  {
                    if(state.isUploaded==true)
                      {

                        Navigator.pushReplacementNamed(context, Routes.homeRoot);
                        instance<ShowMessage>().showSnakeBar(context,AppStrings.acceptedSuccess);

                      }
                    else
                      {
                        instance<ShowMessage>().dismissDialogValue(context);

                      }
                  }

                if(state.statePage==StatePage.error)
                {


                    if (state.failure == AppConstants.maintainFailure) {
                      Navigator.pushReplacementNamed(context, Routes.maintainAppRoot);
                    }
                    else if (state.failure == AppConstants.updateFailure) {

                      Navigator.pushReplacementNamed(context, Routes.maintainAppRoot);
                    }
                    else if (state.failure == AppConstants.unAuthenticatedFailure) {
                      Navigator.pushReplacementNamed(context, Routes.loginRoot);
                    }
                    else
                    {
                      instance<ShowMessage>().showErrorPopUpOk(context, state.failure.message);
                    }


                }

                if(state.statePage==StatePage.loading)
                {
                  instance<ShowMessage>().showModal(context);
                }
                if(state.logout)
                {
                 Navigator.of(context).pushReplacementNamed(Routes.loginRoot);
                }


              },
  child: OrientationBuilder(builder:(context,orren)=>orren==Orientation.portrait? Widgets():WidgetsLandScape()),), onRefresh: ()async{});
  }
}

class WidgetsLandScape extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  WidgetsLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.width*AppSize.appSize0_30,
                child: Column(children: [

                      Container( padding:const EdgeInsets.symmetric(horizontal: 15),height:50,child: Image.asset(ImagesAssetsManage.brandImages),),
                      const SliderLandScape(),


                  ],),),

              Container(
                height: context.width*AppSize.appSize0_60,
                width: context.width,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    //   bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    //   bottomLeft: Radius.circular(40.0)),
                  ),),

                  child: Column(

                    children: [
                    if(state.homeData.data.subjects.isEmpty)
                      Column(
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Lottie.asset(JsonAssetManager.lottieEmptyHome),),
                          Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.emptyContent),textAlign: TextAlign.center,style:
                          getRegularStyle(color: ColorManager.primaryColor,fontSize: FontSize.fontSize16,),)
                        ],
                      ),
                    if(state.homeData.data.subjects.isNotEmpty)
                      _ListView(context),
                    if(state.homeData.data.subjects.isNotEmpty)
                      Divider(height:context.width* AppSize.appSize0_01,endIndent: 20,indent: 20,thickness: 4,color: ColorManager.primaryColorLight,),
                    if(state.homeData.data.subjects.isNotEmpty)
                      Expanded(child: _gridview(context)),
                  ],),),


            ],
          ),
        );
      },
    );
  }





  _ListView(BuildContext context) {
    return SizedBox(
      height: context.width*AppSize.appSize0_10,
      child: Padding(
   padding: const EdgeInsets.all(10.0),
   child: BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
      return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics:const AlwaysScrollableScrollPhysics(),
                itemCount: state.homeData.data.subjects.length,


                itemBuilder: (context, position) {
                  return _ListItem(context,state.homeData.data.subjects[position],state.selected==state.homeData.data.subjects[position].id);
                 });
  },
)),

    );

  }
  _gridview(BuildContext context) {
    return SizedBox(
      height: context.width*AppSize.appSize0_50,
      child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (pre,curr)=>pre.subject!=curr.subject,
            builder: (context, state) {
             return ListView.builder(

              physics:const AlwaysScrollableScrollPhysics(),
              padding:const EdgeInsets.only(bottom: 40),
              itemCount: state.subject.courses.length,
              itemBuilder: (context, position) {
                return _cardGrid(context,state.subject.courses[position]);
               });
  },
)),
    );

  }
  _cardGrid(BuildContext context,Courses courses){
    return BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return GestureDetector(
      onTap: (){
     Navigator.pushNamed(context, Routes.classSchool,arguments: courses);

      },
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: AppPadding.appPadding10,vertical:AppPadding.appPadding4 ),

        height: 60,
        width: context.width,
        child: Stack(

        children: [

        Positioned(
          height: 60,
          width: context.width*AppSize.appSize0_60,


            right: 0,child:
        Container(

          padding:const EdgeInsets.all(AppPadding.appPadding4),
          //padding:const EdgeInsets.symmetric(horizontal:AppPadding.appPadding16,vertical:AppPadding.appPadding4),

          decoration: BoxDecoration(
            color: ColorManager.primaryColorgreen,
            border: Border.all(
              color: ColorManager.primaryColor,
              style: BorderStyle.solid,
              width: 1.0,
            ),

            borderRadius: BorderRadius.circular(15),
          ),
            child: Center(child: Text(courses.description,style: TextStyle(color: ColorManager.whiteColor),
            )
            ),
          )),
          Positioned(
          height: 60,
          width: context.width*AppSize.appSize0_40,left: 0,child:
          Container(


            padding:const EdgeInsets.all(AppPadding.appPadding4),

            decoration: BoxDecoration(
              color: ColorManager.primaryColorLight,
              border: Border.all(
                color: ColorManager.transparentColor,
                style: BorderStyle.solid,
                width: 1.0,
              ),

              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text(courses.title,style: TextStyle(color: ColorManager.primaryColor,),
            )
            ),
          )),


        ],),
      ),
    );
  },
);
  }
  _ListItem(BuildContext context,Subject subject,bool isSelected){
    return BlocBuilder<HomeBloc, HomeState>(
  builder: (context, state) {
    return GestureDetector(
      onTap: (){
       context.read<HomeBloc>().add(SelectedSubject(subject.id,subject));

      },
      child: Container(
        alignment: Alignment.center,
        margin:const EdgeInsets.all(AppPadding.appPadding4),
        padding:const EdgeInsets.all(AppPadding.appPadding8),

        decoration: BoxDecoration(
          color: isSelected? ColorManager.primaryColorgreen:ColorManager.primaryColorLight,
          borderRadius:const BorderRadius.all(Radius.circular(AppSize.appSize10)),

        ),
        height: AppSize.appSize40,


        child: Text(subject.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color:
          isSelected? ColorManager.whiteColor:ColorManager.blackColor
            ,fontWeight: FontWeight.bold,fontSize: FontSize.fontSize16,),),

      ),
    );
  },
);
  }
}
class SliderLandScape extends StatelessWidget {
  const SliderLandScape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.width*AppSize.appSize0_20,
      width: context.width,

      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CarouselSlider(
            options: CarouselOptions(

              enableInfiniteScroll: true,
              reverse: true,
              autoPlay: true,
              autoPlayInterval:const Duration(seconds: AppValue.appValue3),
              autoPlayAnimationDuration:const Duration(milliseconds: AppValue.appValue800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: state.images.map((i) {
              return CachedNetworkImage(
                color: Colors.white,
                width: context.width,
                height:AppSize.appSize150 ,
                //todo
                imageUrl: i.toString() ,
                imageBuilder: (context, imageProvider) => Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(AppSize.appSize20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.colorBurn,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
                errorWidget: (context, url, error) => Card(child: Image.asset(ImagesAssetsManage.splashImages)),
              )
              ;
            }).toList(),
          );
        },
      ),

    );
  }
}



class Widgets extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  Widgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height*AppSize.appSize0_30,
                child: Column(children: [

                  Container( padding:const EdgeInsets.symmetric(horizontal: 15),height:50,child: Image.asset(ImagesAssetsManage.brandImages),),
                  const Slider(),


                ],),),

              Container(
                height: context.height*AppSize.appSize0_60,
                width: context.width,
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration:const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    //   bottomRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                    //   bottomLeft: Radius.circular(40.0)),
                  ),),

                child: Column(

                  children: [
                    if(state.homeData.data.subjects.isEmpty)
                      Column(
                        children: [
                          SizedBox(
                            child: Lottie.asset(JsonAssetManager.lottieEmptyHome),),
                          Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.emptyContent),textAlign: TextAlign.center,style:
                          getRegularStyle(color: ColorManager.primaryColor,fontSize: FontSize.fontSize16,),)
                        ],
                      ),
                    if(state.homeData.data.subjects.isNotEmpty)
                      _ListView(context),
                    if(state.homeData.data.subjects.isNotEmpty)
                      Divider(height:context.height* AppSize.appSize0_01,endIndent: 20,indent: 20,thickness: 4,color: ColorManager.primaryColorLight,),
                    if(state.homeData.data.subjects.isNotEmpty)
                      Expanded(child: _gridview(context)),
                  ],),),


            ],
          ),
        );
      },
    );
  }





  _ListView(BuildContext context) {
    return SizedBox(
      height: context.height*AppSize.appSize0_10,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics:const AlwaysScrollableScrollPhysics(),
                  itemCount: state.homeData.data.subjects.length,


                  itemBuilder: (context, position) {
                    return _ListItem(context,state.homeData.data.subjects[position],state.selected==state.homeData.data.subjects[position].id);
                  });
            },
          )),

    );

  }
  _gridview(BuildContext context) {
    return SizedBox(
      height: context.height*AppSize.appSize0_50,
      child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (pre,curr)=>pre.subject!=curr.subject,
            builder: (context, state) {
              return ListView.builder(

                  physics:const AlwaysScrollableScrollPhysics(),
                  padding:const EdgeInsets.only(bottom: 40),
                  itemCount: state.subject.courses.length,
                  itemBuilder: (context, position) {
                    return _cardGrid(context,state.subject.courses[position]);
                  });
            },
          )),
    );

  }
  _cardGrid(BuildContext context,Courses courses){
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, Routes.classSchool,arguments: courses);

          },
          child: Container(
            margin:const EdgeInsets.symmetric(horizontal: AppPadding.appPadding10,vertical:AppPadding.appPadding4 ),

            height: 60,
            width: context.width,
            child: Stack(

              children: [

                Positioned(
                    height: 60,
                    width: context.width*AppSize.appSize0_55,


                    right: 0,child:     Container(

                  padding:const EdgeInsets.all(AppPadding.appPadding4),
                  //padding:const EdgeInsets.symmetric(horizontal:AppPadding.appPadding16,vertical:AppPadding.appPadding4),

                  decoration: BoxDecoration(
                    color: ColorManager.primaryColorgreen,
                    border: Border.all(
                      color: ColorManager.primaryColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text(courses.description,style: TextStyle(color: ColorManager.whiteColor),
                  )
                  ),
                )),
                Positioned(
                    height: 60,
                    width: context.width*AppSize.appSize0_40,left: 0,child:
                Container(


                  padding:const EdgeInsets.all(AppPadding.appPadding4),

                  decoration: BoxDecoration(
                    color: ColorManager.primaryColorLight,
                    border: Border.all(
                      color: ColorManager.transparentColor,
                      style: BorderStyle.solid,
                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: Text(courses.title,style: TextStyle(color: ColorManager.primaryColor,),
                  )
                  ),
                )),


              ],),
          ),
        );
      },
    );
  }
  _ListItem(BuildContext context,Subject subject,bool isSelected){
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            context.read<HomeBloc>().add(SelectedSubject(subject.id,subject));

          },
          child: Container(
            alignment: Alignment.center,
            margin:const EdgeInsets.all(AppPadding.appPadding4),
            padding:const EdgeInsets.all(AppPadding.appPadding8),

            decoration: BoxDecoration(
              color: isSelected? ColorManager.primaryColorgreen:ColorManager.primaryColorLight,
              borderRadius:const BorderRadius.all(Radius.circular(AppSize.appSize10)),

            ),
            height: AppSize.appSize40,


            child: Text(subject.title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color:
              isSelected? ColorManager.whiteColor:ColorManager.blackColor
                ,fontWeight: FontWeight.bold,fontSize: FontSize.fontSize16,),),

          ),
        );
      },
    );
  }
}
class Slider extends StatelessWidget {
  const Slider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height*AppSize.appSize0_20,
      width: context.width,

      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return CarouselSlider(
            options: CarouselOptions(

              enableInfiniteScroll: true,
              reverse: true,
              autoPlay: true,
              autoPlayInterval:const Duration(seconds: AppValue.appValue3),
              autoPlayAnimationDuration:const Duration(milliseconds: AppValue.appValue800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: state.images.map((i) {
              return CachedNetworkImage(
                color: Colors.white,
                width: context.width,
                height:AppSize.appSize150 ,
                //todo
                imageUrl: i.toString() ,
                imageBuilder: (context, imageProvider) => Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(AppSize.appSize20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.colorBurn,
                      ),
                    ),
                  ),
                ),
                placeholder: (context, url) =>const Center(child:  CircularProgressIndicator()),
                errorWidget: (context, url, error) => Card(child: Image.asset(ImagesAssetsManage.splashImages)),
              )
              ;
            }).toList(),
          );
        },
      ),

    );
  }
}
