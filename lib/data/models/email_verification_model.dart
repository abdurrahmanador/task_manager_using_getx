class EmailVerificationModel {
  String? status;
  Data? data;

  EmailVerificationModel({this.status, this.data});

  factory EmailVerificationModel.fromJson(Map<String, dynamic> json) {
    return EmailVerificationModel(
      status: json['status'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'status': status,
      'data': this.data?.toJson(),
    };
    return data;
  }
}

class Data {
  List<String>? accepted;
  List<String>? rejected;
  List<String>? ehlo;
  int? envelopeTime;
  int? messageTime;
  int? messageSize;
  String? response;
  Envelope? envelope;
  String? messageId;

  Data({
    this.accepted,
    this.rejected,
    this.ehlo,
    this.envelopeTime,
    this.messageTime,
    this.messageSize,
    this.response,
    this.envelope,
    this.messageId,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accepted: json['accepted'] != null
          ? List<String>.from(json['accepted'])
          : null,
      rejected: json['rejected'] != null
          ? List<String>.from(json['rejected'])
          : null,
      ehlo: json['ehlo'] != null ? List<String>.from(json['ehlo']) : null,
      envelopeTime: json['envelopeTime'],
      messageTime: json['messageTime'],
      messageSize: json['messageSize'],
      response: json['response'],
      envelope: json['envelope'] != null
          ? Envelope.fromJson(json['envelope'])
          : null,
      messageId: json['messageId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'accepted': accepted,
      'rejected': rejected,
      'ehlo': ehlo,
      'envelopeTime': envelopeTime,
      'messageTime': messageTime,
      'messageSize': messageSize,
      'response': response,
      'envelope': envelope?.toJson(),
      'messageId': messageId,
    };
    return data;
  }
}

class Envelope {
  String? from;
  List<String>? to;

  Envelope({this.from, this.to});

  factory Envelope.fromJson(Map<String, dynamic> json) {
    return Envelope(
      from: json['from'],
      to: json['to'] != null ? List<String>.from(json['to']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'from': from,
      'to': to,
    };
    return data;
  }
}
