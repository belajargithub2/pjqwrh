import 'dart:convert';

ChannelListResponse merchantListResponseFromJson(String str) => ChannelListResponse.fromJson(json.decode(str));

String merchantListResponseToJson(ChannelListResponse data) => json.encode(data.toJson());

class ChannelListResponse {
  ChannelListResponse({
    this.channels,
    this.message
  });

  List<ChannelData>? channels;
  String? message;

  factory ChannelListResponse.fromJson(Map<String, dynamic> json) => ChannelListResponse(
    message: json["message"] == null ? null : json["message"],
    channels: json["data"] == null ? null :
      List<ChannelData>.from(json["data"].map((x) => ChannelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "data": channels == null ? null : List<dynamic>.from(channels!.map((x) => x.toJson())),
  };
}

class ChannelData {
  ChannelData({
    this.channelId,
    this.channelName,
  });

  String? channelId;
  String? channelName;

  factory ChannelData.fromJson(Map<String, dynamic> json) => ChannelData(
    channelId: json["channel_id"] == null ? null : json["channel_id"],
    channelName: json["channel_name"] == null ? null : json["channel_name"],
  );

  Map<String, dynamic> toJson() => {
    "channel_id": channelId == null ? null : channelId,
    "channel_name": channelName == null ? null : channelName,
  };
}