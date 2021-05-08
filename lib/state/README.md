# State

All application state is managed by the files in this directory. All
`_state.dart` classes are singletons that will live for the entirety of the
application lifecycle.

## Implementation

All state objects should be implemented with a constructor pattern like this:

```dart
static MyState _instance;

factory MyState.init({@required int myParam}) {
  return _instance =
      MyState._internal(myParam: myParam);
}

factory MyState() {
  assert(_instance != null,
      'The MyState.init() factory constructor must be called before using the MyState() constructor.');
  return _instance;
}

CanvasState._internal({@required int myParam}) {
  _myParam = myParam;
}
```

All state objects are initialized in
[`lib/state/init_state.dart`](lib/state/init_state.dart), which must be called
early in the application lifecycle. This file is responsible for initializing
all state objects and connecting dependencies between the various state objects.

`init_state.dart` is the only file that should use the `MyState.init` factory
constructor - all other areas of the codebase should use the default `MyState`
factory constructor.

Each state object is registered as a `Provider` in
[`lib/widgets/inspiral_providers.dart`](lib/widgets/inspiral_providers.dart).

## Referencing other state objects

All state objects have access too all other state objects through the base
property `allStateObjects`:

```dart
var myOtherState = allStateObjects.myOtherState;
```

## Dependent properties

Sometimes a property needs to depend on the value of another state's property,
but still call `notifyListeners()` so that its widgets update.

In this case, listen to the source object in the `startListening` callback.
Here's an example from [`undo_redo_state.dart`](lib/state/undo_redo_state.dart)

```dart
@override
void startListening() {
  _onInkChange = () {
    isInkBaking = allStateObjects.ink.isBaking;
  };

  allStateObjects.ink.addListener(_onInkChange);
}

@override
void dispose() {
  allStateObjects.ink.removeListener(_onInkChange);

  super.dispose();
}
```

## Using a state object

To get a reference to a state object in a widget:

```dart
final myState = Provider.of<MyState>(context);
```

If the state object is only used for its functions, use `listen: false`:

```dart
final myState = Provider.of<MyState>(context, listen: false);
```

If a widget only needs to listen to a single property on a state object, use
`context.select`:

```dart
final myProp = context.select<MyState, bool>((state) => state.myProp);
```

This reduces the number of times the widget's `build` function will be called by
only listening to changes to the specific property instead of _all_ properties
on the state object.
