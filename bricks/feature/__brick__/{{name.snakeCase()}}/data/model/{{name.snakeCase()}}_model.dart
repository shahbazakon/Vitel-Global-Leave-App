import 'package:equatable/equatable.dart';

class {{name.pascalCase()}}Model extends Equatable {
  const {{name.pascalCase()}}Model();

  @override
  // TODO: implement props
  List<Object?> get props => [];

  factory {{name.pascalCase()}}Model.fromJson(Map<String, dynamic> json) {
    return {{name.pascalCase()}}Model();
  }

  Map<String, dynamic> toJson() => {};
}
