import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';
import 'package:models/result.dart';

mixin GetAllUseCase<M extends BaseModel> {
  Future<Result<List<M>>> getAll([BaseRequest? params]);
}

mixin GetAllUseCaseAdapter<M extends BaseModel> implements GetAllUseCase<M> {
  BaseRepository get repository;

  @override
  Future<Result<List<M>>> getAll([BaseRequest? params]) {
    return (repository as RepositoryGetAll).getAll(params)
        as Future<Result<List<M>>>;
  }
}
