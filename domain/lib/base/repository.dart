import 'package:models/base_model.dart';
import 'package:models/base_request.dart';
import 'package:models/result.dart';

mixin BaseRepository {}

mixin RepositoryStreamAll<M extends BaseModel> on BaseRepository {
  Stream<List<M>> streamAll([BaseRequest? params]);
}
mixin RepositoryStream<M extends BaseModel> on BaseRepository {
  Stream<M?> stream([BaseRequest? params]);
}
mixin RepositoryGetAll<M extends BaseModel> on BaseRepository {
  Future<Result<List<M>>> getAll([BaseRequest? params]);
}
mixin RepositoryGet<M extends BaseModel> on BaseRepository {
  Future<Result<M>> get([BaseRequest? params]);
}
mixin RepositoryGetById<M extends BaseModel> on BaseRepository {
  Future<Result<M>> getById(String id);
}
mixin RepositoryStreamById<M extends BaseModel> on BaseRepository {
  Stream<M> streamById(String id);
}
mixin RepositorySave<M, R> on BaseRepository {
  Future<M> save(R request);
}
