class GetEnvironmentModel {
  GetEnvironmentModel({
       this.clientId,
     this.redirectUrl,
     this.scope,
     this.purposeId,
     this.authApiUrl,
     this.subentity,
     this.codeChallenge,
      this.codeVerifier,});

  GetEnvironmentModel.fromJson(dynamic json) {
    clientId = json['clientId'];
    redirectUrl = json['redirectUrl'];
    scope = json['scope'];
    purposeId = json['purpose_id'];
    authApiUrl = json['authApiUrl'];
    subentity = json['subentity'];
    codeChallenge = json['code_challenge'];
    codeVerifier = json['code_verifier'];
  }
   String? clientId;
  String? redirectUrl;
  String? scope;
  String? purposeId;
  String? authApiUrl;
  String? subentity;
  String? codeChallenge;
  String? codeVerifier;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clientId'] = clientId;
    map['redirectUrl'] = redirectUrl;
    map['scope'] = scope;
    map['purpose_id'] = purposeId;
    map['authApiUrl'] = authApiUrl;
    map['subentity'] = subentity;
    map['code_challenge'] = codeChallenge;
    map['code_verifier'] = codeVerifier;
    return map;
  }

}