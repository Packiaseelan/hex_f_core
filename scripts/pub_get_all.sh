#!/bin/bash
(cd core/app-mobile-core/src && pwd && flutter pub get)
(cd widgets/app-mobile-widgets/src && pwd && flutter pub get)
(cd example_mobile_app && pwd && flutter pub get)
