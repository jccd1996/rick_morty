import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

mixin StreamAllUseCase<M extends BaseModel> {
  Stream<List<M>> streamAll([BaseRequest? params]);
}

mixin StreamAllUseCaseAdapter<M extends BaseModel>
    implements StreamAllUseCase<M> {
  BaseRepository get repository;

  @override
  Stream<List<M>> streamAll([BaseRequest? params]) {
    return (repository as RepositoryStreamAll).streamAll(params)
        as Stream<List<M>>;
  }
}
