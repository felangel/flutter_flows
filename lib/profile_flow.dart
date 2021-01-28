import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

class Profile {
  const Profile({this.name, this.age});
  final String name;
  final int age;

  Profile copyWith({String name, int age}) {
    return Profile(
      name: name ?? this.name,
      age: age ?? this.age,
    );
  }
}

List<Page> onGenerateProfilePages(Profile state, List<Page> pages) {
  return [
    ProfileName.page(),
    if (state.name != null) ProfileAge.page(),
  ];
}

class ProfileFlow extends StatelessWidget {
  static Route<Profile> route() {
    return MaterialPageRoute(builder: (_) => ProfileFlow());
  }

  @override
  Widget build(BuildContext context) {
    return FlowBuilder(
      state: const Profile(),
      onGeneratePages: onGenerateProfilePages,
    );
  }
}

class ProfileName extends StatefulWidget {
  static MaterialPage page() => MaterialPage(child: ProfileName());

  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  var _name = '';

  void _onNext() {
    context.flow<Profile>().update((profile) {
      return profile.copyWith(name: _name);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => context.flow<Profile>().complete(),
        ),
        title: const Text('Profile Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (name) => setState(() => _name = name),
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Felix',
                  hintStyle: TextStyle(color: theme.disabledColor),
                ),
              ),
              OutlineButton(
                child: const Text('Next'),
                onPressed: _name.isNotEmpty ? _onNext : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileAge extends StatefulWidget {
  static MaterialPage page() => MaterialPage(child: ProfileAge());

  @override
  _ProfileAgeState createState() => _ProfileAgeState();
}

class _ProfileAgeState extends State<ProfileAge> {
  int _age;

  void _onComplete() {
    context.flow<Profile>().complete((profile) {
      return profile.copyWith(age: _age);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Age')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (age) => setState(() => _age = int.tryParse(age)),
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: '42',
                  hintStyle: TextStyle(color: theme.disabledColor),
                ),
              ),
              OutlineButton(
                child: const Text('Complete'),
                onPressed: _age != null ? _onComplete : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
