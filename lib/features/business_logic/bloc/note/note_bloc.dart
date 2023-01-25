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
import '../../../domain/entities/note.dart';

part 'note_event.dart';
part 'note_state.dart';
const throttleDuration = Duration(milliseconds: AppValue.appValue100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteUseCase _contactUseCase;
  LessonRequest lessonRequest=LessonRequest(1);



  NoteBloc({required NoteUseCase contactUseCase}) :
        _contactUseCase=contactUseCase,
        super(const NoteState()) {
    on<FetchingNote>(_onFetchingMaintain,transformer:throttleDroppable(throttleDuration));
    on<RefreshNote>(_onRefreshMaintain);

  }


  void _onFetchingMaintain(FetchingNote event,Emitter<NoteState> emit)async{
    if (state.hasReachedMax) return;

    if(state.isFirst==true)
    {
      emit(state.copyWith(isLoading: true,isFailure: false));
      final result=await _contactUseCase.execute(lessonRequest);

      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (notes)
          {
            return emit(state.copyWith(isFailure: false,isLoading: false,noteOrdersData:notes.noteOrdersData ,hasReachedMax:notes.noteOrdersData.total==notes.noteOrdersData.to ,isFirst: false));

          });
    }
    else
    {
      lessonRequest.id+=1;
      final result=await _contactUseCase.execute(lessonRequest);
      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (notes)
          {
            if(notes.noteOrdersData.noteOrder.isEmpty)
            {
              emit(state.copyWith(isLoading: false,hasReachedMax: notes.noteOrdersData.total==notes.noteOrdersData.to,isFailure: false));
            }
            else
            {

              var maintains=List.of(state.noteOrdersData.noteOrder)..addAll(notes.noteOrdersData.noteOrder);
              emit(state.copyWith(isLoading: false,noteOrdersData: NoteOrdersData(
                maintains,
                notes.noteOrdersData.currentPage,
                notes.noteOrdersData.from,
                notes.noteOrdersData.lastPage,
                notes.noteOrdersData.to,
                notes.noteOrdersData.total,
              ),hasReachedMax: notes.noteOrdersData.total==notes.noteOrdersData.to ,isFailure: false));
            }



          });
    }


  }
  void _onRefreshMaintain(RefreshNote event,Emitter<NoteState> emit)async{
    {
      emit(state.copyWith(isLoading: true,isFailure: false));

      lessonRequest.id=1;
      final result=await _contactUseCase.execute(lessonRequest);
      result.fold(
              (failure) =>  emit(state.copyWith(isLoading: false,failure: failure,isFailure: true)),
              (notes)
          {
            var maintains=List.of(state.noteOrdersData.noteOrder)..clear()..addAll(notes.noteOrdersData.noteOrder);

            return emit(state.copyWith(isLoading: false,isFailure: false,
                noteOrdersData: NoteOrdersData(
                  maintains,
                  notes.noteOrdersData.currentPage,
                  notes.noteOrdersData.from,
                  notes.noteOrdersData.lastPage,
                  notes.noteOrdersData.to,
                  notes.noteOrdersData.total,
                ),hasReachedMax: notes.noteOrdersData.total==notes.noteOrdersData.to ,));
          });

    }
  }
}
