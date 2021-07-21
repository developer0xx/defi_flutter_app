import 'package:sapiency_app/model/api/influencer/setup/req/setup_influencer_req.dart';
import 'package:sapiency_app/model/api/influencer/setup/res/setup_influencer_res.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/influencer/input/influencer_input.dart';
import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/influencer/exception/setup/influencer_setup_exception.dart';

class InfluencerService {
  final ApiService _apiService;

  const InfluencerService(this._apiService);

  Future<void> setup(InfluencerInput influencer, CrowdsaleInput? crowdsale) async {
    final response = await _apiService.setupInfluencer(
      SetupInfluencerReq(influencer: influencer, crowdsale: crowdsale),
    );
    if(response.body! is SetupInfluencerResError) throw InfluencerSetupException();
  }
}
