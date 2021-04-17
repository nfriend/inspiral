import 'package:inspiral/models/canvas_size.dart';
import 'package:system_info/system_info.dart';
import 'package:device_info/device_info.dart';

/// Tries to guess the best canvas size for the current device. The slower/older
/// the device, the smaller the canvas size should be chosen.
Future<CanvasSizeAndName> guessIdealCanvasSize() async {
  try {
    // This test only works for Android devices
    const megabyte = 1024 * 1024;
    var memoryInMb = SysInfo.getTotalPhysicalMemory() ~/ megabyte;

    if (memoryInMb < 1000) {
      return CanvasSize.small;
    } else if (memoryInMb < 2500) {
      return CanvasSize.medium;
    } else {
      return CanvasSize.large;
    }
  } catch (err) {
    // Ignore the error if the device isn't supported
  }

  try {
    var deviceInfo = DeviceInfoPlugin();
    var iosInfo = await deviceInfo.iosInfo;

    // See https://github.com/fieldnotescommunities/ios-device-identifiers/blob/master/ios-device-identifiers.json
    // for a mapping of `machine` => actual version
    var productName = iosInfo.utsname.machine;

    var iphoneVersionRegex = RegExp(r'^iPhone([0-9]+)');
    var iphoneVersionMatches = iphoneVersionRegex.allMatches(productName);

    if (iphoneVersionMatches.isNotEmpty) {
      var iphoneVersion =
          int.parse(iphoneVersionMatches.elementAt(0).group(1), radix: 10);

      if (iphoneVersion < 5 /** == iPhone 4s or below */) {
        return CanvasSize.small;
      } else if (iphoneVersion < 8 /** == iPhone 6 or below */) {
        return CanvasSize.medium;
      } else {
        return CanvasSize.large;
      }
    }

    var ipadVersionRegex = RegExp(r'^iPad([0-9]+)');
    var ipadVersionMatches = ipadVersionRegex.allMatches(productName);

    if (ipadVersionMatches.isNotEmpty) {
      var ipadVersion =
          int.parse(ipadVersionMatches.elementAt(0).group(1), radix: 10);

      if (ipadVersion < 5 /** == iPad mini 3rd Gen or below */) {
        return CanvasSize.medium;
      } else {
        return CanvasSize.large;
      }
    }
  } catch (err) {
    // Similar to above - silently ignore errors
  }

  // The default if none of the methods above worked.
  return CanvasSize.medium;
}
