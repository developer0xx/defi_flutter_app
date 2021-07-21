import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/screen/payment/payment_screen_args.dart';
import 'package:sapiency_app/screen/payment/payment_screen_result.dart';
import 'package:sapiency_app/util/hook/use_simple_effect.dart';

const _successUrlPart = "/return.html?state=success";
const _errorUrlPart = "/return.html?state=failure";

class PaymentScreenState {
  final String webviewUrl;
  final Function(String) onWebviewUrlChanged;

  const PaymentScreenState({required this.webviewUrl, required this.onWebviewUrlChanged});
}

PaymentScreenState usePaymentScreenState({
  required PaymentScreenArgs args,
  required Function(PaymentScreenResult result) moveBack,
}) {
  final webviewUrlState = useState<String>(args.paymentUrl);

  useSimpleEffect(() {
    final url = webviewUrlState.value;
    if(url.contains(_successUrlPart)) {
      moveBack(PaymentScreenResult.success);
    } else if(url.contains(_errorUrlPart)) {
      moveBack(PaymentScreenResult.error);
    }
  }, [webviewUrlState.value]);

  return PaymentScreenState(
    webviewUrl: webviewUrlState.value,
    onWebviewUrlChanged: (url) => webviewUrlState.value = url,
  );
}
