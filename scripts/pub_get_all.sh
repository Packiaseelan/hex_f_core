#!/bin/bash
(cd core/app-mobile-core/src && pwd && flutter pub get)
(cd widgets/app-mobile-widgets/src && pwd && flutter pub get)
(cd network_manager/app-mobile-networkmanager/src && flutter pub get)
(cd task_manager/app-mobile-taskmanager/src && flutter pub get)
(cd example_mobile_app && pwd && flutter pub get)
