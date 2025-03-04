import 'package:equatable/equatable.dart';

class MailModel extends Equatable {
  const MailModel({
    required this.subject,
    this.body,
    this.email,
  });

  factory MailModel.empty() => const MailModel(
        subject: '',
      );

  final String subject;
  final String? body;
  final String? email;

  MailModel copyWith({
    String? subject,
    String? body,
    String? email,
  }) {
    return MailModel(
      subject: subject ?? this.subject,
      body: body ?? this.body,
      email: email ?? this.email,
    );
  }

  String toEmailString() {
    final data = <String, String>{};

    if (body?.isNotEmpty == true) {
      data['body'] = body!;
    }

    data['subject'] = subject;

    return data.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  @override
  List<Object?> get props {
    return [
      subject,
      body,
      email,
    ];
  }
}
