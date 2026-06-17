class CreateCouponRequest {
  final String code;
  final int usageLimit;

  const CreateCouponRequest({required this.code, required this.usageLimit});

  Map<String, dynamic> toJson() {
    return {"code": code, "usageLimit": usageLimit};
  }
}
