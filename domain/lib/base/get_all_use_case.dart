import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

mixin GetAllUseCase<M extends BaseModel> {
  Future<List<M>> getAll([BaseRequest params]);
}

mixin GetAllUseCaseAdapter<M extends BaseModel> implements GetAllUseCase<M> {
  BaseRepository get repository;

  @override
  Future<List<M>> getAll([BaseRequest params]) {
    return (repository as RepositoryGetAll).getAll(params) as Future<List<M>>;
  }
}
