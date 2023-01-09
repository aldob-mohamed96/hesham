part of 'maintain_bloc.dart';

abstract class MaintainEvent extends Equatable {
  const MaintainEvent();
}
class RefreshMaintain extends MaintainEvent{
  @override
  List<Object?> get props => [];

}
class FetchingMaintain extends MaintainEvent{
  @override
  List<Object?> get props => [];

}
class SendMaintain extends MaintainEvent{
  final String message;
  const SendMaintain(this.message);
  @override
  List<Object?> get props => [];

}
