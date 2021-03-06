import '../common.dart';


abstract class PushChannelSubscriptions {
  Future<PushChannelSubscription> save(PushChannelSubscription subscription);
  Future<PaginatedResult<PushChannelSubscription>> list(PushChannelsParams params);
  Future<PaginatedResult<String>> listChannels(PushChannelsParams params);
  Future<void> remove(PushChannelsParams params);
  Future<void> removeWhere(PushChannelSubscriptionParams params);
}

abstract class PushDeviceRegistrations {
  Future<DeviceDetails> save(DeviceDetails deviceDetails);
  Future<DeviceDetails> get({
    DeviceDetails deviceDetails, String deviceId
  });
  Future<PaginatedResult<DeviceDetails>> list(DeviceRegistrationParams params);
  Future<void> remove({
    DeviceDetails deviceDetails, String deviceId
  });
  Future<void> removeWhere(DeviceRegistrationParams params);
}

abstract class PushAdmin {
  PushDeviceRegistrations deviceRegistrations;
  PushChannelSubscriptions channelSubscriptions;
  Future<void> publish(Map<String, dynamic> recipient, Map payload);
}

class Push {
  PushAdmin admin;
}
