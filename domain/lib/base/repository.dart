import 'package:models/base_model.dart';

mixin BaseRepository {}

mixin RepositoryStreamAll<M extends BaseModel> on BaseRepository {
  Stream<List<M>> streamAll([Map params]);
}
mixin RepositoryStream<M extends BaseModel> on BaseRepository {
  Stream<M> stream([Map params]);
}
mixin RepositoryGetAll<M extends BaseModel> on BaseRepository {
  Future<List<M>> getAll([Map params]);
}
mixin RepositoryGet<M extends BaseModel> on BaseRepository {
  Future<M> get([Map params]);
}
mixin RepositoryGetById<M extends BaseModel> on BaseRepository {
  Future<M> getById(String id);
}
mixin RepositoryStreamById<M extends BaseModel> on BaseRepository {
  Stream<M> streamById(String id);
}
mixin RepositorySave<M, R> on BaseRepository {
  Future<M> save(R request);
}
