import 'package:sapiency_app/screen/influencer/crowdsale/influencer_crowdsale_screen.dart';
import 'package:sapiency_app/screen/influencer/description/influencer_description_screen.dart';
import 'package:sapiency_app/screen/influencer/done/influencer_flow_done_screen.dart';
import 'package:sapiency_app/screen/influencer/info/influencer_info_screen.dart';
import 'package:sapiency_app/screen/influencer/intro/influencer_intro_screen.dart';
import 'package:sapiency_app/screen/influencer/media/influencer_media_screen.dart';
import 'package:sapiency_app/screen/influencer/metatags/influencer_metatags_screen.dart';
import 'package:sapiency_app/screen/influencer/profile/influencer_profile_screen.dart';
import 'package:sapiency_app/screen/influencer/summary/influencer_summary_screen.dart';
import 'package:sapiency_app/screen/influencer/token/influencer_token_screen.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';

class InfluencerFlowRouting {
  static final Map<String, RouteConfig> routes = {
    InfluencerIntroScreen.route: InfluencerIntroScreen.routeConfig,
    InfluencerProfileScreen.route: InfluencerProfileScreen.routeConfig,
    InfluencerInfoScreen.route: InfluencerInfoScreen.routeConfig,
    InfluencerMediaScreen.route: InfluencerMediaScreen.routeConfig,
    InfluencerMetatagsScreen.route: InfluencerMetatagsScreen.routeConfig,
    InfluencerTokenScreen.route: InfluencerTokenScreen.routeConfig,
    InfluencerCrowdsaleScreen.route: InfluencerCrowdsaleScreen.routeConfig,
    InfluencerDescriptionScreen.route: InfluencerDescriptionScreen.routeConfig,
    InfluencerSummaryScreen.route: InfluencerSummaryScreen.routeConfig,
    InfluencerFlowDoneScreen.route: InfluencerFlowDoneScreen.routeConfig,
  };

  static const initialRoute = InfluencerIntroScreen.route;
}
