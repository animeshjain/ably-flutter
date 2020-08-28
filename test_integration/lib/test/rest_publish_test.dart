import 'package:ably_flutter_plugin/ably.dart';
import 'package:flutter/widgets.dart';

import '../test_dispatcher.dart';
import 'appkey_provision_helper.dart';

class RestPublishTest extends StatefulWidget {
  final TestDispatcherState dispatcher;

  const RestPublishTest(this.dispatcher, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RestPublishTestState();
}

class RestPublishTestState extends State<RestPublishTest> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    widget.dispatcher.reportLog('init start');
    final appKey = await provision('sandbox-');
    final logMessages = <List<String>>[];

    final rest = Rest(
      options: ClientOptions.fromKey(appKey.toString())
        ..environment = 'sandbox'
        ..clientId = 'someClientId'
        ..logLevel = LogLevel.verbose
        ..logHandler =
            ({msg, exception}) => logMessages.add([msg, exception.toString()]),
    );

    final name = 'Hello';
    final data = 'Flutter';

    final channel = rest.channels.get('test');
    await channel.publish(name: name, data: data);
    await channel.publish(name: name);
    await channel.publish(data: data);
    await channel.publish();

    widget.dispatcher.reportTestCompletion(<String, dynamic>{
      'handle': await rest.handle,
      'log': logMessages,
    });
  }

  @override
  Widget build(BuildContext context) => Container();
}