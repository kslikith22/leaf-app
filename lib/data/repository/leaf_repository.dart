import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafapp/data/api/node_api.dart';
import 'package:leafapp/data/models/leaf_model.dart';
import 'package:leafapp/data/api/ml_api.dart';

class LeafRepository {
  MLAPI mlapi = MLAPI();

  Future postLeafToPredict({required XFile imageFile}) async {
    FormData formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
    });

    final response = await mlapi.sendRequest.post(
      '/predict',
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );
    if (response.statusCode == 200) {
      LeafModel data = LeafModel.fromJson(response.data);
      return data;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
