import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/font_manager.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/business_logic/cubit/langauge/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MaintainAppScreen extends StatelessWidget {
  const MaintainAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        body: SizedBox(height: context.height,width: context.width,child:
        Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(JsonAssetManager.maintain),
            const SizedBox(height: AppSize.appSize20,),
            Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.maintainApp),style: Theme.of(context).textTheme.displaySmall!.copyWith(color: ColorManager.secondColor,fontSize: FontSize.fontSize16),)
          ],
        ),),

      ),
    );
  }
}
