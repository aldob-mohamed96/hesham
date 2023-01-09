import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/app_constant.dart';

class NotificationItem extends Equatable{
  final String id;
  final String title;
  final String subTitle;
  final String dateDeliver;
  final String dateRead;

 const NotificationItem(this.id, this.title, this.subTitle,this.dateDeliver,this.dateRead);
 const NotificationItem.empty():this(AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString,AppConstants.defaultEmptyString);

  @override
  List<Object?> get props => [id,title,subTitle,dateDeliver,dateRead];

}
class NotificationData extends Equatable{
  final List<NotificationItem> data;


 const NotificationData(this.data);
 const NotificationData.empty():this(const <NotificationItem>[]);

  @override
  List<Object?> get props => [data];

}
