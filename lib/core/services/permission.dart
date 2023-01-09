import 'dart:io';
import 'package:hesham/core/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandling{
 Future<DataSourcePermission> checkPermission(Permission permission);

 Future<void> checkPermissionWithLifeCycleStateApp(bool isDetectedPermission,Permission permission,AppLifecycleState state,DataSourcePermission dataSourcePermission);




}
class PermissionHandlingImpl implements PermissionHandling{

  PermissionHandlingImpl();
  @override
  Future<DataSourcePermission> checkPermission(Permission permission)async
  {
     PermissionStatus permissionStatus=await permission.request();
    if(permissionStatus.isGranted||permissionStatus.isLimited)
      {
          return DataSourcePermission.allow;
      }
    else if(permissionStatus.isDenied)
      {
        return DataSourcePermission.permissionDenied;
      }
    else if(permissionStatus.isRestricted)
      {
         return DataSourcePermission.permissionRestricted;
      }
    else if(Platform.isIOS||permissionStatus.isPermanentlyDenied)
    {
      return DataSourcePermission.permissionPermanentlyDenied;
    }
    else
      {
          return DataSourcePermission.unknownPermissionError;
      }
  }

  @override
  Future<void> checkPermissionWithLifeCycleStateApp(bool isDetectedPermission, Permission permission,AppLifecycleState state,DataSourcePermission dataSourcePermission) async{

    if(AppLifecycleState.resumed==state&&isDetectedPermission&&dataSourcePermission==DataSourcePermission.permissionPermanentlyDenied)
      {
        isDetectedPermission=false;
        await checkPermission(permission);
      }
    if(AppLifecycleState.paused==state&&dataSourcePermission==DataSourcePermission.permissionPermanentlyDenied)
    {
      isDetectedPermission=true;
    }
  }











}