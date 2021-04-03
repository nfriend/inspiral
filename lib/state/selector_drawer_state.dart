import 'package:flutter/material.dart';
import 'package:inspiral/state/state.dart';

enum DrawerTab { tools, pen, gears }

class SelectorDrawerState extends BaseState {
  static SelectorDrawerState _instance;

  factory SelectorDrawerState.init() {
    return _instance = SelectorDrawerState._internal();
  }

  factory SelectorDrawerState() {
    assert(_instance != null,
        'The SelectorDrawerState.init() factory constructor must be called before using the SelectorDrawerState() constructor.');
    return _instance;
  }

  SelectorDrawerState._internal() : super();

  CanvasState canvas;
  ColorState colors;

  /// Whether or not the selector drawer is open
  bool get isOpen => _isOpen;
  bool _isOpen = false;

  /// Opens the drawer with a specific active selection
  void openDrawer({@required DrawerTab activeTab}) {
    _isOpen = true;
    _activeTab = activeTab;
    _updateIsSelectingHole();

    notifyListeners();
  }

  /// Closes the drawer
  void closeDrawer() {
    _isOpen = false;
    _updateIsSelectingHole();
    notifyListeners();
  }

  /// Handles the state of the drawer when the buttons are pressed
  void toggleOrSelectDrawer({@required DrawerTab tabToSelect}) {
    if (!isOpen) {
      openDrawer(activeTab: tabToSelect);
    } else {
      if (activeTab == tabToSelect) {
        closeDrawer();
      } else {
        _activeTab = tabToSelect;
        notifyListeners();
      }
    }

    _updateIsSelectingHole();
    _hideColorDeleteButtons();
  }

  /// Syncs this state's active tab with the TabController's active tab.
  /// This is used to keep the TabController and this state object in sync
  /// when the tab change is triggered by the tab itself (e.g. due
  /// to the user changing tab with a swipe gesture).
  void syncActiveTab({@required DrawerTab newActiveTab}) {
    _activeTab = newActiveTab;
    _updateIsSelectingHole();
    _hideColorDeleteButtons();

    notifyListeners();
  }

  /// Updates the canvas's `isSelectingHole` property based on the currently
  /// selected tab.
  ///
  /// TODO: It feels like there should be a more declarative way to do this.
  void _updateIsSelectingHole() {
    canvas.isSelectingHole = isOpen && activeTab == DrawerTab.pen;
  }

  /// Hides the pen and canvas color delete buttons (if they are shown)
  ///
  /// Same comment as above about a more declarative way to do this.
  void _hideColorDeleteButtons() {
    colors.showPenColorDeleteButtons = false;
    colors.showCanvasColorDeleteButtons = false;
  }

  /// The currently active drawer tab
  DrawerTab get activeTab => _activeTab;
  DrawerTab _activeTab = DrawerTab.pen;
}
