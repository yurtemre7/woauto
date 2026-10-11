///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations
    with BaseTranslations<AppLocale, Translations> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsEn(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        _meta = meta ??
            TranslationMetadata(
              locale: AppLocale.en,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ),
        super(
            cardinalResolver: cardinalResolver,
            ordinalResolver: ordinalResolver) {
    _meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  final TranslationMetadata<AppLocale, Translations> _meta;
  @override
  TranslationMetadata<AppLocale, Translations> get $meta => _meta;

  /// Access flat map
  @override
  dynamic operator [](String key) => _meta.getTranslation(key) ?? super[key];

  late final TranslationsEn _root = this; // ignore: unused_field

  @override
  TranslationsEn $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      TranslationsEn(meta: meta ?? this.$meta);

  // Translations
  @override
  late final _Translations$constants$en constants =
      _Translations$constants$en._(_root);
  @override
  late final _Translations$park_duration$en park_duration =
      _Translations$park_duration$en._(_root);
  @override
  late final _Translations$login_dialog$en login_dialog =
      _Translations$login_dialog$en._(_root);
  @override
  late final _Translations$park_dialog$en park_dialog =
      _Translations$park_dialog$en._(_root);
  @override
  late final _Translations$marker_dialog$en marker_dialog =
      _Translations$marker_dialog$en._(_root);
  @override
  late final _Translations$home$en home = _Translations$home$en._(_root);
  @override
  late final _Translations$history$en history =
      _Translations$history$en._(_root);
  @override
  late final _Translations$info_sheet$en info_sheet =
      _Translations$info_sheet$en._(_root);
  @override
  late final _Translations$top_header$en top_header =
      _Translations$top_header$en._(_root);
  @override
  late final _Translations$car_bottom_sheet$en car_bottom_sheet =
      _Translations$car_bottom_sheet$en._(_root);
  @override
  late final _Translations$my_car$en my_car = _Translations$my_car$en._(_root);
  @override
  late final _Translations$maps$en maps = _Translations$maps$en._(_root);
  @override
  late final _Translations$intro$en intro = _Translations$intro$en._(_root);
  @override
  late final _Translations$bottom_sheet$en bottom_sheet =
      _Translations$bottom_sheet$en._(_root);
  @override
  late final _Translations$snackbar$en snackbar =
      _Translations$snackbar$en._(_root);
  @override
  late final _Translations$dialog$en dialog = _Translations$dialog$en._(_root);
  @override
  late final _Translations$settings$en settings =
      _Translations$settings$en._(_root);
}

// Path: constants
class _Translations$constants$en extends Translations$constants$de {
  _Translations$constants$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get app_name => 'WoAuto';
  @override
  String get default_park_title => 'My Car';
  @override
  String get default_shared_title => 'Other Car';
  @override
  String get default_park_info => 'e.g., parking level 2';
  @override
  String get default_address => 'No address found';
  @override
  String get address_na => 'Address was not found.';
  @override
  String get update => 'Update';
  @override
  String get error => 'Error';
  @override
  String get error_description => 'An error occurred.';
  @override
  String get parked_rn => 'parked right now';
  @override
  String parked_duration_string({required Object duration}) =>
      'parked since ${duration}';
  @override
  String get navigate => 'Navigate';
}

// Path: park_duration
class _Translations$park_duration$en extends Translations$park_duration$de {
  _Translations$park_duration$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String hours({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} hour',
        other: '${n} hours',
      );
  @override
  String minutes({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} minute',
        other: '${n} minutes',
      );
  @override
  String days({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
        n,
        one: '${n} day',
        other: '${n} days',
      );
}

// Path: login_dialog
class _Translations$login_dialog$en extends Translations$login_dialog$de {
  _Translations$login_dialog$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get email => 'E-Mail';
  @override
  String get password => 'Password';
  @override
  String get empty_validation => 'Please enter something in';
  @override
  String get email_validation => 'Please enter a valid e-mail address';
  @override
  String get password_validation =>
      'Please enter a secure, >= 10 characters long password';
  @override
  String get password_forgot => 'Password forgot';
  @override
  String get password_generate => 'Generate password';
  @override
  String get password_generate_info =>
      'Your password will be inserted into the text field when you generate it. It will not be saved by us! Take a look at the code if you are not sure!';
  @override
  String get register => 'Register';
  @override
  String get login => 'Login';
}

// Path: park_dialog
class _Translations$park_dialog$en extends Translations$park_dialog$de {
  _Translations$park_dialog$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'New Parking';
  @override
  String get content_1 => 'Save the new parking?';
  @override
  late final _Translations$park_dialog$park_name$en park_name =
      _Translations$park_dialog$park_name$en._(_root);
  @override
  String get content_2 => 'Additional information';
  @override
  late final _Translations$park_dialog$info$en info =
      _Translations$park_dialog$info$en._(_root);
  @override
  late final _Translations$park_dialog$ticket$en ticket =
      _Translations$park_dialog$ticket$en._(_root);
  @override
  late final _Translations$park_dialog$photo$en photo =
      _Translations$park_dialog$photo$en._(_root);
}

// Path: marker_dialog
class _Translations$marker_dialog$en extends Translations$marker_dialog$de {
  _Translations$marker_dialog$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$marker_dialog$shared$en shared =
      _Translations$marker_dialog$shared$en._(_root);
  @override
  late final _Translations$marker_dialog$mine$en mine =
      _Translations$marker_dialog$mine$en._(_root);
  @override
  String get action_1 => 'Delete parking';
}

// Path: home
class _Translations$home$en extends Translations$home$de {
  _Translations$home$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get navigation_1 => 'Map';
  @override
  String get navigation_2 => 'My Car';
  @override
  String get navigation_3 => 'History';
  @override
  String get navigation_4 => 'Settings';
  @override
  late final _Translations$home$quick_actions$en quick_actions =
      _Translations$home$quick_actions$en._(_root);
}

// Path: history
class _Translations$history$en extends Translations$history$de {
  _Translations$history$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'History';
  @override
  late final _Translations$history$empty$en empty =
      _Translations$history$empty$en._(_root);
  @override
  late final _Translations$history$export$en export =
      _Translations$history$export$en._(_root);
  @override
  late final _Translations$history$delete$en delete =
      _Translations$history$delete$en._(_root);
}

// Path: info_sheet
class _Translations$info_sheet$en extends Translations$info_sheet$de {
  _Translations$info_sheet$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get park_save => 'Save parking spot';
  @override
  String get current_position => 'Go to your current position';
  @override
  String get parkings => 'Open parking spots';
  @override
  String get badge_label => 'Sync';
}

// Path: top_header
class _Translations$top_header$en extends Translations$top_header$de {
  _Translations$top_header$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get driving_mode_tooltip => 'Driving mode';
}

// Path: car_bottom_sheet
class _Translations$car_bottom_sheet$en
    extends Translations$car_bottom_sheet$de {
  _Translations$car_bottom_sheet$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$car_bottom_sheet$empty$en empty =
      _Translations$car_bottom_sheet$empty$en._(_root);
  @override
  late final _Translations$car_bottom_sheet$distance_calculation$en
      distance_calculation =
      _Translations$car_bottom_sheet$distance_calculation$en._(_root);
  @override
  late final _Translations$car_bottom_sheet$you$en you =
      _Translations$car_bottom_sheet$you$en._(_root);
  @override
  late final _Translations$car_bottom_sheet$friends$en friends =
      _Translations$car_bottom_sheet$friends$en._(_root);
  @override
  late final _Translations$car_bottom_sheet$menu$en menu =
      _Translations$car_bottom_sheet$menu$en._(_root);
}

// Path: my_car
class _Translations$my_car$en extends Translations$my_car$de {
  _Translations$my_car$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'My Car';
  @override
  String get login_register => 'Login or Register now';
  @override
  String get shared_content => 'This is my car! 🚗';
  @override
  late final _Translations$my_car$built$en built =
      _Translations$my_car$built$en._(_root);
  @override
  late final _Translations$my_car$driven$en driven =
      _Translations$my_car$driven$en._(_root);
  @override
  late final _Translations$my_car$plate$en plate =
      _Translations$my_car$plate$en._(_root);
  @override
  late final _Translations$my_car$park_name$en park_name =
      _Translations$my_car$park_name$en._(_root);
  @override
  late final _Translations$my_car$tuv$en tuv =
      _Translations$my_car$tuv$en._(_root);
  @override
  String get share_deactivate_info =>
      'If you deactivate these settings, you will be asked to confirm the action again, as switching off always deletes all data from the server first and then prevents it from being saved until you switch it on again.';
  @override
  String get share_my_last_location => 'Share my last location';
  @override
  String get share_my_last_location_description =>
      'While using the app, your live location is saved on our server and only your friends can view it. As soon as the app is closed, the last set location remains visible.';
  @override
  String get share_my_last_location_deactivate =>
      'When you end your sharing, your location will first be deleted from our server and saving will be prevented until you reactivate it.';
  @override
  String get share_my_parkings => 'Share my parking spaces';
  @override
  String get share_my_parkings_description =>
      'This will save your parking spaces in our servers and so your friends, only they, can see your parking spaces, but never your parking history.';
  @override
  String get share_my_parkings_deactivate =>
      'When you end your sharing, your parking locations will be deleted from our server and saving will be prevented until you reactivate it.';
  @override
  String get secure_notice =>
      'Your private car data is stored locally on your device. We do not have access to your data. You can also delete your data at any time in the settings.';
}

// Path: maps
class _Translations$maps$en extends Translations$maps$de {
  _Translations$maps$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get loading => 'Loading maps ...';
  @override
  late final _Translations$maps$traffic$en traffic =
      _Translations$maps$traffic$en._(_root);
}

// Path: intro
class _Translations$intro$en extends Translations$intro$de {
  _Translations$intro$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$intro$page_1$en page_1 =
      _Translations$intro$page_1$en._(_root);
  @override
  late final _Translations$intro$page_2$en page_2 =
      _Translations$intro$page_2$en._(_root);
}

// Path: bottom_sheet
class _Translations$bottom_sheet$en extends Translations$bottom_sheet$de {
  _Translations$bottom_sheet$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get photo => 'Choose photo';
  @override
  String get camera => 'Take photo';
  @override
  String get photo_delete => 'Delete photo';
}

// Path: snackbar
class _Translations$snackbar$en extends Translations$snackbar$de {
  _Translations$snackbar$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$snackbar$locked$en locked =
      _Translations$snackbar$locked$en._(_root);
  @override
  late final _Translations$snackbar$shared_parking$en shared_parking =
      _Translations$snackbar$shared_parking$en._(_root);
  @override
  late final _Translations$snackbar$distance_calculation$en
      distance_calculation =
      _Translations$snackbar$distance_calculation$en._(_root);
}

// Path: dialog
class _Translations$dialog$en extends Translations$dialog$de {
  _Translations$dialog$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get abort => 'Cancel';
  @override
  String get delete => 'Delete';
  @override
  String get leave => 'Exit';
  @override
  String get logout => 'Logout';
  @override
  String get ok => 'Ok';
  @override
  String get yes => 'Yes';
  @override
  String get no => 'No';
  @override
  String get share => 'Share';
  @override
  String get save => 'Save';
  @override
  String get open_settings => 'Open settings';
  @override
  late final _Translations$dialog$share_location_parkings$en
      share_location_parkings =
      _Translations$dialog$share_location_parkings$en._(_root);
  @override
  late final _Translations$dialog$distance$en distance =
      _Translations$dialog$distance$en._(_root);
  @override
  late final _Translations$dialog$notifications$en notifications =
      _Translations$dialog$notifications$en._(_root);
  @override
  late final _Translations$dialog$car_bottom_sheet$en car_bottom_sheet =
      _Translations$dialog$car_bottom_sheet$en._(_root);
  @override
  late final _Translations$dialog$maps$en maps =
      _Translations$dialog$maps$en._(_root);
  @override
  late final _Translations$dialog$history$en history =
      _Translations$dialog$history$en._(_root);
  @override
  late final _Translations$dialog$leave_info$en leave_info =
      _Translations$dialog$leave_info$en._(_root);
  @override
  late final _Translations$dialog$app_info$en app_info =
      _Translations$dialog$app_info$en._(_root);
  @override
  late final _Translations$dialog$feedback$en feedback =
      _Translations$dialog$feedback$en._(_root);
  @override
  late final _Translations$dialog$data_security$en data_security =
      _Translations$dialog$data_security$en._(_root);
  @override
  late final _Translations$dialog$app_data$en app_data =
      _Translations$dialog$app_data$en._(_root);
  @override
  late final _Translations$dialog$account_data$en account_data =
      _Translations$dialog$account_data$en._(_root);
  @override
  String get logout_confirm => 'Are you sure you want to logout?';
}

// Path: settings
class _Translations$settings$en extends Translations$settings$de {
  _Translations$settings$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Settings';
  @override
  late final _Translations$settings$theme$en theme =
      _Translations$settings$theme$en._(_root);
  @override
  late final _Translations$settings$color$en color =
      _Translations$settings$color$en._(_root);
  @override
  late final _Translations$settings$map_type$en map_type =
      _Translations$settings$map_type$en._(_root);
  @override
  late final _Translations$settings$traffic$en traffic =
      _Translations$settings$traffic$en._(_root);
  @override
  late final _Translations$settings$location$en location =
      _Translations$settings$location$en._(_root);
  @override
  late final _Translations$settings$new_ios$en new_ios =
      _Translations$settings$new_ios$en._(_root);
  @override
  late final _Translations$settings$park_ticket$en park_ticket =
      _Translations$settings$park_ticket$en._(_root);
  @override
  late final _Translations$settings$driving_mode$en driving_mode =
      _Translations$settings$driving_mode$en._(_root);
  @override
  late final _Translations$settings$app_info$en app_info =
      _Translations$settings$app_info$en._(_root);
  @override
  late final _Translations$settings$credits$en credits =
      _Translations$settings$credits$en._(_root);
  @override
  late final _Translations$settings$woauto_server$en woauto_server =
      _Translations$settings$woauto_server$en._(_root);
  @override
  late final _Translations$settings$share$en share =
      _Translations$settings$share$en._(_root);
  @override
  late final _Translations$settings$feedback$en feedback =
      _Translations$settings$feedback$en._(_root);
  @override
  late final _Translations$settings$data_security$en data_security =
      _Translations$settings$data_security$en._(_root);
  @override
  late final _Translations$settings$app_data$en app_data =
      _Translations$settings$app_data$en._(_root);
}

// Path: park_dialog.park_name
class _Translations$park_dialog$park_name$en
    extends Translations$park_dialog$park_name$de {
  _Translations$park_dialog$park_name$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Name';
}

// Path: park_dialog.info
class _Translations$park_dialog$info$en
    extends Translations$park_dialog$info$de {
  _Translations$park_dialog$info$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get label => 'Info';
}

// Path: park_dialog.ticket
class _Translations$park_dialog$ticket$en
    extends Translations$park_dialog$ticket$de {
  _Translations$park_dialog$ticket$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Parking ticket';
  @override
  String get help => 'Parking ticket expires at';
  @override
  String until({required Object time}) =>
      'Parking ticket valid until ${time} o\'clock';
}

// Path: park_dialog.photo
class _Translations$park_dialog$photo$en
    extends Translations$park_dialog$photo$de {
  _Translations$park_dialog$photo$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Photo';
}

// Path: marker_dialog.shared
class _Translations$marker_dialog$shared$en
    extends Translations$marker_dialog$shared$de {
  _Translations$marker_dialog$shared$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String content({required Object address}) =>
      'This parking spot is being shared with you.\n\nThe car is at the following address:\n${address}.';
}

// Path: marker_dialog.mine
class _Translations$marker_dialog$mine$en
    extends Translations$marker_dialog$mine$de {
  _Translations$marker_dialog$mine$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String content(
          {required Object formattedDate,
          required Object address,
          required Object description}) =>
      'You have ${formattedDate}.\n\nYour car is at the following address:\n${address}.\n${description}';
}

// Path: home.quick_actions
class _Translations$home$quick_actions$en
    extends Translations$home$quick_actions$de {
  _Translations$home$quick_actions$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get action_parkings => 'Open parking spots';
  @override
  String get action_save => 'Quicksave parking spot';
}

// Path: history.empty
class _Translations$history$empty$en extends Translations$history$empty$de {
  _Translations$history$empty$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'No entries';
  @override
  String get subtitle => 'You have no entries in your history.';
}

// Path: history.export
class _Translations$history$export$en extends Translations$history$export$de {
  _Translations$history$export$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Export as CSV';
  @override
  String get subtitle =>
      'Export your history as a CSV file. This will include all of your parking spots.';
}

// Path: history.delete
class _Translations$history$delete$en extends Translations$history$delete$de {
  _Translations$history$delete$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Delete all entries';
  @override
  String get subtitle => 'Delete all entries in your history.';
}

// Path: car_bottom_sheet.empty
class _Translations$car_bottom_sheet$empty$en
    extends Translations$car_bottom_sheet$empty$de {
  _Translations$car_bottom_sheet$empty$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get parkings => 'You have no parking spots.';
  @override
  String get shared_parkings => 'You have no shared parking spots.';
}

// Path: car_bottom_sheet.distance_calculation
class _Translations$car_bottom_sheet$distance_calculation$en
    extends Translations$car_bottom_sheet$distance_calculation$de {
  _Translations$car_bottom_sheet$distance_calculation$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'How are we calculating the distance?';
}

// Path: car_bottom_sheet.you
class _Translations$car_bottom_sheet$you$en
    extends Translations$car_bottom_sheet$you$de {
  _Translations$car_bottom_sheet$you$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'You';
  @override
  String get address => 'On you';
}

// Path: car_bottom_sheet.friends
class _Translations$car_bottom_sheet$friends$en
    extends Translations$car_bottom_sheet$friends$de {
  _Translations$car_bottom_sheet$friends$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Friends';
  @override
  String get park => 'parking';
}

// Path: car_bottom_sheet.menu
class _Translations$car_bottom_sheet$menu$en
    extends Translations$car_bottom_sheet$menu$de {
  _Translations$car_bottom_sheet$menu$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get open_park_in_maps => 'Open in a maps app';
  @override
  String get share_park => 'Share parking spot';
  @override
  String get to_park => 'Go to parking spot';
  @override
  String get delete_park => 'Delete parking spot';
}

// Path: my_car.built
class _Translations$my_car$built$en extends Translations$my_car$built$de {
  _Translations$my_car$built$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object baujahr, required Object jahre}) =>
      'Year of manufacture: ${baujahr} (${jahre} Jahre)';
  @override
  String title_short({required Object baujahr}) =>
      'Year of manufacture: ${baujahr}';
  @override
  String get title_dialog => 'Year of manufacture';
  @override
  String get subtitle => 'Change the year of manufacture of your car.';
  @override
  String get default_year => '2002';
  @override
  String get validate_null => 'Please enter a valid year of manufacture.';
  @override
  String validate_year({required Object year}) =>
      'Please enter a valid year of manufacture between 1900 and ${year}';
}

