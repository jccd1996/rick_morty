import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';
import 'package:models/base_request.dart';

import 'base_source.dart';

mixin StorageRepositoryStreamAllAdapter<M extends BaseModel>
    implements RepositoryStreamAll<M> {
  DbSource get dbSource;

  @override
  Stream<List<M>> streamAll([BaseRequest params]) {
    return (dbSource as DbSourceGetAll).getAll(params);
  }
}
