import 'package:inspiral/database/get_database.dart';
import 'package:inspiral/database/schema.dart';
import 'package:inspiral/state/state.dart';
import 'package:inspiral/util/color_from_hex_string.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:inspiral/extensions/extensions.dart';

class ColorPickerState extends BaseState {
  static ColorPickerState _instance;

  factory ColorPickerState.init() {
    return _instance = ColorPickerState._internal();
  }

  factory ColorPickerState() {
    assert(_instance != null,
        'The ColorPickerState.init() factory constructor must be called before using the ColorPickerState() constructor.');
    return _instance;
  }

  ColorPickerState._internal() : super();

  /// The last custom pen color selected in the color picker dialog
  TinyColor get lastSelectedCustomPenColor => _lastSelectedCustomPenColor;
  TinyColor _lastSelectedCustomPenColor;
  set lastSelectedCustomPenColor(TinyColor value) {
    _lastSelectedCustomPenColor = value;
    notifyListeners();
  }

  /// The last custom canvas color selected in the color picker dialog
  TinyColor get lastSelectedCustomCanvasColor => _lastSelectedCustomCanvasColor;
  TinyColor _lastSelectedCustomCanvasColor;
  set lastSelectedCustomCanvasColor(TinyColor value) {
    _lastSelectedCustomCanvasColor = value;
    notifyListeners();
  }

  @override
  Future<void> persist() async {
    Database db = await getDatabase();

    Iterable<int> colorIdsToDelete = (await db.query(Schema.colors.toString(),
            columns: [Schema.colors.id],
            where:
                "${Schema.colors.type} = '${ColorsTableType.lastSelectedPen}' OR ${Schema.colors.type} = '${ColorsTableType.lastSelectedCanvas}'"))
        .map((row) => row[Schema.colors.id]);

    int lastPenColorId = await db.insert(Schema.colors.toString(), {
      Schema.colors.value: lastSelectedCustomPenColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedPen
    });

    int lastCanvasColorId = await db.insert(Schema.colors.toString(), {
      Schema.colors.value: lastSelectedCustomCanvasColor.toHexString(),
      Schema.colors.type: ColorsTableType.lastSelectedCanvas
    });

    await db.update(Schema.state.toString(), {
      Schema.state.lastSelectedPenColor: lastPenColorId,
      Schema.state.lastSelectedCanvasColor: lastCanvasColorId,
    });

    await db.delete(Schema.colors.toString(),
        where: "${Schema.colors.id} IN (${colorIdsToDelete.join(', ')})");
  }

  @override
  Future<void> rehydrate() async {
    Database db = await getDatabase();

    Map<String, dynamic> state = (await db.rawQuery('''
      SELECT
        c1.${Schema.colors.value} AS ${Schema.state.lastSelectedPenColor},
        c2.${Schema.colors.value} AS ${Schema.state.lastSelectedCanvasColor}
      FROM
        ${Schema.state} s
      JOIN ${Schema.colors} c1 ON c1.${Schema.colors.id} = s.${Schema.state.lastSelectedPenColor}
      JOIN ${Schema.colors} c2 ON c2.${Schema.colors.id} = s.${Schema.state.lastSelectedCanvasColor}
    ''')).first;

    _lastSelectedCustomPenColor =
        tinyColorFromHexString(state[Schema.state.lastSelectedPenColor]);
    _lastSelectedCustomCanvasColor =
        tinyColorFromHexString(state[Schema.state.lastSelectedCanvasColor]);
  }
}
