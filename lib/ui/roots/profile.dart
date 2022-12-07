import 'package:auto_size_text/auto_size_text.dart';
import 'package:ddstudy_ui/data/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/services/auth_service.dart';
import '../../domain/models/user/user_activity.dart';
import '../../domain/models/user/user_profile.dart';
import '../../internal/config/app_config.dart';
import '../../internal/config/shared_prefs.dart';
import '../../internal/config/token_storage.dart';
import '../app_navigator.dart';

class _ViewModel extends ChangeNotifier {
  BuildContext context;
  final _authService = AuthService();
  final _apiService = ApiService();
  _ViewModel({required this.context}) {
    asyncInit();
  }

  UserProfile? _user;
  UserProfile? get user => _user;
  set user(UserProfile? val) {
    _user = val;
    notifyListeners();
  }

  UserActivity? _userActivity;
  UserActivity? get userActivity => _userActivity;
  set userActivity(UserActivity? val) {
    _userActivity = val;
    notifyListeners();
  }

  Map<String, String>? headers;

  void asyncInit() async {
    var token = await TokenStorage.getAccessToken();
    headers = {"Authorization": "Bearer $token"};
    user = await SharedPrefs.getStoredUser();
    userActivity = await _apiService.getUserActivity();
  }

  void _logout() async {
    await _authService.logout().then((value) => AppNavigator.toLoader());
  }

  Future _refresh() async {
    return _authService.tryGetUser();
  }
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

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
      body: Column(
        children: [
          // Avatar Image
          Flexible(
            flex: 8,
            child: Container(
              margin: const EdgeInsets.all(10),
              constraints: const BoxConstraints.expand(),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 6,
                ),
                shape: BoxShape.circle,
                image: (viewModel.user != null && viewModel.headers != null)
                    ? DecorationImage(
                        image: NetworkImage(
                            "$baseUrl${viewModel.user!.avatarLink}",
                            headers: viewModel.headers),
                        fit: BoxFit.fitHeight,
                      )
                    : null,
              ),
            ),
          ),
          // Full Name
          Flexible(
            flex: 2,
            child: _TextContainer(
              textString: viewModel.user == null ? "Hi" : viewModel.user!.name,
              styleFromAppTheme: Theme.of(context).textTheme.headline4,
            ),
          ),
          // Some User Data
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _TextContainer(
                  textString:
                      "Email: ${viewModel.user == null ? "-" : viewModel.user!.email}",
                ),
                _TextContainer(
                  textString:
                      "Birth at: ${viewModel.user == null ? "-" : "${viewModel.user!.getParsedBirthDate().day}."
                          "${viewModel.user!.getParsedBirthDate().month}."
                          "${viewModel.user!.getParsedBirthDate().year}"}",
                ),
              ],
            ),
          ),
          // Some User Activity
          Flexible(
            flex: 2,
            child: _UserActivity(
              postsAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.postsAmount,
              followersAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.followersAmount,
              followingAmount: viewModel.userActivity == null
                  ? null
                  : viewModel.userActivity!.followingAmount,
              styleFromAppTheme: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static create() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ViewModel(context: context),
      child: const Profile(),
    );
  }
}

class _TextContainer extends StatelessWidget {
  const _TextContainer({
    required this.textString,
    this.styleFromAppTheme,
  });

  final String textString;
  final TextStyle? styleFromAppTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: AutoSizeText(
          textString,
          maxLines: 1,
          style: styleFromAppTheme?.merge(const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}

class _UserActivity extends StatelessWidget {
  const _UserActivity({
    this.postsAmount,
    this.followersAmount,
    this.followingAmount,
    this.styleFromAppTheme,
  });

  final int? postsAmount;
  final int? followersAmount;
  final int? followingAmount;
  final TextStyle? styleFromAppTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: Row(
        children: [
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Posts",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${postsAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Followers",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${followersAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
          Column(
            children: [
              AutoSizeText(
                "Following",
                style: styleFromAppTheme,
              ),
              AutoSizeText(
                "${followingAmount ?? "-"}",
                style: styleFromAppTheme,
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
