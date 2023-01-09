import 'package:hesham/core/extension/extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
 import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';

class ButtonEmergency extends StatelessWidget {
  const ButtonEmergency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
       },
      icon: const Icon(Icons.emergency,size: 20,),
      label: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.emergency),style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.whiteColor,fontWeight: FontWeight.bold,fontSize: FontSize.fontSize18),),

      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}

