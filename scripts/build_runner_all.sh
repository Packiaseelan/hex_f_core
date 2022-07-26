#!/bin/bash
(cd widgets/app-mobile-widgets/src && flutter packages pub run build_runner build --delete-conflicting-outputs)
(cd network_manager/app-mobile-networkmanager/src && flutter packages pub run build_runner build --delete-conflicting-outputs)
