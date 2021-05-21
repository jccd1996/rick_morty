import 'package:domain/base/repository.dart';
import 'package:models/base_model.dart';

import 'base_source.dart';

mixin StorageRepositoryStreamAdapter<M extends BaseModel>
    implements RepositoryStream<M> {
  DbSource get dbSource;

  @override
  Stream<M> stream([Map params]) {
    return (dbSource as DbSourceGet).get(params);
  }
}
