import 'package:ddstudy_ui/internal/config/shared_prefs.dart';
import 'package:ddstudy_ui/internal/config/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/auth_service.dart';
import '../app_navigator.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _authService = AuthService();
  _ViewModel({required this.context}) {
    asyncInit();
  }

  Map<String, String>? headers;

  void asyncInit() async {}

  void _logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }

  Future _refresh() async {
    return _authService.tryGetUser();
  }

  void _openProfile() {
    AppNavigator.toProfile();
  }
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fluttergram.NET"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel._refresh,
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: viewModel._logout,
          ),
        ],
      ),
      body: Container(
        child: Column(children: []),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: viewModel._openProfile,
            ),
          ],
        ),
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const App(),
    );
  }
}
