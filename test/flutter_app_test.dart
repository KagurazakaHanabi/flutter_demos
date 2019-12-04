import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget boilerplate({Widget child}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: const MediaQueryData(size: Size(800.0, 600.0)),
        child: Center(
          child: Material(
            child: child,
          ),
        ),
      ),
    );
  }

  testWidgets('has expected defaults', (WidgetTester tester) async {
    await tester.pumpWidget(
      boilerplate(child: const SelectableText('selectable text')),
    );

    final SelectableText selectableText = tester.firstWidget(find.byType(SelectableText));
    expect(selectableText.showCursor, false);
    expect(selectableText.autofocus, false);
    expect(selectableText.dragStartBehavior, DragStartBehavior.start);
    expect(selectableText.cursorWidth, 2.0);
    expect(selectableText.enableInteractiveSelection, true);

    RenderBox renderBox = tester.renderObject(find.byType(SelectableText));
    expect(renderBox.size.height, 14.0);

    await tester.pumpWidget(
      boilerplate(
        child: const SelectableText(
          'selectable text',
          textScaleFactor: 1.9,
        ),
      ),
    );

    renderBox = tester.renderObject(find.byType(SelectableText));
    expect(renderBox.size.height, 27.0);
  });
}
