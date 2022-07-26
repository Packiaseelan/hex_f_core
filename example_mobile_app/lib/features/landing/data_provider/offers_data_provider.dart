import 'package:example_mobile_app/features/landing/data_model/offers_data_model.dart';

abstract class IOfferDataProvider {
  Future<List<OffersDataModel>> getOffersData();
  Future<List<int>> getNumbers();
  Future<List<String>> getCategories();
}

class OffersDataProvider extends IOfferDataProvider {
  @override
  Future<List<OffersDataModel>> getOffersData() async {
    await Future.delayed(const Duration(seconds: 7));

    return [
      OffersDataModel(
        title: '10.5 Special discount',
        description: 'Get upto 80% discount',
        iconPath: '',
      ),
    ];
  }

  @override
  Future<List<int>> getNumbers() {
    return Future.delayed(const Duration(seconds: 10), () {
      return [1, 2, 3, 4, 5];
    });
  }
  
  @override
  Future<List<String>> getCategories() {
    return Future.delayed(const Duration(seconds: 12), () {
      return ['One', 'Two', 'Three', 'Four', 'Five'];
    });
  }
}
