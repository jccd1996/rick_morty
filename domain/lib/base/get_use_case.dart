import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

mixin GetUseCase<M extends BaseModel> {
  Future<M> get([BaseRequest? params]);
}

mixin GetUseCaseAdapter<M extends BaseModel> implements GetUseCase<M> {
  BaseRepository get repository;

  @override
  Future<M> get([BaseRequest? params]) {
    return (repository as RepositoryGet).get(params) as Future<M>;
  }
}
