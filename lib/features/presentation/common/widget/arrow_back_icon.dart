import 'dart:io';

import 'package:hesham/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
class ArrowBackIcon extends StatelessWidget {
  final VoidCallback voidCallback;
  const ArrowBackIcon({Key? key,required this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.appSize30,
      width: AppSize.appSize30,
      child: IconButton(onPressed: voidCallback,
         icon: Icon(Platform.isIOS?Icons.arrow_back_ios:Icons.arrow_back),iconSize: AppSize.appSize30,),
    )
              ;
  }
}
