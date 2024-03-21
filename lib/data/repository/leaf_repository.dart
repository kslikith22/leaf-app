import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/data/repository/api.dart';

class LeafRepository {
  API api = API();

  Future postLeafToPredict({required XFile imageFile}) async {
    FormData formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
    });

    final response = await api.sendRequest.post(
      '/predict',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 200) {
      return LeafModel.fromJson(response.data);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}