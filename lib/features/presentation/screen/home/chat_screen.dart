import 'dart:developer';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/date_chips/date_chip.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:hesham/core/enum/enums.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/features/business_logic/bloc/home/home_bloc.dart';
import 'package:hesham/features/presentation/common/widget/main_scaffold_auth.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/resources/app_constant.dart';
import '../../../../core/resources/assets_manager.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/style_manager.dart';
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
    return HomeScaffold(
        widget:
           BlocProvider(create: (_) =>  instance<MaintainBloc>()..add(FetchingMaintain()),
           child:const MaintainContent()));
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
    return  BlocConsumer<MaintainBloc, MaintainState>(
      listener: (context,state){
        if(state.isLoading==false&&state.isFailure==false)
        {

            instance<ShowMessage>().dismissDialogValue(context);


        }

        if(state.isFailure==true)
        {


          if (state.failure == AppConstants.maintainFailure) {
            Navigator.pushReplacementNamed(context, Routes.maintainAppRoot);
          }
          else if (state.failure == AppConstants.updateFailure) {

            Navigator.pushReplacementNamed(context, Routes.maintainAppRoot);
          }
          else if (state.failure == AppConstants.unAuthenticatedFailure) {
            Navigator.pushReplacementNamed(context, Routes.loginRoot);
          }
          else
          {
            instance<ShowMessage>().showErrorPopUpOk(context, state.failure.message);
          }


        }

        if(state.isLoading)
        {
          instance<ShowMessage>().showModal(context);
        }

      },
      builder: (context, state) {
       return ListWidget(scrollController: _scrollController,state: state,);
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
      height: context.height*AppSize.appSize0_85,
      child: RefreshIndicator(
        displacement: AppSize.appSize100,
        backgroundColor: ColorManager.secondColor,
        color: ColorManager.whiteColor,

        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: ()async{
          Future.delayed(Duration.zero,()=>
              context.read<MaintainBloc>().add(RefreshMaintain()));
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              state.messages.isNotEmpty?
              SizedBox(
                height: (context.height*AppSize.appSize0_85)-100,
                width: context.width,
                child: ListView.builder(


                  physics:const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {

                    return index >= state.messages.length
                        ?  const BottomLoader()
                        : OrderCardItem(messagesChat:state.messages[index],);
                  },
                  itemCount: state.hasReachedMax
                      ? state.messages.length
                      : state.messages.length + 1,
                  controller: _scrollController,
                ),
              ):
              SizedBox(
                height: (context.height*AppSize.appSize0_85)-100,
                width: context.width,
                child:Column(
                  children: [
                    SizedBox(
                      child: Lottie.asset(JsonAssetManager.lottieEmptyHome),),
                    Text(AppLocalizationsImpl.of(context)!.translate(AppStrings.emptyContent),textAlign: TextAlign.center,style:
                    getRegularStyle(color: ColorManager.whiteColor,fontSize: FontSize.fontSize16,),)
                  ],
                ),
              ),

              SizedBox(
                height: AppSize.appSize100,

                child: MessageBar(
                  messageBarColor: Colors.white,
                  sendButtonColor: Colors.blue,
                  onSend: (value) {
                    context.read<MaintainBloc>().add(SendMaintain(value));

                  },

                ),
              ),

            ],
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

  final MessagesItem messagesChat;

  const OrderCardItem({Key? key,required this.messagesChat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date=DateTime.parse(messagesChat.createdAt);
    return Column(
      children: [
        DateChip(

          date:date,
          color: Colors.grey,

        ),
        BubbleSpecialThree(

          isSender:  messagesChat.isSender,
          text: messagesChat.message,
          color:ColorManager.whiteColor,
          tail: true,

          textStyle:const TextStyle(
              color: Colors.black,
              fontSize: 12
          ),
        ),
      ],
    ) ;
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


