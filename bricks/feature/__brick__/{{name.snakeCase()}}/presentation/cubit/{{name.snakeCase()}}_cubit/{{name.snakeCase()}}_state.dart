import 'package:flutter/material.dart';

import '../../../data/model/{{name.snakeCase()}}_model.dart';

@immutable
abstract class {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Initial extends {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Loading extends {{name.pascalCase()}}State {}

class {{name.pascalCase()}}Loaded extends {{name.pascalCase()}}State {
  final {{name.pascalCase()}}Model {{name.camelCase()}}Response;
  {{name.pascalCase()}}Loaded({required this.{{name.camelCase()}}Response});
}

class {{name.pascalCase()}}Error extends {{name.pascalCase()}}State {
  final String errorMsg;
  {{name.pascalCase()}}Error({required this.errorMsg});
}
