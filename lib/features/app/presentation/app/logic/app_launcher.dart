import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/features/app/registrar/app_dependency_registrar.dart';
import 'package:weather_test/core/base/di/dependency_container.dart';
import 'package:weather_test/core/base/di/dependency_service.dart';
import 'package:weather_test/core/utils/app_bloc_observer.dart';
import 'package:weather_test/core/utils/logger.dart';
import 'package:weather_test/features/app/presentation/app/app.dart';

final class AppLauncher {
  const AppLauncher();

  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Override logging and bloc observer
    Bloc.observer = const AppBlocObserver();
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError = logger.logPlatformDispatcherError;

    // Preserve splash screen
    binding.deferFirstFrame();

    // Register App Dependencies
    final dependencies = AppDependencyRegistrar(
      container: MapDependencyContainer(),
    );

    await dependencies.register();

    // Allow hide splash screen
    binding.allowFirstFrame();

    // Attach the widget to the Root
    runApp(
      DependencyService(
        appDependencies: dependencies,
        child: const App(),
      ),
    );
  }
}
