import 'package:decimal/decimal.dart';
import 'package:sapiency_app/model/api/payment/provider/payment_provider.dart';
import 'package:sapiency_app/model/api/payment/req/payment_req.dart';
import 'package:sapiency_app/model/api/payment/type/payment_type.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/payment/exception/payment_exception.dart';

class PaymentService {
  final ApiService _apiService;

  const PaymentService(this._apiService);

  Future<String> payment({required String token, required Decimal quantity}) async {
    final response = await _apiService.payment(
      PaymentReq(
        provider: PaymentProvider.stripe,
        type: PaymentType.card,
        token: token,
        quantity: quantity,
        currency: 'USD',
        description: 'empty',
      ),
    );
    return response.body!.when(
      ok: (url) => url,
      error: () => throw PaymentException(),
    );
  }
}
