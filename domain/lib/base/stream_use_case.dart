import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';

mixin StreamUseCase<M extends BaseModel> {
  Stream<M> stream([Map params]);
}

mixin StreamUseCaseAdapter<M extends BaseModel> implements StreamUseCase<M> {
  BaseRepository get repository;

  @override
  Stream<M> stream([Map params]) {
    return (repository as RepositoryStream).stream(params);
  }
}
