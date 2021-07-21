import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class DateHelper {
  static bool isInputValid(String text) {
    try {
      formatDMY.parseStrict(text);
      return true;
    } catch (e) {
      return false;
    }
  }

  static final dateInputFormatter = [TextInputMask(mask: '99-99-9999', reverse: false)];

  static const dateFormat = 'dd-MM-yyyy';

  static final formatDMY = DateFormat(dateFormat, 'en_US');

  static String timeLeftFromDuration(Duration duration, BuildContext context) {
    final Duration crowdsaleDuration = Duration(days: 7);
    final bool isUpcoming = isCrowdsaleUpcoming(duration);
    final Duration baseDuration =
        isUpcoming ? Duration(milliseconds: duration.inMilliseconds - crowdsaleDuration.inMilliseconds) : duration;

    DurationTersity setTersity(Duration duration) {
      if (duration.inHours < 1) return DurationTersity.minute;
      if (duration.inDays < 1)
        return DurationTersity.hour;
      else
        return DurationTersity.day;
    }

    final durationText = prettyDuration(
      duration,
      locale: EnglishDurationLocale(),
      tersity: setTersity(baseDuration),
    );

    return isUpcoming
        ? context.strings.post.starts(duration: durationText)
        : context.strings.post.left(duration: durationText);
  }

  static bool isCrowdsaleUpcoming(Duration duration) => duration.inDays >= 7;
}
