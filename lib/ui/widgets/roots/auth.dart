import 'package:ddstudy_ui/data/services/auth_service.dart';
import 'package:ddstudy_ui/ui/navigation/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/exceptions.dart';

class AuthViewModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;
  const AuthViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  AuthViewModelState copyWith({
    String? login,
    String? password,
    bool? isLoading,
    String? errorText,
  }) {
    return AuthViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class AuthViewModel extends ChangeNotifier {
  var loginTec = TextEditingController();
  var passwTec = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  AuthViewModel({required this.context}) {
    loginTec.addListener(() {
      state = state.copyWith(login: loginTec.text);
    });
    passwTec.addListener(() {
      state = state.copyWith(password: passwTec.text);
    });
  }

  var _state = const AuthViewModelState();

  set state(AuthViewModelState val) {
    _state = val;
    notifyListeners();
  }

  AuthViewModelState get state => _state;

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    FocusScope.of(context).requestFocus(FocusNode());
    state = state.copyWith(
      isLoading: true,
    );

    try {
      await _authService
          .auth(state.login, state.password)
          .then((value) => GlobalNavigator.toLoader());
    } on NoNetworkException {
      state = state.copyWith(errorText: "нет сети");
    } on WrongCredentialsException {
      state = state.copyWith(errorText: "неправильные логин или пароль");
    } on ServerException {
      state = state.copyWith(errorText: "ошибка на сервере");
    }
    state = state.copyWith(isLoading: false);
  }

  void _toRegistration() {
    GlobalNavigator.toRegistration();
  }
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluttergram.NET"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: viewModel.loginTec,
                    decoration: const InputDecoration(hintText: "Enter Login"),
                  ),
                  TextField(
                    controller: viewModel.passwTec,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: "Enter Password"),
                  ),
                  ElevatedButton(
                    onPressed: viewModel.checkFields() ? viewModel.login : null,
                    child: const Text("Login"),
                  ),
                  if (viewModel.state.isLoading)
                    const CircularProgressIndicator()
                  else if (viewModel.state.errorText != null)
                    Text(viewModel.state.errorText!),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    onPressed: viewModel._toRegistration,
                    child: const Text('New to Fluttergram.NET? Create Profile'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<AuthViewModel>(
        create: (context) => AuthViewModel(context: context),
        child: const Auth(),
      );
}
