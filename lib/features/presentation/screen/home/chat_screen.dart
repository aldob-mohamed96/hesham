import 'dart:developer';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/features/business_logic/bloc/home/home_bloc.dart';
import 'package:hesham/features/presentation/common/widget/main_scaffold_auth.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../business_logic/bloc/maintain/maintain_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../../domain/entities/chat.dart';
import '../../common/widget/dialog_snackbar.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../common/widget/full_error_screen.dart';
import '../../common/widget/loading_widget.dart';


class MaintainScreen extends StatelessWidget {

  const MaintainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppPadding.appPadding0),
        child:MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) =>  instance<MaintainBloc>()..add(FetchingMaintain())),


          ], child:Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: (){

              Navigator.of(context).pushNamed(Routes.addContact);

            } ,child:Icon(Icons.chat, color: ColorManager.whiteColor,),
            ),
            appBar: AppBar(

              backgroundColor: ColorManager.primaryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,title: Text("الهاشمي",style: TextStyle(color: ColorManager.whiteColor),)),
            body: const MaintainContent()),));
  }
}

class MaintainContent extends StatefulWidget {
  const MaintainContent({Key? key}) : super(key: key);

  @override
  State<MaintainContent> createState() => _MaintainContentState();
}

class _MaintainContentState extends State<MaintainContent> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MaintainBloc, MaintainState>(
      builder: (context, state) {
        return SingleChildScrollView(

          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.appPadding20),
              child:
              state.isLoading?
              const ListViewLoading() :
              state.isFailure?
              ErrorWidget(state: state,):
              state.messageData.messageData.isEmpty?
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
    if (_isBottom) context.read<MaintainBloc>().add(FetchingMaintain());
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
        context.read<MaintainBloc>().add(RefreshMaintain());
      },),
    );
  }
}
class ListWidget extends StatelessWidget {
  final MaintainState state;
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
              context.read<MaintainBloc>().add(RefreshMaintain()));
        },
        child: SizedBox(
          height: context.height,
          width: context.width,
          child: ListView.builder(
            padding:const EdgeInsets.only(bottom: AppSize.appSize50,),
            physics:const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              log(state.messageData.messageData.length.toString());
              return index >= state.messageData.messageData.length
                  ?  const BottomLoader()
                  : OrderCardItem(messagesChat:state.messageData.messageData[index],);
            },
            itemCount: state.hasReachedMax
                ? state.messageData.messageData.length
                : state.messageData.messageData.length + 1,
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

}
class ErrorWidget extends StatelessWidget {
  final MaintainState state;
  const ErrorWidget({
    Key? key,
    required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FullErrorScreen(error: state.failure.message,retryActionFunction: (){
        context.read<MaintainBloc>().add(RefreshMaintain());
      },),
    );
  }
}
class OrderCardItem extends StatelessWidget {

  final MessagesChat messagesChat;

  OrderCardItem({Key? key,required this.messagesChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(child:ExpansionTile(
      title: Text(messagesChat.message,style: TextStyle(color: ColorManager.blackColor),),
      subtitle:  Text(messagesChat.createdAt,style: TextStyle(fontSize: 10,color: ColorManager.grayColor300),),
      children: messagesChat.replies.map((e) =>ListTile(title: Text(e.content,style: TextStyle(color: ColorManager.primaryColor,fontSize: 12))),).toList(),
      onExpansionChanged: (bool expanded) {

      },
    ),);
  }

  }

class ListReplay extends StatelessWidget {
  final MessagesChat messagesChat;
  const ListReplay({Key? key,required this.messagesChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {

      return SizedBox(
        width: context.width,
        height: context.height,
        child:
        ListView.builder(

            itemCount: messagesChat.replies.length,
            itemBuilder: (context,index){
          return  BubbleSpecialThree(
            isSender: true,
            text: messagesChat.replies[index].content,
            color:ColorManager.primaryColorLight,
            tail: false,

            textStyle:const TextStyle(
                color: Colors.white,
                fontSize: 12
            ),
          );
        }),
      );
  }
}


