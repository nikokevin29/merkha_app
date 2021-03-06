import 'dart:convert';
import 'dart:io';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:async/async.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart' as fb_storage;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_greetings/flutter_greetings.dart';
import 'package:geocoder/geocoder.dart' as geocode;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:merkha_app/bloc/feed_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_select/smart_select.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'package:merkha_app/cubit/cubit.dart';
import 'package:merkha_app/models/models.dart';
import 'package:merkha_app/services/services.dart';
import 'package:merkha_app/shared/shared.dart';
import 'package:merkha_app/view/widgets/widgets.dart';

part 'address_feed_pick.dart';
part 'category_page.dart';
part 'chat_page.dart';
part 'create_post.dart';
part 'create_post_2.dart';
part 'detail_chat.dart';
part 'detail_product.dart';
part 'main_page.dart';
part 'reset_password_page.dart';
part 'search_merchant.dart';
part 'search_page.dart';
part 'search_product.dart';
part 'search_product_feed.dart';
part 'sign_in_option_page.dart';
part 'sign_in_page.dart';
part 'sign_up_1.dart';
part 'sign_up_2.dart';
part 'sign_up_3.dart';
part 'sign_up_4.dart';
part 'sign_up_5.dart';
part 'sign_up_6.dart';
part 'spash_screen.dart';
part 'tab_cart.dart';
part 'tab_feed.dart';
part 'tab_main.dart';
part 'tab_profile.dart';
part 'tab_profile_address.dart';
part 'tab_profile_address_add.dart';
part 'tab_profile_address_edit.dart';
part 'tab_profile_order.dart';
part 'tab_profile_post.dart';
part 'tab_profile_update.dart';
part 'tab_wishlist.dart';
part 'wallet_page.dart';
part 'details_own_feed.dart';
part 'comment_page.dart';
part 'detail_merchant.dart';
part 'detail_user.dart';
part 'search_product_merchant.dart';
part 'feed_merchant.dart';
part 'product_merchant.dart';
part 'review_merchant_page.dart';
part 'payment_page.dart';
part 'confirm_payment.dart';
part 'detail_order_page.dart';
part 'update_username_page.dart';
part 'search_merchant_chat.dart';
part 'tab_profile_order_finished.dart';
