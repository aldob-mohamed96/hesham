
import 'package:hesham/features/business_logic/cubit/langauge/localization/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/strings_manager.dart';
class UnDefinedRoute extends StatelessWidget {
  const UnDefinedRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(child: Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.noRouteFound)),),//todo string manager
    );
  }
}
