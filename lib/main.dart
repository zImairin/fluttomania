import 'package:material_ui/material_ui.dart';
import 'package:forui/forui.dart';
import 'package:http/http.dart' as http;
///чтобы дарт подключался к серверу на питончике и выполнял http get запрос и выводил ответ сервера
import 'theme/theme.dart';

void main() {
  runApp(const Application());
}

Future<String> soso() async {
  var url = Uri.http('144.31.165.159:8000');
  var response = await http.get(url);
  return response.body;
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
    home: Example(),
  );
}

class Example extends StatefulWidget {
  const new({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  
  String _switch = ":(", soso_text = "";
  bool _button_flag = false;

  @override
  Widget build(BuildContext context) => FScaffold(
    child: Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        FButton(
          onPress: () {
            soso().then((response) {
              setState(() {
                soso_text = response;
              });
            });
            setState(() {
              _button_flag = !_button_flag;

              if (_button_flag) {
                _switch = "HUY :)";
              } else {
                _switch = ":(";
              }
            });
          },
          mainAxisSize: .min,
          child: Text(_switch),
        ),
        Text(soso_text),
      ]
    ),
  );
}
