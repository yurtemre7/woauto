///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsConstantsEn constants = _TranslationsConstantsEn._(_root);
	@override late final _TranslationsParkDurationEn park_duration = _TranslationsParkDurationEn._(_root);
	@override late final _TranslationsLoginDialogEn login_dialog = _TranslationsLoginDialogEn._(_root);
	@override late final _TranslationsParkDialogEn park_dialog = _TranslationsParkDialogEn._(_root);
	@override late final _TranslationsMarkerDialogEn marker_dialog = _TranslationsMarkerDialogEn._(_root);
	@override late final _TranslationsHomeEn home = _TranslationsHomeEn._(_root);
	@override late final _TranslationsHistoryEn history = _TranslationsHistoryEn._(_root);
	@override late final _TranslationsInfoSheetEn info_sheet = _TranslationsInfoSheetEn._(_root);
	@override late final _TranslationsTopHeaderEn top_header = _TranslationsTopHeaderEn._(_root);
	@override late final _TranslationsCarBottomSheetEn car_bottom_sheet = _TranslationsCarBottomSheetEn._(_root);
	@override late final _TranslationsMyCarEn my_car = _TranslationsMyCarEn._(_root);
	@override late final _TranslationsMapsEn maps = _TranslationsMapsEn._(_root);
	@override late final _TranslationsIntroEn intro = _TranslationsIntroEn._(_root);
	@override late final _TranslationsBottomSheetEn bottom_sheet = _TranslationsBottomSheetEn._(_root);
	@override late final _TranslationsSnackbarEn snackbar = _TranslationsSnackbarEn._(_root);
	@override late final _TranslationsDialogEn dialog = _TranslationsDialogEn._(_root);
	@override late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
}

// Path: constants
class _TranslationsConstantsEn extends TranslationsConstantsDe {
	_TranslationsConstantsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get app_name => 'WoAuto';
	@override String get default_park_title => 'My Car';
	@override String get default_shared_title => 'Other Car';
	@override String get default_park_info => 'e.g., parking level 2';
	@override String get default_address => 'No address found';
	@override String get address_na => 'Address was not found.';
	@override String get update => 'Update';
	@override String get error => 'Error';
	@override String get error_description => 'An error occurred.';
	@override String get parked_rn => 'parked right now';
	@override String parked_duration_string({required Object duration}) => 'parked since ${duration}';
	@override String get navigate => 'Navigate';
}

// Path: park_duration
class _TranslationsParkDurationEn extends TranslationsParkDurationDe {
	_TranslationsParkDurationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String hours({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} hour',
		other: '${n} hours',
	);
	@override String minutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} minute',
		other: '${n} minutes',
	);
	@override String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day',
		other: '${n} days',
	);
}

// Path: login_dialog
class _TranslationsLoginDialogEn extends TranslationsLoginDialogDe {
	_TranslationsLoginDialogEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get email => 'E-Mail';
	@override String get password => 'Password';
	@override String get empty_validation => 'Please enter something in';
	@override String get email_validation => 'Please enter a valid e-mail address';
	@override String get password_validation => 'Please enter a secure, >= 10 characters long password';
	@override String get password_forgot => 'Password forgot';
	@override String get password_generate => 'Generate password';
	@override String get password_generate_info => 'Your password will be inserted into the text field when you generate it. It will not be saved by us! Take a look at the code if you are not sure!';
	@override String get register => 'Register';
	@override String get login => 'Login';
}

// Path: park_dialog
class _TranslationsParkDialogEn extends TranslationsParkDialogDe {
	_TranslationsParkDialogEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'New Parking';
	@override String get content_1 => 'Save the new parking?';
	@override late final _TranslationsParkDialogParkNameEn park_name = _TranslationsParkDialogParkNameEn._(_root);
	@override String get content_2 => 'Additional information';
	@override late final _TranslationsParkDialogInfoEn info = _TranslationsParkDialogInfoEn._(_root);
	@override late final _TranslationsParkDialogTicketEn ticket = _TranslationsParkDialogTicketEn._(_root);
	@override late final _TranslationsParkDialogPhotoEn photo = _TranslationsParkDialogPhotoEn._(_root);
}

// Path: marker_dialog
class _TranslationsMarkerDialogEn extends TranslationsMarkerDialogDe {
	_TranslationsMarkerDialogEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMarkerDialogSharedEn shared = _TranslationsMarkerDialogSharedEn._(_root);
	@override late final _TranslationsMarkerDialogMineEn mine = _TranslationsMarkerDialogMineEn._(_root);
	@override String get action_1 => 'Delete parking';
}

// Path: home
class _TranslationsHomeEn extends TranslationsHomeDe {
	_TranslationsHomeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get navigation_1 => 'Map';
	@override String get navigation_2 => 'My Car';
	@override String get navigation_3 => 'History';
	@override String get navigation_4 => 'Settings';
	@override late final _TranslationsHomeQuickActionsEn quick_actions = _TranslationsHomeQuickActionsEn._(_root);
}

// Path: history
class _TranslationsHistoryEn extends TranslationsHistoryDe {
	_TranslationsHistoryEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override late final _TranslationsHistoryEmptyEn empty = _TranslationsHistoryEmptyEn._(_root);
	@override late final _TranslationsHistoryExportEn export = _TranslationsHistoryExportEn._(_root);
	@override late final _TranslationsHistoryDeleteEn delete = _TranslationsHistoryDeleteEn._(_root);
}

// Path: info_sheet
class _TranslationsInfoSheetEn extends TranslationsInfoSheetDe {
	_TranslationsInfoSheetEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get park_save => 'Save parking spot';
	@override String get current_position => 'Go to your current position';
	@override String get parkings => 'Open parking spots';
	@override String get badge_label => 'Sync';
}

// Path: top_header
class _TranslationsTopHeaderEn extends TranslationsTopHeaderDe {
	_TranslationsTopHeaderEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get driving_mode_tooltip => 'Driving mode';
}

// Path: car_bottom_sheet
class _TranslationsCarBottomSheetEn extends TranslationsCarBottomSheetDe {
	_TranslationsCarBottomSheetEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCarBottomSheetEmptyEn empty = _TranslationsCarBottomSheetEmptyEn._(_root);
	@override late final _TranslationsCarBottomSheetDistanceCalculationEn distance_calculation = _TranslationsCarBottomSheetDistanceCalculationEn._(_root);
	@override late final _TranslationsCarBottomSheetYouEn you = _TranslationsCarBottomSheetYouEn._(_root);
	@override late final _TranslationsCarBottomSheetFriendsEn friends = _TranslationsCarBottomSheetFriendsEn._(_root);
	@override late final _TranslationsCarBottomSheetMenuEn menu = _TranslationsCarBottomSheetMenuEn._(_root);
}

