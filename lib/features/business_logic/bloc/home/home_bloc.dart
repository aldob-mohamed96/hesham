import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/features/data/network/requests_entity/request_entity.dart';
import 'package:hesham/features/domain/entities/chat.dart';
import 'package:hesham/features/domain/entities/courses.dart';
import 'package:hesham/features/domain/entities/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
 import 'package:permission_handler/permission_handler.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../core/enum/enums.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/services/permission.dart';
import '../../../domain/usecases/app_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';
const throttleDuration = Duration(milliseconds: AppValue.appValue100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase homeUseCase;
  final SheetUseCase sheetUseCase;
  final AttendanceUseCase attendanceUseCase;
  final LogoutUseCase logoutUseCase;
  final PermissionHandling permissionHandling;

 HomeBloc({required this.logoutUseCase,required this.homeUseCase,required this.attendanceUseCase,required this.sheetUseCase,required this.permissionHandling}) : super(const HomeState()) {
    on<GetHomeData>(_onGetHomeData);
    on<SelectedSubject>(_onSelectedSubject);
    on<SheetLessonEvent>(_onSheetLessonEvent);
    on<AttendanceLessonEvent>(_onAttendanceLessonEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<PickFile>(_onPickFile);


  }

  void _onLogoutEvent(LogoutEvent event,Emitter<HomeState> emit)async
  {

    emit(state.copyWith(statePage: StatePage.loading));
    await logoutUseCase.execute(unit);
    emit(state.copyWith(logout: true));

  }
  void _onAttendanceLessonEvent(AttendanceLessonEvent event,Emitter<HomeState> emit)async
  {
    await attendanceUseCase.execute(LessonRequest(event.lesson.id));

  }
  void _onSheetLessonEvent(SheetLessonEvent event,Emitter<HomeState> emit)async
  {

    emit(state.copyWith(statePage: StatePage.loading));
    final result=await sheetUseCase.execute(SheetRequest(event.lesson.id, event.file));
    result.fold((failure) => emit(state.copyWith(failure:failure,statePage: StatePage.error)), (homeData)=> emit(state.copyWith(statePage: StatePage.data,isUploaded: true)));


  }
 void _onSelectedSubject(SelectedSubject event,Emitter<HomeState> emit)async{

      emit(state.copyWith(selected: event.id,subject: event.subject));
 }


  void _onPickFile(PickFile event,Emitter<HomeState> emit)  async {

     final hasPermission= await permissionHandling.checkPermission(Permission.storage);
     if(hasPermission==DataSourcePermission.allow)
       {
         final result = await FilePicker.platform.pickFiles(
           allowMultiple: false,
           type: FileType.custom,
           allowedExtensions: [
             'jpg',
             'pdf',
             'png',
             'jpeg',
             'jfif',
             'pjpeg',
             'pjp',
             'tiff',
             'tif'
           ],
         );

         if (result == null) {
           return null;
         }
         else {
           File file = File(result.files.single.path!);
           emit(state.copyWith(file: file));
         }
       }
     else
       {

         emit(state.copyWith(statePage: StatePage.error,failure: DataSourcePermission.permissionDenied.getFailure()));
       }



  }

 void _onGetHomeData(GetHomeData event,Emitter<HomeState> emit)async
 {

   emit(state.copyWith(statePage: StatePage.loading));
   final result=await homeUseCase.execute(unit);
   result.fold((failure) => emit(state.copyWith(failure:failure,statePage: StatePage.error)),
               (homeData)
   {


         Subject subject=homeData.data.subjects.isNotEmpty?homeData.data.subjects.firstWhere((element) => element.id==state.selected):const Subject.empty();
         emit(state.copyWith(homeData: homeData, statePage: StatePage.data,subject: subject,images: homeData.data.images));

   });


 }
}
