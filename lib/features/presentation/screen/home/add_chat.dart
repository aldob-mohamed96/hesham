
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
import '../../../business_logic/bloc/maintain/maintain_bloc.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../../domain/entities/chat.dart';
import '../../common/widget/dialog_snackbar.dart';
import '../../common/widget/full_empty_screen.dart';
import '../../common/widget/full_error_screen.dart';
import '../../common/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';

class AddMaintainScreen extends StatelessWidget {

  AddMaintainScreen({Key? key}) : super(key: key);
  TextEditingController textEditingController= TextEditingController();
  @override
  Widget build(BuildContext context) {
                return HomeScaffold(
                widget: BlocProvider(create: (_) =>  instance<MaintainBloc>(), child:
                BlocListener<MaintainBloc, MaintainState>(
                listener: (context, state) {
                  if(state.isLoading==false)
                  {
                    instance<ShowMessage>().dismissDialogValue(context);
                  }

                  if(state.isFailure)
                  {
                    instance<ShowMessage>().showErrorPopUpOk(context, state.failure.message);
                  }

                  if(state.isLoading)
                  {
                    instance<ShowMessage>().showModal(context);
                  }
                  if(state.sendSuccess)
                    {
                     // instance<ShowMessage>().showSnakeBar(context, AppStrings.success);
                      Navigator.of(context,rootNavigator: true).pushNamed(Routes.contact);
                    }
                },
                child: SingleChildScrollView(
                  child: Column(

                    children: [


                      SizedBox(
                          width: context.width ,
                       //   height: context.height * .25,
                          child: TextField(
                            controller: textEditingController,
                            maxLines: 10,
                            maxLength: 250,
                            decoration:const  InputDecoration(
                              enabledBorder:  OutlineInputBorder(

                                borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                              ),
                              border:  OutlineInputBorder(),
                              labelStyle:  TextStyle(color: Colors.white),

                            ),
                          )),

                      BlocBuilder<MaintainBloc, MaintainState>(
                         builder: (context, state) {
                         return Container(
                        height: context.height * .1,
                        width: context.width * .8,
                        padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: ElevatedButton(

                            child: Text(AppLocalizationsImpl.of(context)!.translate('send')),
                            onPressed: () {
                              if(textEditingController.text.isNotEmpty)
                              {
                                context.read<MaintainBloc>().add(SendMaintain(textEditingController.text));

                              }
                            }),
                      );
  },
)
                    ],
                  ),
                ),
              ),
            ));
  }
}