// Path: my_car
class _TranslationsMyCarEn extends TranslationsMyCarDe {
	_TranslationsMyCarEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My Car';
	@override String get login_register => 'Login or Register now';
	@override String get shared_content => 'This is my car! 🚗';
	@override late final _TranslationsMyCarBuiltEn built = _TranslationsMyCarBuiltEn._(_root);
	@override late final _TranslationsMyCarDrivenEn driven = _TranslationsMyCarDrivenEn._(_root);
	@override late final _TranslationsMyCarPlateEn plate = _TranslationsMyCarPlateEn._(_root);
	@override late final _TranslationsMyCarParkNameEn park_name = _TranslationsMyCarParkNameEn._(_root);
	@override late final _TranslationsMyCarTuvEn tuv = _TranslationsMyCarTuvEn._(_root);
	@override String get share_deactivate_info => 'If you deactivate these settings, you will be asked to confirm the action again, as switching off always deletes all data from the server first and then prevents it from being saved until you switch it on again.';
	@override String get share_my_last_location => 'Share my last location';
	@override String get share_my_last_location_description => 'While using the app, your live location is saved on our server and only your friends can view it. As soon as the app is closed, the last set location remains visible.';
	@override String get share_my_last_location_deactivate => 'When you end your sharing, your location will first be deleted from our server and saving will be prevented until you reactivate it.';
	@override String get share_my_parkings => 'Share my parking spaces';
	@override String get share_my_parkings_description => 'This will save your parking spaces in our servers and so your friends, only they, can see your parking spaces, but never your parking history.';
	@override String get share_my_parkings_deactivate => 'When you end your sharing, your parking locations will be deleted from our server and saving will be prevented until you reactivate it.';
	@override String get secure_notice => 'Your private car data is stored locally on your device. We do not have access to your data. You can also delete your data at any time in the settings.';
}

// Path: maps
class _TranslationsMapsEn extends TranslationsMapsDe {
	_TranslationsMapsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading maps ...';
	@override late final _TranslationsMapsTrafficEn traffic = _TranslationsMapsTrafficEn._(_root);
}

// Path: intro
class _TranslationsIntroEn extends TranslationsIntroDe {
	_TranslationsIntroEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsIntroPage1En page_1 = _TranslationsIntroPage1En._(_root);
	@override late final _TranslationsIntroPage2En page_2 = _TranslationsIntroPage2En._(_root);
}

// Path: bottom_sheet
class _TranslationsBottomSheetEn extends TranslationsBottomSheetDe {
	_TranslationsBottomSheetEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get photo => 'Choose photo';
	@override String get camera => 'Take photo';
	@override String get photo_delete => 'Delete photo';
}

// Path: snackbar
class _TranslationsSnackbarEn extends TranslationsSnackbarDe {
	_TranslationsSnackbarEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSnackbarLockedEn locked = _TranslationsSnackbarLockedEn._(_root);
	@override late final _TranslationsSnackbarSharedParkingEn shared_parking = _TranslationsSnackbarSharedParkingEn._(_root);
	@override late final _TranslationsSnackbarDistanceCalculationEn distance_calculation = _TranslationsSnackbarDistanceCalculationEn._(_root);
}

// Path: dialog
class _TranslationsDialogEn extends TranslationsDialogDe {
	_TranslationsDialogEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get abort => 'Cancel';
	@override String get delete => 'Delete';
	@override String get leave => 'Exit';
	@override String get logout => 'Logout';
	@override String get ok => 'Ok';
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get share => 'Share';
	@override String get save => 'Save';
	@override String get open_settings => 'Open settings';
	@override late final _TranslationsDialogShareLocationParkingsEn share_location_parkings = _TranslationsDialogShareLocationParkingsEn._(_root);
	@override late final _TranslationsDialogDistanceEn distance = _TranslationsDialogDistanceEn._(_root);
	@override late final _TranslationsDialogNotificationsEn notifications = _TranslationsDialogNotificationsEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetEn car_bottom_sheet = _TranslationsDialogCarBottomSheetEn._(_root);
	@override late final _TranslationsDialogMapsEn maps = _TranslationsDialogMapsEn._(_root);
	@override late final _TranslationsDialogHistoryEn history = _TranslationsDialogHistoryEn._(_root);
	@override late final _TranslationsDialogLeaveInfoEn leave_info = _TranslationsDialogLeaveInfoEn._(_root);
	@override late final _TranslationsDialogAppInfoEn app_info = _TranslationsDialogAppInfoEn._(_root);
	@override late final _TranslationsDialogFeedbackEn feedback = _TranslationsDialogFeedbackEn._(_root);
	@override late final _TranslationsDialogDataSecurityEn data_security = _TranslationsDialogDataSecurityEn._(_root);
	@override late final _TranslationsDialogAppDataEn app_data = _TranslationsDialogAppDataEn._(_root);
	@override late final _TranslationsDialogAccountDataEn account_data = _TranslationsDialogAccountDataEn._(_root);
	@override String get logout_confirm => 'Are you sure you want to logout?';
}

// Path: settings
class _TranslationsSettingsEn extends TranslationsSettingsDe {
	_TranslationsSettingsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Settings';
	@override late final _TranslationsSettingsThemeEn theme = _TranslationsSettingsThemeEn._(_root);
	@override late final _TranslationsSettingsColorEn color = _TranslationsSettingsColorEn._(_root);
	@override late final _TranslationsSettingsMapTypeEn map_type = _TranslationsSettingsMapTypeEn._(_root);
	@override late final _TranslationsSettingsTrafficEn traffic = _TranslationsSettingsTrafficEn._(_root);
	@override late final _TranslationsSettingsNewIosEn new_ios = _TranslationsSettingsNewIosEn._(_root);
	@override late final _TranslationsSettingsParkTicketEn park_ticket = _TranslationsSettingsParkTicketEn._(_root);
	@override late final _TranslationsSettingsDrivingModeEn driving_mode = _TranslationsSettingsDrivingModeEn._(_root);
	@override late final _TranslationsSettingsAppInfoEn app_info = _TranslationsSettingsAppInfoEn._(_root);
	@override late final _TranslationsSettingsCreditsEn credits = _TranslationsSettingsCreditsEn._(_root);
	@override late final _TranslationsSettingsWoautoServerEn woauto_server = _TranslationsSettingsWoautoServerEn._(_root);
	@override late final _TranslationsSettingsShareEn share = _TranslationsSettingsShareEn._(_root);
	@override late final _TranslationsSettingsFeedbackEn feedback = _TranslationsSettingsFeedbackEn._(_root);
	@override late final _TranslationsSettingsDataSecurityEn data_security = _TranslationsSettingsDataSecurityEn._(_root);
	@override late final _TranslationsSettingsAppDataEn app_data = _TranslationsSettingsAppDataEn._(_root);
}

// Path: park_dialog.park_name
class _TranslationsParkDialogParkNameEn extends TranslationsParkDialogParkNameDe {
	_TranslationsParkDialogParkNameEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Name';
}

