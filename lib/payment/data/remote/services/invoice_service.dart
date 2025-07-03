import 'package:retrofit/retrofit.dart';
import '../../model/invoice_response.dart';
import '../../remote/dto/add_invoice_request.dart';

part 'invoice_service.g.dart';

@RestApi(baseUrl: "https://your-api-url.com/v1")
abstract class InvoiceService {
  factory InvoiceService(Dio dio, {String baseUrl}) = _InvoiceService;

  @GET("/invoices")
  Future<List<InvoiceResponse>> getAllInvoices();

  @POST("/invoices")
  Future<void> addInvoice(@Body() AddInvoiceRequest invoice);
}
