import 'package:hesham/core/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enum/enums.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/cubit/langauge/langauge_cubit.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
class IconButtonLangauge extends StatelessWidget {
  const IconButtonLangauge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: AppSize.appSize40,
      width:  AppSize.appSize40,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: AppPadding.appPadding4),
        child: PopUpButton(),
      ),
    );
  }
}
class PopUpButton extends StatelessWidget {
  const PopUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: Icon(Icons.language,size: AppSize.appSize30,color: ColorManager.whiteColor,),
        itemBuilder: (context){
          return List.generate(AppConstants.supportedLocales.length, (index) {
            return PopupMenuItem<LangaugeCode>(
              value:AppConstants.supportedLocales.elementAt(index).languageCode.getLangaugeCode() ,
              child: Text(AppLocalizationsImpl.of(context)!.translate(AppConstants.supportedLocales.elementAt(index).languageCode.toString()),textAlign: TextAlign.center,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorManager.secondColor),),
            );
          });
        },
        onSelected:(LangaugeCode value)async{
          final res= context.read<LangaugeCubit>().state.locale.languageCode==value.getLangaugeCode();
          if(!res)
          {
            await context.read<LangaugeCubit>().changeAppLangauge(value);
          }


        }
    );
  }
}