// Path: park_dialog.info
class _TranslationsParkDialogInfoEn extends TranslationsParkDialogInfoDe {
	_TranslationsParkDialogInfoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Info';
}

// Path: park_dialog.ticket
class _TranslationsParkDialogTicketEn extends TranslationsParkDialogTicketDe {
	_TranslationsParkDialogTicketEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking ticket';
	@override String get help => 'Parking ticket expires at';
	@override String until({required Object time}) => 'Parking ticket valid until ${time} o\'clock';
}

// Path: park_dialog.photo
class _TranslationsParkDialogPhotoEn extends TranslationsParkDialogPhotoDe {
	_TranslationsParkDialogPhotoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Photo';
}

// Path: marker_dialog.shared
class _TranslationsMarkerDialogSharedEn extends TranslationsMarkerDialogSharedDe {
	_TranslationsMarkerDialogSharedEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String content({required Object address}) => 'This parking spot is being shared with you.\n\nThe car is at the following address:\n${address}.';
}

// Path: marker_dialog.mine
class _TranslationsMarkerDialogMineEn extends TranslationsMarkerDialogMineDe {
	_TranslationsMarkerDialogMineEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String content({required Object formattedDate, required Object address, required Object description}) => 'You have ${formattedDate}.\n\nYour car is at the following address:\n${address}.\n${description}';
}

// Path: home.quick_actions
class _TranslationsHomeQuickActionsEn extends TranslationsHomeQuickActionsDe {
	_TranslationsHomeQuickActionsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get action_parkings => 'Open parking spots';
	@override String get action_save => 'Quicksave parking spot';
}

// Path: history.empty
class _TranslationsHistoryEmptyEn extends TranslationsHistoryEmptyDe {
	_TranslationsHistoryEmptyEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'No entries';
	@override String get subtitle => 'You have no entries in your history.';
}

// Path: history.export
class _TranslationsHistoryExportEn extends TranslationsHistoryExportDe {
	_TranslationsHistoryExportEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Export as CSV';
	@override String get subtitle => 'Export your history as a CSV file. This will include all of your parking spots.';
}

// Path: history.delete
class _TranslationsHistoryDeleteEn extends TranslationsHistoryDeleteDe {
	_TranslationsHistoryDeleteEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all entries';
	@override String get subtitle => 'Delete all entries in your history.';
}

// Path: car_bottom_sheet.empty
class _TranslationsCarBottomSheetEmptyEn extends TranslationsCarBottomSheetEmptyDe {
	_TranslationsCarBottomSheetEmptyEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get parkings => 'You have no parking spots.';
	@override String get shared_parkings => 'You have no shared parking spots.';
}

// Path: car_bottom_sheet.distance_calculation
class _TranslationsCarBottomSheetDistanceCalculationEn extends TranslationsCarBottomSheetDistanceCalculationDe {
	_TranslationsCarBottomSheetDistanceCalculationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How are we calculating the distance?';
}

// Path: car_bottom_sheet.you
class _TranslationsCarBottomSheetYouEn extends TranslationsCarBottomSheetYouDe {
	_TranslationsCarBottomSheetYouEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'You';
	@override String get address => 'On you';
}

// Path: car_bottom_sheet.friends
class _TranslationsCarBottomSheetFriendsEn extends TranslationsCarBottomSheetFriendsDe {
	_TranslationsCarBottomSheetFriendsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Friends';
	@override String get park => 'parking';
}

// Path: car_bottom_sheet.menu
class _TranslationsCarBottomSheetMenuEn extends TranslationsCarBottomSheetMenuDe {
	_TranslationsCarBottomSheetMenuEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get open_park_in_maps => 'Open in a maps app';
	@override String get share_park => 'Share parking spot';
	@override String get to_park => 'Go to parking spot';
	@override String get delete_park => 'Delete parking spot';
}

// Path: my_car.built
class _TranslationsMyCarBuiltEn extends TranslationsMyCarBuiltDe {
	_TranslationsMyCarBuiltEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object baujahr, required Object jahre}) => 'Year of manufacture: ${baujahr} (${jahre} Jahre)';
	@override String title_short({required Object baujahr}) => 'Year of manufacture: ${baujahr}';
	@override String get title_dialog => 'Year of manufacture';
	@override String get subtitle => 'Change the year of manufacture of your car.';
	@override String get default_year => '2002';
	@override String get validate_null => 'Please enter a valid year of manufacture.';
	@override String validate_year({required Object year}) => 'Please enter a valid year of manufacture between 1900 and ${year}';
}

// Path: my_car.driven
class _TranslationsMyCarDrivenEn extends TranslationsMyCarDrivenDe {
	_TranslationsMyCarDrivenEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object km}) => '${km} km driven';
	@override String title_short({required Object km}) => 'Mileage: ${km}';
	@override String get title_dialog => 'Mileage';
	@override String get subtitle => 'Change the mileage of your car.';
	@override String get hint => '123456';
}

// Path: my_car.plate
class _TranslationsMyCarPlateEn extends TranslationsMyCarPlateDe {
	_TranslationsMyCarPlateEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object plate}) => 'License plate: ${plate}';
	@override String get subtitle => 'Change the license plate of your car.';
	@override String get title_short => 'License plate';
	@override String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class _TranslationsMyCarParkNameEn extends TranslationsMyCarParkNameDe {
	_TranslationsMyCarParkNameEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Title: ${name}';
	@override String get subtitle => 'Change the title of your car, e.g., Mercedes, Audi or BMW.';
	@override String get park_title => 'Name of your car';
}

// Path: my_car.tuv
class _TranslationsMyCarTuvEn extends TranslationsMyCarTuvDe {
	_TranslationsMyCarTuvEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object date}) => 'MOT until ${date}';
	@override String get subtitle => 'Change the MOT date of your car.';
	@override String get help => 'Choose the "1." of the month, e.g., "1.1.2022"';
	@override String get add_to_calender => 'Add to calendar';
	@override String get calender_title => 'MOT expired';
	@override String get calender_content => 'Your MOT has expired! Please make an appointment.\n\nBest regards,\nYour WoAuto-Team';
	@override String get expired_info => 'Your MOT has expired!';
	@override String get expiring_info => 'Your MOT will expire soon! Please make an appointment.';
}

// Path: maps.traffic
class _TranslationsMapsTrafficEn extends TranslationsMapsTrafficDe {
	_TranslationsMapsTrafficEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get show => 'Show traffic';
	@override String get hide => 'Hide traffic';
}

// Path: intro.page_1
class _TranslationsIntroPage1En extends TranslationsIntroPage1De {
	_TranslationsIntroPage1En._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'WoAuto';
	@override String get title => 'Welcome to WoAuto';
	@override String get content_1 => 'With WoAuto you can save your parking spot and view it later, share it with others and even navigate to it.';
	@override String get content_2 => 'Your parking spot is safe and always stays on your device.';
	@override String get content_3 => 'Save your parking spot in just 2 clicks.';
	@override String get action_1 => 'Continue';
}

