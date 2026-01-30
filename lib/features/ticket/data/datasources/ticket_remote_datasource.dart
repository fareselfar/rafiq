import '../models/ticket_model.dart';

abstract class TicketRemoteDataSource {
  Future<List<TicketModel>> getTickets();
  Future<TicketModel> getTicketById(String id);
}

class TicketRemoteDataSourceImpl implements TicketRemoteDataSource {
  @override
  Future<List<TicketModel>> getTickets() async {
    throw UnimplementedError();
  }

  @override
  Future<TicketModel> getTicketById(String id) async {
    throw UnimplementedError();
  }
}
