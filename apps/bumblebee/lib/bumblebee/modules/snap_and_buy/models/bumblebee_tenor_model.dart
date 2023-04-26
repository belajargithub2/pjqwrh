
class TenorModel{
  bool? status;
  String? firstInstallment;
  int? installmentAmount;
  int? insuranceFee;
  double? rate;
  int? tenor;
  int? tenorLimit;
  int? adminFee;
  int? totalPaymentAmount;
  int? payToDealerAmount;
  int? totalOtr;
  int? af;
  int? ntf;
  int? subsidyDealer;
  int? subsidyAdminDealer;
  int? subsidyRateDealer;
  String? productId;
  String? productOfferingId;
  bool? isAdminAsLoan;
  String? sessionId;

  TenorModel({
    this.status,
    this.firstInstallment,
    this.installmentAmount,
    this.insuranceFee,
    this.rate,
    this.tenor,
    this.tenorLimit,
    this.adminFee,
    this.totalPaymentAmount,
    this.payToDealerAmount,
    this.totalOtr,
    this.af = 0,
    this.ntf,
    this.subsidyDealer,
    this.subsidyAdminDealer,
    this.subsidyRateDealer,
    this.productId,
    this.productOfferingId,
    this.isAdminAsLoan,
    this.sessionId});
}