

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:kobo_kobo/functional_util/assets.dart';
import 'package:kobo_kobo/functional_util/date/date_util.dart';
import 'package:kobo_kobo/functional_util/extensions/context_extension.dart';
import 'package:kobo_kobo/ui_widgets/app_bar.dart';
import 'package:kobo_kobo/ui_widgets/constants/constants.dart';
import 'package:kobo_kobo/ui_widgets/constants/numbers.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../guarantors_dashboard/guarantor_loan_overview.dart';
import 'package:kobo_kobo/features/navigation/navigation.dart';

class NotifyScreen extends StatefulWidget {
  const NotifyScreen({super.key});

  @override
  State<NotifyScreen> createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {
  List<Notification> notifications = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadInitialNotifications();
    _startSimulatingRealTimeNotifications();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _loadInitialNotifications() {
    setState(() {
      notifications = [
        Notification(
          message: 'Your guarantor has accepted your loan request',
          dateTime: DateTime.now().subtract(const Duration(minutes: 30)),
          isRead: false,
        ),
        Notification(
          message: 'Your guarantor has rejected your loan request',
          dateTime: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
        ),
        Notification(
          message: 'Your loan has been approved',
          dateTime: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
        ),
        Notification(
          message: 'Your loan has been disbursed',
          dateTime: DateTime.now().subtract(const Duration(days: 2)),
          isRead: true,
        ),
        Notification(
          message:
              'A guarantor loan request has been sent to you from Adeyemi Temitope',
          dateTime: DateTime.now().subtract(const Duration(days: 2)),
          isRead: false,
        ),
      ];
    });
  }

  void _startSimulatingRealTimeNotifications() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (notifications.length < 500) {
        setState(() {
          notifications.insert(
            0,
            Notification(
              message: 'New notification ${notifications.length + 1}',
              dateTime: DateTime.now(),
              isRead: false,
            ),
          );
        });
      }
    });
  }

  void handleNotificationTap(Notification notification) {
    setState(() {
      notification.isRead = true;
    });

    if (notification.message.contains('accepted')) {
      navigateToLoanStatusScreen(
        title: '',
        imagePath: emailSentImg,
        message:
            'Your loan request has been sent to your guarantor and is awaiting acceptance.',
        primaryButtonText: 'Go To Homepage',
      );
    } else if (notification.message.contains('rejected')) {
      navigateToLoanStatusScreen(
        title: '',
        imagePath: emailRejImg,
        message: 'We are sorry! Your guarantor has rejected your loan request.',
        primaryButtonText: 'Assign  a new Guarantor',
        secondaryButtonText: 'Cancel loan request',
      );
    } else if (notification.message.contains('approved')) {
      navigateToLoanStatusScreen(
        title: '',
        imagePath: emailApvImg,
        message:
            'Congrats! Your guarantor has accepted your loan request. Your loan will be approved and disbursed shortly.',
        primaryButtonText: 'Go To Homepage',
      );
    } else if (notification.message.contains('disbursed')) {
      navigateToLoanStatusScreen(
        title: '',
        imagePath: emaildisImg,
        message:
            'Your loan has been disbursed. You can now access your funds to meet your financial needs.',
        primaryButtonText: 'Go To Homepage',
      );
    } else if (notification.message.contains('guarantor')) {
      navigateToGuarantorScreen();
    } else {
      print('Unknown notification type');
    }
  }

  void navigateToLoanStatusScreen({
    required String title,
    required String imagePath,
    required String message,
    required String primaryButtonText,
    String? secondaryButtonText,
  }) {
    AppNavigator.of(context).push(
        '${AppRoutes.notificationRoute}/${AppRoutes.loanStatusScreen}',
        args: {
          'title': title,
          'imagePath': imagePath,
          'message': message,
          'primaryButtonText': primaryButtonText,
          'primaryAction': () {
            print('Primary action pressed');
            AppNavigator.of(context).pop();
          },
          'secondaryButtonText': secondaryButtonText,
          'secondaryAction': secondaryButtonText != null
              ? () {
                  print('Secondary action pressed');
                  AppNavigator.of(context).pop();
                }
              : null,
        });
  }

  void navigateToGuarantorScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const GuarantorLoanOverview(),
      ),
    );
  }

  List<Widget> _buildGroupedNotifications() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<Notification>> groupedNotifications = {
      'Today': [],
      'Yesterday': [],
      'This Week': [],
      'This Month': [],
      'Older': [],
    };

    for (var notification in notifications) {
      final notificationDate = DateTime(
        notification.dateTime.year,
        notification.dateTime.month,
        notification.dateTime.day,
      );

      if (notificationDate == today) {
        groupedNotifications['Today']!.add(notification);
      } else if (notificationDate == yesterday) {
        groupedNotifications['Yesterday']!.add(notification);
      } else if (now.difference(notificationDate).inDays < 7) {
        groupedNotifications['This Week']!.add(notification);
      } else if (now.month == notificationDate.month &&
          now.year == notificationDate.year) {
        groupedNotifications['This Month']!.add(notification);
      } else {
        groupedNotifications['Older']!.add(notification);
      }
    }

    List<Widget> widgets = [];

    groupedNotifications.forEach((key, value) {
      if (value.isNotEmpty) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor.withValues(alpha: 0.1),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  key,
                  style: context.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        );
        widgets.addAll(
          value.map(
            (notification) => NotificationItem(
              notification: notification,
              onTap: handleNotificationTap,
            ),
          ),
        );
      }
    });

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showLeading: true,
        title: 'Notifications',
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              AppNavigator.of(context).pop();
            },
            tooltip: 'Clear read notifications',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: _buildGroupedNotifications(),
            ),
          ),
          // Add the View All button
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
              child: Text(
                'View all notifications',
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.appPrimaryColor.withOpacity(.88),
                  fontSize: Insets.dim_14.sp,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Notification notification;
  final Function(Notification) onTap;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        height: Insets.dim_12.h,
        width: Insets.dim_12.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: notification.isRead ? Colors.grey[300] : null,
          gradient: notification.isRead
              ? null
              : LinearGradient(
                  colors: [
                    AppColors.appPrimaryColor.withValues(alpha: 0.8),
                    const Color(0xFFC67C94).withValues(alpha: 0.7),
                    const Color(0xFF8776FF).withValues(alpha: 0.8),
                  ],
                ),
        ),
      ),
      title: Text(
        notification.message,
        style: context.textTheme.bodySmall!.copyWith(
          fontSize: Insets.dim_14.sp,
          color: AppColors.black.withValues(alpha: 0.8),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            DateFormatUtil.formatDate(
                dateMonthTimeFormat2, notification.dateTime.toIso8601String()),
            style: context.textTheme.bodySmall!.copyWith(
              fontSize: Insets.dim_12.sp,
              color: AppColors.black.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
      trailing: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(6.sp),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: notification.isRead
              ? Colors.grey[200]
              : AppColors.appPrimaryButton.withValues(alpha: 0.2),
        ),
        child: Icon(
          notification.isRead
              ? PhosphorIcons.envelopeSimpleOpen()
              : PhosphorIcons.envelopeSimple(),
          color: notification.isRead
              ? Colors.grey[600]
              : AppColors.appPrimaryColor,
          size: 14.sp,
        ),
      ),
      onTap: () => onTap(notification),
    );
  }
}

class Notification {
  final String message;
  final DateTime dateTime;
  bool isRead;

  Notification({
    required this.message,
    required this.dateTime,
    this.isRead = false,
  });
}
