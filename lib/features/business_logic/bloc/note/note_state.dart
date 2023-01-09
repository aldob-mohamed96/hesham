part of 'note_bloc.dart';

class NoteState extends Equatable {
  final bool isLoading;
  final bool isFirst;
  final bool isFailure;
  final Failure failure;
  final bool hasReachedMax ;
  final bool sendSuccess ;
  final NoteOrdersData noteOrdersData;


  const NoteState({

    this.hasReachedMax =false,
    this.sendSuccess =false,
    this.isFailure =false,
    this.isFirst =true,
    this.isLoading=true,

    this.failure=const Failure.empty(),
    this.noteOrdersData=const NoteOrdersData.empty(),

  });
  NoteState copyWith
      ({

    bool? isLoading,
    bool? sendSuccess,
    bool? isFailure,
    bool? isFirst,
    Failure? failure,
    NoteOrdersData? noteOrdersData,
    bool? hasReachedMax ,
  }){
    return NoteState(isLoading: isLoading??this.isLoading,
      failure: failure??this.failure,
      noteOrdersData: noteOrdersData??this.noteOrdersData,
      hasReachedMax : hasReachedMax ??this.hasReachedMax ,
      isFirst : isFirst ??this.isFirst ,
      sendSuccess : sendSuccess ??this.sendSuccess ,
      isFailure : isFailure ??this.isFailure ,
    );
  }

  @override

  List<Object?> get props =>[isLoading,sendSuccess,failure,isFailure,noteOrdersData,hasReachedMax];
}

