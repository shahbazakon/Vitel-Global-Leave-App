

//TODO: register the Blow feature and Delete this File


//register_remote_datasource.dart --> RegisterCubit
locator.registerLazySingleton<{{name.pascalCase()}}RemoteDataSource>(
() => {{name.pascalCase()}}RemoteDataSourceImp());

// register_repositories.dart --> RegisterRepository
locator.registerLazySingleton<{{name.pascalCase()}}Repository>(() =>
{{name.pascalCase()}}RepositoryImp({{name.camelCase()}}RemoteDataSource: locator()));



//register_main_bloc.dart --> providers
BlocProvider<{{name.pascalCase()}}Cubit>(
create: (BuildContext context) => locator<{{name.pascalCase()}}Cubit>()),


// register_cubit.dart --> RegisterCubit
locator.registerFactory(() => {{name.pascalCase()}}Cubit({{name.camelCase()}}UseCase: locator()));


//register_useCase.dart --> RegisterUseCases
locator.registerLazySingleton(
() => {{name.pascalCase()}}UseCase({{name.camelCase()}}Repository: locator.call()));