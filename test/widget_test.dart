import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:valentine/router.dart';
import 'package:valentine/widgets/responsive_scaled_box_pixel_ratio_fix.dart';

void main() {
  for (final width in [320.0, 375.0, 800.0, 1920.0, 2200.0]) {
    testWidgets('Responsive layout renders at width $width', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = Size(width, 900);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      double? contentWidth;
      double? scale;
      double? pixelRatio;
      await tester.pumpWidget(MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: const [],
          child: child!,
        ),
        home: Responsive(
          child: Builder(builder: (context) {
            contentWidth = MediaQuery.sizeOf(context).width;
            pixelRatio = MediaQuery.devicePixelRatioOf(context);
            scale = context.read<Scale>().value;
            return const Text('Valentine');
          }),
        ),
      ));
      await tester.pumpAndSettle();

      final expectedWidth = width.clamp(375.0, 1920.0);
      expect(tester.takeException(), isNull);
      expect(find.text('Valentine'), findsOneWidget);
      expect(contentWidth, closeTo(expectedWidth, 0.001));
      expect(scale, closeTo(width / expectedWidth, 0.001));
      expect(pixelRatio, closeTo(width / expectedWidth, 0.001));
    });
  }
}
