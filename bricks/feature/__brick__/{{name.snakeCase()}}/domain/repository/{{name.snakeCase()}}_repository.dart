import 'package:dartz/dartz.dart';
import 'package:project_spectrum/core/error/failure.dart';

import '../../data/data_source/remote/{{name.snakeCase()}}_remote_datasourec.dart';
import '../../data/model/{{name.snakeCase()}}_model.dart';
import '../entities/{{name.snakeCase()}}_request_entity.dart';

abstract class {{name.pascalCase()}}Repository {
  Future<Either<Failure, {{name.pascalCase()}}Model>> get{{name.pascalCase()}}(
      {required {{name.pascalCase()}}RequestEntity data});
}

class {{name.pascalCase()}}RepositoryImp extends {{name.pascalCase()}}Repository {
  final {{name.pascalCase()}}RemoteDataSource {{name.camelCase()}}RemoteDataSource;
  {{name.pascalCase()}}RepositoryImp({required this.{{name.camelCase()}}RemoteDataSource});

  @override
  Future<Either<Failure, {{name.pascalCase()}}Model>> get{{name.pascalCase()}}(
      {required {{name.pascalCase()}}RequestEntity data}) async {
    try {
      final result =
          await {{name.camelCase()}}RemoteDataSource.get{{name.pascalCase()}}(data: data);
      return Right(result);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
