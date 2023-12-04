///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ClientProjectsModel {

  String? userId;
  String? freelancerEmail;
  String? createdOn;
  String? freelancerId;
  String? isApproved;
  String? projectId;
  String? title;

  ClientProjectsModel({
    this.userId,
    this.freelancerEmail,
    this.createdOn,
    this.freelancerId,
    this.isApproved,
    this.projectId,
    this.title,
  });
  ClientProjectsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId']?.toString();
    freelancerEmail = json['freelancerEmail']?.toString();
    createdOn = json['createdOn']?.toString();
    freelancerId = json['freelancerId']?.toString();
    isApproved = json['isApproved'].toString();
    projectId = json['projectId']?.toString();
    title = json['title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['freelancerEmail'] = freelancerEmail;
    data['createdOn'] = createdOn;
    data['freelancerId'] = freelancerId;
    data['isApproved'] = isApproved;
    data['projectId'] = projectId;
    data['title'] = title;
    return data;
  }
}