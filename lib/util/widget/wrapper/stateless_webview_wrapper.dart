import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/hook/use_simple_effect.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StatelessWebViewWrapper extends HookWidget {
  final String url;
  final Function(String) onUrlChanged;
  final Widget Function(
    Function(WebViewController) onWebViewCreated,
    Function(String) onPageStarted,
    String initialUrl,
  ) builder;

  const StatelessWebViewWrapper({required this.url, required this.onUrlChanged, required this.builder});

  @override
  Widget build(BuildContext context) {
    final controllerState = useState<WebViewController?>(null);
    final urlState = useState<String>(url);

    useSimpleEffect(() {
      if (urlState.value != url) {
        urlState.value = url;
        controllerState.value?.loadUrl(url);
      }
    }, [urlState.value, controllerState.value, url]);

    return builder(
      (controller) => controllerState.value = controller,
      (url) {
        if(url != urlState.value) {
          urlState.value = url;
          onUrlChanged(url);
        }
      },
      url,
    );
  }
}
