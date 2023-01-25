import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
class FullEmptyScreen extends StatelessWidget {

  final VoidCallback retryActionFunction;
  const FullEmptyScreen({Key? key,required this.retryActionFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height/AppValue.appValue2,
      child:   Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding10),
        child: _getErrorFullScreen(context,[
          _getAnimatedImage(JsonAssetManager.lottieEmpty),
          _getMessage(context,AppStrings.emptyContent),
          _getRetryButton(context, retryActionFunction),

        ]),
      ),
    );
  }

  Widget _getRetryButton(BuildContext context,Function retryActionFunction) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding12),
        child: SizedBox(
            child: ElevatedButton(onPressed: (){

              retryActionFunction.call();

            }, child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.retryAgain),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.focusColor,fontSize: FontSize.fontSize16),))),
      ),
    );
  }
  Widget _getErrorFullScreen(BuildContext context,List<Widget> children) {
    return Container(

        decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.appSize14),
            boxShadow: [
              BoxShadow(color: ColorManager.boxShadowColorDialog)
            ]
        ),
        child: _getContent(context,children),

    );
  }
  Widget _getContent(BuildContext context,List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,);
  }
  Widget _getAnimatedImage(String animationName) {
    return Center(
      child: SizedBox(height: AppSize.appSize100,width:AppSize.appSize100,
        child: Lottie.asset(animationName),),
    );

  }
  Widget _getMessage(BuildContext context,String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding8),
        child: Text(AppLocalizationsImpl.of(context)!.translate(message),textAlign: TextAlign.center,style:
        getRegularStyle(color: ColorManager.primaryColor,fontSize: FontSize.fontSize16,),),
      ),
    );

  }
}
class FullEmptyHome extends StatelessWidget {


  const FullEmptyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height/2,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding10),
        child: _getErrorFullScreen(context,[
          _getAnimatedImage(JsonAssetManager.lottieEmptyHome,context),
          _getMessage(context,AppStrings.emptyContent),


        ]),
      ),
    );
  }

  Widget _getErrorFullScreen(BuildContext context,List<Widget> children) {
    return Container(

        decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.appSize14),
            boxShadow: [
              BoxShadow(color: ColorManager.boxShadowColorDialog)
            ]
        ),
        child: _getContent(context,children),

    );
  }
  Widget _getContent(BuildContext context,List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,);
  }
  Widget _getAnimatedImage(String animationName,BuildContext context) {
    return Column(
      children: [
        SizedBox(height:context.height/2,width:AppSize.appSize100,
          child: Lottie.asset(JsonAssetManager.lottieEmptyHome),),
        Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.emptyContent),textAlign: TextAlign.center,style:
        getRegularStyle(color: ColorManager.primaryColor,fontSize: FontSize.fontSize16,),)
      ],
    );

  }
  Widget _getMessage(BuildContext context,String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding8),
        child: Text(AppLocalizationsImpl.of(context)!.translate(message),textAlign: TextAlign.center,style:
        getRegularStyle(color: ColorManager.primaryColor,fontSize: FontSize.fontSize16,),),
      ),
    );

  }
}
