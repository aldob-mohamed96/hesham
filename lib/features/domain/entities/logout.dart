import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:equatable/equatable.dart';


class Logout extends Equatable{
  final String logoutTime;
  const Logout(this.logoutTime);
  const Logout.empty():this(AppConstants.defaultEmptyString);
  @override
  List<Object?> get props => [logoutTime];

}
class LogoutData extends Equatable{
  final Logout logout;
  const LogoutData(this.logout);
 const LogoutData.empty():this(const Logout.empty());
  @override
  List<Object?> get props => [logout];

}
class DeletedAccount extends Equatable{
  final bool deleted;
  const DeletedAccount(this.deleted);
  @override
  List<Object?> get props => [deleted];

}