import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final InternetConnectionChecker internetConnectionChecker;
  late StreamSubscription connectivityStreamSubscription;
  InternetCubit({required this.internetConnectionChecker}) : super(InternetLoading()){
    monitorInternetConnection();
    }

  Future<bool> isConnected()async=>await internetConnectionChecker.hasConnection;
  void emitInternetConnected()=>emit(InternetConnected());
  void emitInternetDisConnected()=>emit(InternetDisConnected());

  StreamSubscription<InternetConnectionStatus> monitorInternetConnection()=> connectivityStreamSubscription=internetConnectionChecker.onStatusChange.listen((internetConnectionStatus)=>getInternetConnectionStatus);


  void getInternetConnectionStatus(InternetConnectionStatus internetConnectionStatus) {
    internetConnectionStatus.index==0?emitInternetConnected():emitInternetDisConnected();

  }

  @override
  Future<void> close()async{
    connectivityStreamSubscription.cancel();
    super.close();
  }
}
