part of 'generated.dart';

class GetChannelsVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetChannelsVariablesBuilder(this._dataConnect, );
  Deserializer<GetChannelsData> dataDeserializer = (dynamic json)  => GetChannelsData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetChannelsData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetChannelsData, void> ref() {
    
    return _dataConnect.query("GetChannels", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetChannelsChannels {
  final String id;
  final String name;
  final String? description;
  final bool isPrivate;
  final GetChannelsChannelsHost host;
  GetChannelsChannels.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  description = json['description'] == null ? null : nativeFromJson<String>(json['description']),
  isPrivate = nativeFromJson<bool>(json['isPrivate']),
  host = GetChannelsChannelsHost.fromJson(json['host']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChannelsChannels otherTyped = other as GetChannelsChannels;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    description == otherTyped.description && 
    isPrivate == otherTyped.isPrivate && 
    host == otherTyped.host;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, description.hashCode, isPrivate.hashCode, host.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    if (description != null) {
      json['description'] = nativeToJson<String?>(description);
    }
    json['isPrivate'] = nativeToJson<bool>(isPrivate);
    json['host'] = host.toJson();
    return json;
  }

  GetChannelsChannels({
    required this.id,
    required this.name,
    this.description,
    required this.isPrivate,
    required this.host,
  });
}

@immutable
class GetChannelsChannelsHost {
  final String id;
  final String username;
  GetChannelsChannelsHost.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  username = nativeFromJson<String>(json['username']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChannelsChannelsHost otherTyped = other as GetChannelsChannelsHost;
    return id == otherTyped.id && 
    username == otherTyped.username;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, username.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['username'] = nativeToJson<String>(username);
    return json;
  }

  GetChannelsChannelsHost({
    required this.id,
    required this.username,
  });
}

@immutable
class GetChannelsData {
  final List<GetChannelsChannels> channels;
  GetChannelsData.fromJson(dynamic json):
  
  channels = (json['channels'] as List<dynamic>)
        .map((e) => GetChannelsChannels.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetChannelsData otherTyped = other as GetChannelsData;
    return channels == otherTyped.channels;
    
  }
  @override
  int get hashCode => channels.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['channels'] = channels.map((e) => e.toJson()).toList();
    return json;
  }

  GetChannelsData({
    required this.channels,
  });
}

