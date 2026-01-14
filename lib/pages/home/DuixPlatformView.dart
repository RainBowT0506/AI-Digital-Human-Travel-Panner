import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DuixPlatformView extends StatelessWidget {
  const DuixPlatformView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 70, 0, 90),
      child: AndroidView(
        viewType: 'duix_platform_view',
        layoutDirection: TextDirection.ltr,
        creationParamsCodec: StandardMessageCodec(),
      ),
    );
  }
}
