part of 'models.dart';

class Comment extends Equatable {
  // "id_user": 11,
  // "id_merchant": null,
  // "id_feed": 13,
  // "merchant_name": null,
  // "user_name": "nikokevin29",
  // "comment": "tes comment postman",
  // "mention": null,
  // "created_at": "2021-01-31 20:34:29",
  // "updated_at": "2021-01-31 20:34:29"
  final int id;
  final int idMerchant;
  final int idFeed;
  final int idUser;
  final String merchantName;
  final String userName;
  final String comment;
  final String mention;
  final String createdAt;
  final String updatedAt;

  Comment({
    this.id,
    this.idMerchant,
    this.idFeed,
    this.idUser,
    this.merchantName,
    this.userName,
    this.comment,
    this.mention,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        idMerchant,
        idFeed,
        idUser,
        merchantName,
        userName,
        comment,
        mention,
        createdAt,
        updatedAt,
      ];

  factory Comment.fromJson(Map<String, dynamic> data) => Comment(
        id: data['id'],
        idMerchant: data['id_merchant'],
        merchantName: data['merchant_name'],
        userName: data['user_name'],
        idFeed: int.parse(data['id_feed'].toString()),
        idUser: data['id_user'],
        comment: data['comment'],
        mention: data['mention'],
        createdAt: data['created_at'],
        updatedAt: data['updated_at'],
      );
}
