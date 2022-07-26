abstract class IDataModel {
  void fromJsonToModel(Map<String, dynamic> value);
  void fromRawResponseToModel(dynamic value);
}

class BaseDataModel implements IDataModel {
  @override
  void fromJsonToModel(Map<String, dynamic> value) {
    throw UnimplementedError();
  }

  @override
  void fromRawResponseToModel(dynamic value) {
    throw UnimplementedError();
  }
}
