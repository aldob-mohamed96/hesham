import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';

import '../../../../../core/enum/enums.dart';
import '../../../../../core/validation/validation_input.dart';
import '../resources/app_constant.dart';

export 'input_model.dart';

class Username extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const Username.pure() : super.pure(AppConstants.defaultEmptyString);
  const Username.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateUserName(value!);
  }
}
class ImageInput extends FormzInput<File?, DataSourceValidationInput> with ValidationImpl {

  const ImageInput.pure()
      : super.pure(null);
  const ImageInput.dirty([value])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(File? value) {
    return null;
  }
}
class Password extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const Password.pure() : super.pure(AppConstants.defaultEmptyString);
  const Password.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validatePassword(value!);
  }
}
class BirthDateInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const BirthDateInput.pure() : super.pure(AppConstants.defaultEmptyString);
  const BirthDateInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateBirthDate(value!);
  }
}
class GenderInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const GenderInput.pure() : super.pure(AppConstants.defaultEmptyString);
  const GenderInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateGender(value!);
  }
}
class ConfirmPassword extends FormzInput<List<String>, DataSourceValidationInput> with ValidationImpl {
  const ConfirmPassword.pure() : super.pure(const[AppConstants.defaultEmptyString,AppConstants.defaultEmptyString]);
  const ConfirmPassword.dirty([List<String> value = const[AppConstants.defaultEmptyString,AppConstants.defaultEmptyString]])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(List<String>? value) {
    return validateConfirmPassword(value!);
  }
}
class CodeVerificationInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const CodeVerificationInput.pure()
      : super.pure(AppConstants.defaultEmptyString);
  const CodeVerificationInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateVerificationCode(value!);
  }
}
class NameInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const NameInput.pure()
      : super.pure(AppConstants.defaultEmptyString);
  const NameInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateName(value!);
  }
}

class CounterInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const CounterInput.pure()
      : super.pure(AppConstants.defaultEmptyString);
  const CounterInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateCounter(value!);
  }
}
class AddressInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const AddressInput.pure()
      : super.pure(AppConstants.defaultEmptyString);
  const AddressInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateAddress(value!);
  }
}
class EmailInput extends FormzInput<String, DataSourceValidationInput> with ValidationImpl {
  const EmailInput.pure()
      : super.pure(AppConstants.defaultEmptyString);
  const EmailInput.dirty([value = AppConstants.defaultEmptyString])
      : super.dirty(value);

  @override
  DataSourceValidationInput? validator(String? value) {
    return validateEmail(value!);
  }
}