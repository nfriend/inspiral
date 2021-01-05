import 'package:xml/xml.dart';
import 'gear_path.dart';
import 'package:meta/meta.dart';

class GearSvg {
  GearSvg({@required this.path, @required this.width, @required this.height});

  final GearPath path;
  final int width;
  final int height;

  @override
  String toString() {
    final builder = XmlBuilder();

    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('svg', nest: () {
      builder.namespace("http://www.w3.org/2000/svg");
      builder.attribute("version", "1.1");
      builder.attribute("width", width);
      builder.attribute("height", height);
      builder.attribute("viewbox", "0 0 $width $height");
      builder.element('g', nest: () {
        builder.element('path', nest: () {
          builder.attribute('d', path.toString());
          builder.attribute('style',
              'fill:#000000; fill-opacity:0.3; stroke:#000000; stroke-width:0.25;');
        });
      });
    });

    return builder.buildDocument().toXmlString(pretty: true);
  }
}
