part of 'maintain_bloc.dart';

class MaintainState extends Equatable {
  final bool isLoading;
  final bool isFirst;
  final bool isFailure;
  final Failure failure;
  final bool hasReachedMax ;
  final bool sendSuccess ;
  final MessageData messageData;


  const MaintainState({

    this.hasReachedMax =false,
    this.sendSuccess =false,
    this.isFailure =false,
    this.isFirst =true,
    this.isLoading=true,

    this.failure=const Failure.empty(),
    this.messageData=const MessageData.empty(),

  });
  MaintainState copyWith
      ({

    bool? isLoading,
    bool? sendSuccess,
    bool? isFailure,
    bool? isFirst,
    Failure? failure,
    MessageData? messageData,
    bool? hasReachedMax ,
  }){
    return MaintainState(isLoading: isLoading??this.isLoading,
      failure: failure??this.failure,
      messageData: messageData??this.messageData,
      hasReachedMax : hasReachedMax ??this.hasReachedMax ,
      isFirst : isFirst ??this.isFirst ,
      sendSuccess : sendSuccess ??this.sendSuccess ,
      isFailure : isFailure ??this.isFailure ,
    );
  }

  @override

  List<Object?> get props =>[isLoading,sendSuccess,failure,isFailure,messageData,hasReachedMax];
}

