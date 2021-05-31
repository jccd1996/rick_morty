import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';
import 'package:models/result.dart';

mixin GetUseCase<M extends BaseModel> {
  Future<Result<M>> get([BaseRequest? params]);
}

mixin GetUseCaseAdapter<M extends BaseModel> implements GetUseCase<M> {
  BaseRepository get repository;

  @override
  Future<Result<M>> get([BaseRequest? params]) {
    print('akgi');
    return (repository as RepositoryGet).get(params) as Future<Result<M>>;
  }
}
