
import 'package:equatable/equatable.dart';

import '../../../core/resources/app_constant.dart';





class ReplyMessagesChat extends Equatable{
  final int id;
  final String content;
  final String createdAt;

  @override
  List<Object?> get props => [
    id,
    content,createdAt
  ];
  const ReplyMessagesChat.empty():this(
    AppConstants.defaultEmptyInteger,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
  );
  const ReplyMessagesChat(this.id, this.content, this.createdAt);
}
class MessagesChat extends Equatable{
  final int id;
  final String message;
  final String createdAt;
  final List<ReplyMessagesChat> replies;

  @override
  List<Object?> get props => [
    id,
    message,replies,createdAt
  ];
  const MessagesChat.empty():this(
    AppConstants.defaultEmptyInteger,
    AppConstants.defaultEmptyString,
    const <ReplyMessagesChat>[],
    AppConstants.defaultEmptyString,

  );
  const MessagesChat(this.id, this.message, this.replies,this.createdAt);
}
class MessageData extends Equatable{
  final List<MessagesChat> messageData;
  final int currentPage;
  final int from;
  final int lastPage;
  final int total;
  final int to;
  const MessageData(this.messageData,this.currentPage,this.from,this.lastPage,this.to,this.total);
  const MessageData.empty():this(const <MessagesChat>[],AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger);
  @override
  List<Object?> get props => [MessageData,currentPage,from,lastPage,to,total];


}

class MessageDataPagaination extends Equatable{
  final MessageData data;
  const MessageDataPagaination(this.data);
  const MessageDataPagaination.empty():this(const MessageData.empty());
  @override
  List<Object?> get props => [data];


}



class MessagesItem extends Equatable{
  final int id;
  final String message;
  final String createdAt;
  final bool isSender;

  @override
  List<Object?> get props => [
    id,
    message,isSender,createdAt
  ];
  const MessagesItem.empty():this(
    AppConstants.defaultEmptyInteger,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyString,
    AppConstants.defaultEmptyBool,


  );
  const MessagesItem(this.id, this.message,this.createdAt,this.isSender);
}