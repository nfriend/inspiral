import 'dart:async';
import 'package:inspiral/state/state.dart';

const _snackBarDisplayDuration = Duration(milliseconds: 4000);

class SnackbarState extends InspiralStateObject {
  static SnackbarState _instance;

  factory SnackbarState.init() {
    return _instance = SnackbarState._internal();
  }

  factory SnackbarState() {
    assert(_instance != null,
        'The SnackbarState.init() factory constructor must be called before using the SnackbarState() constructor.');
    return _instance;
  }

  SnackbarState._internal() : super();

  Timer _timer;

  /// Whether or not something is loading
  String get message => _message;
  String _message = '';

  /// Whether or not to render the snackbar
  bool get isVisible => _isVisible;
  bool _isVisible = false;

  /// Shows a snackbar with the provided message
  void showSnackbar(String message) {
    _message = message;
    _isVisible = true;
    notifyListeners();

    _timer?.cancel();
    _timer = Timer(_snackBarDisplayDuration, () {
      _isVisible = false;
      notifyListeners();
    });
  }
}
