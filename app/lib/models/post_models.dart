class PostData {
  final String desc;
  final List likes;
  final List comments;
  final String? image;
  final String subject;
  final String uid;
  final String postId;
  final String? imagePath;

  PostData(this.desc, this.likes, this.comments, this.image, this.subject,
      this.uid, this.postId, this.imagePath);
}
