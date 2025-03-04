import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';
import 'package:kobo_kobo/ui_widgets/ui_widgets.dart';
import '../../../navigation/navigation.dart';
import 'curved_painter.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> transactionData;

  const TransactionDetailsScreen({
    super.key,
    required this.transactionData,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncoming = !(transactionData['isOutgoing'] ?? false);
    final String senderOrBeneficiary = isIncoming
        ? (transactionData['sender'] ?? 'Unknown')
        : (transactionData['beneficiary'] ?? 'Unknown');

    return AppScaffoldWidget(
      padding: const EdgeInsets.all(0.0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180.h),
        child: Stack(
          children: [
            CustomPaint(
              // i didnt get the color of the curve
              painter: CurvedPainter(
                fillColor: AppColors.appPrimaryColor.withValues(alpha: 0.1),
                borderColor: const Color(0xFFFF7517),
                borderWidth: 1.0,
              ),
              child: Container(height: 180.h),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon:
                    const Icon(Icons.chevron_left_rounded, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Transaction Details',
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.black.withValues(alpha: 1),
                  fontSize: Insets.dim_18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              centerTitle: true,
            ),
            Positioned(
              bottom: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.orange,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: LocalImage(
                      emailApvImg,
                      height: 40.h,
                      width: 40.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  '${isIncoming ? "Incoming" : "Outgoing"} Transfer ${isIncoming ? "from" : "to"} $senderOrBeneficiary',
                  // style: TextStyle(
                  //   fontSize: 18.sp,
                  //   fontWeight: FontWeight.w500,
                  // ),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black.withValues(alpha: 1),
                    fontSize: Insets.dim_18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  '${isIncoming ? "+" : "-"} ₦ ${transactionData['amount'] ?? '0'}',
                  // style: TextStyle(
                  //   fontSize: 32.sp,
                  //   fontWeight: FontWeight.bold,
                  // ),
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.black.withValues(alpha: 1),
                    fontSize: Insets.dim_32.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  'Successful',
                  // style: TextStyle(
                  //   color: Colors.green,
                  //   fontSize: 16.sp,
                  //   fontWeight: FontWeight.w500,
                  // ),
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.green,
                    fontSize: Insets.dim_16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              if (!isIncoming) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Service Charge',
                      // style: TextStyle(
                      //   fontSize: 14.sp,
                      //   color: Colors.grey[600],
                      // ),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                        fontSize: Insets.dim_14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₦${transactionData['serviceCharge'] ?? '0'}',
                      // style: TextStyle(
                      //   fontSize: 14.sp,
                      //   color: Colors.black,
                      // ),
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withValues(alpha: 1),
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: Colors.grey[300], height: 1),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount Paid',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withOpacity(0.5),
                        fontSize: Insets.dim_14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₦${transactionData['totalAmount'] ?? '0'}',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.black.withValues(alpha: 1),
                        fontSize: Insets.dim_16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Divider(color: Colors.grey[300], height: 1),
              ],
              SizedBox(height: 30.h),
              if (isIncoming) ...[
                _buildDetailRow('Sender', senderOrBeneficiary, context),
                SizedBox(height: 30.h),
              ],
              Text(
                'Details',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              if (!isIncoming) ...[
                // SizedBox(height: 20.h),
                _buildDetailRow(
                    'Beneficiary Name', senderOrBeneficiary, context),
                SizedBox(height: 20.h),
              ],
              _buildDetailRow(
                  'Remark', transactionData['remark'] ?? 'No remark', context),
              SizedBox(height: 20.h),
              _buildDetailRow('Transaction Date',
                  transactionData['transactionDate'] ?? 'Unknown', context),
              SizedBox(height: 20.h),
              _buildDetailRow('Transaction\nReference',
                  transactionData['reference'] ?? 'Unknown', context),
              SizedBox(height: 20.h),
              _buildDetailRow('Session ID',
                  transactionData['sessionId'] ?? 'Unknown', context),
              // const Spacer(),
              const YBox(Insets.dim_22),
              AppPrimaryButton(
                textTitle: "Share Receipt",
                action: () {
                  // Navigator.pop(context);
                  AppNavigator.of(context).pop();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              // style: TextStyle(
              //   fontSize: 14.sp,
              //   color: Colors.grey[600],
              // ),
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.black.withOpacity(0.6),
                fontSize: Insets.dim_14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              value,
              // style: TextStyle(
              //   fontSize: 14.sp,
              //   color: Colors.black,
              // ),
              style: context.textTheme.bodyMedium!.copyWith(
                color: AppColors.black.withOpacity(1),
                fontSize: Insets.dim_16.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(
          color: Colors.grey[300],
          height: 1,
        ),
      ],
    );
  }
}
