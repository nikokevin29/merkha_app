part of 'wishlist_cubit.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Product> wishlist;
  WishlistLoaded(this.wishlist);
  @override
  List<Object> get props => [wishlist];
}

class WishlistAddLoaded extends WishlistState {
  final Wishlist wishlist;
  WishlistAddLoaded(this.wishlist);
  @override
  List<Object> get props => [wishlist];
}

class WishlistLoadingFailed extends WishlistState {
  final String message;

  WishlistLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
