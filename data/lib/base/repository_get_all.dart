import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

import 'base_source.dart';

mixin StorageRepositoryGetAllAdapter<M extends BaseModel>
    implements RepositoryGetAll<M> {
  ApiSource get apiSource;
  DbSource get dbSource;

  @override
  Future<List<M>> getAll([BaseRequest? params]) {
    return (apiSource as ApiSourceGetAll).getAll(params).then((result) async {
      if (result != null) {
        await (dbSource as DbSourceSaveAll).saveAll(result);
      }
      return result as List<M>;
    });
  }
}

mixin RepositoryGetAllAdapter<M extends BaseModel>
    implements RepositoryGetAll<M> {
  ApiSourceGetAll get apiSource;

  @override
  Future<List<M>> getAll([BaseRequest? params]) {
    return apiSource.getAll(params) as Future<List<M>>;
  }
}
