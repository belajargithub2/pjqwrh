class UserChangePasswordRequest {
  String? confirmNewPassword;
  String? currentPassword;
  String? newPassword;
  String? userId;

  UserChangePasswordRequest(
      {this.confirmNewPassword,
        this.currentPassword,
        this.newPassword,
        this.userId});

  UserChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    confirmNewPassword = json['confirm_new_password'];
    currentPassword = json['current_password'];
    newPassword = json['new_password'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm_new_password'] = this.confirmNewPassword;
    data['current_password'] = this.currentPassword;
    data['new_password'] = this.newPassword;
    data['user_id'] = this.userId;
    return data;
  }
}
