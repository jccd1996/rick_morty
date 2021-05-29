import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

mixin StreamUseCase<M extends BaseModel> {
  Stream<M> stream([BaseRequest params]);
}

mixin StreamUseCaseAdapter<M extends BaseModel> implements StreamUseCase<M> {
  BaseRepository get repository;

  @override
  Stream<M> stream([BaseRequest params]) {
    return (repository as RepositoryStream).stream(params) as Stream<M>;
  }
}
