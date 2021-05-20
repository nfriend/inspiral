import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/state/inspiral_state_object.dart';

Future<void> persistAllStateObjects(AllStateObjects allStateObjects) async {
  var db = await getDatabase();

  await db.transaction((txn) async {
    var batch = txn.batch();

    allStateObjects.list.forEach((state) => state.persist(batch));

    await batch.commit(noResult: true);
  });
}
