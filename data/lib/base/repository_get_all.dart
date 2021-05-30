import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';
import 'package:models/result.dart';

import 'base_source.dart';

mixin StorageRepositoryGetAllAdapter<M extends BaseModel>
    implements RepositoryGetAll<M> {
  ApiSource get apiSource;
  DbSource get dbSource;

  @override
  Future<Result<List<M>>> getAll([BaseRequest? params]) {
    return (apiSource as ApiSourceGetAll).getAll(params).then((result) async {
      if (result.data != null) {
        await (dbSource as DbSourceSaveAll).saveAll(result.data ?? []);
      }
      return result as Result<List<M>>;
    });
  }
}

mixin RepositoryGetAllAdapter<M extends BaseModel>
    implements RepositoryGetAll<M> {
  ApiSourceGetAll get apiSource;

  @override
  Future<Result<List<M>>> getAll([BaseRequest? params]) {
    return apiSource.getAll(params) as Future<Result<List<M>>>;
  }
}
