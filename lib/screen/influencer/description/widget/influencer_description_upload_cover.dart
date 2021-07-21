import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/upload/upload_wrapper.dart';
import 'package:sapiency_app/screen/influencer/description/state/influencer_description_screen_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class InfluencerDescriptionUploadCover extends StatelessWidget {
  final InfluencerDescriptionScreenState state;
  static const double coverRatio = 1 / 3;

  const InfluencerDescriptionUploadCover({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.strings.inf.description.label.cover,
              style: AppText.label,
            ),
            SizedBox(height: 2),
            ClipRRect(
              borderRadius: AppValues.smallBorderRadius,
              child: FileUploadWrapper(
                state: state.uploadState,
                width: constraints.maxWidth,
                height: constraints.maxWidth * coverRatio,
                shape: FileUploadWrapperShape.rectangular,
                child: GestureDetector(
                  onTap: state.uploadState.onUploadPressed,
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxWidth * coverRatio,
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: AppValues.smallBorderRadius),
                      child: state.uploadState.pickedFile != null || state.uploadState.pickedUrl != null
                          ? _buildCover(context, constraints.maxWidth)
                          : _buildUpload(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //TODO refactor to state based file

  Widget _buildCover(BuildContext context, double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: AppValues.smallBorderRadius,
          child: _buildImage(width),
        ),
        _buildOptions(context),
      ],
    );
  }

  Widget _buildImage(double width) {
    if (state.uploadState.pickedUrl != null && state.uploadState.pickedFile == null)
      return Image.network(state.uploadState.pickedUrl!, fit: BoxFit.cover, width: width);
    else
      return Image.file(state.uploadState.pickedFile!, fit: BoxFit.cover, width: width);
  }

  Widget _buildUpload(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppImages.uploadIcon),
          SizedBox(height: 4),
          Text(context.strings.inf.description.hint.cover, style: AppText.text.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildOptionButton(state.uploadState.onResetState, context.strings.inf.description.cover.remove),
        SizedBox(width: 15),
        _buildOptionButton(state.uploadState.onUploadPressed, context.strings.inf.description.cover.uploadNew),
      ],
    );
  }

  Widget _buildOptionButton(Function() onTap, String title) {
    return ClipRRect(
      //workaround: make rounded border
      borderRadius: BorderRadius.circular(2000),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 110,
          color: Colors.black.withOpacity(0.7),
          child: Center(child: Text(title, style: AppText.button.copyWith(fontSize: 12))),
        ),
      ),
    );
  }
}
