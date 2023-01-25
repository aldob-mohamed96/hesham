import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/domain/entities/chat.dart';
import 'package:hesham/features/domain/usecases/app_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../data/network/requests_entity/request_entity.dart';
import '../../../domain/entities/failure.dart';

part 'maintain_event.dart';
part 'maintain_state.dart';
const throttleDuration = Duration(milliseconds: AppValue.appValue100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
class MaintainBloc extends Bloc<MaintainEvent, MaintainState> {
  final ContactUseCase _contactUseCase;
  final AddContactUseCase _addContactUseCase;
  LessonRequest lessonRequest=LessonRequest(1);



  MaintainBloc({required ContactUseCase contactUseCase,required AddContactUseCase addContactUseCase}) :
        _contactUseCase=contactUseCase,
        _addContactUseCase=addContactUseCase,
        super(const MaintainState()) {
    on<FetchingMaintain>(_onFetchingMaintain,transformer:throttleDroppable(throttleDuration));
    on<RefreshMaintain>(_onRefreshMaintain);
    on<SendMaintain>(_onSendMaintain);

  }


  void _onSendMaintain(SendMaintain event,Emitter<MaintainState> emit)async{
    emit(state.copyWith(isLoading: true,isFailure: false));
    final result=await _addContactUseCase.execute(AddContactRequest(event.message));
    result.fold(
            (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
            (driverOrderDataResponse)
        {
          final list=List.of(state.messages)..add(MessagesItem(state.messages.length, event.message, DateTime.now().toString(), false));
          return emit(state.copyWith(isLoading: false,sendSuccess: true,messages: list));

        });

  }
  void _onFetchingMaintain(FetchingMaintain event,Emitter<MaintainState> emit)async{
    if (state.hasReachedMax) return;

    if(state.isFirst==true)
    {
      emit(state.copyWith(isLoading: true,isFailure: false));
      final result=await _contactUseCase.execute(lessonRequest);

      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (driverOrderDataResponse)
          {
            List<MessagesItem> items=messages( driverOrderDataResponse.data.messageData);

            return emit(state.copyWith(isLoading: false,isFailure: false,messages: items,messageData: driverOrderDataResponse.data,hasReachedMax:driverOrderDataResponse.data.total==driverOrderDataResponse.data.to ,isFirst: false));

          });
    }
    else
    {
      lessonRequest.id+=1;
      final result=await _contactUseCase.execute(lessonRequest);
      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (driverOrderDataResponse)
          {
            if(driverOrderDataResponse.data.messageData.isEmpty)
            {
              emit(state.copyWith(isLoading: false,hasReachedMax: driverOrderDataResponse.data.total==driverOrderDataResponse.data.to,isFailure: false));
            }
            else
            {

              var maintains=List.of(state.messageData.messageData)..addAll(driverOrderDataResponse.data.messageData);
              List<MessagesItem> items=messages(maintains);
              emit(state.copyWith(
                messages: items,
                isFailure: false,
                isLoading: false,messageData: MessageData(
                maintains,
                driverOrderDataResponse.data.currentPage,
                driverOrderDataResponse.data.from,
                driverOrderDataResponse.data.lastPage,
                driverOrderDataResponse.data.to,
                driverOrderDataResponse.data.total,
              ),hasReachedMax: driverOrderDataResponse.data.total==driverOrderDataResponse.data.to ,));
            }



          });
    }


  }
  void _onRefreshMaintain(RefreshMaintain event,Emitter<MaintainState> emit)async{
    {
      emit(state.copyWith(isLoading: true,isFailure: false));

      lessonRequest.id=1;
      final result=await _contactUseCase.execute(lessonRequest);
      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (driverOrderDataResponse)
          {
            var maintains=List.of(state.messageData.messageData)..clear()..addAll(driverOrderDataResponse.data.messageData);
            List<MessagesItem> items=messages(maintains);
            return emit(state.copyWith(
                messages: items,
                isLoading: false,
                isFailure: false,
                messageData: MessageData(maintains, driverOrderDataResponse.data.currentPage,
                    driverOrderDataResponse.data.from,
                    driverOrderDataResponse.data.lastPage,
                    driverOrderDataResponse.data.to,
                    driverOrderDataResponse.data.total),hasReachedMax: driverOrderDataResponse.data.total==driverOrderDataResponse.data.to,isFirst: true));

          });

    }
  }
}

List<MessagesItem> messages(List<MessagesChat> data)
{
  List<MessagesItem> items=<MessagesItem>[];

  for(int i=0;i<data.length;i++)
    {
      items.add(MessagesItem(data[i].id, data[i].message,data[i].createdAt, false,));

      for(int o=0;o<data[i].replies.length;o++)
        {
          items.add(MessagesItem(data[i].replies[o].id, data[i].replies[o].content,data[i].replies[o].createdAt, true,));
         }
    }


  return items;
}