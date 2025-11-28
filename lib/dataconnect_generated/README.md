# dataconnect_generated SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetChannels
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getChannels().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetChannelsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getChannels();
GetChannelsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getChannels().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### CreateChannel
#### Required Arguments
```dart
String name = ...;
bool isPrivate = ...;
ExampleConnector.instance.createChannel(
  name: name,
  isPrivate: isPrivate,
).execute();
```

#### Optional Arguments
We return a builder for each query. For CreateChannel, we created `CreateChannelBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class CreateChannelVariablesBuilder {
  ...
   CreateChannelVariablesBuilder description(String? t) {
   _description.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.createChannel(
  name: name,
  isPrivate: isPrivate,
)
.description(description)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<CreateChannelData, CreateChannelVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.createChannel(
  name: name,
  isPrivate: isPrivate,
);
CreateChannelData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String name = ...;
bool isPrivate = ...;

final ref = ExampleConnector.instance.createChannel(
  name: name,
  isPrivate: isPrivate,
).ref();
ref.execute();
```


### JoinChannel
#### Required Arguments
```dart
String channelId = ...;
ExampleConnector.instance.joinChannel(
  channelId: channelId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<JoinChannelData, JoinChannelVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.joinChannel(
  channelId: channelId,
);
JoinChannelData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String channelId = ...;

final ref = ExampleConnector.instance.joinChannel(
  channelId: channelId,
).ref();
ref.execute();
```


### ReportChannel
#### Required Arguments
```dart
String channelId = ...;
String reason = ...;
ExampleConnector.instance.reportChannel(
  channelId: channelId,
  reason: reason,
).execute();
```

#### Optional Arguments
We return a builder for each query. For ReportChannel, we created `ReportChannelBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class ReportChannelVariablesBuilder {
  ...
   ReportChannelVariablesBuilder details(String? t) {
   _details.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.reportChannel(
  channelId: channelId,
  reason: reason,
)
.details(details)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<ReportChannelData, ReportChannelVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.reportChannel(
  channelId: channelId,
  reason: reason,
);
ReportChannelData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String channelId = ...;
String reason = ...;

final ref = ExampleConnector.instance.reportChannel(
  channelId: channelId,
  reason: reason,
).ref();
ref.execute();
```

