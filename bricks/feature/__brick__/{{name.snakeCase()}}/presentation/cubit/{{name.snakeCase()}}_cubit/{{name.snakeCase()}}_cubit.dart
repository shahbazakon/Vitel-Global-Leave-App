import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:project_spectrum/core/error/failure.dart';

import '../../../data/model/{{name.snakeCase()}}_model.dart';
import '../../../domain/entities/{{name.snakeCase()}}_request_entity.dart';
import '../../../domain/usecase/{{name.snakeCase()}}_usecase.dart';
import '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State> {
  final {{name.pascalCase()}}UseCase {{name.camelCase()}}UseCase;
  {{name.pascalCase()}}Cubit({required this.{{name.camelCase()}}UseCase})
      : super({{name.pascalCase()}}Initial());

  Future<Either<Failure, {{name.pascalCase()}}Model>> get{{name.pascalCase()}}(
      {required {{name.pascalCase()}}RequestEntity requestData}) async {
    emit({{name.pascalCase()}}Loading());
    final result = await {{name.camelCase()}}UseCase.call(requestData: requestData);
    result.fold(
        (l) => emit({{name.pascalCase()}}Error(errorMsg: l.displayErrorMessage())),
        (r) => emit({{name.pascalCase()}}Loaded({{name.camelCase()}}Response: r)));
    return result;
  }
}
