part of 'ticket_cubit.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitial extends TicketState {
  const TicketInitial();
}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {}

class TicketError extends TicketState {
  final String message;
  const TicketError(this.message);

  @override
  List<Object> get props => [message];
}
