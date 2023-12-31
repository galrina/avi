///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class RecordScreenshotsModel {
/*
{
  "capturedScreeShot": "",
  "createdOn": "",
  "projectId": "",
  "recordId": "",
  "screenshotDocumentId": ""
}
*/

  String? capturedScreeShot;
  String? createdOn;
  String? projectId;
  String? recordId;
  String? screenshotDocumentId;

  RecordScreenshotsModel({
    this.capturedScreeShot,
    this.createdOn,
    this.projectId,
    this.recordId,
    this.screenshotDocumentId,
  });
  RecordScreenshotsModel.fromJson(Map<String, dynamic> json) {
    capturedScreeShot = json['capturedScreeShot']?.toString();
    createdOn = json['createdOn']?.toString();
    projectId = json['projectId']?.toString();
    recordId = json['recordId']?.toString();
    screenshotDocumentId = json['screenshotDocumentId']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['capturedScreeShot'] = capturedScreeShot;
    data['createdOn'] = createdOn;
    data['projectId'] = projectId;
    data['recordId'] = recordId;
    data['screenshotDocumentId'] = screenshotDocumentId;
    return data;
  }
}