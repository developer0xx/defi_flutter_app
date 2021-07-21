import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/screen/payment/state/use_payment_screen_state.dart';
import 'package:sapiency_app/util/hook/use_simple_effect.dart';
import 'package:sapiency_app/util/widget/wrapper/stateless_webview_wrapper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreenView extends HookWidget {
  final PaymentScreenState state;

  const PaymentScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    useSimpleEffect(() => WebView.platform = SurfaceAndroidWebView(), []);

    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset(AppImages.textLogo), centerTitle: true),
      body: _buildWebView(),
    );
  }

  Widget _buildWebView() {
    return StatelessWebViewWrapper(
      url: state.webviewUrl,
      onUrlChanged: (url) => state.onWebviewUrlChanged(url),
      builder: (onWebViewCreated, onPageStarted, initialUrl) => WebView(
        onWebViewCreated: onWebViewCreated,
        onPageStarted: onPageStarted,
        initialUrl: initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
