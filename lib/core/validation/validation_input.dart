import 'dart:io';

import 'package:hesham/core/extension/extension.dart';
import 'package:hesham/core/resources/app_constant.dart';
import 'package:dartz/dartz.dart';

import '../enum/enums.dart';

abstract class Validation {
  DataSourceValidationInput? validateUserName(String? username);
  DataSourceValidationInput? validatePassword(String? password);
  DataSourceValidationInput? validateConfirmPassword(List<String>? list);

  DataSourceValidationInput? validateName(String? name);
  DataSourceValidationInput? validateAddress(String? address);
  DataSourceValidationInput? validateImage(File? imagePath);
  DataSourceValidationInput? validateBirthDate(String? birthDate);
  DataSourceValidationInput? validateGender(String? gender);
  DataSourceValidationInput? validateEmail(String? email);
  DataSourceValidationInput? validateCounter(String? counter);
  DataSourceValidationInput? validateVerificationCode(String? code);
}

mixin ValidationImpl implements Validation {

  @override
  DataSourceValidationInput? validateConfirmPassword(List<String>? list) {

      if(list==null||list.isEmpty)
        {
          return DataSourceValidationInput.notIdenticalPassword;
        }
      if(list.length==2)
        {
          if(list[0]!=list[1])
            {
              return DataSourceValidationInput.notIdenticalPassword;
            }
        }


      return null;

  }
  @override
  DataSourceValidationInput? validateGender(String? gender) {
    return gender==null||(gender is  !Gender)
        ? DataSourceValidationInput.unknown
        : null;
  }
  @override
  DataSourceValidationInput? validateName(String? name) {
    if (name == null || name.length < 5) {
      return DataSourceValidationInput.length;
    }
    return null;
  }  @override
  DataSourceValidationInput? validateCounter(String? counter) {

    if (counter == null||counter.isEmpty) {
      return DataSourceValidationInput.empty;
    }
   else if(int.tryParse(counter)==null)
      {
        return DataSourceValidationInput.inValidFormat;
      }
   else if(counter.length>10||counter.length<2)
      {
        return DataSourceValidationInput.length;
      }

    return null;
  }
  @override
  DataSourceValidationInput? validateAddress(String? address) {
    if (address == null || address.length < 5) {
      return DataSourceValidationInput.length;
    }
    return null;
  }
  @override
  DataSourceValidationInput? validateImage(File? imagePath) {
    return null;
  }
  @override
  DataSourceValidationInput? validateBirthDate(String? birthDate) {
    if (birthDate == null || birthDate is !DateTime) {
      return DataSourceValidationInput.unknown;
    }
    return null;
  }
  @override
  DataSourceValidationInput? validateEmail(String? email) {
   final exp= RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if(email==null||email.isEmpty)
      {
        return DataSourceValidationInput.empty;
      }
    if(!exp.hasMatch(email))
      {
        return DataSourceValidationInput.notEmail;
      }
    return null;
  }
  @override
  DataSourceValidationInput? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return DataSourceValidationInput.empty;
    }
    if (password.length < 5) {
      return DataSourceValidationInput.shortPassword;
    }
    if (password.length > 25) {
      return DataSourceValidationInput.veryLong;
    }
    return null;
  }
  @override
  DataSourceValidationInput? validateVerificationCode(String? code) {
    if (code == null ||
        code.isEmpty ||
        code.length != AppConstants.verificationCodeLength) {
      return DataSourceValidationInput.valid;
    }
    return null;
  }
  @override
  DataSourceValidationInput? validateUserName(String? username) {

    if (username == null || username.length<4||username.length>25) {
      return DataSourceValidationInput.length;
    }
    return null;
  }
}