// Path: intro.page_2
class _TranslationsIntroPage2En extends TranslationsIntroPage2De {
	_TranslationsIntroPage2En._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'App preferences';
	@override String get parking_title => 'Set a name for your car';
	@override String get parking_content => 'Give your car a cool name';
	@override String get parking_hint => 'My Car';
	@override String get theme_title => 'Set the app theme';
	@override String get theme_content => 'Choose the theme you like best';
	@override String get location_title => 'Allow real-time location permission';
	@override String get location_content => 'In order for WoAuto to save your location, you must allow real-time location permission. This is necessary to find your parking spot and load the map.';
	@override String get location_checkbox => 'Real-time location permission';
	@override String get location_checkbox_error => 'Please allow the app to query your location while using the app.';
	@override String get notification_checkbox => 'Notifications (optional)';
	@override String get exact_notification_checkbox => 'Scheduled notifications (optional)';
	@override String get exact_notification_description => 'Receive a notification when your parking ticket is about to expire.';
	@override String get action_1 => 'Done';
}

// Path: snackbar.locked
class _TranslationsSnackbarLockedEn extends TranslationsSnackbarLockedDe {
	_TranslationsSnackbarLockedEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Did you lock your car?';
	@override String get subtitle => 'This is a reminder if you locked your car';
	@override String get action => 'Yes, I did';
}

// Path: snackbar.shared_parking
class _TranslationsSnackbarSharedParkingEn extends TranslationsSnackbarSharedParkingDe {
	_TranslationsSnackbarSharedParkingEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'A shared online parking space has been added';
	@override String get subtitle => 'Check the map or the list.';
}

// Path: snackbar.distance_calculation
class _TranslationsSnackbarDistanceCalculationEn extends TranslationsSnackbarDistanceCalculationDe {
	_TranslationsSnackbarDistanceCalculationEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How is the distance calculated?';
	@override String get subtitle => 'Distance is calculated using the Haversine formula. The formula is a special form of the Pythagorean formula used to calculate the distance between two points on a sphere. The formula is also known as "sphere distance".';
	@override String get subsubtitle => 'Click here to know more.';
}

// Path: dialog.share_location_parkings
class _TranslationsDialogShareLocationParkingsEn extends TranslationsDialogShareLocationParkingsDe {
	_TranslationsDialogShareLocationParkingsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deactivate Sharing';
	@override String get content_1 => '';
	@override String get content_2 => 'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
	@override String get deactivate => 'Deactivate';
}

// Path: dialog.distance
class _TranslationsDialogDistanceEn extends TranslationsDialogDistanceDe {
	_TranslationsDialogDistanceEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Distance calculation';
	@override String content({required Object distance}) => 'The calculated distance is ${distance}';
}

// Path: dialog.notifications
class _TranslationsDialogNotificationsEn extends TranslationsDialogNotificationsDe {
	_TranslationsDialogNotificationsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogNotificationsNaEn na = _TranslationsDialogNotificationsNaEn._(_root);
	@override late final _TranslationsDialogNotificationsDeniedEn denied = _TranslationsDialogNotificationsDeniedEn._(_root);
	@override late final _TranslationsDialogNotificationsSentEn sent = _TranslationsDialogNotificationsSentEn._(_root);
	@override late final _TranslationsDialogNotificationsExpiringEn expiring = _TranslationsDialogNotificationsExpiringEn._(_root);
}

// Path: dialog.car_bottom_sheet
class _TranslationsDialogCarBottomSheetEn extends TranslationsDialogCarBottomSheetDe {
	_TranslationsDialogCarBottomSheetEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogCarBottomSheetSyncEn sync = _TranslationsDialogCarBottomSheetSyncEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetSyncedEn synced = _TranslationsDialogCarBottomSheetSyncedEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetSharingEn sharing = _TranslationsDialogCarBottomSheetSharingEn._(_root);
}

// Path: dialog.maps
class _TranslationsDialogMapsEn extends TranslationsDialogMapsDe {
	_TranslationsDialogMapsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogMapsDrivingModeEn driving_mode = _TranslationsDialogMapsDrivingModeEn._(_root);
	@override late final _TranslationsDialogMapsLocationDeniedEn location_denied = _TranslationsDialogMapsLocationDeniedEn._(_root);
}

// Path: dialog.history
class _TranslationsDialogHistoryEn extends TranslationsDialogHistoryDe {
	_TranslationsDialogHistoryEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogHistoryInfoEn info = _TranslationsDialogHistoryInfoEn._(_root);
	@override late final _TranslationsDialogHistoryDeleteEn delete = _TranslationsDialogHistoryDeleteEn._(_root);
}

// Path: dialog.leave_info
class _TranslationsDialogLeaveInfoEn extends TranslationsDialogLeaveInfoDe {
	_TranslationsDialogLeaveInfoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Leave App';
	@override String get subtitle => 'Are you sure you want to leave the app?';
}

