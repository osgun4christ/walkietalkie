part of 'generated.dart';

class CreateChannelVariablesBuilder {
  String name;
  final Optional<String> _description = Optional.optional(nativeFromJson, nativeToJson);
  bool isPrivate;

  final FirebaseDataConnect _dataConnect;  CreateChannelVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  CreateChannelVariablesBuilder(this._dataConnect, {required  this.name,required  this.isPrivate,});
  Deserializer<CreateChannelData> dataDeserializer = (dynamic json)  => CreateChannelData.fromJson(jsonDecode(json));
  Serializer<CreateChannelVariables> varsSerializer = (CreateChannelVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateChannelData, CreateChannelVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateChannelData, CreateChannelVariables> ref() {
    CreateChannelVariables vars= CreateChannelVariables(name: name,description: _description,isPrivate: isPrivate,);
    return _dataConnect.mutation("CreateChannel", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateChannelChannelInsert {
  final String id;
  CreateChannelChannelInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChannelChannelInsert otherTyped = other as CreateChannelChannelInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateChannelChannelInsert({
    required this.id,
  });
}

@immutable
class CreateChannelData {
  final CreateChannelChannelInsert channel_insert;
  CreateChannelData.fromJson(dynamic json):
  
  channel_insert = CreateChannelChannelInsert.fromJson(json['channel_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChannelData otherTyped = other as CreateChannelData;
    return channel_insert == otherTyped.channel_insert;
    
  }
  @override
  int get hashCode => channel_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['channel_insert'] = channel_insert.toJson();
    return json;
  }

  CreateChannelData({
    required this.channel_insert,
  });
}

@immutable
class CreateChannelVariables {
  final String name;
  late final Optional<String>description;
  final bool isPrivate;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateChannelVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  isPrivate = nativeFromJson<bool>(json['isPrivate']) {
  
  
  
    description = Optional.optional(nativeFromJson, nativeToJson);
    description.value = json['description'] == null ? null : nativeFromJson<String>(json['description']);
  
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateChannelVariables otherTyped = other as CreateChannelVariables;
    return name == otherTyped.name && 
    description == otherTyped.description && 
    isPrivate == otherTyped.isPrivate;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, description.hashCode, isPrivate.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    if(description.state == OptionalState.set) {
      json['description'] = description.toJson();
    }
    json['isPrivate'] = nativeToJson<bool>(isPrivate);
    return json;
  }

  CreateChannelVariables({
    required this.name,
    required this.description,
    required this.isPrivate,
  });
}

