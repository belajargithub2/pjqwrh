import 'dart:convert';

enum LimitType {BLUE, GOLD, PLATINUM}

enum LimitStatus {ACTIVE, INACTIVE_OVD, INACTIVE_RESTRUCTURE, TERMINATED_OVD, TERMINATED_BLACKLIST, TERMINATED_SUSPECT}

enum VerificationLimitStatus {VERIFY, NOT_VERIFY, RE_VERIFY, RENEWAL}

CutomerCheckLimitTypeResponse cutomerCheckLimitTypeResponseFromJson(String str) => CutomerCheckLimitTypeResponse.fromJson(json.decode(str));

String cutomerCheckLimitTypeResponseToJson(CutomerCheckLimitTypeResponse data) => json.encode(data.toJson());

class CutomerCheckLimitTypeResponse {
    CutomerCheckLimitTypeResponse({
        this.code,
        this.messages,
        this.data,
        this.errors,
    });

    int? code;
    String? messages;
    CutomerCheckLimitTypeData? data;
    CutomerCheckLimitTypeErrors? errors;

    factory CutomerCheckLimitTypeResponse.fromJson(Map<String, dynamic> json) => CutomerCheckLimitTypeResponse(
        code: json["code"],
        messages: json["messages"],
        data: json["data"] == null ? null : CutomerCheckLimitTypeData.fromJson(json["data"]),
        errors: json["errors"] == null ? null : CutomerCheckLimitTypeErrors.fromJson(json["errors"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "messages": messages,
        "data": data?.toJson(),
        "errors": errors?.toJson(),
    };
}

class CutomerCheckLimitTypeData {
    CutomerCheckLimitTypeData({
        this.customerId,
        this.fullName,
        this.customerRegisterStatus,
        this.limitCategory,
        this.isRegisteredKreditmu,
        this.verificationLimitStatus,
        this.limitStatus,
        this.isExpiredVerification,
        this.expiredLimit,
        this.verificationSchema,
        this.agreeToAcceptOtherOffering,
        this.documentAdditionalCheck,
    });

    int? customerId;
    String? fullName;
    String? customerRegisterStatus;
    LimitType? limitCategory;
    bool? isRegisteredKreditmu;
    VerificationLimitStatus? verificationLimitStatus;
    LimitStatus? limitStatus;
    bool? isExpiredVerification;
    String? expiredLimit;
    VerificationSchema? verificationSchema;
    bool? agreeToAcceptOtherOffering;
    bool? documentAdditionalCheck;

    factory CutomerCheckLimitTypeData.fromJson(Map<String, dynamic> json) => CutomerCheckLimitTypeData(
        customerId: json["customer_id"],
        fullName: json["full_name"],
        customerRegisterStatus: json["customer_register_status"],
        limitCategory: json["limit_category"] != "" ? LimitType.values.byName(json["limit_category"]) : null,
        isRegisteredKreditmu: json["is_registered_kreditmu"],
        verificationLimitStatus: json["verification_limit_status"] != "" ? VerificationLimitStatus.values.byName(json["verification_limit_status"] ): null,
        limitStatus: json["limit_status"] != "" ? LimitStatus.values.byName(json["limit_status"]) : null,
        isExpiredVerification: json["is_expired_verification"],
        expiredLimit: json["expired_limit"],
        verificationSchema: json["verification_schema"] == null ? null : VerificationSchema.fromJson(json["verification_schema"]),
        agreeToAcceptOtherOffering: json["agree_to_accept_other_offering"],
        documentAdditionalCheck: json["document_additional_check"],
    );

    Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "full_name": fullName,
        "customer_register_status": customerRegisterStatus,
        "limit_category": limitCategory != null ? limitCategory!.name : null,
        "is_registered_kreditmu": isRegisteredKreditmu,
        "verification_limit_status": verificationLimitStatus,
        "limit_status": limitStatus,
        "is_expired_verification": isExpiredVerification,
        "expired_limit": expiredLimit,
        "verification_schema": verificationSchema?.toJson(),
        "agree_to_accept_other_offering": agreeToAcceptOtherOffering,
        "document_additional_check": documentAdditionalCheck,
    };
}

class VerificationSchema {
    VerificationSchema({
        this.verifyData,
        this.idForgery,
        this.liveness,
        this.faceCompare,
        this.human,
    });

    VerifyData? verifyData;
    IdForgery? idForgery;
    Liveness? liveness;
    FaceCompare? faceCompare;
    Human? human;

    factory VerificationSchema.fromJson(Map<String, dynamic> json) => VerificationSchema(
        verifyData: json["verify_data"] == null ? null : VerifyData.fromJson(json["verify_data"]),
        idForgery: json["id_forgery"] == null ? null : IdForgery.fromJson(json["id_forgery"]),
        liveness: json["liveness"] == null ? null : Liveness.fromJson(json["liveness"]),
        faceCompare: json["face_compare"] == null ? null : FaceCompare.fromJson(json["face_compare"]),
        human: json["human"] == null ? null : Human.fromJson(json["human"]),
    );

    Map<String, dynamic> toJson() => {
        "verify_data": verifyData?.toJson(),
        "id_forgery": idForgery?.toJson(),
        "liveness": liveness?.toJson(),
        "face_compare": faceCompare?.toJson(),
        "human": human?.toJson(),
    };
}

class FaceCompare {
    FaceCompare({
        this.required,
        this.faceVerification,
    });

    bool? required;
    bool? faceVerification;

    factory FaceCompare.fromJson(Map<String, dynamic> json) => FaceCompare(
        required: json["required"],
        faceVerification: json["face_verification"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
        "face_verification": faceVerification,
    };
}

class Human {
    Human({
        this.required,
        this.humanVerification,
    });

    bool? required;
    bool? humanVerification;

    factory Human.fromJson(Map<String, dynamic> json) => Human(
        required: json["required"],
        humanVerification: json["human_verification"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
        "human_verification": humanVerification,
    };
}

class IdForgery {
    IdForgery({
        this.required,
        this.idForgeryVerification,
    });

    bool? required;
    bool? idForgeryVerification;

    factory IdForgery.fromJson(Map<String, dynamic> json) => IdForgery(
        required: json["required"],
        idForgeryVerification: json["id_forgery_verification"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
        "id_forgery_verification": idForgeryVerification,
    };
}

class Liveness {
    Liveness({
        this.required,
        this.livenessVerification,
    });

    bool? required;
    bool? livenessVerification;

    factory Liveness.fromJson(Map<String, dynamic> json) => Liveness(
        required: json["required"],
        livenessVerification: json["liveness_verification"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
        "liveness_verification": livenessVerification,
    };
}

class VerifyData {
    VerifyData({
        this.required,
        this.dataVerification,
    });

    bool? required;
    bool? dataVerification;

    factory VerifyData.fromJson(Map<String, dynamic> json) => VerifyData(
        required: json["required"],
        dataVerification: json["data_verification"],
    );

    Map<String, dynamic> toJson() => {
        "required": required,
        "data_verification": dataVerification,
    };
}

class CutomerCheckLimitTypeErrors {
    CutomerCheckLimitTypeErrors({
        this.parameter,
        this.message,
    });

    String? parameter;
    String? message;

    factory CutomerCheckLimitTypeErrors.fromJson(dynamic json) => CutomerCheckLimitTypeErrors(
        parameter: json["parameter"],
        message:  json["message"],
    );

    Map<String, dynamic> toJson() => {
        "parameter": parameter,
        "message": message,
    };
}