// Path: my_car.driven
class _Translations$my_car$driven$en extends Translations$my_car$driven$de {
  _Translations$my_car$driven$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object km}) => '${km} km driven';
  @override
  String title_short({required Object km}) => 'Mileage: ${km}';
  @override
  String get title_dialog => 'Mileage';
  @override
  String get subtitle => 'Change the mileage of your car.';
  @override
  String get hint => '123456';
}

// Path: my_car.plate
class _Translations$my_car$plate$en extends Translations$my_car$plate$de {
  _Translations$my_car$plate$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object plate}) => 'License plate: ${plate}';
  @override
  String get subtitle => 'Change the license plate of your car.';
  @override
  String get title_short => 'License plate';
  @override
  String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class _Translations$my_car$park_name$en
    extends Translations$my_car$park_name$de {
  _Translations$my_car$park_name$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object name}) => 'Title: ${name}';
  @override
  String get subtitle =>
      'Change the title of your car, e.g., Mercedes, Audi or BMW.';
  @override
  String get park_title => 'Name of your car';
}

// Path: my_car.tuv
class _Translations$my_car$tuv$en extends Translations$my_car$tuv$de {
  _Translations$my_car$tuv$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String title({required Object date}) => 'MOT until ${date}';
  @override
  String get subtitle => 'Change the MOT date of your car.';
  @override
  String get help => 'Choose the "1." of the month, e.g., "1.1.2022"';
  @override
  String get add_to_calender => 'Add to calendar';
  @override
  String get calender_title => 'MOT expired';
  @override
  String get calender_content =>
      'Your MOT has expired! Please make an appointment.\n\nBest regards,\nYour WoAuto-Team';
  @override
  String get expired_info => 'Your MOT has expired!';
  @override
  String get expiring_info =>
      'Your MOT will expire soon! Please make an appointment.';
}