// Path: dialog.app_info
class _TranslationsDialogAppInfoEn extends TranslationsDialogAppInfoDe {
	_TranslationsDialogAppInfoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'App Info';
	@override String get subtitle => 'This app was developed by Emre Yurtseven, is open-source and of course available on Github.';
	@override String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class _TranslationsDialogFeedbackEn extends TranslationsDialogFeedbackDe {
	_TranslationsDialogFeedbackEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Feedback';
	@override String get subtitle => 'Feel free to email me, join our Telegram channel, or send me a private message on Telegram:';
	@override String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class _TranslationsDialogDataSecurityEn extends TranslationsDialogDataSecurityDe {
	_TranslationsDialogDataSecurityEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Privacy Policy and Legal Notice';
	@override String get content_1 => 'Brief summary of privacy policy in our own words (as of 25/08/2024):';
	@override String get content_2 => '- The app communicates with Google Maps to display the map.';
	@override String get content_3 => '- The app communicates with my VPS server on German soil to display, create and manage synchronized parking spots and your location data, only ever if you allow it.';
	@override String get content_4 => '- The app does not store any metadata, such as IP address, device name, or operating system version.';
	@override String get content_5 => '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ';
	@override String get content_6 => 'not to any third parties.';
	@override String get content_7 => '\n\n A data exchange with my server and with the servers of Google, when providing the Google Maps maps, takes place. ';
	@override String get content_8 => 'The app otherwise stores all data only on your device and you can delete them at any time, then they are also deleted from my server (in the settings at the bottom).';
	@override String get action_1 => 'Imprint';
	@override String get action_2 => 'Privacy';
}

// Path: dialog.app_data
class _TranslationsDialogAppDataEn extends TranslationsDialogAppDataDe {
	_TranslationsDialogAppDataEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete App Data';
	@override String get subtitle => 'Are you sure you want to delete all app data?';
}

// Path: dialog.account_data
class _TranslationsDialogAccountDataEn extends TranslationsDialogAccountDataDe {
	_TranslationsDialogAccountDataEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete Account & Data';
	@override String get content => 'This will delete your account, all the data associated with you, parkings, locations etc. It will also reset all of app-data on device.';
}

// Path: settings.theme
class _TranslationsSettingsThemeEn extends TranslationsSettingsThemeDe {
	_TranslationsSettingsThemeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Theme';
	@override String get subtitle => 'Choose the theme you like best.';
	@override String get dropdown_1 => 'System';
	@override String get dropdown_2 => 'Light';
	@override String get dropdown_3 => 'Dark';
}

// Path: settings.color
class _TranslationsSettingsColorEn extends TranslationsSettingsColorDe {
	_TranslationsSettingsColorEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get choice => 'Color';
}

// Path: settings.map_type
class _TranslationsSettingsMapTypeEn extends TranslationsSettingsMapTypeDe {
	_TranslationsSettingsMapTypeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Map type';
	@override String get subtitle => 'Choose the map type you like best.';
	@override String get dropdown_1 => 'Normal';
	@override String get dropdown_2 => 'Satellite';
	@override String get dropdown_3 => 'Hybrid';
	@override String get dropdown_4 => 'Terrain';
}

// Path: settings.traffic
class _TranslationsSettingsTrafficEn extends TranslationsSettingsTrafficDe {
	_TranslationsSettingsTrafficEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Traffic';
	@override String get subtitle => 'Show the current traffic situation on the map.';
}

// Path: settings.new_ios
class _TranslationsSettingsNewIosEn extends TranslationsSettingsNewIosDe {
	_TranslationsSettingsNewIosEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'iOS only design';
	@override String get subtitle => 'Use the iOS only design with Cupertino widgets.';
}

// Path: settings.park_ticket
class _TranslationsSettingsParkTicketEn extends TranslationsSettingsParkTicketDe {
	_TranslationsSettingsParkTicketEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking ticket time buffer';
	@override String get subtitle => 'Set a time buffer so you have time to renew the ticket or return to the car before the parking ticket expires.';
	@override String dropdown_value({required Object value}) => '${value} minutes';
}

// Path: settings.driving_mode
class _TranslationsSettingsDrivingModeEn extends TranslationsSettingsDrivingModeDe {
	_TranslationsSettingsDrivingModeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Driving Mode Detection';
	@override String get subtitle => 'Set how fast you need to drive for the app to detect driving mode.';
	@override String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class _TranslationsSettingsAppInfoEn extends TranslationsSettingsAppInfoDe {
	_TranslationsSettingsAppInfoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'App Info';
	@override String subtitle({required Object appVersion, required Object buildNumber}) => 'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class _TranslationsSettingsCreditsEn extends TranslationsSettingsCreditsDe {
	_TranslationsSettingsCreditsEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Credits';
	@override String get subtitle => 'Thanks to Google Maps API and of course to the Flutter community.';
}

// Path: settings.woauto_server
class _TranslationsSettingsWoautoServerEn extends TranslationsSettingsWoautoServerDe {
	_TranslationsSettingsWoautoServerEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'WoAuto Server (PocketBase)';
	@override String subtitle({required Object status}) => 'Server status: ${status}';
}

// Path: settings.share
class _TranslationsSettingsShareEn extends TranslationsSettingsShareDe {
	_TranslationsSettingsShareEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Share App';
	@override String get subtitle => 'Why not share the app with your friends and family?';
	@override String get share_content => 'Did you also forget where you parked last? No more. With WoAuto you can easily save your parking spot and view it later, share it with others and even navigate to it.\nYour parking spot is safe and always stays on your device.\n\nWhy don\'t you download it and try it out for yourself? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class _TranslationsSettingsFeedbackEn extends TranslationsSettingsFeedbackDe {
	_TranslationsSettingsFeedbackEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Feedback';
	@override String get subtitle => 'Do you have any suggestions for improvement, bugs or anything else to say?';
}

// Path: settings.data_security
class _TranslationsSettingsDataSecurityEn extends TranslationsSettingsDataSecurityDe {
	_TranslationsSettingsDataSecurityEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Privacy and Legal Notice';
	@override String get subtitle => 'Learn how your data is protected.';
}

// Path: settings.app_data
class _TranslationsSettingsAppDataEn extends TranslationsSettingsAppDataDe {
	_TranslationsSettingsAppDataEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all app data';
	@override String get subtitle => 'Press and hold here to delete all your app data.';
	@override String get subtitle_ios => 'Tap here to delete all your app data.';
}

// Path: dialog.notifications.na
class _TranslationsDialogNotificationsNaEn extends TranslationsDialogNotificationsNaDe {
	_TranslationsDialogNotificationsNaEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications are not available';
	@override String get subtitle => 'notifications are not available on your device';
}

// Path: dialog.notifications.denied
class _TranslationsDialogNotificationsDeniedEn extends TranslationsDialogNotificationsDeniedDe {
	_TranslationsDialogNotificationsDeniedEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications access denied';
	@override String get subtitle => 'You have denied notifications access. Please go to settings and allow notifications.';
}

// Path: dialog.notifications.sent
class _TranslationsDialogNotificationsSentEn extends TranslationsDialogNotificationsSentDe {
	_TranslationsDialogNotificationsSentEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Car parked';
}

// Path: dialog.notifications.expiring
class _TranslationsDialogNotificationsExpiringEn extends TranslationsDialogNotificationsExpiringDe {
	_TranslationsDialogNotificationsExpiringEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your parking ticket is about to expire';
	@override String subtitle({required Object minutesLeft}) => 'In about ${minutesLeft} minutes your parking ticket will expire, slowly prepare to leave.';
}

// Path: dialog.car_bottom_sheet.sync
class _TranslationsDialogCarBottomSheetSyncEn extends TranslationsDialogCarBottomSheetSyncDe {
	_TranslationsDialogCarBottomSheetSyncEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sync parking spot';
	@override String get subtitle => 'Do you want to sync the parking spot?';
	@override String get action_1 => 'Sync';
}

// Path: dialog.car_bottom_sheet.synced
class _TranslationsDialogCarBottomSheetSyncedEn extends TranslationsDialogCarBottomSheetSyncedDe {
	_TranslationsDialogCarBottomSheetSyncedEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking spot synced';
	@override String get subtitle => 'This parking spot is now on WoAuto\'s servers.\nWould you like to share the parking spot?';
}

// Path: dialog.car_bottom_sheet.sharing
class _TranslationsDialogCarBottomSheetSharingEn extends TranslationsDialogCarBottomSheetSharingDe {
	_TranslationsDialogCarBottomSheetSharingEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sharing parking spot';
	@override String get subtitle => 'Have this QR code scanned to share your location';
	@override String get action_1 => 'Share link';
	@override String share_content({required Object woLink}) => 'Here is my synced parking:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class _TranslationsDialogMapsDrivingModeEn extends TranslationsDialogMapsDrivingModeDe {
	_TranslationsDialogMapsDrivingModeEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Driving mode detected';
	@override String get subtitle => 'You are (probably) driving your car right now. Do you want to switch to the driving mode?';
}

// Path: dialog.maps.location_denied
class _TranslationsDialogMapsLocationDeniedEn extends TranslationsDialogMapsLocationDeniedDe {
	_TranslationsDialogMapsLocationDeniedEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Location permission denied';
	@override String get subtitle => 'You have denied location permission. Please go to settings and allow access to your location.';
}

// Path: dialog.history.info
class _TranslationsDialogHistoryInfoEn extends TranslationsDialogHistoryInfoDe {
	_TranslationsDialogHistoryInfoEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override String get subtitle => 'This will show you the last 15 parking spaces';
}

// Path: dialog.history.delete
class _TranslationsDialogHistoryDeleteEn extends TranslationsDialogHistoryDeleteDe {
	_TranslationsDialogHistoryDeleteEn._(TranslationsEn root) : this._root = root, super.internal(root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all entries';
	@override String get subtitle => 'Are you sure you want to delete all entries?';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'constants.app_name': return 'WoAuto';
			case 'constants.default_park_title': return 'My Car';
			case 'constants.default_shared_title': return 'Other Car';
			case 'constants.default_park_info': return 'e.g., parking level 2';
			case 'constants.default_address': return 'No address found';
			case 'constants.address_na': return 'Address was not found.';
			case 'constants.update': return 'Update';
			case 'constants.error': return 'Error';
			case 'constants.error_description': return 'An error occurred.';
			case 'constants.parked_rn': return 'parked right now';
			case 'constants.parked_duration_string': return ({required Object duration}) => 'parked since ${duration}';
			case 'constants.navigate': return 'Navigate';
			case 'park_duration.hours': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} hour',
				other: '${n} hours',
			);
			case 'park_duration.minutes': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} minute',
				other: '${n} minutes',
			);
			case 'park_duration.days': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
				one: '${n} day',
				other: '${n} days',
			);
			case 'login_dialog.email': return 'E-Mail';
			case 'login_dialog.password': return 'Password';
			case 'login_dialog.empty_validation': return 'Please enter something in';
			case 'login_dialog.email_validation': return 'Please enter a valid e-mail address';
			case 'login_dialog.password_validation': return 'Please enter a secure, >= 10 characters long password';
			case 'login_dialog.password_forgot': return 'Password forgot';
			case 'login_dialog.password_generate': return 'Generate password';
			case 'login_dialog.password_generate_info': return 'Your password will be inserted into the text field when you generate it. It will not be saved by us! Take a look at the code if you are not sure!';
			case 'login_dialog.register': return 'Register';
			case 'login_dialog.login': return 'Login';
			case 'park_dialog.title': return 'New Parking';
			case 'park_dialog.content_1': return 'Save the new parking?';
			case 'park_dialog.park_name.label': return 'Name';
			case 'park_dialog.content_2': return 'Additional information';
			case 'park_dialog.info.label': return 'Info';
			case 'park_dialog.ticket.title': return 'Parking ticket';
			case 'park_dialog.ticket.help': return 'Parking ticket expires at';
			case 'park_dialog.ticket.until': return ({required Object time}) => 'Parking ticket valid until ${time} o\'clock';
			case 'park_dialog.photo.title': return 'Photo';
			case 'marker_dialog.shared.content': return ({required Object address}) => 'This parking spot is being shared with you.\n\nThe car is at the following address:\n${address}.';
			case 'marker_dialog.mine.content': return ({required Object formattedDate, required Object address, required Object description}) => 'You have ${formattedDate}.\n\nYour car is at the following address:\n${address}.\n${description}';
			case 'marker_dialog.action_1': return 'Delete parking';
			case 'home.navigation_1': return 'Map';
			case 'home.navigation_2': return 'My Car';
			case 'home.navigation_3': return 'History';
			case 'home.navigation_4': return 'Settings';
			case 'home.quick_actions.action_parkings': return 'Open parking spots';
			case 'home.quick_actions.action_save': return 'Quicksave parking spot';
			case 'history.title': return 'History';
			case 'history.empty.title': return 'No entries';
			case 'history.empty.subtitle': return 'You have no entries in your history.';
			case 'history.export.title': return 'Export as CSV';
			case 'history.export.subtitle': return 'Export your history as a CSV file. This will include all of your parking spots.';
			case 'history.delete.title': return 'Delete all entries';
			case 'history.delete.subtitle': return 'Delete all entries in your history.';
			case 'info_sheet.park_save': return 'Save parking spot';
			case 'info_sheet.current_position': return 'Go to your current position';
			case 'info_sheet.parkings': return 'Open parking spots';
			case 'info_sheet.badge_label': return 'Sync';
			case 'top_header.driving_mode_tooltip': return 'Driving mode';
			case 'car_bottom_sheet.empty.parkings': return 'You have no parking spots.';
			case 'car_bottom_sheet.empty.shared_parkings': return 'You have no shared parking spots.';
			case 'car_bottom_sheet.distance_calculation.title': return 'How are we calculating the distance?';
			case 'car_bottom_sheet.you.title': return 'You';
			case 'car_bottom_sheet.you.address': return 'On you';
			case 'car_bottom_sheet.friends.title': return 'Friends';
			case 'car_bottom_sheet.friends.park': return 'parking';
			case 'car_bottom_sheet.menu.open_park_in_maps': return 'Open in a maps app';
			case 'car_bottom_sheet.menu.share_park': return 'Share parking spot';
			case 'car_bottom_sheet.menu.to_park': return 'Go to parking spot';
			case 'car_bottom_sheet.menu.delete_park': return 'Delete parking spot';
			case 'my_car.title': return 'My Car';
			case 'my_car.login_register': return 'Login or Register now';
			case 'my_car.shared_content': return 'This is my car! 🚗';
			case 'my_car.built.title': return ({required Object baujahr, required Object jahre}) => 'Year of manufacture: ${baujahr} (${jahre} Jahre)';
			case 'my_car.built.title_short': return ({required Object baujahr}) => 'Year of manufacture: ${baujahr}';
			case 'my_car.built.title_dialog': return 'Year of manufacture';
			case 'my_car.built.subtitle': return 'Change the year of manufacture of your car.';
			case 'my_car.built.default_year': return '2002';
			case 'my_car.built.validate_null': return 'Please enter a valid year of manufacture.';
			case 'my_car.built.validate_year': return ({required Object year}) => 'Please enter a valid year of manufacture between 1900 and ${year}';
			case 'my_car.driven.title': return ({required Object km}) => '${km} km driven';
			case 'my_car.driven.title_short': return ({required Object km}) => 'Mileage: ${km}';
			case 'my_car.driven.title_dialog': return 'Mileage';
			case 'my_car.driven.subtitle': return 'Change the mileage of your car.';
			case 'my_car.driven.hint': return '123456';
			case 'my_car.plate.title': return ({required Object plate}) => 'License plate: ${plate}';
			case 'my_car.plate.subtitle': return 'Change the license plate of your car.';
			case 'my_car.plate.title_short': return 'License plate';
			case 'my_car.plate.hint': return 'B-DE-1234';
			case 'my_car.park_name.title': return ({required Object name}) => 'Title: ${name}';
			case 'my_car.park_name.subtitle': return 'Change the title of your car, e.g., Mercedes, Audi or BMW.';
			case 'my_car.park_name.park_title': return 'Name of your car';
			case 'my_car.tuv.title': return ({required Object date}) => 'MOT until ${date}';
			case 'my_car.tuv.subtitle': return 'Change the MOT date of your car.';
			case 'my_car.tuv.help': return 'Choose the "1." of the month, e.g., "1.1.2022"';
			case 'my_car.tuv.add_to_calender': return 'Add to calendar';
			case 'my_car.tuv.calender_title': return 'MOT expired';
			case 'my_car.tuv.calender_content': return 'Your MOT has expired! Please make an appointment.\n\nBest regards,\nYour WoAuto-Team';
			case 'my_car.tuv.expired_info': return 'Your MOT has expired!';
			case 'my_car.tuv.expiring_info': return 'Your MOT will expire soon! Please make an appointment.';
			case 'my_car.share_deactivate_info': return 'If you deactivate these settings, you will be asked to confirm the action again, as switching off always deletes all data from the server first and then prevents it from being saved until you switch it on again.';
			case 'my_car.share_my_last_location': return 'Share my last location';
			case 'my_car.share_my_last_location_description': return 'While using the app, your live location is saved on our server and only your friends can view it. As soon as the app is closed, the last set location remains visible.';
			case 'my_car.share_my_last_location_deactivate': return 'When you end your sharing, your location will first be deleted from our server and saving will be prevented until you reactivate it.';
			case 'my_car.share_my_parkings': return 'Share my parking spaces';
			case 'my_car.share_my_parkings_description': return 'This will save your parking spaces in our servers and so your friends, only they, can see your parking spaces, but never your parking history.';
			case 'my_car.share_my_parkings_deactivate': return 'When you end your sharing, your parking locations will be deleted from our server and saving will be prevented until you reactivate it.';
			case 'my_car.secure_notice': return 'Your private car data is stored locally on your device. We do not have access to your data. You can also delete your data at any time in the settings.';
			case 'maps.loading': return 'Loading maps ...';
			case 'maps.traffic.show': return 'Show traffic';
			case 'maps.traffic.hide': return 'Hide traffic';
			case 'intro.page_1.page_title': return 'WoAuto';
			case 'intro.page_1.title': return 'Welcome to WoAuto';
			case 'intro.page_1.content_1': return 'With WoAuto you can save your parking spot and view it later, share it with others and even navigate to it.';
			case 'intro.page_1.content_2': return 'Your parking spot is safe and always stays on your device.';
			case 'intro.page_1.content_3': return 'Save your parking spot in just 2 clicks.';
			case 'intro.page_1.action_1': return 'Continue';
			case 'intro.page_2.page_title': return 'App preferences';
			case 'intro.page_2.parking_title': return 'Set a name for your car';
			case 'intro.page_2.parking_content': return 'Give your car a cool name';
			case 'intro.page_2.parking_hint': return 'My Car';
			case 'intro.page_2.theme_title': return 'Set the app theme';
			case 'intro.page_2.theme_content': return 'Choose the theme you like best';
			case 'intro.page_2.location_title': return 'Allow real-time location permission';
			case 'intro.page_2.location_content': return 'In order for WoAuto to save your location, you must allow real-time location permission. This is necessary to find your parking spot and load the map.';
			case 'intro.page_2.location_checkbox': return 'Real-time location permission';
			case 'intro.page_2.location_checkbox_error': return 'Please allow the app to query your location while using the app.';
			case 'intro.page_2.notification_checkbox': return 'Notifications (optional)';
			case 'intro.page_2.exact_notification_checkbox': return 'Scheduled notifications (optional)';
			case 'intro.page_2.exact_notification_description': return 'Receive a notification when your parking ticket is about to expire.';
			case 'intro.page_2.action_1': return 'Done';
			case 'bottom_sheet.photo': return 'Choose photo';
			case 'bottom_sheet.camera': return 'Take photo';
			case 'bottom_sheet.photo_delete': return 'Delete photo';
			case 'snackbar.locked.title': return 'Did you lock your car?';
			case 'snackbar.locked.subtitle': return 'This is a reminder if you locked your car';
			case 'snackbar.locked.action': return 'Yes, I did';
			case 'snackbar.shared_parking.title': return 'A shared online parking space has been added';
			case 'snackbar.shared_parking.subtitle': return 'Check the map or the list.';
			case 'snackbar.distance_calculation.title': return 'How is the distance calculated?';
			case 'snackbar.distance_calculation.subtitle': return 'Distance is calculated using the Haversine formula. The formula is a special form of the Pythagorean formula used to calculate the distance between two points on a sphere. The formula is also known as "sphere distance".';
			case 'snackbar.distance_calculation.subsubtitle': return 'Click here to know more.';
			case 'dialog.abort': return 'Cancel';
			case 'dialog.delete': return 'Delete';
			case 'dialog.leave': return 'Exit';
			case 'dialog.logout': return 'Logout';
			case 'dialog.ok': return 'Ok';
			case 'dialog.yes': return 'Yes';
			case 'dialog.no': return 'No';
			case 'dialog.share': return 'Share';
			case 'dialog.save': return 'Save';
			case 'dialog.open_settings': return 'Open settings';
			case 'dialog.share_location_parkings.title': return 'Deactivate Sharing';
			case 'dialog.share_location_parkings.content_1': return '';
			case 'dialog.share_location_parkings.content_2': return 'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
			case 'dialog.share_location_parkings.deactivate': return 'Deactivate';
			case 'dialog.distance.title': return 'Distance calculation';
			case 'dialog.distance.content': return ({required Object distance}) => 'The calculated distance is ${distance}';
			case 'dialog.notifications.na.title': return 'Notifications are not available';
			case 'dialog.notifications.na.subtitle': return 'notifications are not available on your device';
			case 'dialog.notifications.denied.title': return 'Notifications access denied';
			case 'dialog.notifications.denied.subtitle': return 'You have denied notifications access. Please go to settings and allow notifications.';
			case 'dialog.notifications.sent.title': return 'Car parked';
			case 'dialog.notifications.expiring.title': return 'Your parking ticket is about to expire';
			case 'dialog.notifications.expiring.subtitle': return ({required Object minutesLeft}) => 'In about ${minutesLeft} minutes your parking ticket will expire, slowly prepare to leave.';
			case 'dialog.car_bottom_sheet.sync.title': return 'Sync parking spot';
			case 'dialog.car_bottom_sheet.sync.subtitle': return 'Do you want to sync the parking spot?';
			case 'dialog.car_bottom_sheet.sync.action_1': return 'Sync';
			case 'dialog.car_bottom_sheet.synced.title': return 'Parking spot synced';
			case 'dialog.car_bottom_sheet.synced.subtitle': return 'This parking spot is now on WoAuto\'s servers.\nWould you like to share the parking spot?';
			case 'dialog.car_bottom_sheet.sharing.title': return 'Sharing parking spot';
			case 'dialog.car_bottom_sheet.sharing.subtitle': return 'Have this QR code scanned to share your location';
			case 'dialog.car_bottom_sheet.sharing.action_1': return 'Share link';
			case 'dialog.car_bottom_sheet.sharing.share_content': return ({required Object woLink}) => 'Here is my synced parking:\n\n${woLink}';
			case 'dialog.maps.driving_mode.title': return 'Driving mode detected';
			case 'dialog.maps.driving_mode.subtitle': return 'You are (probably) driving your car right now. Do you want to switch to the driving mode?';
			case 'dialog.maps.location_denied.title': return 'Location permission denied';
			case 'dialog.maps.location_denied.subtitle': return 'You have denied location permission. Please go to settings and allow access to your location.';
			case 'dialog.history.info.title': return 'History';
			case 'dialog.history.info.subtitle': return 'This will show you the last 15 parking spaces';
			case 'dialog.history.delete.title': return 'Delete all entries';
			case 'dialog.history.delete.subtitle': return 'Are you sure you want to delete all entries?';
			case 'dialog.leave_info.title': return 'Leave App';
			case 'dialog.leave_info.subtitle': return 'Are you sure you want to leave the app?';
			case 'dialog.app_info.title': return 'App Info';
			case 'dialog.app_info.subtitle': return 'This app was developed by Emre Yurtseven, is open-source and of course available on Github.';
			case 'dialog.app_info.action_1': return 'GitHub';
			case 'dialog.feedback.title': return 'Feedback';
			case 'dialog.feedback.subtitle': return 'Feel free to email me, join our Telegram channel, or send me a private message on Telegram:';
			case 'dialog.feedback.action_1': return 'Telegram';
			case 'dialog.data_security.title': return 'Privacy Policy and Legal Notice';
			case 'dialog.data_security.content_1': return 'Brief summary of privacy policy in our own words (as of 25/08/2024):';
			case 'dialog.data_security.content_2': return '- The app communicates with Google Maps to display the map.';
			case 'dialog.data_security.content_3': return '- The app communicates with my VPS server on German soil to display, create and manage synchronized parking spots and your location data, only ever if you allow it.';
			case 'dialog.data_security.content_4': return '- The app does not store any metadata, such as IP address, device name, or operating system version.';
			case 'dialog.data_security.content_5': return '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ';
			case 'dialog.data_security.content_6': return 'not to any third parties.';
			case 'dialog.data_security.content_7': return '\n\n A data exchange with my server and with the servers of Google, when providing the Google Maps maps, takes place. ';
			case 'dialog.data_security.content_8': return 'The app otherwise stores all data only on your device and you can delete them at any time, then they are also deleted from my server (in the settings at the bottom).';
			case 'dialog.data_security.action_1': return 'Imprint';
			case 'dialog.data_security.action_2': return 'Privacy';
			case 'dialog.app_data.title': return 'Delete App Data';
			case 'dialog.app_data.subtitle': return 'Are you sure you want to delete all app data?';
			case 'dialog.account_data.title': return 'Delete Account & Data';
			case 'dialog.account_data.content': return 'This will delete your account, all the data associated with you, parkings, locations etc. It will also reset all of app-data on device.';
			case 'dialog.logout_confirm': return 'Are you sure you want to logout?';
			case 'settings.title': return 'Settings';
			case 'settings.theme.title': return 'Theme';
			case 'settings.theme.subtitle': return 'Choose the theme you like best.';
			case 'settings.theme.dropdown_1': return 'System';
			case 'settings.theme.dropdown_2': return 'Light';
			case 'settings.theme.dropdown_3': return 'Dark';
			case 'settings.color.choice': return 'Color';
			case 'settings.map_type.title': return 'Map type';
			case 'settings.map_type.subtitle': return 'Choose the map type you like best.';
			case 'settings.map_type.dropdown_1': return 'Normal';
			case 'settings.map_type.dropdown_2': return 'Satellite';
			case 'settings.map_type.dropdown_3': return 'Hybrid';
			case 'settings.map_type.dropdown_4': return 'Terrain';
			case 'settings.traffic.title': return 'Traffic';
			case 'settings.traffic.subtitle': return 'Show the current traffic situation on the map.';
			case 'settings.new_ios.title': return 'iOS only design';
			case 'settings.new_ios.subtitle': return 'Use the iOS only design with Cupertino widgets.';
			case 'settings.park_ticket.title': return 'Parking ticket time buffer';
			case 'settings.park_ticket.subtitle': return 'Set a time buffer so you have time to renew the ticket or return to the car before the parking ticket expires.';
			case 'settings.park_ticket.dropdown_value': return ({required Object value}) => '${value} minutes';
			case 'settings.driving_mode.title': return 'Driving Mode Detection';
			case 'settings.driving_mode.subtitle': return 'Set how fast you need to drive for the app to detect driving mode.';
			case 'settings.driving_mode.dropdown_value': return ({required Object value}) => '${value} km/h';
			case 'settings.app_info.title': return 'App Info';
			case 'settings.app_info.subtitle': return ({required Object appVersion, required Object buildNumber}) => 'Version ${appVersion}+${buildNumber}';
			case 'settings.credits.title': return 'Credits';
			case 'settings.credits.subtitle': return 'Thanks to Google Maps API and of course to the Flutter community.';
			case 'settings.woauto_server.title': return 'WoAuto Server (PocketBase)';
			case 'settings.woauto_server.subtitle': return ({required Object status}) => 'Server status: ${status}';
			case 'settings.share.title': return 'Share App';
			case 'settings.share.subtitle': return 'Why not share the app with your friends and family?';
			case 'settings.share.share_content': return 'Did you also forget where you parked last? No more. With WoAuto you can easily save your parking spot and view it later, share it with others and even navigate to it.\nYour parking spot is safe and always stays on your device.\n\nWhy don\'t you download it and try it out for yourself? https://play.google.com/store/apps/details?id=de.emredev.woauto';
			case 'settings.feedback.title': return 'Feedback';
			case 'settings.feedback.subtitle': return 'Do you have any suggestions for improvement, bugs or anything else to say?';
			case 'settings.data_security.title': return 'Privacy and Legal Notice';
			case 'settings.data_security.subtitle': return 'Learn how your data is protected.';
			case 'settings.app_data.title': return 'Delete all app data';
			case 'settings.app_data.subtitle': return 'Press and hold here to delete all your app data.';
			case 'settings.app_data.subtitle_ios': return 'Tap here to delete all your app data.';
			default: return null;
		}
	}
}

