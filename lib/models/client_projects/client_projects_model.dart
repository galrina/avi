///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ProjectsModel {
  String? userId;
  String? freelancerEmail;
  String? createdOn;
  String? freelancerId;
  String? clientName;
  String? freelancerName;
  String? isApproved;
  String? projectId;
  String? title;

  ProjectsModel({
    this.userId,
    this.freelancerEmail,
    this.createdOn,
    this.freelancerId,
    this.isApproved,
    this.clientName,
    this.freelancerName,
    this.projectId,
    this.title,
  });

  ProjectsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId']?.toString();
    freelancerEmail = json['freelancerEmail']?.toString();
    createdOn = json['createdOn']?.toString();
    freelancerId = json['freelancerId']?.toString();
    clientName = json['clientName']?.toString();
    freelancerName = json['freelancerName']?.toString();
    isApproved = json['isApproved'].toString();
    projectId = json['projectId']?.toString();
    title = json['title']?.toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['freelancerEmail'] = freelancerEmail;
    data['createdOn'] = createdOn;
    data['clientName'] = clientName;
    data['freelancerName'] = freelancerName;
    data['freelancerId'] = freelancerId;
    data['isApproved'] = isApproved;
    data['projectId'] = projectId;
    data['title'] = title;
    return data;
  }
}
