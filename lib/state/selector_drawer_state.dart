import 'package:flutter/material.dart';

enum DrawerTab { tools, pen, gears }

class SelectorDrawerState extends ChangeNotifier {
  static SelectorDrawerState _instance;

  factory SelectorDrawerState.init() {
    return _instance = SelectorDrawerState._internal();
  }

  factory SelectorDrawerState() {
    assert(_instance != null,
        'The SelectorDrawerState.init() factory constructor must be called before using the SelectorDrawerState() constructor.');
    return _instance;
  }

  SelectorDrawerState._internal();

  /// Whether or not the selector drawer is open
  bool get isOpen => _isOpen;
  bool _isOpen = false;

  /// Opens the drawer with a specific active selection
  void openDrawer({@required DrawerTab activeTab}) {
    _isOpen = true;
    _activeTab = activeTab;
    notifyListeners();
  }

  /// Closes the drawer
  void closeDrawer() {
    _isOpen = false;
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
  }

  /// Syncs this state's active tab with the TabController's active tab.
  /// This is used to keep the TabController and this state object in sync
  /// when the tab change is triggered by the tab itself (e.g. due
  /// to the user changing tab with a swipe gesture).
  void syncActiveTab({@required DrawerTab newActiveTab}) {
    _activeTab = newActiveTab;
    notifyListeners();
  }

  /// The currently active drawer tab
  DrawerTab get activeTab => _activeTab;
  DrawerTab _activeTab = DrawerTab.pen;
}
