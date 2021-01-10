import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistInitial());

  Future<void> showWishlist() async {
    ApiReturnValue<List<Product>> result = await WishlistService.showWishlist();
    if (result.value != null) {
      emit(WishlistLoaded(result.value));
    } else {
      emit(WishlistLoadingFailed(result.message));
    }
  }

  Future<void> addWishlist(Wishlist wishlist) async {
    ApiReturnValue<Wishlist> result = await WishlistService.addWishlist(wishlist);
    if (result.value != null) {
      emit(WishlistAddLoaded(result.value));
    } else {
      emit(WishlistLoadingFailed(result.message));
    }
  }

  Future<void> deleteWishlist(String id) async {
    ApiReturnValue<Wishlist> result = await WishlistService.deleteWishlist(id);
    if (result.value != null) {
      emit(WishlistLoadingFailed(result.message));
      print(result.message);
    } else {
      emit(WishlistLoadingFailed(result.message));
    }
  }
}
