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
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [

                    SizedBox(
                      width: 450,
                      child: SingleChildScrollView(child: LoginForm()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[


          Row(
            children: const [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
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
            _PhoneInput(),
            const Padding(padding: EdgeInsets.all(AppPadding.appPadding14)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(AppPadding.appPadding14)),
            const _LoginButton(),
          ],
        ),));
  }
}

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        const SizedBox(height: AppPadding.appPadding30),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: AppValue.appValue8,
              child: Image.asset(ImagesAssetsManage.mock2,height: AppSize.appSize200,width: context.width,),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: AppPadding.appPadding30),
      ],
    );
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
          onChanged: (username) => context
              .read<LoginBloc>()
              .add(UsernameChanged(username: username)),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.all(AppPadding.appPadding16),
              child: Icon(Icons.person),
            ),
            hintText: AppLocalizationsImpl.of(context)!
                .translate(AppStrings.username),
            errorText: state.password.invalid
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
              .read<LoginBloc>().add(PasswordChanged(password: password)),
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
            width: context.width * AppSize.appSize0_80,
            // height: AppSize.appSize40,
            child: Hero(
              tag: "button_login",
              child: ElevatedButton(
                key: const Key(AppConstants.keyLoginButtonFiled),
                onPressed: state.username.valid&&state.password.valid
                    ? () =>

              context.read<LoginBloc>().add(LoginSubmitted())

                    : null,
                child: Text(AppLocalizationsImpl.of(context)!
                    .translate(AppStrings.login)),
              ),
            ),
          );
        });
  }
}
