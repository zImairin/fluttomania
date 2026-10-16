import 'package:material_ui/material_ui.dart';
import 'package:forui/forui.dart';

import 'theme/theme.dart';

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    supportedLocales: FLocalizations.supportedLocales,
    localizationsDelegates: const [...FLocalizations.localizationsDelegates],
    theme: lightTheme.toApproximateMaterialTheme(),
    darkTheme: darkTheme.toApproximateMaterialTheme(),
    builder: (context, child) => FTheme(
      data: Theme.brightnessOf(context) == .light ? lightTheme : darkTheme,
      child: FToaster(child: FTooltipGroup(child: child!)),
    ),
    home: const FScaffold(
      child: Example(),
    ),
  );
}

class Example extends StatefulWidget {
  const new({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _count = 0;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: .min,
      spacing: 10,
      children: [
        Text('Count: $_count'),
        FButton(
          onPress: () => setState(() => _count++),
          suffix: const Icon(FLucideIcons.chevronsUp),
          child: const Text('Increase'),
        ),
      ],
    ),
  );
}
