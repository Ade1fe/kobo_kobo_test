import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

extension StringExtension on String {
  String intelligentTrim(int length) {
    return this.length > length ? '${substring(0, length)}...' : this;
  }

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return -1;
    }
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      return -1;
    }
  }

  String camelToSnakeCase() {
    return split(RegExp('(?=[A-Z])')).join('_').toLowerCase();
  }

  String getFirstName() {
    return contains(' ') ? split(' ').first.capitalize() : capitalize();
  }

  String getLastName() {
    return contains(' ') ? split(' ').last.capitalize() : capitalize();
  }

  String splitBySPace({required bool takeFirst}) {
    return contains(' ')
        ? takeFirst
            ? split(' ').first
            : split(' ').last
        : this;
  }

  String capInitial({int? endsAt = 1}) {
    return substring(0, endsAt).toUpperCase();
  }

  String toReadableDateString({
    bool withTime = false,
    bool relativeToNow = false,
  }) {
    try {
      final date = DateFormat(
        // isStampDuty ? "yyyy-MM-dd HH:mm:ss" : "EEE MMM dd yyyy HH:mm:ss",
        'EEE MMM dd yyyy HH:mm:ss',
      ).parse(this, true).toLocal();
      if (relativeToNow) {
        return _dateRelativeToNow(date);
      }
      final dateFormat = DateFormat('d, MMM yyyy');
      if (withTime) {
        return dateFormat.add_jm().format(date);
      } else {
        return dateFormat.format(date);
      }
    } catch (_) {
      return '';
    }
  }

  String getInitials({int defaultLength = 2}) {
    try {
      if (isEmpty) return '';
      final names = split(' ');
      if (names.length < defaultLength) {
        return names[0][0].toUpperCase();
      }
      return names.sublist(0, defaultLength).map((name) {
        return name[0].toUpperCase();
      }).join();
    } catch (_) {
      return substring(0, 1).toUpperCase();
    }
  }

  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String toFilterDate() {
    return replaceAll('/', '-').split('-').reversed.toList().join('-');
  }

  String toTitleCase() {
    if (length < 2) return this;
    return toLowerCase().split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  String redactRange(int start, int end, {String replacement = '•'}) {
    return replaceRange(start, end, replacement * (end - start));
  }

  String routeSplitter() => split('/').last;

  String toUrlEncoded() {
    return Uri.encodeComponent(this);
  }

  void toClipboard({String feedbackMsg = 'Copied to clipboard'}) {
    Clipboard.setData(ClipboardData(text: this))
        .then((value) => showSuccessNotification(feedbackMsg))
        .catchError((_) {});
  }

  String _dateRelativeToNow(DateTime date) {
    final thisInstant = DateTime.now();
    final diff = thisInstant.difference(date);

    if ((diff.inDays / 365).floor() >= 2) {
      return '${(diff.inDays / 365).floor()} years ago';
    } else if ((diff.inDays / 365).floor() >= 1) {
      return 'Last year';
    } else if ((diff.inDays / 30).floor() >= 2) {
      return '${(diff.inDays / 30).floor()} months ago';
    } else if ((diff.inDays / 30).floor() >= 1) {
      return 'Last month';
    } else if ((diff.inDays / 7).floor() >= 2) {
      return '${(diff.inDays / 7).floor()} weeks ago';
    } else if ((diff.inDays / 7).floor() >= 1) {
      return 'Last week';
    } else if (diff.inDays >= 2) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays >= 1) {
      return 'Yesterday';
    } else if (diff.inHours >= 2) {
      return '${diff.inHours} hours ago';
    } else if (diff.inHours >= 1) {
      return '1 hour ago';
    } else if (diff.inMinutes >= 2) {
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inMinutes >= 1) {
      return '1 minute ago';
    } else if (diff.inSeconds >= 3) {
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
