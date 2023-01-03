
abstract class TransactionsPageEvent {  
  final List<String>? categories;
  
  TransactionsPageEvent({
    this.categories,
  }); 
}

class OnTransactionsPageEmpty extends TransactionsPageEvent {}

class OnTransactionsPageSuccess extends TransactionsPageEvent {
  OnTransactionsPageSuccess({
    super.categories,
  }); 
}