// Path: maps.traffic
class _Translations$maps$traffic$en extends Translations$maps$traffic$de {
  _Translations$maps$traffic$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get show => 'Show traffic';
  @override
  String get hide => 'Hide traffic';
}

// Path: intro.page_1
class _Translations$intro$page_1$en extends Translations$intro$page_1$de {
  _Translations$intro$page_1$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get page_title => 'WoAuto';
  @override
  String get title => 'Welcome to WoAuto';
  @override
  String get content_1 =>
      'With WoAuto you can save your parking spot and view it later, share it with others and even navigate to it.';
  @override
  String get content_2 =>
      'Your parking spot is safe and always stays on your device.';
  @override
  String get content_3 => 'Save your parking spot in just 2 clicks.';
  @override
  String get action_1 => 'Continue';
}

// Path: intro.page_2
class _Translations$intro$page_2$en extends Translations$intro$page_2$de {
  _Translations$intro$page_2$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get page_title => 'App preferences';
  @override
  String get parking_title => 'Set a name for your car';
  @override
  String get parking_content => 'Give your car a cool name';
  @override
  String get parking_hint => 'My Car';
  @override
  String get theme_title => 'Set the app theme';
  @override
  String get theme_content => 'Choose the theme you like best';
  @override
  String get location_title => 'Allow real-time location permission (optional)';
  @override
  String get location_content =>
      'In order for WoAuto to automatically save your location, you can allow real-time location permission. This helps automatically locate your parking spot.';
  @override
  String get location_checkbox => 'Real-time location permission';
  @override
  String get location_checkbox_error =>
      'Please allow the app to query your location while using the app.';
  @override
  String get notification_checkbox => 'Notifications (optional)';
  @override
  String get exact_notification_checkbox =>
      'Scheduled notifications (optional)';
  @override
  String get exact_notification_description =>
      'Receive a notification when your parking ticket is about to expire.';
  @override
  String get action_1 => 'Done';
}

