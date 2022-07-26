#!/bin/bash
(cd core/app-mobile-core/src && flutter clean)
(cd core/app-mobile-core/src && rm pubspec.lock)

(cd core/app-mobile-core/src/example && flutter clean)
(cd core/app-mobile-core/src/example && rm pubspec.lock)

(cd widgets/app-mobile-widgets/src && flutter clean)
(cd widgets/app-mobile-widgets/src && rm pubspec.lock)

(cd network_manager/app-mobile-networkmanager/src && flutter clean)
(cd network_manager/app-mobile-networkmanager/src && rm pubspec.lock)

(cd task_manager/app-mobile-taskmanager/src && flutter clean)
(cd task_manager/app-mobile-taskmanager/src && rm pubspec.lock)
