part of 'services.dart';

class PaymentService {
  static Future<ApiReturnValue<Payment>> createPayment(
      {Payment payment, File urlphoto, http.Client client}) async {
    //note: Upload Image to Firebase
    String urlpicture;
    String fileName = payment.idOrder.toString(); //basename(urlphoto.path);
    fb_storage.Reference firebaseStorageref =
        fb_storage.FirebaseStorage.instance.ref('transfer_evidence').child(fileName);
    fb_storage.UploadTask uploadTask = firebaseStorageref.putFile(urlphoto);

    fb_storage.TaskSnapshot taskSnapshot = await uploadTask;
    var downurl = await (taskSnapshot).ref.getDownloadURL();
    print(taskSnapshot);
    urlpicture = downurl.toString();
    print(urlpicture);
    //note: Upload Data and Link to Database
    if (client == null) {
      client = http.Client();
    }
    String url = baseURL + 'payment/create';
    var response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ' + User.token,
      },
      body: jsonEncode(<String, String>{
        'id_order': payment.idOrder.toString(),
        'payment_status': payment.paymentStatus.toString(),
        'url_bukti_transfer': urlpicture, //url firebase Storage folder_named : transfer_evidence
      }),
    );
    if (response.statusCode != 200) {
      print('StatusCode Payment Create: ${response.statusCode}');
      print('data : ${response.body}');
      return ApiReturnValue(message: 'StatusCode : ${response.statusCode}');
    }
    var data = jsonDecode(response.body);
    Payment value = Payment.fromJson(data['data']);
    print('Payment Created');
    OrderServices.updateStatusOrder(
        order: Order(
            id: payment.idOrder, orderStatus: 'NEW ORDER')); //Update Order Status to NEW ORDER
    return ApiReturnValue(value: value);
  }
}
