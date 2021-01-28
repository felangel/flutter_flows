import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

enum OnboardingState {
  initial,
  welcomeComplete,
  usageComplete,
  onboardingComplete,
}

List<Page> onGenerateOnboardingPages(OnboardingState state, List<Page> pages) {
  switch (state) {
    case OnboardingState.usageComplete:
      return [
        OnboardingWelcome.page(),
        OnboardingUsage.page(),
        OnboardingComplete.page(),
      ];
    case OnboardingState.welcomeComplete:
      return [
        OnboardingWelcome.page(),
        OnboardingUsage.page(),
      ];
    case OnboardingState.initial:
    default:
      return [
        OnboardingWelcome.page(),
      ];
  }
}

class OnboardingFlow extends StatelessWidget {
  static Route<OnboardingState> route() {
    return MaterialPageRoute(builder: (_) => OnboardingFlow());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create a FlowBuilder
    return const SizedBox();
  }
}

class OnboardingWelcome extends StatelessWidget {
  static MaterialPage page() => MaterialPage(child: OnboardingWelcome());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            // TODO: Complete Flow
          },
        ),
        title: Text('Welcome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome Text',
                style: theme.textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              OutlineButton(
                child: Text('Got It!'),
                onPressed: () {
                  // TODO: Update the Flow
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingUsage extends StatelessWidget {
  static MaterialPage page() => MaterialPage(child: OnboardingUsage());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(title: Text('Usage')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Usage Text',
                style: theme.textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              OutlineButton(
                child: Text('Next'),
                onPressed: () {
                  // TODO: Update the Flow
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingComplete extends StatelessWidget {
  static MaterialPage page() => MaterialPage(child: OnboardingComplete());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.pink,
      appBar: AppBar(title: Text('Complete')),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'All Done!',
                style: theme.textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              OutlineButton(
                child: Text('Yay!'),
                onPressed: () {
                  // TODO: Complete the Flow
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
