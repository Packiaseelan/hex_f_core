import 'package:core/base_classes/base_coordinator.dart';

part '../state/images_state.dart';

class ImagesCoordinator extends BaseCoordinator<ImagesState> {
  ImagesCoordinator()
      : super(
          ImagesState(
            iconTitle: 'sset SVG Icon',
            iconPath: 'assets/icons/bag.svg',
            imageTitle: 'Asset JPEG Image',
            imagePath: 'assets/images/bg.jpeg',
            networkImageTitle: 'Network Image',
            networkImagePath:
                'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2020/05/Frame-9.png',
          ),
        );

  void initialize() {}
}
