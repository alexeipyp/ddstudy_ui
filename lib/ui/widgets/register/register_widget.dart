import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_view_model.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<RegisterViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluttergram.NET"),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: viewModel.nameTec,
                    decoration:
                        const InputDecoration(hintText: "Enter Your Name"),
                  ),
                  TextFormField(
                    controller: viewModel.emailTec,
                    decoration:
                        const InputDecoration(hintText: "Enter Your E-mail"),
                  ),
                  TextFormField(
                    controller: viewModel.passwTec,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: "Enter Password"),
                  ),
                  TextFormField(
                    controller: viewModel.retryPasswTec,
                    obscureText: true,
                    decoration:
                        const InputDecoration(hintText: "Retry Password"),
                  ),
                  TextFormField(
                    controller: viewModel.birthDateTec,
                    keyboardType: TextInputType.datetime,
                    decoration:
                        const InputDecoration(hintText: "Enter birth date"),
                  ),
                  ElevatedButton(
                    onPressed:
                        viewModel.checkFields() ? viewModel.register : null,
                    child: const Text("Register"),
                  ),
                  if (viewModel.state.isLoading)
                    const CircularProgressIndicator()
                  else if (viewModel.state.messageText != null)
                    Center(
                      child: Text(viewModel.state.messageText!),
                    ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                      padding: const EdgeInsets.all(20.0),
                    ),
                    onPressed: viewModel.returnToAuth,
                    child: const Text('Already have an account? Log in'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<RegisterViewModel>(
        create: (context) => RegisterViewModel(context: context),
        child: const RegisterWidget(),
      );
}
