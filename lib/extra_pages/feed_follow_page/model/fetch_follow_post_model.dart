// import 'package:tingle/page/feed_page/model/fetch_post_model.dart';
//
// class FetchFollowPostModel {
//   FetchFollowPostModel({
//     bool? status,
//     String? message,
//     List<Post>? post,
//   }) {
//     _status = status;
//     _message = message;
//     _post = post;
//   }
//
//   FetchFollowPostModel.fromJson(dynamic json) {
//     _status = json['status'];
//     _message = json['message'];
//     if (json['post'] != null) {
//       _post = [];
//       json['post'].forEach((v) {
//         _post?.add(Post.fromJson(v));
//       });
//     }
//   }
//   bool? _status;
//   String? _message;
//   List<Post>? _post;
//   FetchFollowPostModel copyWith({
//     bool? status,
//     String? message,
//     List<Post>? post,
//   }) =>
//       FetchFollowPostModel(
//         status: status ?? _status,
//         message: message ?? _message,
//         post: post ?? _post,
//       );
//   bool? get status => _status;
//   String? get message => _message;
//   List<Post>? get post => _post;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = _status;
//     map['message'] = _message;
//     if (_post != null) {
//       map['post'] = _post?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
//
// // class Post {
// //   Post({
// //     String? id,
// //     String? caption,
// //     List<PostImage>? postImage,
// //     int? shareCount,
// //     String? createdAt,
// //     String? postId,
// //     bool? isFake,
// //     List<String>? hashTag,
// //     String? userId,
// //     String? name,
// //     String? userName,
// //     int? age,
// //     String? countryFlagImage,
// //     String? userImage,
// //     bool? isProfilePicBanned,
// //     bool? isVerified,
// //     bool? isLike,
// //     bool? isFollow,
// //     int? totalLikes,
// //     int? totalComments,
// //     String? time,
// //   }) {
// //     _id = id;
// //     _caption = caption;
// //     _postImage = postImage;
// //     _shareCount = shareCount;
// //     _createdAt = createdAt;
// //     _postId = postId;
// //     _isFake = isFake;
// //     _hashTag = hashTag;
// //     _userId = userId;
// //     _name = name;
// //     _userName = userName;
// //     _age = age;
// //     _countryFlagImage = countryFlagImage;
// //     _userImage = userImage;
// //     _isProfilePicBanned = isProfilePicBanned;
// //     _isVerified = isVerified;
// //     _isLike = isLike;
// //     _isFollow = isFollow;
// //     _totalLikes = totalLikes;
// //     _totalComments = totalComments;
// //     _time = time;
// //   }
// //
// //   Post.fromJson(dynamic json) {
// //     _id = json['_id'];
// //     _caption = json['caption'];
// //     if (json['postImage'] != null) {
// //       _postImage = [];
// //       json['postImage'].forEach((v) {
// //         _postImage?.add(PostImage.fromJson(v));
// //       });
// //     }
// //     _shareCount = json['shareCount'];
// //     _createdAt = json['createdAt'];
// //     _postId = json['postId'];
// //     _isFake = json['isFake'];
// //     _hashTag = json['hashTag'] != null ? json['hashTag'].cast<String>() : [];
// //     _userId = json['userId'];
// //     _name = json['name'];
// //     _userName = json['userName'];
// //     _age = json['age'];
// //     _countryFlagImage = json['countryFlagImage'];
// //     _userImage = json['userImage'];
// //     _isProfilePicBanned = json['isProfilePicBanned'];
// //     _isVerified = json['isVerified'];
// //     _isLike = json['isLike'];
// //     _isFollow = json['isFollow'];
// //     _totalLikes = json['totalLikes'];
// //     _totalComments = json['totalComments'];
// //     _time = json['time'];
// //   }
// //   String? _id;
// //   String? _caption;
// //   List<PostImage>? _postImage;
// //   int? _shareCount;
// //   String? _createdAt;
// //   String? _postId;
// //   bool? _isFake;
// //   List<String>? _hashTag;
// //   String? _userId;
// //   String? _name;
// //   String? _userName;
// //   int? _age;
// //   String? _countryFlagImage;
// //   String? _userImage;
// //   bool? _isProfilePicBanned;
// //   bool? _isVerified;
// //   bool? _isLike;
// //   bool? _isFollow;
// //   int? _totalLikes;
// //   int? _totalComments;
// //   String? _time;
// //   Post copyWith({
// //     String? id,
// //     String? caption,
// //     List<PostImage>? postImage,
// //     int? shareCount,
// //     String? createdAt,
// //     String? postId,
// //     bool? isFake,
// //     List<String>? hashTag,
// //     String? userId,
// //     String? name,
// //     String? userName,
// //     int? age,
// //     String? countryFlagImage,
// //     String? userImage,
// //     bool? isProfilePicBanned,
// //     bool? isVerified,
// //     bool? isLike,
// //     bool? isFollow,
// //     int? totalLikes,
// //     int? totalComments,
// //     String? time,
// //   }) =>
// //       Post(
// //         id: id ?? _id,
// //         caption: caption ?? _caption,
// //         postImage: postImage ?? _postImage,
// //         shareCount: shareCount ?? _shareCount,
// //         createdAt: createdAt ?? _createdAt,
// //         postId: postId ?? _postId,
// //         isFake: isFake ?? _isFake,
// //         hashTag: hashTag ?? _hashTag,
// //         userId: userId ?? _userId,
// //         name: name ?? _name,
// //         userName: userName ?? _userName,
// //         age: age ?? _age,
// //         countryFlagImage: countryFlagImage ?? _countryFlagImage,
// //         userImage: userImage ?? _userImage,
// //         isProfilePicBanned: isProfilePicBanned ?? _isProfilePicBanned,
// //         isVerified: isVerified ?? _isVerified,
// //         isLike: isLike ?? _isLike,
// //         isFollow: isFollow ?? _isFollow,
// //         totalLikes: totalLikes ?? _totalLikes,
// //         totalComments: totalComments ?? _totalComments,
// //         time: time ?? _time,
// //       );
// //   String? get id => _id;
// //   String? get caption => _caption;
// //   List<PostImage>? get postImage => _postImage;
// //   int? get shareCount => _shareCount;
// //   String? get createdAt => _createdAt;
// //   String? get postId => _postId;
// //   bool? get isFake => _isFake;
// //   List<String>? get hashTag => _hashTag;
// //   String? get userId => _userId;
// //   String? get name => _name;
// //   String? get userName => _userName;
// //   int? get age => _age;
// //   String? get countryFlagImage => _countryFlagImage;
// //   String? get userImage => _userImage;
// //   bool? get isProfilePicBanned => _isProfilePicBanned;
// //   bool? get isVerified => _isVerified;
// //   bool? get isLike => _isLike;
// //   bool? get isFollow => _isFollow;
// //   int? get totalLikes => _totalLikes;
// //   int? get totalComments => _totalComments;
// //   String? get time => _time;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['_id'] = _id;
// //     map['caption'] = _caption;
// //     if (_postImage != null) {
// //       map['postImage'] = _postImage?.map((v) => v.toJson()).toList();
// //     }
// //     map['shareCount'] = _shareCount;
// //     map['createdAt'] = _createdAt;
// //     map['postId'] = _postId;
// //     map['isFake'] = _isFake;
// //     map['hashTag'] = _hashTag;
// //     map['userId'] = _userId;
// //     map['name'] = _name;
// //     map['userName'] = _userName;
// //     map['age'] = _age;
// //     map['countryFlagImage'] = _countryFlagImage;
// //     map['userImage'] = _userImage;
// //     map['isProfilePicBanned'] = _isProfilePicBanned;
// //     map['isVerified'] = _isVerified;
// //     map['isLike'] = _isLike;
// //     map['isFollow'] = _isFollow;
// //     map['totalLikes'] = _totalLikes;
// //     map['totalComments'] = _totalComments;
// //     map['time'] = _time;
// //     return map;
// //   }
// // }
//
// // class PostImage {
// //   PostImage({
// //     String? url,
// //     bool? isBanned,
// //     String? id,
// //   }) {
// //     _url = url;
// //     _isBanned = isBanned;
// //     _id = id;
// //   }
// //
// //   PostImage.fromJson(dynamic json) {
// //     _url = json['url'];
// //     _isBanned = json['isBanned'];
// //     _id = json['_id'];
// //   }
// //   String? _url;
// //   bool? _isBanned;
// //   String? _id;
// //   PostImage copyWith({
// //     String? url,
// //     bool? isBanned,
// //     String? id,
// //   }) =>
// //       PostImage(
// //         url: url ?? _url,
// //         isBanned: isBanned ?? _isBanned,
// //         id: id ?? _id,
// //       );
// //   String? get url => _url;
// //   bool? get isBanned => _isBanned;
// //   String? get id => _id;
// //
// //   Map<String, dynamic> toJson() {
// //     final map = <String, dynamic>{};
// //     map['url'] = _url;
// //     map['isBanned'] = _isBanned;
// //     map['_id'] = _id;
// //     return map;
// //   }
// // }