// Path: snackbar.locked
class _Translations$snackbar$locked$en extends Translations$snackbar$locked$de {
  _Translations$snackbar$locked$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Did you lock your car?';
  @override
  String get subtitle => 'This is a reminder if you locked your car';
  @override
  String get action => 'Yes, I did';
}

// Path: snackbar.shared_parking
class _Translations$snackbar$shared_parking$en
    extends Translations$snackbar$shared_parking$de {
  _Translations$snackbar$shared_parking$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'A shared online parking space has been added';
  @override
  String get subtitle => 'Check the map or the list.';
}

// Path: snackbar.distance_calculation
class _Translations$snackbar$distance_calculation$en
    extends Translations$snackbar$distance_calculation$de {
  _Translations$snackbar$distance_calculation$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'How is the distance calculated?';
  @override
  String get subtitle =>
      'Distance is calculated using the Haversine formula. The formula is a special form of the Pythagorean formula used to calculate the distance between two points on a sphere. The formula is also known as "sphere distance".';
  @override
  String get subsubtitle => 'Click here to know more.';
}

// Path: dialog.share_location_parkings
class _Translations$dialog$share_location_parkings$en
    extends Translations$dialog$share_location_parkings$de {
  _Translations$dialog$share_location_parkings$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Deactivate Sharing';
  @override
  String get content_1 => '';
  @override
  String get content_2 =>
      'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
  @override
  String get deactivate => 'Deactivate';
}

// Path: dialog.distance
class _Translations$dialog$distance$en extends Translations$dialog$distance$de {
  _Translations$dialog$distance$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Distance calculation';
  @override
  String content({required Object distance}) =>
      'The calculated distance is ${distance}';
}

// Path: dialog.notifications
class _Translations$dialog$notifications$en
    extends Translations$dialog$notifications$de {
  _Translations$dialog$notifications$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$dialog$notifications$na$en na =
      _Translations$dialog$notifications$na$en._(_root);
  @override
  late final _Translations$dialog$notifications$denied$en denied =
      _Translations$dialog$notifications$denied$en._(_root);
  @override
  late final _Translations$dialog$notifications$sent$en sent =
      _Translations$dialog$notifications$sent$en._(_root);
  @override
  late final _Translations$dialog$notifications$expiring$en expiring =
      _Translations$dialog$notifications$expiring$en._(_root);
}

// Path: dialog.car_bottom_sheet
class _Translations$dialog$car_bottom_sheet$en
    extends Translations$dialog$car_bottom_sheet$de {
  _Translations$dialog$car_bottom_sheet$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$dialog$car_bottom_sheet$sync$en sync =
      _Translations$dialog$car_bottom_sheet$sync$en._(_root);
  @override
  late final _Translations$dialog$car_bottom_sheet$synced$en synced =
      _Translations$dialog$car_bottom_sheet$synced$en._(_root);
  @override
  late final _Translations$dialog$car_bottom_sheet$sharing$en sharing =
      _Translations$dialog$car_bottom_sheet$sharing$en._(_root);
}

// Path: dialog.maps
class _Translations$dialog$maps$en extends Translations$dialog$maps$de {
  _Translations$dialog$maps$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$dialog$maps$driving_mode$en driving_mode =
      _Translations$dialog$maps$driving_mode$en._(_root);
  @override
  late final _Translations$dialog$maps$location_denied$en location_denied =
      _Translations$dialog$maps$location_denied$en._(_root);
  @override
  late final _Translations$dialog$maps$no_location$en no_location =
      _Translations$dialog$maps$no_location$en._(_root);
}

// Path: dialog.history
class _Translations$dialog$history$en extends Translations$dialog$history$de {
  _Translations$dialog$history$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  late final _Translations$dialog$history$info$en info =
      _Translations$dialog$history$info$en._(_root);
  @override
  late final _Translations$dialog$history$delete$en delete =
      _Translations$dialog$history$delete$en._(_root);
}

// Path: dialog.leave_info
class _Translations$dialog$leave_info$en
    extends Translations$dialog$leave_info$de {
  _Translations$dialog$leave_info$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Leave App';
  @override
  String get subtitle => 'Are you sure you want to leave the app?';
}

