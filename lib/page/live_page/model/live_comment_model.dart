class LiveCommentModel {
  int type;
  String userId;
  String name;
  String image;
  String commentText;
  bool isBanned;
  String? emoji;

  LiveCommentModel({
    required this.type,
    required this.userId,
    required this.name,
    required this.image,
    required this.commentText,
    required this.isBanned,
    this.emoji,
  });
}
