import 'package:flutter/material.dart';
import 'package:inspiral/constants.dart';
import 'package:inspiral/state/snackbar_state.dart';
import 'package:inspiral/state/state.dart';
import 'package:provider/provider.dart';

class SnackbarContainer extends StatefulWidget {
  @override
  _SnackbarContainerState createState() => _SnackbarContainerState();
}

const _snackBarTransitionDuration = Duration(milliseconds: 250);

AnimationController? _controller;
late Animation<double> _animation;

class _SnackbarContainerState extends State<SnackbarContainer>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: _snackBarTransitionDuration,
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller!, curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    final snackbar = Provider.of<SnackbarState>(context);
    final isDark = context.select<ColorState, bool>((colors) => colors.isDark);
    final backgroundColor = isDark ? Colors.white : Color(0xFF353535);
    final textColor = isDark ? Colors.black : Colors.white;

    if (_controller == null ||
        (!snackbar.isVisible && _controller!.isDismissed)) {
      // If the snackbar is not visible, and any previous animations have
      // finished, just return an empty Container().
      // Or, if the controller is `null`, we know this component has been
      // disposed, so we shouldn't render anything.
      // Disclaimer: I'm unsure if this is actually an effective optimization.
      return Container();
    }

    if (snackbar.isVisible) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }

    return FadeTransition(
        opacity: _animation,
        child: IgnorePointer(
            child: Padding(
                padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0,
                    menuBarHeight + selectorDrawerHeight + 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Material(
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        color: backgroundColor,
                        child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(snackbar.message,
                                style: TextStyle(color: textColor))),
                      ))
                    ]))));
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }
}
