import 'dart:developer';

import 'package:hesham/features/business_logic/bloc/note/note_bloc.dart';
import 'package:hesham/features/domain/entities/note.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/features/business_logic/bloc/home/home_bloc.dart';
import 'package:hesham/features/presentation/common/widget/main_scaffold_auth.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../common/widget/full_error_screen.dart';
import '../../common/widget/loading_widget.dart';
class NoteScreen extends StatelessWidget {

  const NoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
        widget:MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) =>  instance<NoteBloc>()..add(FetchingNote())),


          ], child:NoteContent()));
  }
}

class NoteContent extends StatefulWidget {
  const NoteContent({Key? key}) : super(key: key);

  @override
  State<NoteContent> createState() => _NoteContentState();
}

class _NoteContentState extends State<NoteContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return SingleChildScrollView(

          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.appPadding20),
              child:
              state.isLoading?
              const ListViewLoading() :
              state.isFailure?
              ErrorWidget(state: state,):
              state.noteOrdersData.noteOrder.isEmpty?
              const EmptyWidget()
                  :
              ListWidget(scrollController: _scrollController,state: state,)
          ),);
      },
    );
  }
  @override
  void dispose() {
    _scrollController..removeListener(_onScroll)..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<NoteBloc>().add(FetchingNote());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height/2,
      child: FullEmptyScreen(retryActionFunction: (){
        context.read<NoteBloc>().add(RefreshNote());
      },),
    );
  }
}
class ListWidget extends StatelessWidget {
  final NoteState state;
  const ListWidget({
    Key? key,
    required this.state,
    required ScrollController scrollController,
  }) : _scrollController = scrollController, super(key: key);

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      height: context.height-AppSize.appSize20,
      child: RefreshIndicator(
        displacement: AppSize.appSize100,
        backgroundColor: ColorManager.secondColor,
        color: ColorManager.whiteColor,

        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: ()async{
          Future.delayed(Duration.zero,()=>
              context.read<NoteBloc>().add(RefreshNote()));
        },
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: ListView.builder(
            padding:const EdgeInsets.only(bottom: AppSize.appSize100,),
            physics:const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return index >= state.noteOrdersData.noteOrder.length
                  ?  const BottomLoader()
                  : OrderCardItem1(noteOrder:state.noteOrdersData.noteOrder[index],);
            },
            itemCount: state.hasReachedMax
                ? state.noteOrdersData.noteOrder.length
                : state.noteOrdersData.noteOrder.length + 1,
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

}
class ErrorWidget extends StatelessWidget {
  final NoteState state;
  const ErrorWidget({
    Key? key,
    required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FullErrorScreen(error: state.failure.message,retryActionFunction: (){
        context.read<NoteBloc>().add(RefreshNote());
      },),
    );
  }
}
class OrderCardItem extends StatelessWidget {

  final NoteOrder noteOrder;

  OrderCardItem({Key? key,required this.noteOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(child:Card(
      elevation: 10,
      child: ListTile(
        title: Text(noteOrder.title+(noteOrder.id+1).toString(),style: TextStyle(color: ColorManager.blackColor),),
        subtitle:  Text(noteOrder.description,style: TextStyle(fontSize: 10,color: Colors.grey),),

      ),
    ),);
  }

}



class OrderCardItem1 extends StatelessWidget {

  final NoteOrder noteOrder;
  const OrderCardItem1({Key? key,required this.noteOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:const EdgeInsets.symmetric(horizontal:AppPadding.appPadding10),
      child: SizedBox(
        width: context.width,
        height: AppSize.appSize100,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: AppSize.appSize6,),
                  CircleAvatar(backgroundColor:ColorManager.primaryColor,child: Text(noteOrder.id.toString(),style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: FontSize.fontSize8,fontWeight: FontWeightManager.medium,color: ColorManager.whiteColor),),radius: AppSize.appSize20,)
                  , const SizedBox(width: AppSize.appSize6,),

                  SizedBox(width: context.width/2,child:
                  ListTile(
                      title: Text(noteOrder.title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorManager.primaryColor,fontSize:FontSize.fontSize14),),
                      subtitle: Text(noteOrder.description,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey,fontSize:FontSize.fontSize10),)))

                ],),

              Padding(
                padding: const EdgeInsets.all(AppSize.appSize8),
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(noteOrder.createdAt.length>=10?noteOrder.createdAt.substring(0,10):noteOrder.createdAt,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.primaryColor),),
                            Text(noteOrder.createdAt.length>=16?noteOrder.createdAt.substring(11,16):noteOrder.createdAt,style: Theme.of(context).textTheme.bodySmall!.copyWith(color: ColorManager.primaryColor),),
                          ],
                        ),
                      ],
                    ),

                  ],),
              )

            ],
          ),
        ),
      ),
    );
  }

}