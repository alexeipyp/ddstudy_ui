import 'package:ddstudy_ui/data/services/auth_service.dart';
import 'package:ddstudy_ui/ui/navigation/global_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoaderViewModel extends ChangeNotifier {
  final _authService = AuthService();

  BuildContext context;
  LoaderViewModel({required this.context}) {
    _asyncInit();
  }
  Future _asyncInit() async {
    if (await _authService.checkAuth()) {
      GlobalNavigator.toHome();
    } else {
      GlobalNavigator.toAuth();
    }
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<LoaderViewModel>(
        create: (context) => LoaderViewModel(context: context),
        lazy: false,
        child: const LoaderWidget(),
      );
}
