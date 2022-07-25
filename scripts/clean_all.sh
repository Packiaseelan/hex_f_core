#!/bin/bash
(cd core/app-mobile-core/src && flutter clean)
(cd core/app-mobile-core/src && rm pubspec.lock)

(cd core/app-mobile-core/src/example && flutter clean)
(cd core/app-mobile-core/src/example && rm pubspec.lock)

(cd widgets/app-mobile-widgets/src && flutter clean)
(cd widgets/app-mobile-widgets/src && rm pubspec.lock)

(cd network_manager/app-mobile-network_manager/src && flutter clean)
(cd network_manager/app-mobile-network_manager/src && rm pubspec.lock)
