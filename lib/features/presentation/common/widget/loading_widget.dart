import 'dart:io';

import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/resources/font_manager.dart';
class CircularLoading extends StatelessWidget {
  const CircularLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator.adaptive(
      backgroundColor: AppConstants.backgroundCircularLoading,
      strokeWidth:AppConstants.strokeWidth ,
    );
  }
}

class ListViewLoading extends StatelessWidget {
  const ListViewLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height*AppSize.appSize0_80,
      width: context.width,

      padding: const EdgeInsets.symmetric(horizontal: AppPadding.appPadding16, vertical:  AppPadding.appPadding16),
      child: Shimmer.fromColors(
        baseColor: ColorManager.whiteColor,

        highlightColor: ColorManager.grayColor300,
        child: ListView.builder(

          itemCount: AppValue.appValue8,
          itemBuilder: (context, index) {
            return Card(
              elevation: AppSize.appSize1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.appSize10),
              ),
              child:const SizedBox(height: AppSize.appSize70,),
            );
          },
        ),
      )
    );
  }
}

class BottomLoader extends StatelessWidget {

 const BottomLoader({Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Center(
      child: SizedBox(
        height: AppSize.appSize24,
        width:AppSize.appSize24,
        child: CircularLoading()
      ),
    );
  }
}