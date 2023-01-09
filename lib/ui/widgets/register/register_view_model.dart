import 'package:flutter/material.dart';

import '../../../data/services/auth_service.dart';
import '../../../utils/exceptions.dart';
import '../../navigation/global_navigator.dart';

class RegisterViewModelState {
  final String? name;
  final String? email;
  final String? password;
  final String? retryPassword;
  final DateTime? birthDate;
  final bool isLoading;
  final String? messageText;
  const RegisterViewModelState({
    this.name,
    this.email,
    this.password,
    this.retryPassword,
    this.birthDate,
    this.isLoading = false,
    this.messageText,
  });

  RegisterViewModelState copyWith({
    String? name,
    String? email,
    String? password,
    String? retryPassword,
    DateTime? birthDate,
    bool? isLoading,
    String? messageText,
  }) {
    return RegisterViewModelState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      retryPassword: retryPassword ?? this.retryPassword,
      birthDate: birthDate ?? this.birthDate,
      isLoading: isLoading ?? this.isLoading,
      messageText: messageText ?? this.messageText,
    );
  }
}

class RegisterViewModel extends ChangeNotifier {
  var nameTec = TextEditingController();
  var emailTec = TextEditingController();
  var passwTec = TextEditingController();
  var retryPasswTec = TextEditingController();
  var birthDateTec = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  RegisterViewModel({required this.context}) {
    nameTec.addListener(() {
      state = state.copyWith(name: nameTec.text);
    });
    emailTec.addListener(() {
      state = state.copyWith(email: emailTec.text);
    });
    passwTec.addListener(() {
      state = state.copyWith(password: passwTec.text);
    });
    retryPasswTec.addListener(() {
      state = state.copyWith(retryPassword: retryPasswTec.text);
    });
    birthDateTec.addListener(() {
      state = state.copyWith(birthDate: DateTime.tryParse(birthDateTec.text));
    });
  }

  var _state = const RegisterViewModelState();

  set state(RegisterViewModelState val) {
    _state = val;
    notifyListeners();
  }

  RegisterViewModelState get state => _state;

  bool checkFields() {
    return (state.name?.isNotEmpty ?? false) &&
        (state.email?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false) &&
        (state.retryPassword?.isNotEmpty ?? false) &&
        (state.birthDate != null) &&
        (state.password == state.retryPassword);
  }

  void register() async {
    state = state.copyWith(
      isLoading: true,
    );

    try {
      await _authService.register(
        state.name,
        state.email,
        state.password,
        state.retryPassword,
        state.birthDate,
      );
      state = state.copyWith(messageText: "регистрация успешно завершена");
    } on NoNetworkException {
      state = state.copyWith(messageText: "нет сети");
    } on EmailAlreadyBusyException {
      state = state.copyWith(
          messageText: "аккаунт с указанным email уже существует");
    } on ServerException {
      state = state.copyWith(messageText: "ошибка на сервере");
    }
    state = state.copyWith(isLoading: false);
  }

  void returnToAuth() {
    GlobalNavigator.back();
  }
}
