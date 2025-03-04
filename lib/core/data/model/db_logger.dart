import 'dart:convert';

import 'package:equatable/equatable.dart';

class DBLoggerRequest extends Equatable {
  const DBLoggerRequest({
    required this.url,
    required this.email,
    required this.deviceToken,
    required this.request,
    required this.tag,
    required this.response,
  });

  factory DBLoggerRequest.fromMap(Map<String, dynamic> map) {
    return DBLoggerRequest(
      url: map['url'] ?? '',
      email: map['email'] ?? '',
      deviceToken: map['deviceToken'] ?? '',
      request: map['request'] ?? {},
      tag: map['tag'] ?? '',
      response: map['response'],
    );
  }

  factory DBLoggerRequest.empty() {
    return const DBLoggerRequest(
      url: '',
      email: '',
      deviceToken: '',
      request: {},
      tag: '',
      response: null,
    );
  }

  factory DBLoggerRequest.fromJson(String source) =>
      DBLoggerRequest.fromMap(json.decode(source) as Map<String, dynamic>);
  final String url;
  final String email;
  final String deviceToken;
  final Map request;
  final String tag;
  final dynamic response;

  @override
  List<Object?> get props => [
        url,
        email,
        deviceToken,
        request,
        tag,
        response,
      ];

  DBLoggerRequest copyWith({
    String? url,
    String? email,
    String? deviceToken,
    Map? request,
    String? tag,
    dynamic response,
  }) {
    return DBLoggerRequest(
      url: url ?? this.url,
      email: email ?? this.email,
      deviceToken: deviceToken ?? this.deviceToken,
      request: request ?? this.request,
      tag: tag ?? this.tag,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'email': email,
      'deviceToken': deviceToken,
      'request': request,
      'tag': tag,
      'response': response,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;
}
