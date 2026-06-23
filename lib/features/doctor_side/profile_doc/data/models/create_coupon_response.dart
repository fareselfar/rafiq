class CreateCouponResponse {
  final String? message;
  final int? couponId;

  const CreateCouponResponse({this.message, this.couponId});

  factory CreateCouponResponse.fromJson(Map<String, dynamic> json) {
    return CreateCouponResponse(
      message: json['message'],
      couponId: json['couponId'],
    );
  }
}
