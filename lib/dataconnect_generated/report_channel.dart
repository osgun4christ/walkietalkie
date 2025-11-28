part of 'generated.dart';

class ReportChannelVariablesBuilder {
  String channelId;
  String reason;
  Optional<String> _details = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  ReportChannelVariablesBuilder details(String? t) {
   _details.value = t;
   return this;
  }

  ReportChannelVariablesBuilder(this._dataConnect, {required  this.channelId,required  this.reason,});
  Deserializer<ReportChannelData> dataDeserializer = (dynamic json)  => ReportChannelData.fromJson(jsonDecode(json));
  Serializer<ReportChannelVariables> varsSerializer = (ReportChannelVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<ReportChannelData, ReportChannelVariables>> execute() {
    return ref().execute();
  }

  MutationRef<ReportChannelData, ReportChannelVariables> ref() {
    ReportChannelVariables vars= ReportChannelVariables(channelId: channelId,reason: reason,details: _details,);
    return _dataConnect.mutation("ReportChannel", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class ReportChannelReportInsert {
  final String id;
  ReportChannelReportInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportChannelReportInsert otherTyped = other as ReportChannelReportInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  ReportChannelReportInsert({
    required this.id,
  });
}

@immutable
class ReportChannelData {
  final ReportChannelReportInsert report_insert;
  ReportChannelData.fromJson(dynamic json):
  
  report_insert = ReportChannelReportInsert.fromJson(json['report_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportChannelData otherTyped = other as ReportChannelData;
    return report_insert == otherTyped.report_insert;
    
  }
  @override
  int get hashCode => report_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['report_insert'] = report_insert.toJson();
    return json;
  }

  ReportChannelData({
    required this.report_insert,
  });
}

@immutable
class ReportChannelVariables {
  final String channelId;
  final String reason;
  late final Optional<String>details;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  ReportChannelVariables.fromJson(Map<String, dynamic> json):
  
  channelId = nativeFromJson<String>(json['channelId']),
  reason = nativeFromJson<String>(json['reason']) {
  
  
  
  
    details = Optional.optional(nativeFromJson, nativeToJson);
    details.value = json['details'] == null ? null : nativeFromJson<String>(json['details']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final ReportChannelVariables otherTyped = other as ReportChannelVariables;
    return channelId == otherTyped.channelId && 
    reason == otherTyped.reason && 
    details == otherTyped.details;
    
  }
  @override
  int get hashCode => Object.hashAll([channelId.hashCode, reason.hashCode, details.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['channelId'] = nativeToJson<String>(channelId);
    json['reason'] = nativeToJson<String>(reason);
    if(details.state == OptionalState.set) {
      json['details'] = details.toJson();
    }
    return json;
  }

  ReportChannelVariables({
    required this.channelId,
    required this.reason,
    required this.details,
  });
}

