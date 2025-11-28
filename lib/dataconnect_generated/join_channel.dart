part of 'generated.dart';

class JoinChannelVariablesBuilder {
  String channelId;

  final FirebaseDataConnect _dataConnect;
  JoinChannelVariablesBuilder(this._dataConnect, {required  this.channelId,});
  Deserializer<JoinChannelData> dataDeserializer = (dynamic json)  => JoinChannelData.fromJson(jsonDecode(json));
  Serializer<JoinChannelVariables> varsSerializer = (JoinChannelVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<JoinChannelData, JoinChannelVariables>> execute() {
    return ref().execute();
  }

  MutationRef<JoinChannelData, JoinChannelVariables> ref() {
    JoinChannelVariables vars= JoinChannelVariables(channelId: channelId,);
    return _dataConnect.mutation("JoinChannel", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class JoinChannelChannelParticipantInsert {
  final String userId;
  final String channelId;
  JoinChannelChannelParticipantInsert.fromJson(dynamic json):
  
  userId = nativeFromJson<String>(json['userId']),
  channelId = nativeFromJson<String>(json['channelId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinChannelChannelParticipantInsert otherTyped = other as JoinChannelChannelParticipantInsert;
    return userId == otherTyped.userId && 
    channelId == otherTyped.channelId;
    
  }
  @override
  int get hashCode => Object.hashAll([userId.hashCode, channelId.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['userId'] = nativeToJson<String>(userId);
    json['channelId'] = nativeToJson<String>(channelId);
    return json;
  }

  JoinChannelChannelParticipantInsert({
    required this.userId,
    required this.channelId,
  });
}

@immutable
class JoinChannelData {
  final JoinChannelChannelParticipantInsert channelParticipant_insert;
  JoinChannelData.fromJson(dynamic json):
  
  channelParticipant_insert = JoinChannelChannelParticipantInsert.fromJson(json['channelParticipant_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinChannelData otherTyped = other as JoinChannelData;
    return channelParticipant_insert == otherTyped.channelParticipant_insert;
    
  }
  @override
  int get hashCode => channelParticipant_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['channelParticipant_insert'] = channelParticipant_insert.toJson();
    return json;
  }

  JoinChannelData({
    required this.channelParticipant_insert,
  });
}

@immutable
class JoinChannelVariables {
  final String channelId;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  JoinChannelVariables.fromJson(Map<String, dynamic> json):
  
  channelId = nativeFromJson<String>(json['channelId']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final JoinChannelVariables otherTyped = other as JoinChannelVariables;
    return channelId == otherTyped.channelId;
    
  }
  @override
  int get hashCode => channelId.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['channelId'] = nativeToJson<String>(channelId);
    return json;
  }

  JoinChannelVariables({
    required this.channelId,
  });
}

