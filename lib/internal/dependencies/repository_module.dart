import 'package:ddstudy_ui/data/repository/api_data_repository.dart';
import 'package:ddstudy_ui/internal/dependencies/api_module.dart';

import '../../domain/repository/api_repository.dart';

class RepositoryModule {
  static ApiRepository? _apiRepository;

  static ApiRepository apiRepository() =>
      _apiRepository ??
      ApiDataRepository(
        ApiModule.auth(),
        ApiModule.api(),
      );
}
