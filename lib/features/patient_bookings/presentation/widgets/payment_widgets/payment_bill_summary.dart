// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:rafiq/core/theme/app_colors.dart';
// import 'package:rafiq/core/theme/app_text_styles.dart';
// import 'package:rafiq/core/widgets/spacing_widget.dart';
// import 'package:rafiq/features/patient_bookings/domain/entities/bookings_entity.dart';

// class PaymentBillSummary extends StatelessWidget {
//   final BookingEntity booking;
//   const PaymentBillSummary({super.key, required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(color: const Color(0xFFE8F1FF)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'تفاصيل الفاتورة',
//             style: AppTypography.doctorName.copyWith(fontSize: 16.sp),
//           ),
//           const HeightSpace(16),

//           _buildBillRow('${booking.subTotal}', "سعر الكشف", isTotal: false),
//           const HeightSpace(10),

//           _buildBillRow('${booking.discount}', "خصم", isTotal: false),

//           const HeightSpace(12),
//           const Divider(color: Color(0xFFE8F1FF), thickness: 1),
//           const HeightSpace(12),

//           _buildBillRow(
//             '${booking.totalPrice}',
//             "المجموع الكلي",
//             isTotal: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBillRow(String label, String value, {required bool isTotal}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: isTotal ? 16.sp : 14.sp,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
//             color: isTotal ? Colors.black : Colors.black87,
//           ),
//         ),

//         Text(
//           label,
//           style: TextStyle(
//             fontSize: isTotal ? 16.sp : 14.sp,
//             fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//             color: isTotal ? AppColors.primary : Colors.grey.shade700,
//           ),
//         ),
//       ],
//     );
//   }
// }