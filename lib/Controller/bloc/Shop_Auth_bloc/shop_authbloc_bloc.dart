import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_authbloc_event.dart';
part 'shop_authbloc_state.dart';

class ShopAuthblocBloc extends Bloc<ShopAuthblocEvent, ShopAuthblocState> {
  ShopAuthblocBloc() : super(ShopAuthblocInitial()) {
    on<ShopAuthblocEvent>((event, emit) {

    });
  }
}
