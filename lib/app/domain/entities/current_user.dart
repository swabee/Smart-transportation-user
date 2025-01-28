import 'package:equatable/equatable.dart';

/// {@template user}
/// CurrentUser model
///
/// [CurrentUser.empty] represents an unauthenticated user.
/// {@endtemplate}
class CurrentUser extends Equatable {
  /// {@macro user}
  const CurrentUser({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = CurrentUser(id: '');

  /// Method to check if the user is logged in or not.
  bool get isEmpty => id.isEmpty;

  @override
  List<Object?> get props => [email, id, name, photo];
}
