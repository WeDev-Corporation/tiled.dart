part of tiled;

class TiledObject {
  bool ellipse = false;
  int gId;
  double height;
  int id;
  String name;
  bool point = false;
  List<Point> polygon = [];
  List<Point> polyline = [];
  List<Property> properties = [];
  double rotation;
  Template template;
  Text text;
  String type;
  bool visible;
  double width;
  double x;
  double y;
  bool rectangle = false;

  TiledObject.fromXml(XmlNode xmlElement) {
    x = double.tryParse(xmlElement.getAttribute('x') ?? 0);
    y = double.tryParse(xmlElement.getAttribute('y') ?? 0);
    height = double.tryParse(xmlElement.getAttribute('height') ?? '0');
    width = double.tryParse(xmlElement.getAttribute('width') ?? '0');
    rotation = double.tryParse(xmlElement.getAttribute('rotation') ?? '0');
    visible = int.tryParse(xmlElement.getAttribute('visible') ?? '1') == 1;
    id = int.tryParse(xmlElement.getAttribute('id') ?? '');
    gId = int.tryParse(xmlElement.getAttribute('gid') ?? '');
    name = xmlElement.getAttribute('name');
    type = xmlElement.getAttribute('type');

    xmlElement.children.whereType<XmlElement>().forEach((XmlElement element) {
      switch (element.name.local) {
        case 'ellipse':
          ellipse = true;
          break;
        case 'point':
          point = true;
          break;
        case 'polygon':
          polygon = [];
          final List<String> pointString =
              element.getAttribute('points').split(" "); // "0,0 -4,81 -78,19"
          for (var i = 0; i < pointString.length; ++i) {
            pointString.forEach((element) {
              final List<String> ps = element.split(",");
              polygon.add(Point(double.parse(ps[0]), double.parse(ps[1])));
            });
          }
          break;
        case 'polyline':
          polyline = [];
          final List<String> pointString =
              element.getAttribute('points').split(" "); // "0,0 -4,81 -78,19"
          for (var i = 0; i < pointString.length; ++i) {
            pointString.forEach((element) {
              final List<String> ps = element.split(",");
              polyline.add(Point(double.parse(ps[0]), double.parse(ps[1])));
            });
          }
          break;
        case 'text':
          text = Text.fromXml(element);
          break;
        case 'template':
          template = Template.fromXml(element);
          break;
        case 'properties':
          element.nodes.whereType<XmlElement>().forEach((element) {
            properties.add(Property.fromXml(element));
          });
          break;
      }
    });
    rectangle = polyline.isEmpty && polygon.isEmpty && !ellipse && !point;
  }

  TiledObject.fromJson(Map<String, dynamic> json) {
    ellipse = json['ellipse'];
    gId = json['gid'];
    height = json['height']?.toDouble();
    id = json['id'];
    name = json['name'];
    point = json['point'];
    polygon =
        (json['polygon'] as List)?.map((e) => Point.fromJson(e))?.toList() ??
            [];
    polyline =
        (json['polyline'] as List)?.map((e) => Point.fromJson(e))?.toList() ??
            [];
    properties = (json['properties'] as List)
            ?.map((e) => Property.fromJson(e))
            ?.toList() ??
        [];
    rotation = json['rotation']?.toDouble();
    template =
        json['template'] != null ? Template.fromJson(json['template']) : null;
    text = json['text'] != null ? Text.fromJson(json['text']) : null;
    type = json['type'];
    visible = json['visible'];
    width = json['width']?.toDouble();
    x = json['x']?.toDouble();
    y = json['y']?.toDouble();
  }

  bool get isPolyline => polyline.isNotEmpty;
  bool get isPolygon => polygon.isNotEmpty;
  bool get isPoint => point;
  bool get isEllipse => ellipse;
  bool get isRectangle => rectangle;
}
