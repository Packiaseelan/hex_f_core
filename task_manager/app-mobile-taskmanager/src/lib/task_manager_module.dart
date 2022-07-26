import 'package:core/ioc/di_container.dart';
import 'package:core/session_management/inactivity_service.dart';
import 'package:core/storage/file_storage/file_storage_service_impl.dart';
import 'package:core/storage/i_storage_service.dart';
import 'package:core/storage/memory_storage/memory_storage_service_impl.dart';
import 'package:core/storage/unsecure_storage/unsecure_storage_service_impl.dart';
import 'package:task_manager/session_management/inactivity_service_impl.dart';
import 'package:task_manager/stream_observer/data_change_observer_resolver.dart';
import 'package:task_manager/task_manager.dart';

class TaskManagerModule {
  static void registerDependencies({required IStorageService secureStorageService}) {
    DIContainer.container.registerSingleton(
      (container) => CacheTaskResolver(
        secureStorageService: secureStorageService,
        fileStorageService: FileStorageServiceImpl(),
        unsecureStorageService: UnsecureStorageServiceImpl(),
        memoryStorageService: MemoryStorageServiceImpl(),
      ),
    );

    DIContainer.container.registerSingleton<DataChangeObserverTaskResolver>(
      (container) => DataChangeObserverTaskResolver(),
    );

    DIContainer.container.registerSingleton(
      (container) => TaskManager(
        dataChangeObserverTaskResolver: DIContainer.container.resolve<DataChangeObserverTaskResolver>(),
        cacheTaskResolver: DIContainer.container.resolve<CacheTaskResolver>(),
      ),
    );

    DIContainer.container.registerSingleton<IInactivityService>(
      (container) => InactivityService(
        taskManager: DIContainer.container.resolve(),
      ),
    );
  }
}