// Path: dialog.app_info
class _Translations$dialog$app_info$en extends Translations$dialog$app_info$de {
  _Translations$dialog$app_info$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'App Info';
  @override
  String get subtitle =>
      'This app was developed by Emre Yurtseven, is open-source and of course available on Github.';
  @override
  String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class _Translations$dialog$feedback$en extends Translations$dialog$feedback$de {
  _Translations$dialog$feedback$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Feedback';
  @override
  String get subtitle =>
      'Feel free to email me, join our Telegram channel, or send me a private message on Telegram:';
  @override
  String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class _Translations$dialog$data_security$en
    extends Translations$dialog$data_security$de {
  _Translations$dialog$data_security$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Privacy Policy and Legal Notice';
  @override
  String get content_1 =>
      'Brief summary of privacy policy in our own words (as of 14th December 2025):';
  @override
  String get content_2 =>
      '- The app communicates with Google Maps to display the map.';
  @override
  String get content_4 =>
      '- The app does not store any metadata, such as IP address, device name, or operating system version.';
  @override
  String get content_5 =>
      '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ';
  @override
  String get content_6 => 'not to any third parties.';
  @override
  String get content_7 =>
      '\n\n A data exchange with the servers of Google, when providing the Google Maps maps, takes place. ';
  @override
  String get content_8 =>
      'The app otherwise stores all data only on your device and you can delete them at any time.';
  @override
  String get action_1 => 'Imprint';
  @override
  String get action_2 => 'Privacy';
}

// Path: dialog.app_data
class _Translations$dialog$app_data$en extends Translations$dialog$app_data$de {
  _Translations$dialog$app_data$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Delete App Data';
  @override
  String get subtitle => 'Are you sure you want to delete all app data?';
}

// Path: dialog.account_data
class _Translations$dialog$account_data$en
    extends Translations$dialog$account_data$de {
  _Translations$dialog$account_data$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Delete Account & Data';
  @override
  String get content =>
      'This will delete your account, all the data associated with you, parkings, locations etc. It will also reset all of app-data on device.';
}

// Path: settings.theme
class _Translations$settings$theme$en extends Translations$settings$theme$de {
  _Translations$settings$theme$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Theme';
  @override
  String get subtitle => 'Choose the theme you like best.';
  @override
  String get dropdown_1 => 'System';
  @override
  String get dropdown_2 => 'Light';
  @override
  String get dropdown_3 => 'Dark';
}

// Path: settings.color
class _Translations$settings$color$en extends Translations$settings$color$de {
  _Translations$settings$color$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get choice => 'Color';
}

// Path: settings.map_type
class _Translations$settings$map_type$en
    extends Translations$settings$map_type$de {
  _Translations$settings$map_type$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Map type';
  @override
  String get subtitle => 'Choose the map type you like best.';
  @override
  String get dropdown_1 => 'Normal';
  @override
  String get dropdown_2 => 'Satellite';
  @override
  String get dropdown_3 => 'Hybrid';
  @override
  String get dropdown_4 => 'Terrain';
}

// Path: settings.traffic
class _Translations$settings$traffic$en
    extends Translations$settings$traffic$de {
  _Translations$settings$traffic$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Traffic';
  @override
  String get subtitle => 'Show the current traffic situation on the map.';
}

// Path: settings.location
class _Translations$settings$location$en
    extends Translations$settings$location$de {
  _Translations$settings$location$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Real-time Location';
  @override
  String get subtitle =>
      'Toggle location permission or open system settings to adjust.';
}

// Path: settings.new_ios
class _Translations$settings$new_ios$en
    extends Translations$settings$new_ios$de {
  _Translations$settings$new_ios$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'iOS only design';
  @override
  String get subtitle => 'Use the iOS only design with Cupertino widgets.';
}

// Path: settings.park_ticket
class _Translations$settings$park_ticket$en
    extends Translations$settings$park_ticket$de {
  _Translations$settings$park_ticket$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Parking ticket time buffer';
  @override
  String get subtitle =>
      'Set a time buffer so you have time to renew the ticket or return to the car before the parking ticket expires.';
  @override
  String dropdown_value({required Object value}) => '${value} minutes';
}

// Path: settings.driving_mode
class _Translations$settings$driving_mode$en
    extends Translations$settings$driving_mode$de {
  _Translations$settings$driving_mode$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Driving Mode Detection';
  @override
  String get subtitle =>
      'Set how fast you need to drive for the app to detect driving mode.';
  @override
  String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class _Translations$settings$app_info$en
    extends Translations$settings$app_info$de {
  _Translations$settings$app_info$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'App Info';
  @override
  String subtitle({required Object appVersion, required Object buildNumber}) =>
      'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class _Translations$settings$credits$en
    extends Translations$settings$credits$de {
  _Translations$settings$credits$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Credits';
  @override
  String get subtitle =>
      'Thanks to Google Maps API and of course to the Flutter community.';
}

// Path: settings.woauto_server
class _Translations$settings$woauto_server$en
    extends Translations$settings$woauto_server$de {
  _Translations$settings$woauto_server$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'WoAuto Server (PocketBase)';
  @override
  String subtitle({required Object status}) => 'Server status: ${status}';
}

// Path: settings.share
class _Translations$settings$share$en extends Translations$settings$share$de {
  _Translations$settings$share$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Share App';
  @override
  String get subtitle => 'Why not share the app with your friends and family?';
  @override
  String get share_content =>
      'Did you also forget where you parked last? No more. With WoAuto you can easily save your parking spot and view it later, share it with others and even navigate to it.\nYour parking spot is safe and always stays on your device.\n\nWhy don\'t you download it and try it out for yourself? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class _Translations$settings$feedback$en
    extends Translations$settings$feedback$de {
  _Translations$settings$feedback$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Feedback';
  @override
  String get subtitle =>
      'Do you have any suggestions for improvement, bugs or anything else to say?';
}

// Path: settings.data_security
class _Translations$settings$data_security$en
    extends Translations$settings$data_security$de {
  _Translations$settings$data_security$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Privacy and Legal Notice';
  @override
  String get subtitle => 'Learn how your data is protected.';
}

// Path: settings.app_data
class _Translations$settings$app_data$en
    extends Translations$settings$app_data$de {
  _Translations$settings$app_data$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Delete all app data';
  @override
  String get subtitle => 'Press and hold here to delete all your app data.';
  @override
  String get subtitle_ios => 'Tap here to delete all your app data.';
}

// Path: dialog.notifications.na
class _Translations$dialog$notifications$na$en
    extends Translations$dialog$notifications$na$de {
  _Translations$dialog$notifications$na$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Notifications are not available';
  @override
  String get subtitle => 'notifications are not available on your device';
}

// Path: dialog.notifications.denied
class _Translations$dialog$notifications$denied$en
    extends Translations$dialog$notifications$denied$de {
  _Translations$dialog$notifications$denied$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Notifications access denied';
  @override
  String get subtitle =>
      'You have denied notifications access. Please go to settings and allow notifications.';
}

// Path: dialog.notifications.sent
class _Translations$dialog$notifications$sent$en
    extends Translations$dialog$notifications$sent$de {
  _Translations$dialog$notifications$sent$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Car parked';
}

// Path: dialog.notifications.expiring
class _Translations$dialog$notifications$expiring$en
    extends Translations$dialog$notifications$expiring$de {
  _Translations$dialog$notifications$expiring$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Your parking ticket is about to expire';
  @override
  String subtitle({required Object minutesLeft}) =>
      'In about ${minutesLeft} minutes your parking ticket will expire, slowly prepare to leave.';
}

// Path: dialog.car_bottom_sheet.sync
class _Translations$dialog$car_bottom_sheet$sync$en
    extends Translations$dialog$car_bottom_sheet$sync$de {
  _Translations$dialog$car_bottom_sheet$sync$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sync parking spot';
  @override
  String get subtitle => 'Do you want to sync the parking spot?';
  @override
  String get action_1 => 'Sync';
}

// Path: dialog.car_bottom_sheet.synced
class _Translations$dialog$car_bottom_sheet$synced$en
    extends Translations$dialog$car_bottom_sheet$synced$de {
  _Translations$dialog$car_bottom_sheet$synced$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Parking spot synced';
  @override
  String get subtitle =>
      'This parking spot is now on WoAuto\'s servers.\nWould you like to share the parking spot?';
}

// Path: dialog.car_bottom_sheet.sharing
class _Translations$dialog$car_bottom_sheet$sharing$en
    extends Translations$dialog$car_bottom_sheet$sharing$de {
  _Translations$dialog$car_bottom_sheet$sharing$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Sharing parking spot';
  @override
  String get subtitle => 'Have this QR code scanned to share your location';
  @override
  String get action_1 => 'Share link';
  @override
  String share_content({required Object woLink}) =>
      'Here is my synced parking:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class _Translations$dialog$maps$driving_mode$en
    extends Translations$dialog$maps$driving_mode$de {
  _Translations$dialog$maps$driving_mode$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Driving mode detected';
  @override
  String get subtitle =>
      'You are (probably) driving your car right now. Do you want to switch to the driving mode?';
}

// Path: dialog.maps.location_denied
class _Translations$dialog$maps$location_denied$en
    extends Translations$dialog$maps$location_denied$de {
  _Translations$dialog$maps$location_denied$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Location permission denied';
  @override
  String get subtitle =>
      'You have denied location permission. Please go to settings and allow access to your location.';
}

// Path: dialog.maps.no_location
class _Translations$dialog$maps$no_location$en
    extends Translations$dialog$maps$no_location$de {
  _Translations$dialog$maps$no_location$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'No location selected';
  @override
  String get subtitle =>
      'Tap on the map to manually mark your parking spot, or enable location access.';
  @override
  String get select_on_map => 'Choose on map';
  @override
  String get enable_location => 'Enable location';
}

// Path: dialog.history.info
class _Translations$dialog$history$info$en
    extends Translations$dialog$history$info$de {
  _Translations$dialog$history$info$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'History';
  @override
  String get subtitle => 'This will show you the last 15 parking spaces';
}

// Path: dialog.history.delete
class _Translations$dialog$history$delete$en
    extends Translations$dialog$history$delete$de {
  _Translations$dialog$history$delete$en._(TranslationsEn root)
      : this._root = root,
        super.internal(root);

  final TranslationsEn _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Delete all entries';
  @override
  String get subtitle => 'Are you sure you want to delete all entries?';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'constants.app_name' => 'WoAuto',
      'constants.default_park_title' => 'My Car',
      'constants.default_shared_title' => 'Other Car',
      'constants.default_park_info' => 'e.g., parking level 2',
      'constants.default_address' => 'No address found',
      'constants.address_na' => 'Address was not found.',
      'constants.update' => 'Update',
      'constants.error' => 'Error',
      'constants.error_description' => 'An error occurred.',
      'constants.parked_rn' => 'parked right now',
      'constants.parked_duration_string' => ({required Object duration}) =>
          'parked since ${duration}',
      'constants.navigate' => 'Navigate',
      'park_duration.hours' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
            n,
            one: '${n} hour',
            other: '${n} hours',
          ),
      'park_duration.minutes' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
            n,
            one: '${n} minute',
            other: '${n} minutes',
          ),
      'park_duration.days' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(
            n,
            one: '${n} day',
            other: '${n} days',
          ),
      'login_dialog.email' => 'E-Mail',
      'login_dialog.password' => 'Password',
      'login_dialog.empty_validation' => 'Please enter something in',
      'login_dialog.email_validation' => 'Please enter a valid e-mail address',
      'login_dialog.password_validation' =>
        'Please enter a secure, >= 10 characters long password',
      'login_dialog.password_forgot' => 'Password forgot',
      'login_dialog.password_generate' => 'Generate password',
      'login_dialog.password_generate_info' =>
        'Your password will be inserted into the text field when you generate it. It will not be saved by us! Take a look at the code if you are not sure!',
      'login_dialog.register' => 'Register',
      'login_dialog.login' => 'Login',
      'park_dialog.title' => 'New Parking',
      'park_dialog.content_1' => 'Save the new parking?',
      'park_dialog.park_name.label' => 'Name',
      'park_dialog.content_2' => 'Additional information',
      'park_dialog.info.label' => 'Info',
      'park_dialog.ticket.title' => 'Parking ticket',
      'park_dialog.ticket.help' => 'Parking ticket expires at',
      'park_dialog.ticket.until' => ({required Object time}) =>
          'Parking ticket valid until ${time} o\'clock',
      'park_dialog.photo.title' => 'Photo',
      'marker_dialog.shared.content' => ({required Object address}) =>
          'This parking spot is being shared with you.\n\nThe car is at the following address:\n${address}.',
      'marker_dialog.mine.content' => (
              {required Object formattedDate,
              required Object address,
              required Object description}) =>
          'You have ${formattedDate}.\n\nYour car is at the following address:\n${address}.\n${description}',
      'marker_dialog.action_1' => 'Delete parking',
      'home.navigation_1' => 'Map',
      'home.navigation_2' => 'My Car',
      'home.navigation_3' => 'History',
      'home.navigation_4' => 'Settings',
      'home.quick_actions.action_parkings' => 'Open parking spots',
      'home.quick_actions.action_save' => 'Quicksave parking spot',
      'history.title' => 'History',
      'history.empty.title' => 'No entries',
      'history.empty.subtitle' => 'You have no entries in your history.',
      'history.export.title' => 'Export as CSV',
      'history.export.subtitle' =>
        'Export your history as a CSV file. This will include all of your parking spots.',
      'history.delete.title' => 'Delete all entries',
      'history.delete.subtitle' => 'Delete all entries in your history.',
      'info_sheet.park_save' => 'Save parking spot',
      'info_sheet.current_position' => 'Go to your current position',
      'info_sheet.parkings' => 'Open parking spots',
      'info_sheet.badge_label' => 'Sync',
      'top_header.driving_mode_tooltip' => 'Driving mode',
      'car_bottom_sheet.empty.parkings' => 'You have no parking spots.',
      'car_bottom_sheet.empty.shared_parkings' =>
        'You have no shared parking spots.',
      'car_bottom_sheet.distance_calculation.title' =>
        'How are we calculating the distance?',
      'car_bottom_sheet.you.title' => 'You',
      'car_bottom_sheet.you.address' => 'On you',
      'car_bottom_sheet.friends.title' => 'Friends',
      'car_bottom_sheet.friends.park' => 'parking',
      'car_bottom_sheet.menu.open_park_in_maps' => 'Open in a maps app',
      'car_bottom_sheet.menu.share_park' => 'Share parking spot',
      'car_bottom_sheet.menu.to_park' => 'Go to parking spot',
      'car_bottom_sheet.menu.delete_park' => 'Delete parking spot',
      'my_car.title' => 'My Car',
      'my_car.login_register' => 'Login or Register now',
      'my_car.shared_content' => 'This is my car! 🚗',
      'my_car.built.title' => (
              {required Object baujahr, required Object jahre}) =>
          'Year of manufacture: ${baujahr} (${jahre} Jahre)',
      'my_car.built.title_short' => ({required Object baujahr}) =>
          'Year of manufacture: ${baujahr}',
      'my_car.built.title_dialog' => 'Year of manufacture',
      'my_car.built.subtitle' => 'Change the year of manufacture of your car.',
      'my_car.built.default_year' => '2002',
      'my_car.built.validate_null' =>
        'Please enter a valid year of manufacture.',
      'my_car.built.validate_year' => ({required Object year}) =>
          'Please enter a valid year of manufacture between 1900 and ${year}',
      'my_car.driven.title' => ({required Object km}) => '${km} km driven',
      'my_car.driven.title_short' => ({required Object km}) => 'Mileage: ${km}',
      'my_car.driven.title_dialog' => 'Mileage',
      'my_car.driven.subtitle' => 'Change the mileage of your car.',
      'my_car.driven.hint' => '123456',
      'my_car.plate.title' => ({required Object plate}) =>
          'License plate: ${plate}',
      'my_car.plate.subtitle' => 'Change the license plate of your car.',
      'my_car.plate.title_short' => 'License plate',
      'my_car.plate.hint' => 'B-DE-1234',
      'my_car.park_name.title' => ({required Object name}) => 'Title: ${name}',
      'my_car.park_name.subtitle' =>
        'Change the title of your car, e.g., Mercedes, Audi or BMW.',
      'my_car.park_name.park_title' => 'Name of your car',
      'my_car.tuv.title' => ({required Object date}) => 'MOT until ${date}',
      'my_car.tuv.subtitle' => 'Change the MOT date of your car.',
      'my_car.tuv.help' => 'Choose the "1." of the month, e.g., "1.1.2022"',
      'my_car.tuv.add_to_calender' => 'Add to calendar',
      'my_car.tuv.calender_title' => 'MOT expired',
      'my_car.tuv.calender_content' =>
        'Your MOT has expired! Please make an appointment.\n\nBest regards,\nYour WoAuto-Team',
      'my_car.tuv.expired_info' => 'Your MOT has expired!',
      'my_car.tuv.expiring_info' =>
        'Your MOT will expire soon! Please make an appointment.',
      'my_car.share_deactivate_info' =>
        'If you deactivate these settings, you will be asked to confirm the action again, as switching off always deletes all data from the server first and then prevents it from being saved until you switch it on again.',
      'my_car.share_my_last_location' => 'Share my last location',
      'my_car.share_my_last_location_description' =>
        'While using the app, your live location is saved on our server and only your friends can view it. As soon as the app is closed, the last set location remains visible.',
      'my_car.share_my_last_location_deactivate' =>
        'When you end your sharing, your location will first be deleted from our server and saving will be prevented until you reactivate it.',
      'my_car.share_my_parkings' => 'Share my parking spaces',
      'my_car.share_my_parkings_description' =>
        'This will save your parking spaces in our servers and so your friends, only they, can see your parking spaces, but never your parking history.',
      'my_car.share_my_parkings_deactivate' =>
        'When you end your sharing, your parking locations will be deleted from our server and saving will be prevented until you reactivate it.',
      'my_car.secure_notice' =>
        'Your private car data is stored locally on your device. We do not have access to your data. You can also delete your data at any time in the settings.',
      'maps.loading' => 'Loading maps ...',
      'maps.traffic.show' => 'Show traffic',
      'maps.traffic.hide' => 'Hide traffic',
      'intro.page_1.page_title' => 'WoAuto',
      'intro.page_1.title' => 'Welcome to WoAuto',
      'intro.page_1.content_1' =>
        'With WoAuto you can save your parking spot and view it later, share it with others and even navigate to it.',
      'intro.page_1.content_2' =>
        'Your parking spot is safe and always stays on your device.',
      'intro.page_1.content_3' => 'Save your parking spot in just 2 clicks.',
      'intro.page_1.action_1' => 'Continue',
      'intro.page_2.page_title' => 'App preferences',
      'intro.page_2.parking_title' => 'Set a name for your car',
      'intro.page_2.parking_content' => 'Give your car a cool name',
      'intro.page_2.parking_hint' => 'My Car',
      'intro.page_2.theme_title' => 'Set the app theme',
      'intro.page_2.theme_content' => 'Choose the theme you like best',
      'intro.page_2.location_title' =>
        'Allow real-time location permission (optional)',
      'intro.page_2.location_content' =>
        'In order for WoAuto to automatically save your location, you can allow real-time location permission. This helps automatically locate your parking spot.',
      'intro.page_2.location_checkbox' => 'Real-time location permission',
      'intro.page_2.location_checkbox_error' =>
        'Please allow the app to query your location while using the app.',
      'intro.page_2.notification_checkbox' => 'Notifications (optional)',
      'intro.page_2.exact_notification_checkbox' =>
        'Scheduled notifications (optional)',
      'intro.page_2.exact_notification_description' =>
        'Receive a notification when your parking ticket is about to expire.',
      'intro.page_2.action_1' => 'Done',
      'bottom_sheet.photo' => 'Choose photo',
      'bottom_sheet.camera' => 'Take photo',
      'bottom_sheet.photo_delete' => 'Delete photo',
      'snackbar.locked.title' => 'Did you lock your car?',
      'snackbar.locked.subtitle' => 'This is a reminder if you locked your car',
      'snackbar.locked.action' => 'Yes, I did',
      'snackbar.shared_parking.title' =>
        'A shared online parking space has been added',
      'snackbar.shared_parking.subtitle' => 'Check the map or the list.',
      'snackbar.distance_calculation.title' =>
        'How is the distance calculated?',
      'snackbar.distance_calculation.subtitle' =>
        'Distance is calculated using the Haversine formula. The formula is a special form of the Pythagorean formula used to calculate the distance between two points on a sphere. The formula is also known as "sphere distance".',
      'snackbar.distance_calculation.subsubtitle' => 'Click here to know more.',
      'dialog.abort' => 'Cancel',
      'dialog.delete' => 'Delete',
      'dialog.leave' => 'Exit',
      'dialog.logout' => 'Logout',
      'dialog.ok' => 'Ok',
      'dialog.yes' => 'Yes',
      'dialog.no' => 'No',
      'dialog.share' => 'Share',
      'dialog.save' => 'Save',
      'dialog.open_settings' => 'Open settings',
      'dialog.share_location_parkings.title' => 'Deactivate Sharing',
      'dialog.share_location_parkings.content_1' => '',
      'dialog.share_location_parkings.content_2' =>
        'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.',
      'dialog.share_location_parkings.deactivate' => 'Deactivate',
      'dialog.distance.title' => 'Distance calculation',
      'dialog.distance.content' => ({required Object distance}) =>
          'The calculated distance is ${distance}',
      'dialog.notifications.na.title' => 'Notifications are not available',
      'dialog.notifications.na.subtitle' =>
        'notifications are not available on your device',
      'dialog.notifications.denied.title' => 'Notifications access denied',
      'dialog.notifications.denied.subtitle' =>
        'You have denied notifications access. Please go to settings and allow notifications.',
      'dialog.notifications.sent.title' => 'Car parked',
      'dialog.notifications.expiring.title' =>
        'Your parking ticket is about to expire',
      'dialog.notifications.expiring.subtitle' => (
              {required Object minutesLeft}) =>
          'In about ${minutesLeft} minutes your parking ticket will expire, slowly prepare to leave.',
      'dialog.car_bottom_sheet.sync.title' => 'Sync parking spot',
      'dialog.car_bottom_sheet.sync.subtitle' =>
        'Do you want to sync the parking spot?',
      'dialog.car_bottom_sheet.sync.action_1' => 'Sync',
      'dialog.car_bottom_sheet.synced.title' => 'Parking spot synced',
      'dialog.car_bottom_sheet.synced.subtitle' =>
        'This parking spot is now on WoAuto\'s servers.\nWould you like to share the parking spot?',
      'dialog.car_bottom_sheet.sharing.title' => 'Sharing parking spot',
      'dialog.car_bottom_sheet.sharing.subtitle' =>
        'Have this QR code scanned to share your location',
      'dialog.car_bottom_sheet.sharing.action_1' => 'Share link',
      'dialog.car_bottom_sheet.sharing.share_content' =>
        ({required Object woLink}) => 'Here is my synced parking:\n\n${woLink}',
      'dialog.maps.driving_mode.title' => 'Driving mode detected',
      'dialog.maps.driving_mode.subtitle' =>
        'You are (probably) driving your car right now. Do you want to switch to the driving mode?',
      'dialog.maps.location_denied.title' => 'Location permission denied',
      'dialog.maps.location_denied.subtitle' =>
        'You have denied location permission. Please go to settings and allow access to your location.',
      'dialog.maps.no_location.title' => 'No location selected',
      'dialog.maps.no_location.subtitle' =>
        'Tap on the map to manually mark your parking spot, or enable location access.',
      'dialog.maps.no_location.select_on_map' => 'Choose on map',
      'dialog.maps.no_location.enable_location' => 'Enable location',
      'dialog.history.info.title' => 'History',
      'dialog.history.info.subtitle' =>
        'This will show you the last 15 parking spaces',
      'dialog.history.delete.title' => 'Delete all entries',
      'dialog.history.delete.subtitle' =>
        'Are you sure you want to delete all entries?',
      'dialog.leave_info.title' => 'Leave App',
      'dialog.leave_info.subtitle' => 'Are you sure you want to leave the app?',
      'dialog.app_info.title' => 'App Info',
      'dialog.app_info.subtitle' =>
        'This app was developed by Emre Yurtseven, is open-source and of course available on Github.',
      'dialog.app_info.action_1' => 'GitHub',
      'dialog.feedback.title' => 'Feedback',
      'dialog.feedback.subtitle' =>
        'Feel free to email me, join our Telegram channel, or send me a private message on Telegram:',
      'dialog.feedback.action_1' => 'Telegram',
      'dialog.data_security.title' => 'Privacy Policy and Legal Notice',
      'dialog.data_security.content_1' =>
        'Brief summary of privacy policy in our own words (as of 14th December 2025):',
      'dialog.data_security.content_2' =>
        '- The app communicates with Google Maps to display the map.',
      'dialog.data_security.content_4' =>
        '- The app does not store any metadata, such as IP address, device name, or operating system version.',
      'dialog.data_security.content_5' =>
        '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ',
      'dialog.data_security.content_6' => 'not to any third parties.',
      'dialog.data_security.content_7' =>
        '\n\n A data exchange with the servers of Google, when providing the Google Maps maps, takes place. ',
      'dialog.data_security.content_8' =>
        'The app otherwise stores all data only on your device and you can delete them at any time.',
      'dialog.data_security.action_1' => 'Imprint',
      'dialog.data_security.action_2' => 'Privacy',
      'dialog.app_data.title' => 'Delete App Data',
      'dialog.app_data.subtitle' =>
        'Are you sure you want to delete all app data?',
      'dialog.account_data.title' => 'Delete Account & Data',
      'dialog.account_data.content' =>
        'This will delete your account, all the data associated with you, parkings, locations etc. It will also reset all of app-data on device.',
      'dialog.logout_confirm' => 'Are you sure you want to logout?',
      'settings.title' => 'Settings',
      'settings.theme.title' => 'Theme',
      'settings.theme.subtitle' => 'Choose the theme you like best.',
      'settings.theme.dropdown_1' => 'System',
      'settings.theme.dropdown_2' => 'Light',
      'settings.theme.dropdown_3' => 'Dark',
      'settings.color.choice' => 'Color',
      'settings.map_type.title' => 'Map type',
      'settings.map_type.subtitle' => 'Choose the map type you like best.',
      'settings.map_type.dropdown_1' => 'Normal',
      'settings.map_type.dropdown_2' => 'Satellite',
      'settings.map_type.dropdown_3' => 'Hybrid',
      'settings.map_type.dropdown_4' => 'Terrain',
      'settings.traffic.title' => 'Traffic',
      'settings.traffic.subtitle' =>
        'Show the current traffic situation on the map.',
      'settings.location.title' => 'Real-time Location',
      'settings.location.subtitle' =>
        'Toggle location permission or open system settings to adjust.',
      'settings.new_ios.title' => 'iOS only design',
      'settings.new_ios.subtitle' =>
        'Use the iOS only design with Cupertino widgets.',
      'settings.park_ticket.title' => 'Parking ticket time buffer',
      'settings.park_ticket.subtitle' =>
        'Set a time buffer so you have time to renew the ticket or return to the car before the parking ticket expires.',
      'settings.park_ticket.dropdown_value' => ({required Object value}) =>
          '${value} minutes',
      'settings.driving_mode.title' => 'Driving Mode Detection',
      'settings.driving_mode.subtitle' =>
        'Set how fast you need to drive for the app to detect driving mode.',
      'settings.driving_mode.dropdown_value' => ({required Object value}) =>
          '${value} km/h',
      'settings.app_info.title' => 'App Info',
      'settings.app_info.subtitle' => (
              {required Object appVersion, required Object buildNumber}) =>
          'Version ${appVersion}+${buildNumber}',
      'settings.credits.title' => 'Credits',
      'settings.credits.subtitle' =>
        'Thanks to Google Maps API and of course to the Flutter community.',
      'settings.woauto_server.title' => 'WoAuto Server (PocketBase)',
      'settings.woauto_server.subtitle' => ({required Object status}) =>
          'Server status: ${status}',
      'settings.share.title' => 'Share App',
      'settings.share.subtitle' =>
        'Why not share the app with your friends and family?',
      'settings.share.share_content' =>
        'Did you also forget where you parked last? No more. With WoAuto you can easily save your parking spot and view it later, share it with others and even navigate to it.\nYour parking spot is safe and always stays on your device.\n\nWhy don\'t you download it and try it out for yourself? https://play.google.com/store/apps/details?id=de.emredev.woauto',
      'settings.feedback.title' => 'Feedback',
      'settings.feedback.subtitle' =>
        'Do you have any suggestions for improvement, bugs or anything else to say?',
      'settings.data_security.title' => 'Privacy and Legal Notice',
      'settings.data_security.subtitle' => 'Learn how your data is protected.',
      'settings.app_data.title' => 'Delete all app data',
      'settings.app_data.subtitle' =>
        'Press and hold here to delete all your app data.',
      'settings.app_data.subtitle_ios' =>
        'Tap here to delete all your app data.',
      _ => null,
    };
  }
}
