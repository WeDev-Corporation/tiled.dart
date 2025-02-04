import 'dart:io';

import 'package:test/test.dart';
import 'package:tiled/tiled.dart';

void main() {
  TiledMap map;
  setUp(() {
    return File('./test/fixtures/objectgroup.tmx').readAsString().then((xml) {
      map = TileMapParser.parseTmx(xml);
    });
  });

  group('Layer.fromXML', () {
    Layer objectGroup;

    setUp(() {
      objectGroup = map.getLayerByName('Test Object Layer 1');
    });

    test('sets name', () {
      expect(objectGroup.name, equals('Test Object Layer 1'));
    });

    test('sets color', () {
      expect(objectGroup.color, equals('#555500'));
    });

    test('sets opacity', () {
      expect(objectGroup.opacity, equals(0.7));
    });

    test('sets visible', () {
      expect(objectGroup.visible, equals(true));
      objectGroup = map.getLayerByName('EmptyLayer');

      expect(objectGroup.visible, equals(false));
    });

    test('populates tmxObjects', () {
      expect(objectGroup.objects.length, greaterThan(0));
    });
  });
}
