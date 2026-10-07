// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:task/data/database/app_database.dart' as _i335;
import 'package:task/data/repositories/drift_formats_repository.dart' as _i450;
import 'package:task/di/database_module.dart' as _i1009;
import 'package:task/domain/repositories/formats_repository.dart' as _i283;
import 'package:task/pages/home/bloc/home_bloc.dart' as _i630;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    gh.lazySingleton<_i335.AppDatabase>(
      () => databaseModule.database,
      dispose: _i1009.closeDatabase,
    );
    gh.lazySingleton<_i283.FormatsRepository>(
      () => _i450.DriftFormatsRepository(gh<_i335.AppDatabase>()),
    );
    gh.factory<_i630.HomeBloc>(
      () => _i630.HomeBloc(gh<_i283.FormatsRepository>()),
    );
    return this;
  }
}

class _$DatabaseModule extends _i1009.DatabaseModule {}
