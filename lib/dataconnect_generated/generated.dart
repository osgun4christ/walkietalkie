library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_channel.dart';

part 'get_channels.dart';

part 'join_channel.dart';

part 'report_channel.dart';







class ExampleConnector {
  
  
  CreateChannelVariablesBuilder createChannel ({required String name, required bool isPrivate, }) {
    return CreateChannelVariablesBuilder(dataConnect, name: name,isPrivate: isPrivate,);
  }
  
  
  GetChannelsVariablesBuilder getChannels () {
    return GetChannelsVariablesBuilder(dataConnect, );
  }
  
  
  JoinChannelVariablesBuilder joinChannel ({required String channelId, }) {
    return JoinChannelVariablesBuilder(dataConnect, channelId: channelId,);
  }
  
  
  ReportChannelVariablesBuilder reportChannel ({required String channelId, required String reason, }) {
    return ReportChannelVariablesBuilder(dataConnect, channelId: channelId,reason: reason,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-east4',
    'example',
    'walkietalkie',
  );

  ExampleConnector({required this.dataConnect});
  static ExampleConnector get instance {
    return ExampleConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
