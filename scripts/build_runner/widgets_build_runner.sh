#!/bin/bash
(cd widgets/app-mobile-widgets/src && flutter packages pub run build_runner build --delete-conflicting-outputs)
