import 'package:equatable/equatable.dart';

import '../../../core/resources/app_constant.dart';

class NoteOrder extends Equatable{
  final int id;
  final String title;
  final String description;
  final String createdAt;


  const NoteOrder(
  this.id,
   this.title,
   this.description,
   this.createdAt

      );
  @override
  List<Object?> get props => [
    id,
    title,
    description,
    createdAt

  ];

}
class NoteOrdersData extends Equatable{
  final List<NoteOrder> noteOrder;
  final int currentPage;
  final int from;
  final int lastPage;
  final int total;
  final int to;
  const NoteOrdersData(this.noteOrder,this.currentPage,this.from,this.lastPage,this.to,this.total);
  const NoteOrdersData.empty():this(const <NoteOrder>[],AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,AppConstants.defaultEmptyInteger,);
  @override
  List<Object?> get props => [noteOrder,currentPage,from,lastPage,to,total];

}
class NotePaginationOrders extends Equatable{
  final NoteOrdersData noteOrdersData;
  const NotePaginationOrders(this.noteOrdersData);
  const NotePaginationOrders.empty():this(const NoteOrdersData.empty());
  @override

  List<Object?> get props => [noteOrdersData];

}