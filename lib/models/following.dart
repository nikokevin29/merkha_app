part of 'models.dart';

class Following extends Equatable {
  final int id;
  final int idUser;
  final int following;
  final String createdAt;
  final String updatedAt;

  Following({
    this.id,
    this.idUser,
    this.following,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [idUser, following,createdAt,updatedAt,id];

  factory Following.fromJson(Map<String, dynamic> data) => Following(
        id: data['id'],
        idUser: data['category'],
        following: data['merchant_id'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );
}
