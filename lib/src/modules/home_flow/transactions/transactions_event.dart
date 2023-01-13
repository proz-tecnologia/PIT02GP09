
abstract class TransactionsPageEvent {  
  final List<String>? categories;
  
  TransactionsPageEvent({
    this.categories,
  }); 
}

class OnTransactionsPageEmpty extends TransactionsPageEvent {}

class OnTransactionsInitState extends TransactionsPageEvent {
  OnTransactionsInitState({
    super.categories,
  }); 
}