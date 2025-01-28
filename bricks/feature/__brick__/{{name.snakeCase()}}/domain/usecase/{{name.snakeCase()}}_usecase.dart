import 'package:dartz/dartz.dart';
import 'package:project_spectrum/core/error/failure.dart';

import '../../data/model/{{name.snakeCase()}}_model.dart';
import '../entities/{{name.snakeCase()}}_request_entity.dart';
import '../repository/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}UseCase {
  final {{name.pascalCase()}}Repository {{name.camelCase()}}Repository;
  {{name.pascalCase()}}UseCase({required this.{{name.camelCase()}}Repository});

  Future<Either<Failure, {{name.pascalCase()}}Model>> call(
      {required {{name.pascalCase()}}RequestEntity requestData}) async {
    return await {{name.camelCase()}}Repository.get{{name.pascalCase()}}(data: requestData);
  }
}
