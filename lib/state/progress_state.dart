import 'package:flutter/material.dart';
import 'package:inspiral/state/persistors/persistable.dart';

class ProgressState extends ChangeNotifier with Persistable {
  static ProgressState _instance;

  factory ProgressState.init() {
    return _instance = ProgressState._internal();
  }

  factory ProgressState() {
    assert(_instance != null,
        'The ProgressState.init() factory constructor must be called before using the ProgressState() constructor.');
    return _instance;
  }

  ProgressState._internal() : super();

  /// Whether or not something is loading
  bool get isLoading => _isLoading;
  bool _isLoading = false;

  /// An optional message to show with the progress bar
  String get loadingMessage => _loadingMessage;
  String _loadingMessage;

  /// Shows the modal progress overlay, with an optional message
  void showModalProgress({String message}) {
    _isLoading = true;
    _loadingMessage = message;
    notifyListeners();
  }

  /// Hides the modal progress overlay
  void hideModalPropress() {
    _isLoading = false;
    _loadingMessage = null;
    notifyListeners();
  }
}
