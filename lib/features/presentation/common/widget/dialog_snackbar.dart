import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/features/presentation/common/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/enum/enums.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/style_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
abstract class ShowMessage{

  showErrorPopUpOk(BuildContext context, String message);
  showSuccessPopUpOk(BuildContext context, String message);
  showLoadingPopUp(BuildContext context);
  showErrorPopupRetry(BuildContext context, String message,Function retryActionFunction);
  showAskContinuePopup(BuildContext context, String message,Function retryActionFunction);
  showSnakeBar(BuildContext context, String message);
  showModal(BuildContext context) ;
  dismissDialogValue(context);
}
class ShowMessageImpl implements ShowMessage  {

  @override
  showModal(BuildContext context) async =>await Navigator.of(context).push(FullScreenModal());

  @override
  showErrorPopUpOk(BuildContext context, String message) {
    _dismissDialog(context);
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Padding(
                  padding: const EdgeInsets.all(AppPadding.appPadding10)
                  ,child: _getPopUpDialog(context,[

                  _getAnimatedImage(JsonAssetManager.lottieErrorDialog),
                  _getMessage(context,message),
                  _getPopUpButton(context)
                ]),)
        );
  }
  @override
  showSuccessPopUpOk(BuildContext context, String message) {
    _dismissDialog(context);

        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Padding(
                    padding: const EdgeInsets.all(AppPadding.appPadding18),
                    child: _getPopUpDialog(context,[
                   const SizedBox(height:AppSize.appSize20 ,),
                    _getAnimatedImage(JsonAssetManager.lottieSuccess),
                      const SizedBox(height:AppSize.appSize10 ,),
                    _getMessage(context,message),
                      const SizedBox(height:AppSize.appSize10 ,),
                    _getPopUpButton(context)
                  ]),
                ));
  }
  @override
  showLoadingPopUp(BuildContext context) {
    _dismissDialog(context);

        showDialog(
            barrierDismissible: false,
            useRootNavigator: true,
            useSafeArea: true,
            context: context,
            builder: (BuildContext context) =>
                Padding(
                  padding: const EdgeInsets.all(AppPadding.appPadding18),
                  child: _getPopUpDialog(context,[
                    const SizedBox(height:AppSize.appSize20 ,),
                     const CircularLoading(),
                    _getMessage(context,AppStrings.loading),
                    const SizedBox(height:AppSize.appSize10 ,),
                  ]),
                ));
  }
  @override
  showErrorPopupRetry(BuildContext context, String message,Function retryActionFunction) {
    _dismissDialog(context);

        showDialog(
            context: context,
            builder: (BuildContext context) =>
                Padding(
                  padding: const EdgeInsets.all(AppPadding.appPadding10),
                  child: _getPopUpDialog(context,[
                    _getAnimatedImage(JsonAssetManager.lottieErrorDialog),
                    _getMessage(context,message),
                    _getRetryButton(context, retryActionFunction)
                  ]),
                ));
  }
  @override
  showAskContinuePopup(BuildContext context, String message,Function retryActionFunction) {
    _dismissDialog(context);

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) =>
                Padding(
                  padding: const EdgeInsets.all(AppPadding.appPadding10),
                  child: _getPopUpDialog(context,[
                    _getAnimatedImage(JsonAssetManager.lottieSuccess),
                    _getMessage(context,message),
                    _getDialogContentButton(context, [
                      _getPopUpDismissButton(context),
                      _getExitButton(context, retryActionFunction),


                    ])
                  ]),
                ));
  }
  @override
  showSnakeBar(BuildContext context, String message) {
    _dismissDialog(context);

    ScaffoldMessenger.of(context)..clearSnackBars()..showSnackBar(SnackBar(
      content: Text(AppLocalizationsImpl.of(context)!.translate(message),textAlign: TextAlign.center),
      backgroundColor: AppConstants.backgroundCircularSnackBar,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: AppLocalizationsImpl.of(context)!.translate(
            AppStrings.dismiss),
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
      ),

    ));
  }

  _isCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
  _dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }



  Widget _getPopUpDialog(BuildContext context,List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.appSize14)
      ),
      elevation: AppSizeMin.appSizeMin1_4,
      backgroundColor: ColorManager.transparentColor,
      child: Container(

        decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.appSize14),
            boxShadow: [
              BoxShadow(color: ColorManager.boxShadowColorDialog)
            ]
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }
  Widget _getDialogContent(BuildContext context,List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,);
  }
  Widget _getDialogContentButton(BuildContext context,List<Widget> children) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
  Widget _getPopUpButton(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding12),
        child: SizedBox(
            child: ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
            }, child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.ok),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.focusColor,fontSize: FontSize.fontSize16),))),
      ),
    );
  }
  Widget _getPopUpDismissButton(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding12),
        child: SizedBox(
            child: ElevatedButton(onPressed: (){
                Navigator.of(context).pop();
            }, child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.dismiss),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.focusColor,fontSize: FontSize.fontSize16),))),
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

            }, child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.ok),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.focusColor,fontSize: FontSize.fontSize16),))),
      ),
    );
  }
  Widget _getExitButton(BuildContext context,Function retryActionFunction) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding12),
        child: SizedBox(
            child: ElevatedButton(onPressed: (){

                retryActionFunction.call();

            }, child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.ok),textAlign: TextAlign.center,style: getRegularStyle(color: ColorManager.focusColor,fontSize: FontSize.fontSize16),))),
      ),
    );
  }

  @override
  dismissDialogValue(context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }


}

class FullScreenModal extends ModalRoute {



  // constructor
  FullScreenModal();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.6);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  static const colorizeColors = [
    Colors.lightBlue,
    Colors.blue,
    Colors.green,
    Colors.lightBlueAccent,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Material(

        type: MaterialType.transparency,
        child: Center(
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                 child:  Lottie.asset(JsonAssetManager.lottieLoading, width: context.width,
                   height: context.height, ),
                ),


              ],
            ),
          )
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // add fade animation
    return FadeTransition(
      opacity: animation,
      // add slide animation
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        // add scale animation
        child: ScaleTransition(
          scale: animation,
          child: child,
        ),
      ),
    );
  }
}


