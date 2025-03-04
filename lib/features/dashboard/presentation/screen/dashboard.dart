import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kobo_kobo/features/dashboard/dashboard.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../ui_widgets/textfields/date_picker_form_field.dart';
import '../../../navigation/navigation.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _current = 0;
  bool _showName = false;
  bool _showAllActivities = false;
  bool _showServices = true;
  final List<Map<String, dynamic>> _activities = [];
  List<Map<String, dynamic>> _filteredActivities = [];
  late final TextEditingController _searchController;
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  final List<String> tenureOptions = ['Day', 'Week', 'Month', 'Custom'];
  bool _isBalanceVisible = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_searchListener);
    _generateRandomActivities();
    _filteredActivities = List.from(_activities);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchListener);
    _searchController.dispose();
    _daysController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _searchListener() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredActivities = List.from(_activities);
      });
    } else {
      setState(() {
        _filteredActivities = _activities.where((activity) {
          final name = activity['name'].toString().toLowerCase();
          final amount = activity['amount'].toString();
          return name.contains(query) || amount.contains(query);
        }).toList();
      });
    }
  }

  Future<void> _showSelectionBottomSheet(BuildContext context, String title,
      List<String> items, Function(String) onSelect) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.all(16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: Insets.dim_18.sp,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                ),
                SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index]),
                        onTap: () {
                          onSelect(items[index]);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTenureBottomSheet() {
    bool isApplyClicked = false;
    bool isClearClicked = false;
    bool isCloseClicked = false;

    if (tenureOptions.isEmpty) {
      return;
    }

    _showSelectionBottomSheet(
      context,
      'Select',
      tenureOptions,
      (String tenure) {
        setState(() {
          _daysController.text = tenure;
        });
      },
    ).then((_) {
      if (_daysController.text.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: Container(
                constraints: BoxConstraints(
                  minWidth: 400.w,
                  maxWidth: 500.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    DatePickerFormField(
                      labelText: 'From:',
                      hintText: 'DD/MM/YYYY',
                      controller: _fromDateController,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please select a date'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    DatePickerFormField(
                      labelText: 'To:',
                      hintText: 'DD/MM/YYYY',
                      controller: _toDateController,
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Please select a date'
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    _buildActionButton("Apply", isApplyClicked, () {
                      setState(() {
                        isApplyClicked = true;
                        isCloseClicked = false;
                        isClearClicked = false;
                        _filterActivitiesByTenure();
                      });
                      Navigator.of(context).pop();
                    }),
                    SizedBox(height: 12.h),
                    _buildActionButton("Clear", isClearClicked, () {
                      setState(() {
                        isApplyClicked = false;
                        isCloseClicked = false;
                        isClearClicked = true;
                        _fromDateController.clear();
                        _toDateController.clear();
                        _filteredActivities = List.from(_activities);
                      });
                    }),
                    SizedBox(height: 12.h),
                    _buildActionButton("Close", isCloseClicked, () {
                      setState(() {
                        isApplyClicked = false;
                        isCloseClicked = true;
                        isClearClicked = false;
                        _fromDateController.clear();
                        _toDateController.clear();
                      });
                      Navigator.of(context).pop();
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  void _filterActivitiesByTenure() {
    final now = DateTime.now();
    DateTime? fromDate;
    DateTime? toDate;

    switch (_daysController.text) {
      case 'Day':
        fromDate = now.subtract(const Duration(days: 1));
        toDate = now;
        break;
      case 'Week':
        fromDate = now.subtract(const Duration(days: 7));
        toDate = now;
        break;
      case 'Month':
        fromDate = now.subtract(const Duration(days: 30));
        toDate = now;
        break;
      case 'Custom':
        fromDate = DateFormat('dd/MM/yyyy').parse(_fromDateController.text);
        toDate = DateFormat('dd/MM/yyyy').parse(_toDateController.text);
        break;
    }

    setState(() {
      _filteredActivities = _activities.where((activity) {
        final activityDate = activity['date'] as DateTime;
        return activityDate.isAfter(fromDate!) &&
            activityDate.isBefore(toDate!.add(const Duration(days: 1)));
      }).toList();
    });
  }

  Widget _buildActionButton(
      String title, bool isClicked, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40.h,
        width: 200.w,
        decoration: BoxDecoration(
          color: title == "Clear"
              ? (isClicked
                  ? AppColors.appPrimaryButton
                  : AppColors.backButtonColor)
              : (isClicked ? AppColors.appPrimaryButton : Colors.transparent),
          border: Border.all(
            color: title == 'Clear'
                ? AppColors.backButtonColor
                : AppColors.appPrimaryColor,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            title,
            style: context.textTheme.bodyMedium!.copyWith(
              color: title == "Clear"
                  ? (isClicked ? Colors.white : Colors.black)
                  : (isClicked ? Colors.white : AppColors.appPrimaryButton),
              fontSize: Insets.dim_14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _generateRandomActivities() {
    final random = Random();
    final names = [
      'John Maxwell',
      'Richeal Lin',
      'Emma Thompson',
      'Michael Chen',
      'Sophia Rodriguez',
      'Liam O\'Connor',
      'Aisha Patel',
      'Yuki Tanaka',
      'Gabriel Santos',
      'Zoe Nguyen'
    ];
    _activities.clear();
    for (int i = 0; i < max(20, 6); i++) {
      _activities.add({
        'name': names[random.nextInt(names.length)],
        'isOutgoing': random.nextBool(),
        'amount': random.nextInt(10000) + 100,
        'date': DateTime.now().subtract(Duration(days: random.nextInt(30))),
        'sender': names[random.nextInt(names.length)],
      });
    }
    _activities.sort((a, b) => b['date'].compareTo(a['date']));
  }

  void _showCoinBalance(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Coin Balance',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(0.8),
              fontSize: Insets.dim_18.sp,
            ),
          ),
          content: Text(
            _isBalanceVisible ? '40000' : '****',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(
              color: AppColors.black.withOpacity(0.8),
              fontSize: Insets.dim_14.sp,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _showAllActivities
            ? IconButton(
                icon: const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.black,
                ),
                onPressed: () {
                  setState(() {
                    _showAllActivities = false;
                    _showServices = true;
                  });
                },
              )
            : Row(
                children: [
                  InkWell(
                    onTap: () => AppNavigator.of(context).push(AppRoutes.more),
                    child: const HostedImage(
                      'https://picsum.photos/200/300',
                    ),
                  ),
                  XBox(Insets.dim_8.w),
                  Text(
                    'Hi, Temitope! ',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                      fontSize: Insets.dim_14.sp,
                    ),
                  ).onTap(() => AppNavigator.of(context).push(AppRoutes.more)),
                ],
              ),
        const Spacer(),
        Row(
          children: [
            GestureDetector(
              child: Row(
                children: [
                  Icon(
                    PhosphorIcons.wallet(PhosphorIconsStyle.bold),
                    color: AppColors.black,
                    size: Insets.dim_24.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBalanceVisible = !_isBalanceVisible;
                        _showCoinBalance(context);
                      });
                    },
                    child: Icon(
                      _isBalanceVisible
                          ? PhosphorIcons.eye(PhosphorIconsStyle.bold)
                          : PhosphorIcons.eyeSlash(PhosphorIconsStyle.bold),
                      color: AppColors.black,
                      size: Insets.dim_14.sp,
                    ),
                  ),
                ],
              ),
            ),
            XBox(Insets.dim_8.w),
            IconButton(
              onPressed: () {
                AppNavigator.of(context).push(AppRoutes.notificationRoute);
              },
              icon: Badge.count(
                count: 2,
                child: Icon(
                  PhosphorIcons.bell(PhosphorIconsStyle.bold),
                  color: AppColors.black,
                  size: Insets.dim_24.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBVNVerification(BuildContext context) {
    return Row(
      children: [
        LocalSvgImage(purpleInfoSvg),
        XBox(Insets.dim_4.w),
        Text(
          'Complete your BVN Verification',
          style: context.textTheme.bodySmall!.copyWith(
            color: AppColors.black.withOpacity(0.8),
            fontSize: Insets.dim_14.sp,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }

  Widget _buildAccountCarousel(BuildContext context, dynamic money) {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        autoPlay: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        padEnds: false,
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return AccountBalanceBg(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Number',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.white,
                          fontSize: Insets.dim_12.sp,
                        ),
                      ),
                      YBox(Insets.dim_6.h),
                      Row(
                        children: [
                          Text(
                            _showName ? '0034507169' : '********7169',
                            style: context.textTheme.bodySmall!.copyWith(
                              color: AppColors.white,
                              fontSize: Insets.dim_14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          XBox(Insets.dim_16.w),
                          if (_showName)
                            const Icon(Icons.copy, color: AppColors.white)
                                .onTap(() {
                              setState(() {
                                Clipboard.setData(
                                  const ClipboardData(
                                    text: '0034507169\nVFD MFB\nAdisa Joshua',
                                  ),
                                ).then((_) {
                                  showInfoNotification(
                                    'Account Information copied to clipboard',
                                  );
                                });
                                _showName = false;
                              });
                            })
                          else
                            Icon(
                              PhosphorIcons.eyeSlash(PhosphorIconsStyle.fill),
                              color: AppColors.white,
                            ).onTap(() {
                              setState(() {
                                _showName = true;
                              });
                            }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const Divider(color: AppColors.white),
              Text(
                'Current Balance',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: Insets.dim_12.sp,
                ),
              ),
              YBox(Insets.dim_6.h),
              Row(
                children: [
                  Text(
                    money.formatWithCurrencySymbol(
                      12596397,
                      currencyShortName: 'NGN',
                    ),
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.white,
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  XBox(Insets.dim_16.w),
                  Icon(
                    PhosphorIcons.eyeSlash(PhosphorIconsStyle.fill),
                    color: AppColors.white,
                  ),
                ],
              ),
              const Divider(color: AppColors.white),
              Text(
                'Acct. Type',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: Insets.dim_12.sp,
                ),
              ),
              YBox(Insets.dim_6.h),
              Text(
                'Individual',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                  fontSize: Insets.dim_14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          [...List.generate(3, (index) => index)].asMap().entries.map((entry) {
        return Container(
          width: _current == entry.key ? Insets.dim_20.w : Insets.dim_14.w,
          height: _current == entry.key ? Insets.dim_20.h : Insets.dim_14.h,
          margin: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 4.0,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == entry.key
                ? AppColors.appPrimaryColor
                : AppColors.black.withOpacity(0.3),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildServices(BuildContext context, DashboardVm provider) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Services',
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(0.8),
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        YBox(Insets.dim_12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            provider.items(context).length,
            (index) {
              final data = provider.items(context)[index];
              return GestureDetector(
                onTap: data.onTap ?? () {},
                child: Column(
                  children: [
                    if (data.img != null)
                      Container(
                        height: Insets.dim_66.h,
                        width: Insets.dim_66.w,
                        padding: EdgeInsets.all(Insets.dim_10.sp),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          border: Border.all(color: AppColors.appPrimaryColor),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.appPrimaryColor.withOpacity(0.45),
                              blurRadius: 4,
                              offset: const Offset(0, 5),
                            )
                          ],
                        ),
                        child: LocalImage(
                          data.img!,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    YBox(Insets.dim_12.h),
                    FittedBox(
                      child: Text(
                        data.title,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: AppColors.black.withOpacity(0.8),
                          fontSize: Insets.dim_14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivities(BuildContext context, dynamic money) {
    return Column(
      children: [
        _showAllActivities
            ? Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'All Activities',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withOpacity(0.8),
                    fontSize: Insets.dim_16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Activities',
                    style: context.textTheme.bodySmall!.copyWith(
                      color: AppColors.black.withOpacity(0.8),
                      fontSize: Insets.dim_16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAllActivities = true;
                        _showServices = false;
                      });
                    },
                    child: Text(
                      'See all',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.appPrimaryColor,
                        fontSize: Insets.dim_14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
        _showAllActivities ? YBox(Insets.dim_16.h) : YBox(Insets.dim_1.h),
        if (_showAllActivities)
          Row(
            spacing: 5,
            children: [
              Expanded(
                child: SearchTextInputField(
                  controller: _searchController,
                  onChanged: (_) {},
                  title: 'Name, Amount, Narration',
                ),
              ),
              XBox(Insets.dim_8.w),
              Container(
                width: 100.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.black.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: TextButton(
                  onPressed: _showTenureBottomSheet,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _daysController.text.isEmpty
                              ? 'Select'
                              : _daysController.text,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: AppColors.black.withOpacity(0.5),
                            fontSize: Insets.dim_12.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        _showAllActivities ? YBox(Insets.dim_16.h) : YBox(Insets.dim_1.h),
        if (_filteredActivities.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history,
                    size: 48, color: AppColors.black.withOpacity(0.5)),
                YBox(Insets.dim_16.h),
                Text(
                  'No activities found',
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Insets.dim_16.h, horizontal: Insets.dim_8.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: AppColors.black.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Insets.dim_16.sp),
                topRight: Radius.circular(Insets.dim_16.sp),
              ),
            ),
            child: SizedBox(
              height: context.getHeight(_showAllActivities ? 0.6 : 0.54),
              child: ListView.builder(
                itemCount: _showAllActivities
                    ? _filteredActivities.length
                    : min(6, _filteredActivities.length),
                itemBuilder: (context, index) {
                  final activity = _filteredActivities[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransactionDetailsScreen(
                            transactionData: {
                              'amount': activity['amount'],
                              'beneficiary': activity['isOutgoing']
                                  ? activity['name']
                                  : null,
                              'sender': activity['isOutgoing']
                                  ? null
                                  : activity['sender'],
                              'isOutgoing': activity['isOutgoing'],
                              'serviceCharge': 10.75,
                              'totalAmount': activity['amount'] + 10.75,
                              'remark': 'Transaction',
                              'transactionDate':
                                  DateFormat('dd MMM yyyy, HH:mm:ss')
                                      .format(activity['date']),
                              'reference': '01234567890987654321',
                              'sessionId': '01234567890987654321',
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: Insets.dim_8.w,
                      ),
                      padding: EdgeInsets.only(
                        top: Insets.dim_16.h,
                        bottom: Insets.dim_16.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 0.5,
                            color: AppColors.black.withOpacity(0.3),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          LocalSvgImage(
                            activity['isOutgoing']
                                ? outflowArrowSvg
                                : inflowArrowSvg,
                          ),
                          XBox(Insets.dim_20.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity['name'],
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors.black,
                                    fontSize: Insets.dim_14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                YBox(Insets.dim_4.h),
                                Text(
                                  activity['isOutgoing']
                                      ? 'Outgoing transfer'
                                      : 'Incoming transfer',
                                  style: context.textTheme.bodySmall!.copyWith(
                                    color:
                                        AppColors.black.withValues(alpha: 0.6),
                                    fontSize: Insets.dim_10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${activity['isOutgoing'] ? '-' : '+'} ${money.formatWithCurrencySymbol(
                                  activity['amount'],
                                  currencyShortName: 'NGN',
                                )}',
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: activity['isOutgoing']
                                      ? AppColors.outgoingColor
                                      : AppColors.incomingColor,
                                  fontSize: Insets.dim_14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              YBox(Insets.dim_4.h),
                              Text(
                                DateFormat('dd/MM/yy').format(activity['date']),
                                style: context.textTheme.bodySmall!.copyWith(
                                  color: AppColors.black.withValues(alpha: 0.6),
                                  fontSize: Insets.dim_10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final money = context.money();
    final provider = context.watch<DashboardVm>();
    return AppScaffoldWidget(
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    _buildHeader(context),
                    YBox(Insets.dim_14.h),
                    _showAllActivities
                        ? const SizedBox.shrink()
                        : _buildBVNVerification(context),
                    YBox(Insets.dim_12.h),
                    _buildAccountCarousel(context, money),
                    YBox(Insets.dim_12.h),
                    _buildCarouselIndicators(),
                    YBox(Insets.dim_10.h),
                    if (_showServices) _buildServices(context, provider),
                    YBox(Insets.dim_16.h),
                    _buildRecentActivities(context, money),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
