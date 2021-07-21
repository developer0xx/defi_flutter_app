import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/screen/home/state/home_page_state.dart';
import 'package:sapiency_app/screen/home/widgets/post_view.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class HomePageView extends StatelessWidget {
  final HomePageState state;

  const HomePageView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(AppImages.textLogo),
        titleSpacing: 32,
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => await state.refresh(),
          color: AppColors.primary,
          backgroundColor: Colors.white,
          child: _buildContent(context),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (state.isInProgress) return _buildLoadingIndicator();
    if (state.users == null) return _buildCenterMessage(context.strings.home.error);
    if (state.users!.isEmpty) return _buildCenterMessage(context.strings.home.empty);
    return _buildUserList();
  }

  Widget _buildCenterMessage(String message) {
    return Stack(
      children: [
        Center(child: Text(message, style: AppText.label)),
        Positioned.fill(child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics())),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return SpinKitThreeBounce(
      color: AppColors.primary,
      size: 40,
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: state.users!.length,
      itemBuilder: (context, index) => PostView(user: state.users![index]),
    );
  }
}
