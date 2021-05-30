import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';
import 'package:models/result.dart';

import 'base_source.dart';

mixin StorageRepositoryGetAdapter<M extends BaseModel>
    implements RepositoryGet<M> {
  ApiSource get apiSource;
  DbSource get dbSource;

  @override
  Future<Result<M>> get([BaseRequest? params]) {
    return (apiSource as ApiSourceGet).get(params).then((result) async {
      if (result.data != null) {
        await (dbSource as DbSourceSave).save(result.data!);
      }
      return result as Result<M>;
    });
  }
}

mixin RepositoryGetAdapter<M extends BaseModel> implements RepositoryGet<M> {
  ApiSourceGet get apiSource;

  @override
  Future<Result<M>> get([BaseRequest? params]) {
    return apiSource.get(params) as Future<Result<M>>;
  }
}
