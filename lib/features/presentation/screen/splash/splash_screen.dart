import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/font_manager.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/business_logic/cubit/langauge/localization/app_localizations.dart';
import 'package:hesham/features/presentation/common/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../common/widget/main_scaffold_auth.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Image.asset(

      ImagesAssetsManage.gifImages,
      fit: BoxFit.fill,

    );
  }

}