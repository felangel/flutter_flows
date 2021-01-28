import 'package:flutter/material.dart';
import 'package:flutter_flows/onboarding_flow.dart';
import 'package:flutter_flows/profile_flow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  bool _onboardingComplete = false;
  Profile _profile;

  Color get _onboardingTileColor {
    return _onboardingComplete ? Colors.green : Colors.redAccent;
  }

  Text get _onboardingTileSubtitle {
    return Text(_onboardingComplete ? 'complete' : 'incomplete');
  }

  Color get _profileTileColor {
    return _profile?.isComplete == true ? Colors.green : Colors.red;
  }

  Text get _profileTileSubtitle {
    return Text(
      _profile?.isComplete == true
          ? '${_profile.name}, ${_profile.age}'
          : 'incomplete',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Flows')),
      body: ListView(
        children: [
          ListTile(
            tileColor: _onboardingTileColor,
            leading: const Icon(Icons.help),
            title: const Text('Onboarding'),
            subtitle: _onboardingTileSubtitle,
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final onboardingState = await Navigator.of(context).push(
                OnboardingFlow.route(),
              );
              setState(() => _onboardingComplete = onboardingState.isComplete);
            },
          ),
          ListTile(
            tileColor: _profileTileColor,
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            subtitle: _profileTileSubtitle,
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              final profile = await Navigator.of(context).push(
                ProfileFlow.route(),
              );
              setState(() => _profile = profile);
            },
          ),
        ],
      ),
    );
  }
}

extension on OnboardingState {
  bool get isComplete => this == OnboardingState.onboardingComplete;
}

extension on Profile {
  bool get isComplete => name != null && age != null;
}
