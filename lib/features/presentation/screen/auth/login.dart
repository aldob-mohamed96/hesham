import 'dart:developer';

import 'package:hesham/core/resources/app_constant.dart';
import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/assets_manager.dart';
import 'package:hesham/core/resources/color_manager.dart';
import 'package:hesham/core/resources/strings_manager.dart';
import 'package:hesham/core/resources/values_manager.dart';
import 'package:hesham/features/business_logic/bloc/auth/auth/authentication_bloc.dart';
import 'package:hesham/features/business_logic/bloc/auth/login/login_bloc.dart';
import 'package:hesham/features/presentation/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:formz/formz.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enum/enums.dart';
import '../../../../core/resources/responsive.dart';
import '../../../business_logic/cubit/langauge/langauge_cubit.dart';
import '../../../business_logic/cubit/langauge/localization/app_localizations.dart';
import '../../common/widget/dialog_snackbar.dart';
import '../../common/widget/icon_langauge.dart';
import '../../common/widget/main_scaffold_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      widget: _Content(),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return instance<LoginBloc>();
      },
      child: LoginForm(),
    );
  }
}


class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            instance<ShowMessage>()
                .showErrorPopUpOk(context, state.failure.message);
          }
          if (state.status.isSubmissionInProgress) {
            instance<ShowMessage>().showModal(context);
          }
          if (state.status.isSubmissionSuccess) {
            context.read<AuthenticationBloc>().user=state.user;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, Routes.homeRoot);
            });
          }
        },
        child:SingleChildScrollView(child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSize.appSize80,width:context.width*AppSize.appSize0_85,
            
            child: Image.asset(ImagesAssetsManage.logoImages),
            ),
            const  SizedBox(height: AppSize.appSize30,),
            SizedBox(width: context.width*AppSize.appSize0_85,child: _PhoneInput()),
            const Padding(padding: EdgeInsets.all(AppPadding.appPadding14)),
            SizedBox(width: context.width*AppSize.appSize0_85,child: _PasswordInput()),
            const Padding(padding: EdgeInsets.all(AppPadding.appPadding14)),
            const _LoginButton(),
          ],
        ),));
  }
}


class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          keyboardType: TextInputType.text,
          onChanged: (username) => context.read<LoginBloc>().add(UsernameChanged(username: username.toString().trimLeft().trimRight())),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(AppPadding.appPadding16),
              child: Icon(Icons.person),
            ),
            hintText: AppLocalizationsImpl.of(context)!
                .translate(AppStrings.username),
            errorText: state.username.invalid
                ? AppLocalizationsImpl.of(context)!
                    .translate(state.username.error.getErrorInput().toString())
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password || previous.isVisible != current.isVisible,
      builder: (context, state) {
        return TextField(
          obscureText: state.isVisible,
          keyboardType: TextInputType.text,

          onChanged: (password) => context
              .read<LoginBloc>().add(PasswordChanged(password: password.toString().trimLeft().trimRight())),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(AppPadding.appPadding16),
              child: Icon(Icons.lock),
            ),
            suffixIcon: IconButton(
              onPressed: () =>
                  context.read<LoginBloc>().add(const VisiblePasswordChanged()),
              icon: state.isVisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
            hintText: AppLocalizationsImpl.of(context)!
                .translate(AppStrings.password),
            errorText: state.password.invalid
                ? AppLocalizationsImpl.of(context)!
                    .translate(state.password.error.getErrorInput().toString())
                : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return SizedBox(
            width: context.width * AppSize.appSize0_85,
             height: AppSize.appSize50,
             child: RawMaterialButton(
shape:
    RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0), side:const BorderSide(color: Colors.transparent)),
                padding:const EdgeInsets.all(10.0),
                disabledElevation: 1,
                fillColor:  state.status.isValidated ? ColorManager.whiteColor :  Colors.grey,
                onPressed: state.status.isValidated?()=> context.read<LoginBloc>().add(LoginSubmitted()):null,
                child:!state.status.isValidated?
                    Icon(Icons.lock,color: ColorManager.primaryColor,)
                    :
                Text(AppLocalizationsImpl.of(context)!
                    .translate(AppStrings.login),style: TextStyle(color:  state.status.isValidated ?ColorManager.primaryColor:Colors.grey,fontFamily: 'Montserrat',)),

              )
          );
        });
  }
}
