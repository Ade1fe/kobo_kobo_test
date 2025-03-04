import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';

String transactionStatusAnalyzer(int status) {
  switch (status) {
    case 0:
      return 'Pending';
    case 1:
      return 'Processing';
    case 2:
      return 'Successful';
    case 3:
      return 'Failed';
    case 4:
      return 'Cancelled';
    case 5:
      return 'Review';
    case 6:
      return 'Expired';
    default:
      return 'Pending';
  }
}

enum TransactionStatusEnum {
  pending, // => 0
  processing, //=>1
  successful, //=>2
  failed, //=>3
  cancelled, //=>4
  review, //=>5
  expired, //=>6
}

Color avatarBgColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
    case 'review':
    case 'processing':
      return AppColors.pendingBg;
    case 'successful':
    case 'cancelled':
    case 'failed':
    case 'expired':
      return AppColors.lighterGrey;
    default:
      return AppColors.black;
  }
}

extension TransactionStatusExtension on TransactionStatusEnum {
  String get name => describeEnum(this);

  String describeEnum(Object enumEntry) {
    final description = enumEntry.toString();
    final indexOfDot = description.indexOf('.');
    assert(true, indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get displayTitle {
    switch (this) {
      case TransactionStatusEnum.pending:
        return 'Pending';
      case TransactionStatusEnum.processing:
        return 'Processing';
      case TransactionStatusEnum.successful:
        return 'Successful';
      case TransactionStatusEnum.failed:
        return 'Failed';
      case TransactionStatusEnum.cancelled:
        return 'Cancelled';
      case TransactionStatusEnum.review:
        return 'Review';
      case TransactionStatusEnum.expired:
        return 'Expired';
    }
  }

  Widget getStatusText(BuildContext context) {
    switch (this) {
      case TransactionStatusEnum.pending:
        return Text(
          'Pending',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF9500),
          ),
        );
      case TransactionStatusEnum.processing:
        return Text(
          'Processing',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF9500),
          ),
        );
      case TransactionStatusEnum.successful:
        return Text(
          'Success',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xff00A32E),
          ),
        );
      case TransactionStatusEnum.failed:
        return Text(
          'Failed',
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF2D55),
          ),
        );
      case TransactionStatusEnum.review:
        return Text(
          'Review',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF9500),
          ),
        );
      case TransactionStatusEnum.cancelled:
        return Text(
          'Cancelled',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF9500),
          ),
        );
      case TransactionStatusEnum.expired:
        return Text(
          'Expired',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: const Color(0xffFF9500),
          ),
        );
    }
  }
}
