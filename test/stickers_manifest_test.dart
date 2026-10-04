import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:valentine/widgets/responsive_scaled_box_pixel_ratio_fix.dart';
import 'package:valentine/widgets/stickers.dart';

void main() {
  testWidgets('stickers load without the legacy JSON manifest', (tester) async {
    const sticker = 'assets/images/maker/stickers/crown.png';
    final image = ByteData.sublistView(File(sticker).readAsBytesSync());
    final requests = <String>[];
    final manifest = const StandardMessageCodec().encodeMessage({
      sticker: [{'asset': sticker}],
      'assets/unrelated.png': [{'asset': 'assets/unrelated.png'}],
    })!;

    final messenger = tester.binding.defaultBinaryMessenger;
    rootBundle.clear();
    messenger.setMockMessageHandler('flutter/assets', (message) async {
      final key = utf8.decode(Uint8List.sublistView(message!));
      requests.add(key);
      if (key == 'AssetManifest.bin') return manifest;
      if (key == sticker) return image;
      return null;
    });
    addTearDown(() {
      messenger.setMockMessageHandler('flutter/assets', null);
      rootBundle.clear();
    });

    await tester.pumpWidget(
      Provider<Scale>.value(
        value: const Scale(1),
        child: const MaterialApp(home: Scaffold(body: Stickers())),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(requests, contains('AssetManifest.bin'));
    expect(requests, isNot(contains('AssetManifest.json')));
    expect(find.byType(DraggableSticker), findsOneWidget);
    expect(tester.widget<DraggableSticker>(find.byType(DraggableSticker)).image, sticker);
  });
}
