import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';

mixin GetAllUseCase<M extends BaseModel> {
  Future<List<M>> getAll([Map params]);
}

mixin GetAllUseCaseAdapter<M extends BaseModel> implements GetAllUseCase<M> {
  BaseRepository get repository;

  @override
  Future<List<M>> getAll([Map params]) {
    return (repository as RepositoryGetAll).getAll(params);
  }
}
