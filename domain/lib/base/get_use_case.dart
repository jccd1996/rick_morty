import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';

mixin GetUseCase<M extends BaseModel> {
  Future<M> get([Map params]);
}

mixin GetUseCaseAdapter<M extends BaseModel> implements GetUseCase<M> {
  BaseRepository get repository;

  @override
  Future<M> get([Map params]) {
    return (repository as RepositoryGet).get(params);
  }
}
