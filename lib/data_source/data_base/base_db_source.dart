import 'package:data/base/base_source.dart';
import 'package:models/base_model.dart';
import 'package:sembast/sembast.dart';

const String _dbOrderKey = 'dbOrder';

mixin DbSourceGetAllAdapter<T extends BaseModel> implements DbSourceGetAll<T> {
  T mapper(RecordSnapshot<String, Map<String, dynamic>> record);

  Database get db;

  StoreRef<String, Map<String, dynamic>> get store;

  @override
  Stream<List<T>> getAll([Map params]) {
    return store
        .query(finder: Finder(sortOrders: [SortOrder(_dbOrderKey)]))
        .onSnapshots(db)
        .map((records) => records.map(mapper).toList());
  }
}
mixin DbSourceGetAdapter<T extends BaseModel> implements DbSourceGet<T> {
  T mapper(Map<String, dynamic> record);

  Database get db;

  final store = StoreRef.main();

  @override
  Stream<T> get([Map params]) {
    return store
        .record(T.toString())
        .onSnapshot(db)
        .map((record) => record == null ? null : mapper(record.value));
  }
}
mixin DbSourceSaveAdapter<T extends BaseModel> implements DbSourceSave<T> {
  Database get db;

  final store = StoreRef.main();

  @override
  Future save(T item) async {
    await store.record(T.toString()).put(db, item.toJson());
  }
}
