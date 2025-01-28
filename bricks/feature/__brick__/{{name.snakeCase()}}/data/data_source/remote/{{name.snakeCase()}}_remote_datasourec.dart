import 'package:project_spectrum/core/api/api.dart';
import 'package:project_spectrum/core/error/failure.dart';
import 'package:project_spectrum/core/design_system/popups/primary_snack_bar.dart';


import '../../../domain/entities/{{name.snakeCase()}}_request_entity.dart';
import '../../model/{{name.snakeCase()}}_model.dart';

abstract class {{name.pascalCase()}}RemoteDataSource {
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}(
      {required {{name.pascalCase()}}RequestEntity data});
}

class {{name.pascalCase()}}RemoteDataSourceImp extends {{name.pascalCase()}}RemoteDataSource {
  API api = API();
  @override
  Future<{{name.pascalCase()}}Model> get{{name.pascalCase()}}(
      {required {{name.pascalCase()}}RequestEntity data}) async {
    //check {{name.pascalCase()}} source
    try {
      final response = await api.sendRequest
          .post("TODO: Add api ", data: data.toJson());
      final status = await handleStatusCode(response);
      if (status.status) {
        {{name.pascalCase()}}Model data = {{name.pascalCase()}}Model.fromJson(response.data);
        return data;
      } else {
        throw status.failure!;
      }
    } catch (error) {
        showPrimarySnackBar(text: "$error", isError: true);
      rethrow;
    }
  }
}
