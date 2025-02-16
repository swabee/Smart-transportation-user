import 'package:cloud_firestore/cloud_firestore.dart';

class WalletHistoryModel {
  final String id;
  final String title;
  final String content;
  final bool isCredited;
  final Timestamp createdAt;

  WalletHistoryModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isCredited,
    required this.createdAt,
  });

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) {
    return WalletHistoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      isCredited: json['isCredited'] as bool,
      createdAt: json['createdAt'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isCredited': isCredited,
      'createdAt': createdAt,
    };
  }

  WalletHistoryModel copyWith({
    String? id,
    String? title,
    String? content,
    bool? isCredited,
    Timestamp? createdAt,
  }) {
    return WalletHistoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isCredited: isCredited ?? this.isCredited,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}