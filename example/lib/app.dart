import 'package:example/config/design/tokens.dart';
import 'package:example/config/routes/routes.dart';
import 'package:flutter/material.dart';

class FakeStoreApi extends StatelessWidget {
  const FakeStoreApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Fake Store Api Package",
      debugShowCheckedModeBanner: false,
      theme: Themes.defaultTheme,
      routerConfig: router,
    );
  }
}
