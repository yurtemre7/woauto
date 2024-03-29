/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 432 (216 per locale)
///
/// Built on 2024-03-29 at 12:01 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.de;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.de) // set locale
/// - Locale locale = AppLocale.de.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.de) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	de(languageCode: 'de', build: Translations.build),
	en(languageCode: 'en', build: _TranslationsEn.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _TranslationsConstantsDe constants = _TranslationsConstantsDe._(_root);
	late final _TranslationsParkDurationDe park_duration = _TranslationsParkDurationDe._(_root);
	late final _TranslationsParkDialogDe park_dialog = _TranslationsParkDialogDe._(_root);
	late final _TranslationsMarkerDialogDe marker_dialog = _TranslationsMarkerDialogDe._(_root);
	late final _TranslationsHomeDe home = _TranslationsHomeDe._(_root);
	late final _TranslationsHistoryDe history = _TranslationsHistoryDe._(_root);
	late final _TranslationsInfoSheetDe info_sheet = _TranslationsInfoSheetDe._(_root);
	late final _TranslationsTopHeaderDe top_header = _TranslationsTopHeaderDe._(_root);
	late final _TranslationsCarBottomSheetDe car_bottom_sheet = _TranslationsCarBottomSheetDe._(_root);
	late final _TranslationsMyCarDe my_car = _TranslationsMyCarDe._(_root);
	late final _TranslationsMapsDe maps = _TranslationsMapsDe._(_root);
	late final _TranslationsIntroDe intro = _TranslationsIntroDe._(_root);
	late final _TranslationsBottomSheetDe bottom_sheet = _TranslationsBottomSheetDe._(_root);
	late final _TranslationsSnackbarDe snackbar = _TranslationsSnackbarDe._(_root);
	late final _TranslationsDialogDe dialog = _TranslationsDialogDe._(_root);
	late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
}

// Path: constants
class _TranslationsConstantsDe {
	_TranslationsConstantsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get app_name => 'WoAuto';
	String get default_park_title => 'Mein Auto';
	String get default_shared_title => 'Anderes Auto';
	String get default_park_info => 'z.B. Parkdeck 2';
	String get default_address => 'Keine Adresse gefunden';
	String get address_na => 'Adresse nicht gefunden.';
	String get update => 'Aktualisieren';
	String get error => 'Fehler';
	String get error_description => 'Es ist ein Fehler aufgetreten.';
	String get parked_rn => 'gerade eben geparkt';
	String parked_duration_string({required Object duration}) => 'vor ${duration} geparkt';
}

// Path: park_duration
class _TranslationsParkDurationDe {
	_TranslationsParkDurationDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String hours({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Stunde',
		other: '${n} Stunden',
	);
	String minutes({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Minute',
		other: '${n} Minuten',
	);
	String days({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Tag',
		other: '${n} Tage',
	);
}

// Path: park_dialog
class _TranslationsParkDialogDe {
	_TranslationsParkDialogDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Neuer Parkplatz';
	String get content_1 => 'Neuen Parkplatz speichern?';
	late final _TranslationsParkDialogParkNameDe park_name = _TranslationsParkDialogParkNameDe._(_root);
	String get content_2 => 'Zusätzliche Infos';
	late final _TranslationsParkDialogInfoDe info = _TranslationsParkDialogInfoDe._(_root);
	late final _TranslationsParkDialogTicketDe ticket = _TranslationsParkDialogTicketDe._(_root);
	late final _TranslationsParkDialogPhotoDe photo = _TranslationsParkDialogPhotoDe._(_root);
}

// Path: marker_dialog
class _TranslationsMarkerDialogDe {
	_TranslationsMarkerDialogDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsMarkerDialogSharedDe shared = _TranslationsMarkerDialogSharedDe._(_root);
	late final _TranslationsMarkerDialogMineDe mine = _TranslationsMarkerDialogMineDe._(_root);
	String get action_1 => 'Parkplatz löschen';
}

// Path: home
class _TranslationsHomeDe {
	_TranslationsHomeDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get navigation_1 => 'Karte';
	String get navigation_2 => 'Mein Auto';
	String get navigation_3 => 'Historie';
	String get navigation_4 => 'Einstellungen';
	late final _TranslationsHomeQuickActionsDe quick_actions = _TranslationsHomeQuickActionsDe._(_root);
}

// Path: history
class _TranslationsHistoryDe {
	_TranslationsHistoryDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Historie';
	late final _TranslationsHistoryEmptyDe empty = _TranslationsHistoryEmptyDe._(_root);
	late final _TranslationsHistoryExportDe export = _TranslationsHistoryExportDe._(_root);
	late final _TranslationsHistoryDeleteDe delete = _TranslationsHistoryDeleteDe._(_root);
}

// Path: info_sheet
class _TranslationsInfoSheetDe {
	_TranslationsInfoSheetDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get park_save => 'Parkplatz speichern';
	String get current_position => 'Zur aktuellen Position';
	String get parkings => 'Parkplätze';
	String get badge_label => 'Sync';
}

// Path: top_header
class _TranslationsTopHeaderDe {
	_TranslationsTopHeaderDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get driving_mode_tooltip => 'Driving Modus';
}

// Path: car_bottom_sheet
class _TranslationsCarBottomSheetDe {
	_TranslationsCarBottomSheetDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsCarBottomSheetEmptyDe empty = _TranslationsCarBottomSheetEmptyDe._(_root);
	late final _TranslationsCarBottomSheetDistanceCalculationDe distance_calculation = _TranslationsCarBottomSheetDistanceCalculationDe._(_root);
	late final _TranslationsCarBottomSheetParkingsDe parkings = _TranslationsCarBottomSheetParkingsDe._(_root);
	late final _TranslationsCarBottomSheetSharedParkingsDe shared_parkings = _TranslationsCarBottomSheetSharedParkingsDe._(_root);
	late final _TranslationsCarBottomSheetMenuDe menu = _TranslationsCarBottomSheetMenuDe._(_root);
}

// Path: my_car
class _TranslationsMyCarDe {
	_TranslationsMyCarDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Mein Auto';
	String get shared_content => 'Das ist mein Auto! 🚗';
	late final _TranslationsMyCarBuiltDe built = _TranslationsMyCarBuiltDe._(_root);
	late final _TranslationsMyCarDrivenDe driven = _TranslationsMyCarDrivenDe._(_root);
	late final _TranslationsMyCarPlateDe plate = _TranslationsMyCarPlateDe._(_root);
	late final _TranslationsMyCarParkNameDe park_name = _TranslationsMyCarParkNameDe._(_root);
	late final _TranslationsMyCarTuvDe tuv = _TranslationsMyCarTuvDe._(_root);
	String get secure_notice => 'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.';
}

// Path: maps
class _TranslationsMapsDe {
	_TranslationsMapsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get loading => 'Lädt Karte...';
	late final _TranslationsMapsTrafficDe traffic = _TranslationsMapsTrafficDe._(_root);
}

// Path: intro
class _TranslationsIntroDe {
	_TranslationsIntroDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsIntroPage1De page_1 = _TranslationsIntroPage1De._(_root);
	late final _TranslationsIntroPage2De page_2 = _TranslationsIntroPage2De._(_root);
}

// Path: bottom_sheet
class _TranslationsBottomSheetDe {
	_TranslationsBottomSheetDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get photo => 'Foto auswählen';
	String get camera => 'Foto aufnehmen';
	String get photo_delete => 'Foto löschen';
}

// Path: snackbar
class _TranslationsSnackbarDe {
	_TranslationsSnackbarDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsSnackbarLockedDe locked = _TranslationsSnackbarLockedDe._(_root);
	late final _TranslationsSnackbarSharedParkingDe shared_parking = _TranslationsSnackbarSharedParkingDe._(_root);
	late final _TranslationsSnackbarDistanceCalculationDe distance_calculation = _TranslationsSnackbarDistanceCalculationDe._(_root);
}

// Path: dialog
class _TranslationsDialogDe {
	_TranslationsDialogDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get abort => 'Abbrechen';
	String get delete => 'Löschen';
	String get leave => 'Verlassen';
	String get ok => 'Ok';
	String get yes => 'Ja';
	String get no => 'Nein';
	String get share => 'Teilen';
	String get save => 'Speichern';
	String get open_settings => 'Einstellungen öffnen';
	late final _TranslationsDialogNavigationDe navigation = _TranslationsDialogNavigationDe._(_root);
	late final _TranslationsDialogNotificationsDe notifications = _TranslationsDialogNotificationsDe._(_root);
	late final _TranslationsDialogCarBottomSheetDe car_bottom_sheet = _TranslationsDialogCarBottomSheetDe._(_root);
	late final _TranslationsDialogMapsDe maps = _TranslationsDialogMapsDe._(_root);
	late final _TranslationsDialogHistoryDe history = _TranslationsDialogHistoryDe._(_root);
	late final _TranslationsDialogLeaveInfoDe leave_info = _TranslationsDialogLeaveInfoDe._(_root);
	late final _TranslationsDialogAppInfoDe app_info = _TranslationsDialogAppInfoDe._(_root);
	late final _TranslationsDialogFeedbackDe feedback = _TranslationsDialogFeedbackDe._(_root);
	late final _TranslationsDialogDataSecurityDe data_security = _TranslationsDialogDataSecurityDe._(_root);
	late final _TranslationsDialogAppDataDe app_data = _TranslationsDialogAppDataDe._(_root);
}

// Path: settings
class _TranslationsSettingsDe {
	_TranslationsSettingsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Einstellungen';
	late final _TranslationsSettingsThemeDe theme = _TranslationsSettingsThemeDe._(_root);
	late final _TranslationsSettingsColorDe color = _TranslationsSettingsColorDe._(_root);
	late final _TranslationsSettingsMapTypeDe map_type = _TranslationsSettingsMapTypeDe._(_root);
	late final _TranslationsSettingsTrafficDe traffic = _TranslationsSettingsTrafficDe._(_root);
	late final _TranslationsSettingsNewIosDe new_ios = _TranslationsSettingsNewIosDe._(_root);
	late final _TranslationsSettingsParkTicketDe park_ticket = _TranslationsSettingsParkTicketDe._(_root);
	late final _TranslationsSettingsDrivingModeDe driving_mode = _TranslationsSettingsDrivingModeDe._(_root);
	late final _TranslationsSettingsAppInfoDe app_info = _TranslationsSettingsAppInfoDe._(_root);
	late final _TranslationsSettingsCreditsDe credits = _TranslationsSettingsCreditsDe._(_root);
	late final _TranslationsSettingsWoautoServerDe woauto_server = _TranslationsSettingsWoautoServerDe._(_root);
	late final _TranslationsSettingsShareDe share = _TranslationsSettingsShareDe._(_root);
	late final _TranslationsSettingsFeedbackDe feedback = _TranslationsSettingsFeedbackDe._(_root);
	late final _TranslationsSettingsDataSecurityDe data_security = _TranslationsSettingsDataSecurityDe._(_root);
	late final _TranslationsSettingsAppDataDe app_data = _TranslationsSettingsAppDataDe._(_root);
}

// Path: park_dialog.park_name
class _TranslationsParkDialogParkNameDe {
	_TranslationsParkDialogParkNameDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Name';
}

// Path: park_dialog.info
class _TranslationsParkDialogInfoDe {
	_TranslationsParkDialogInfoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get label => 'Info';
}

// Path: park_dialog.ticket
class _TranslationsParkDialogTicketDe {
	_TranslationsParkDialogTicketDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkticket';
	String get help => 'Parkticket läuft ab um';
	String until({required Object time}) => 'Parkticket gilt bis ${time} Uhr';
}

// Path: park_dialog.photo
class _TranslationsParkDialogPhotoDe {
	_TranslationsParkDialogPhotoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Foto';
}

// Path: marker_dialog.shared
class _TranslationsMarkerDialogSharedDe {
	_TranslationsMarkerDialogSharedDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String content({required Object address}) => 'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.';
}

// Path: marker_dialog.mine
class _TranslationsMarkerDialogMineDe {
	_TranslationsMarkerDialogMineDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String content({required Object formattedDate, required Object address, required Object description}) => 'Du hast ${formattedDate}.\n\nDein Auto steht an folgender Adresse:\n${address}.\n${description}';
}

// Path: home.quick_actions
class _TranslationsHomeQuickActionsDe {
	_TranslationsHomeQuickActionsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get action_parkings => 'Parkplätze ansehen';
	String get action_save => 'Parkplatz speichern';
}

// Path: history.empty
class _TranslationsHistoryEmptyDe {
	_TranslationsHistoryEmptyDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Keine Einträge';
	String get subtitle => 'Du hast noch keine Einträge in deiner Historie.';
}

// Path: history.export
class _TranslationsHistoryExportDe {
	_TranslationsHistoryExportDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Exportiere als CSV';
	String get subtitle => 'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.';
}

// Path: history.delete
class _TranslationsHistoryDeleteDe {
	_TranslationsHistoryDeleteDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Lösche alle Einträge';
	String get subtitle => 'Lösche alle Einträge in deiner Historie.';
}

// Path: car_bottom_sheet.empty
class _TranslationsCarBottomSheetEmptyDe {
	_TranslationsCarBottomSheetEmptyDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get parkings => 'Du hast keine Parkplätze.';
	String get shared_parkings => 'Du hast keine geteilten Parkplätze.';
}

// Path: car_bottom_sheet.distance_calculation
class _TranslationsCarBottomSheetDistanceCalculationDe {
	_TranslationsCarBottomSheetDistanceCalculationDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Wie wird die Entfernung berechnet, fragst du dich?';
}

// Path: car_bottom_sheet.parkings
class _TranslationsCarBottomSheetParkingsDe {
	_TranslationsCarBottomSheetParkingsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkplätze';
}

// Path: car_bottom_sheet.shared_parkings
class _TranslationsCarBottomSheetSharedParkingsDe {
	_TranslationsCarBottomSheetSharedParkingsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Geteilte Parkplätze';
}

// Path: car_bottom_sheet.menu
class _TranslationsCarBottomSheetMenuDe {
	_TranslationsCarBottomSheetMenuDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get open_park_in_maps => 'Karten App öffnen';
	String get share_park => 'Parkplatz teilen';
	String get to_park => 'Zum Parkplatz';
	String get delete_park => 'Parkplatz löschen';
}

// Path: my_car.built
class _TranslationsMyCarBuiltDe {
	_TranslationsMyCarBuiltDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object baujahr, required Object jahre}) => 'Baujahr: ${baujahr} (${jahre} Jahre)';
	String title_short({required Object baujahr}) => 'Baujahr: ${baujahr}';
	String get title_dialog => 'Baujahr';
	String get subtitle => 'Ändere das Baujahr deines Autos.';
	String get default_year => '2002';
	String get validate_null => 'Bitte gib ein gültiges Baujahr ein';
	String validate_year({required Object year}) => 'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein';
}

// Path: my_car.driven
class _TranslationsMyCarDrivenDe {
	_TranslationsMyCarDrivenDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object km}) => '${km} km gefahren';
	String title_short({required Object km}) => 'Kilometerstand: ${km}';
	String get title_dialog => 'Kilometerstand';
	String get subtitle => 'Ändere den Kilometerstand deines Autos.';
	String get hint => '123456';
}

// Path: my_car.plate
class _TranslationsMyCarPlateDe {
	_TranslationsMyCarPlateDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object plate}) => 'Kennzeichen: ${plate}';
	String get subtitle => 'Ändere das Kennzeichen deines Autos.';
	String get title_short => 'Kennzeichen';
	String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class _TranslationsMyCarParkNameDe {
	_TranslationsMyCarParkNameDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object name}) => 'Titel: ${name}';
	String get subtitle => 'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW';
	String get park_title => 'Name des Parkplatzes';
}

// Path: my_car.tuv
class _TranslationsMyCarTuvDe {
	_TranslationsMyCarTuvDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String title({required Object date}) => 'TÜV bis ${date}';
	String get subtitle => 'Ändere das Datum, an dem dein TÜV abläuft';
	String get help => 'Gebe als Tag den "1." an, also z.B. "1.1.2022"';
	String get add_to_calender => 'Zum Kalender hinzufügen';
	String get calender_title => 'TÜV abgelaufen';
	String get calender_content => 'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team';
	String get expired_info => 'Dein TÜV ist abgelaufen!';
	String get expiring_info => 'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.';
}

// Path: maps.traffic
class _TranslationsMapsTrafficDe {
	_TranslationsMapsTrafficDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get show => 'Verkehr anzeigen';
	String get hide => 'Verkehr ausblenden';
}

// Path: intro.page_1
class _TranslationsIntroPage1De {
	_TranslationsIntroPage1De._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get page_title => 'WoAuto';
	String get title => 'Willkommen bei WoAuto';
	String get content_1 => 'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.';
	String get content_2 => 'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.';
	String get content_3 => 'Speichere in nur 2 Klicks deinen Parkplatz.';
	String get action_1 => 'Weiter';
}

// Path: intro.page_2
class _TranslationsIntroPage2De {
	_TranslationsIntroPage2De._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get page_title => 'App-Voreinstellungen';
	String get parking_title => 'Name für dein Auto setzen';
	String get parking_content => 'Gib deinem Auto einen coolen Namen.';
	String get parking_hint => 'Mein Auto';
	String get theme_title => 'App-Theme einstellen';
	String get theme_content => 'Wähle das Theme aus, das dir am besten gefällt.';
	String get location_title => 'Echtzeit-Standortberechtigung erlauben';
	String get location_content => 'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.';
	String get location_checkbox => 'Echtzeit-Standortberechtigung';
	String get location_checkbox_error => 'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.';
	String get notification_checkbox => 'Benachrichtigungen (optional)';
	String get exact_notification_checkbox => 'Geplante Benachrichtigungen (optional)';
	String get exact_notification_description => 'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.';
	String get action_1 => 'Fertig';
}

// Path: snackbar.locked
class _TranslationsSnackbarLockedDe {
	_TranslationsSnackbarLockedDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Hast du dein Auto abgeschlossen?';
	String get subtitle => 'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.';
	String get action => 'Ja, hab\' ich';
}

// Path: snackbar.shared_parking
class _TranslationsSnackbarSharedParkingDe {
	_TranslationsSnackbarSharedParkingDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Ein geteilter Online Parkplatz wurde hinzugefügt';
	String get subtitle => 'Schaue auf der Karte oder in der Liste nach.';
}

// Path: snackbar.distance_calculation
class _TranslationsSnackbarDistanceCalculationDe {
	_TranslationsSnackbarDistanceCalculationDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Wie wird die Entfernung berechnet?';
	String get subtitle => 'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.';
	String get subsubtitle => 'Tippe um mehr zu erfahren.';
}

// Path: dialog.navigation
class _TranslationsDialogNavigationDe {
	_TranslationsDialogNavigationDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Standort Info';
	String distance_info({required Object distance}) => 'Abstand zum aktuellen Standort: ${distance} m';
	String get action_1 => 'Navigation starten';
}

// Path: dialog.notifications
class _TranslationsDialogNotificationsDe {
	_TranslationsDialogNotificationsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsDialogNotificationsNaDe na = _TranslationsDialogNotificationsNaDe._(_root);
	late final _TranslationsDialogNotificationsDeniedDe denied = _TranslationsDialogNotificationsDeniedDe._(_root);
	late final _TranslationsDialogNotificationsSentDe sent = _TranslationsDialogNotificationsSentDe._(_root);
	late final _TranslationsDialogNotificationsExpiringDe expiring = _TranslationsDialogNotificationsExpiringDe._(_root);
}

// Path: dialog.car_bottom_sheet
class _TranslationsDialogCarBottomSheetDe {
	_TranslationsDialogCarBottomSheetDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsDialogCarBottomSheetSyncDe sync = _TranslationsDialogCarBottomSheetSyncDe._(_root);
	late final _TranslationsDialogCarBottomSheetSyncedDe synced = _TranslationsDialogCarBottomSheetSyncedDe._(_root);
	late final _TranslationsDialogCarBottomSheetSharingDe sharing = _TranslationsDialogCarBottomSheetSharingDe._(_root);
}

// Path: dialog.maps
class _TranslationsDialogMapsDe {
	_TranslationsDialogMapsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsDialogMapsDrivingModeDe driving_mode = _TranslationsDialogMapsDrivingModeDe._(_root);
	late final _TranslationsDialogMapsLocationDeniedDe location_denied = _TranslationsDialogMapsLocationDeniedDe._(_root);
}

// Path: dialog.history
class _TranslationsDialogHistoryDe {
	_TranslationsDialogHistoryDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _TranslationsDialogHistoryInfoDe info = _TranslationsDialogHistoryInfoDe._(_root);
	late final _TranslationsDialogHistoryDeleteDe delete = _TranslationsDialogHistoryDeleteDe._(_root);
}

// Path: dialog.leave_info
class _TranslationsDialogLeaveInfoDe {
	_TranslationsDialogLeaveInfoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'App verlassen';
	String get subtitle => 'Bist du sicher, dass du die App verlassen möchtest?';
}

// Path: dialog.app_info
class _TranslationsDialogAppInfoDe {
	_TranslationsDialogAppInfoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'App Info';
	String get subtitle => 'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.';
	String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class _TranslationsDialogFeedbackDe {
	_TranslationsDialogFeedbackDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	String get subtitle => 'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:';
	String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class _TranslationsDialogDataSecurityDe {
	_TranslationsDialogDataSecurityDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Datenschutz und Impressum';
	String get content_1 => 'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 01.09.2023):';
	String get content_2 => '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.';
	String get content_3 => '- Die App kommuniziert mit meinem VPS Server auf Deutschem Boden, um synchronisierte Parkplätze anzuzeigen, anzulegen und zu verwalten.';
	String get content_4 => '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.';
	String get content_5 => '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ';
	String get content_6 => 'nicht an Dritte weiter.';
	String get content_7 => '\n\nEs findet ein Datenaustausch mit meinem Server und mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ';
	String get content_8 => 'Die App speichert sont alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen, dann sind sie auch aus meinem Server gelöscht (in den Einstellungen ganz unten).';
	String get action_1 => 'Impressum';
	String get action_2 => 'Datenschutz';
}

// Path: dialog.app_data
class _TranslationsDialogAppDataDe {
	_TranslationsDialogAppDataDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'App-Daten löschen';
	String get subtitle => 'Bist du sicher, dass du alle App-Daten löschen möchtest?';
}

// Path: settings.theme
class _TranslationsSettingsThemeDe {
	_TranslationsSettingsThemeDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Theme';
	String get subtitle => 'Wähle das Theme aus, das dir am besten gefällt.';
	String get dropdown_1 => 'System';
	String get dropdown_2 => 'Hell';
	String get dropdown_3 => 'Dunkel';
}

// Path: settings.color
class _TranslationsSettingsColorDe {
	_TranslationsSettingsColorDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get choice => 'Farbe';
}

// Path: settings.map_type
class _TranslationsSettingsMapTypeDe {
	_TranslationsSettingsMapTypeDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Karten Typ';
	String get subtitle => 'Wähle den Karten Typ aus, der dir am besten gefällt.';
	String get dropdown_1 => 'Normal';
	String get dropdown_2 => 'Satellit';
	String get dropdown_3 => 'Hybrid';
	String get dropdown_4 => 'Terrain';
}

// Path: settings.traffic
class _TranslationsSettingsTrafficDe {
	_TranslationsSettingsTrafficDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Verkehrslage';
	String get subtitle => 'Zeige die aktuelle Verkehrslage auf der Karte an.';
}

// Path: settings.new_ios
class _TranslationsSettingsNewIosDe {
	_TranslationsSettingsNewIosDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'iOS Design';
	String get subtitle => 'Aktiviere das neue iOS Design mit Cupertino Widgets.';
}

// Path: settings.park_ticket
class _TranslationsSettingsParkTicketDe {
	_TranslationsSettingsParkTicketDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkticket Zeitpuffer';
	String get subtitle => 'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.';
	String dropdown_value({required Object value}) => '${value} Minuten';
}

// Path: settings.driving_mode
class _TranslationsSettingsDrivingModeDe {
	_TranslationsSettingsDrivingModeDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Driving Modus Erkennung';
	String get subtitle => 'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.';
	String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class _TranslationsSettingsAppInfoDe {
	_TranslationsSettingsAppInfoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'App Info';
	String subtitle({required Object appVersion, required Object buildNumber}) => 'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class _TranslationsSettingsCreditsDe {
	_TranslationsSettingsCreditsDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Credits';
	String get subtitle => 'Dank an Google Maps API und natürlich an die Flutter Community.';
}

// Path: settings.woauto_server
class _TranslationsSettingsWoautoServerDe {
	_TranslationsSettingsWoautoServerDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'WoAuto Server';
	String subtitle({required Object status}) => 'Server Status: ${status}';
}

// Path: settings.share
class _TranslationsSettingsShareDe {
	_TranslationsSettingsShareDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'App Teilen';
	String get subtitle => 'Teile die App doch mit deinen Freunden und deiner Familie.';
	String get share_content => 'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class _TranslationsSettingsFeedbackDe {
	_TranslationsSettingsFeedbackDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	String get subtitle => 'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?';
}

// Path: settings.data_security
class _TranslationsSettingsDataSecurityDe {
	_TranslationsSettingsDataSecurityDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Datenschutz und Impressum';
	String get subtitle => 'Erfahre wie deine Daten geschützt werden.';
}

// Path: settings.app_data
class _TranslationsSettingsAppDataDe {
	_TranslationsSettingsAppDataDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Lösche alle App-Daten';
	String get subtitle => 'Halte hier gedrückt, um all deine App-Daten zu löschen.';
	String get subtitle_ios => 'Tippe hier, um all deine App-Daten zu löschen.';
}

// Path: dialog.notifications.na
class _TranslationsDialogNotificationsNaDe {
	_TranslationsDialogNotificationsNaDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Benachrichtigungen nicht verfügbar';
	String get subtitle => 'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.';
}

// Path: dialog.notifications.denied
class _TranslationsDialogNotificationsDeniedDe {
	_TranslationsDialogNotificationsDeniedDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Benachrichtigungen verweigert';
	String get subtitle => 'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.';
}

// Path: dialog.notifications.sent
class _TranslationsDialogNotificationsSentDe {
	_TranslationsDialogNotificationsSentDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Auto geparkt';
}

// Path: dialog.notifications.expiring
class _TranslationsDialogNotificationsExpiringDe {
	_TranslationsDialogNotificationsExpiringDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Dein Parkticket läuft bald ab';
	String subtitle({required Object minutesLeft}) => 'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.';
}

// Path: dialog.car_bottom_sheet.sync
class _TranslationsDialogCarBottomSheetSyncDe {
	_TranslationsDialogCarBottomSheetSyncDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkplatz synchronisieren';
	String get subtitle => 'Möchtest du den Parkplatz synchronisieren?';
	String get action_1 => 'Synchronisieren';
}

// Path: dialog.car_bottom_sheet.synced
class _TranslationsDialogCarBottomSheetSyncedDe {
	_TranslationsDialogCarBottomSheetSyncedDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkplatz synchronisiert';
	String get subtitle => 'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?';
}

// Path: dialog.car_bottom_sheet.sharing
class _TranslationsDialogCarBottomSheetSharingDe {
	_TranslationsDialogCarBottomSheetSharingDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Parkplatz teilen';
	String get subtitle => 'Lasse diesen QR Code scannen, um deinen Standort zu teilen';
	String get action_1 => 'Link teilen';
	String share_content({required Object woLink}) => 'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class _TranslationsDialogMapsDrivingModeDe {
	_TranslationsDialogMapsDrivingModeDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Driving Modus erkannt';
	String get subtitle => 'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?';
}

// Path: dialog.maps.location_denied
class _TranslationsDialogMapsLocationDeniedDe {
	_TranslationsDialogMapsLocationDeniedDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Standortberechtigung verweigert';
	String get subtitle => 'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.';
}

// Path: dialog.history.info
class _TranslationsDialogHistoryInfoDe {
	_TranslationsDialogHistoryInfoDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Historie';
	String get subtitle => 'Hier werden dir die letzten 15 Parkplätze angezeigt';
}

// Path: dialog.history.delete
class _TranslationsDialogHistoryDeleteDe {
	_TranslationsDialogHistoryDeleteDe._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Lösche alle Einträge';
	String get subtitle => 'Bist du sicher, dass du alle Einträge löschen möchtest?';
}

// Path: <root>
class _TranslationsEn extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_TranslationsEn.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super.build(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	@override late final _TranslationsEn _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsConstantsEn constants = _TranslationsConstantsEn._(_root);
	@override late final _TranslationsParkDurationEn park_duration = _TranslationsParkDurationEn._(_root);
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
class _TranslationsConstantsEn extends _TranslationsConstantsDe {
	_TranslationsConstantsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
}

// Path: park_duration
class _TranslationsParkDurationEn extends _TranslationsParkDurationDe {
	_TranslationsParkDurationEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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

// Path: park_dialog
class _TranslationsParkDialogEn extends _TranslationsParkDialogDe {
	_TranslationsParkDialogEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
class _TranslationsMarkerDialogEn extends _TranslationsMarkerDialogDe {
	_TranslationsMarkerDialogEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMarkerDialogSharedEn shared = _TranslationsMarkerDialogSharedEn._(_root);
	@override late final _TranslationsMarkerDialogMineEn mine = _TranslationsMarkerDialogMineEn._(_root);
	@override String get action_1 => 'Delete parking';
}

// Path: home
class _TranslationsHomeEn extends _TranslationsHomeDe {
	_TranslationsHomeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get navigation_1 => 'Map';
	@override String get navigation_2 => 'My Car';
	@override String get navigation_3 => 'History';
	@override String get navigation_4 => 'Settings';
	@override late final _TranslationsHomeQuickActionsEn quick_actions = _TranslationsHomeQuickActionsEn._(_root);
}

// Path: history
class _TranslationsHistoryEn extends _TranslationsHistoryDe {
	_TranslationsHistoryEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override late final _TranslationsHistoryEmptyEn empty = _TranslationsHistoryEmptyEn._(_root);
	@override late final _TranslationsHistoryExportEn export = _TranslationsHistoryExportEn._(_root);
	@override late final _TranslationsHistoryDeleteEn delete = _TranslationsHistoryDeleteEn._(_root);
}

// Path: info_sheet
class _TranslationsInfoSheetEn extends _TranslationsInfoSheetDe {
	_TranslationsInfoSheetEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get park_save => 'Save parking spot';
	@override String get current_position => 'Go to your current position';
	@override String get parkings => 'Open parking spots';
	@override String get badge_label => 'Sync';
}

// Path: top_header
class _TranslationsTopHeaderEn extends _TranslationsTopHeaderDe {
	_TranslationsTopHeaderEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get driving_mode_tooltip => 'Driving mode';
}

// Path: car_bottom_sheet
class _TranslationsCarBottomSheetEn extends _TranslationsCarBottomSheetDe {
	_TranslationsCarBottomSheetEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCarBottomSheetEmptyEn empty = _TranslationsCarBottomSheetEmptyEn._(_root);
	@override late final _TranslationsCarBottomSheetDistanceCalculationEn distance_calculation = _TranslationsCarBottomSheetDistanceCalculationEn._(_root);
	@override late final _TranslationsCarBottomSheetParkingsEn parkings = _TranslationsCarBottomSheetParkingsEn._(_root);
	@override late final _TranslationsCarBottomSheetSharedParkingsEn shared_parkings = _TranslationsCarBottomSheetSharedParkingsEn._(_root);
	@override late final _TranslationsCarBottomSheetMenuEn menu = _TranslationsCarBottomSheetMenuEn._(_root);
}

// Path: my_car
class _TranslationsMyCarEn extends _TranslationsMyCarDe {
	_TranslationsMyCarEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'My Car';
	@override String get shared_content => 'This is my car! 🚗';
	@override late final _TranslationsMyCarBuiltEn built = _TranslationsMyCarBuiltEn._(_root);
	@override late final _TranslationsMyCarDrivenEn driven = _TranslationsMyCarDrivenEn._(_root);
	@override late final _TranslationsMyCarPlateEn plate = _TranslationsMyCarPlateEn._(_root);
	@override late final _TranslationsMyCarParkNameEn park_name = _TranslationsMyCarParkNameEn._(_root);
	@override late final _TranslationsMyCarTuvEn tuv = _TranslationsMyCarTuvEn._(_root);
	@override String get secure_notice => 'Your private car data is stored locally on your device. We do not have access to your data. You can also delete your data at any time in the settings.';
}

// Path: maps
class _TranslationsMapsEn extends _TranslationsMapsDe {
	_TranslationsMapsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading maps ...';
	@override late final _TranslationsMapsTrafficEn traffic = _TranslationsMapsTrafficEn._(_root);
}

// Path: intro
class _TranslationsIntroEn extends _TranslationsIntroDe {
	_TranslationsIntroEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsIntroPage1En page_1 = _TranslationsIntroPage1En._(_root);
	@override late final _TranslationsIntroPage2En page_2 = _TranslationsIntroPage2En._(_root);
}

// Path: bottom_sheet
class _TranslationsBottomSheetEn extends _TranslationsBottomSheetDe {
	_TranslationsBottomSheetEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get photo => 'Choose photo';
	@override String get camera => 'Take photo';
	@override String get photo_delete => 'Delete photo';
}

// Path: snackbar
class _TranslationsSnackbarEn extends _TranslationsSnackbarDe {
	_TranslationsSnackbarEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSnackbarLockedEn locked = _TranslationsSnackbarLockedEn._(_root);
	@override late final _TranslationsSnackbarSharedParkingEn shared_parking = _TranslationsSnackbarSharedParkingEn._(_root);
	@override late final _TranslationsSnackbarDistanceCalculationEn distance_calculation = _TranslationsSnackbarDistanceCalculationEn._(_root);
}

// Path: dialog
class _TranslationsDialogEn extends _TranslationsDialogDe {
	_TranslationsDialogEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get abort => 'Cancel';
	@override String get delete => 'Delete';
	@override String get leave => 'Exit';
	@override String get ok => 'Ok';
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get share => 'Share';
	@override String get save => 'Save';
	@override String get open_settings => 'Open settings';
	@override late final _TranslationsDialogNavigationEn navigation = _TranslationsDialogNavigationEn._(_root);
	@override late final _TranslationsDialogNotificationsEn notifications = _TranslationsDialogNotificationsEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetEn car_bottom_sheet = _TranslationsDialogCarBottomSheetEn._(_root);
	@override late final _TranslationsDialogMapsEn maps = _TranslationsDialogMapsEn._(_root);
	@override late final _TranslationsDialogHistoryEn history = _TranslationsDialogHistoryEn._(_root);
	@override late final _TranslationsDialogLeaveInfoEn leave_info = _TranslationsDialogLeaveInfoEn._(_root);
	@override late final _TranslationsDialogAppInfoEn app_info = _TranslationsDialogAppInfoEn._(_root);
	@override late final _TranslationsDialogFeedbackEn feedback = _TranslationsDialogFeedbackEn._(_root);
	@override late final _TranslationsDialogDataSecurityEn data_security = _TranslationsDialogDataSecurityEn._(_root);
	@override late final _TranslationsDialogAppDataEn app_data = _TranslationsDialogAppDataEn._(_root);
}

// Path: settings
class _TranslationsSettingsEn extends _TranslationsSettingsDe {
	_TranslationsSettingsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
class _TranslationsParkDialogParkNameEn extends _TranslationsParkDialogParkNameDe {
	_TranslationsParkDialogParkNameEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Name';
}

// Path: park_dialog.info
class _TranslationsParkDialogInfoEn extends _TranslationsParkDialogInfoDe {
	_TranslationsParkDialogInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get label => 'Info';
}

// Path: park_dialog.ticket
class _TranslationsParkDialogTicketEn extends _TranslationsParkDialogTicketDe {
	_TranslationsParkDialogTicketEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking ticket';
	@override String get help => 'Parking ticket expires at';
	@override String until({required Object time}) => 'Parking ticket valid until ${time} o\'clock';
}

// Path: park_dialog.photo
class _TranslationsParkDialogPhotoEn extends _TranslationsParkDialogPhotoDe {
	_TranslationsParkDialogPhotoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Photo';
}

// Path: marker_dialog.shared
class _TranslationsMarkerDialogSharedEn extends _TranslationsMarkerDialogSharedDe {
	_TranslationsMarkerDialogSharedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String content({required Object address}) => 'This parking spot is being shared with you.\n\nThe car is at the following address:\n${address}.';
}

// Path: marker_dialog.mine
class _TranslationsMarkerDialogMineEn extends _TranslationsMarkerDialogMineDe {
	_TranslationsMarkerDialogMineEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String content({required Object formattedDate, required Object address, required Object description}) => 'You have ${formattedDate}.\n\nYour car is at the following address:\n${address}.\n${description}';
}

// Path: home.quick_actions
class _TranslationsHomeQuickActionsEn extends _TranslationsHomeQuickActionsDe {
	_TranslationsHomeQuickActionsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get action_parkings => 'Open parking spots';
	@override String get action_save => 'Quicksave parking spot';
}

// Path: history.empty
class _TranslationsHistoryEmptyEn extends _TranslationsHistoryEmptyDe {
	_TranslationsHistoryEmptyEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'No entries';
	@override String get subtitle => 'You have no entries in your history.';
}

// Path: history.export
class _TranslationsHistoryExportEn extends _TranslationsHistoryExportDe {
	_TranslationsHistoryExportEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Export as CSV';
	@override String get subtitle => 'Export your history as a CSV file. This will include all of your parking spots.';
}

// Path: history.delete
class _TranslationsHistoryDeleteEn extends _TranslationsHistoryDeleteDe {
	_TranslationsHistoryDeleteEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all entries';
	@override String get subtitle => 'Delete all entries in your history.';
}

// Path: car_bottom_sheet.empty
class _TranslationsCarBottomSheetEmptyEn extends _TranslationsCarBottomSheetEmptyDe {
	_TranslationsCarBottomSheetEmptyEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get parkings => 'You have no parking spots.';
	@override String get shared_parkings => 'You have no shared parking spots.';
}

// Path: car_bottom_sheet.distance_calculation
class _TranslationsCarBottomSheetDistanceCalculationEn extends _TranslationsCarBottomSheetDistanceCalculationDe {
	_TranslationsCarBottomSheetDistanceCalculationEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How are we calculating the distance?';
}

// Path: car_bottom_sheet.parkings
class _TranslationsCarBottomSheetParkingsEn extends _TranslationsCarBottomSheetParkingsDe {
	_TranslationsCarBottomSheetParkingsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parkings';
}

// Path: car_bottom_sheet.shared_parkings
class _TranslationsCarBottomSheetSharedParkingsEn extends _TranslationsCarBottomSheetSharedParkingsDe {
	_TranslationsCarBottomSheetSharedParkingsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shared Parkings';
}

// Path: car_bottom_sheet.menu
class _TranslationsCarBottomSheetMenuEn extends _TranslationsCarBottomSheetMenuDe {
	_TranslationsCarBottomSheetMenuEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get open_park_in_maps => 'Open in a maps app';
	@override String get share_park => 'Share parking spot';
	@override String get to_park => 'Go to parking spot';
	@override String get delete_park => 'Delete parking spot';
}

// Path: my_car.built
class _TranslationsMyCarBuiltEn extends _TranslationsMyCarBuiltDe {
	_TranslationsMyCarBuiltEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
class _TranslationsMyCarDrivenEn extends _TranslationsMyCarDrivenDe {
	_TranslationsMyCarDrivenEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object km}) => '${km} km driven';
	@override String title_short({required Object km}) => 'Mileage: ${km}';
	@override String get title_dialog => 'Mileage';
	@override String get subtitle => 'Change the mileage of your car.';
	@override String get hint => '123456';
}

// Path: my_car.plate
class _TranslationsMyCarPlateEn extends _TranslationsMyCarPlateDe {
	_TranslationsMyCarPlateEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object plate}) => 'License plate: ${plate}';
	@override String get subtitle => 'Change the license plate of your car.';
	@override String get title_short => 'License plate';
	@override String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class _TranslationsMyCarParkNameEn extends _TranslationsMyCarParkNameDe {
	_TranslationsMyCarParkNameEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Title: ${name}';
	@override String get subtitle => 'Change the title of your car, e.g., Mercedes, Audi or BMW.';
	@override String get park_title => 'Name of your car';
}

// Path: my_car.tuv
class _TranslationsMyCarTuvEn extends _TranslationsMyCarTuvDe {
	_TranslationsMyCarTuvEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
class _TranslationsMapsTrafficEn extends _TranslationsMapsTrafficDe {
	_TranslationsMapsTrafficEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get show => 'Show traffic';
	@override String get hide => 'Hide traffic';
}

// Path: intro.page_1
class _TranslationsIntroPage1En extends _TranslationsIntroPage1De {
	_TranslationsIntroPage1En._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get page_title => 'WoAuto';
	@override String get title => 'Welcome to WoAuto';
	@override String get content_1 => 'With WoAuto you can save your parking spot and view it later, share it with others and even navigate to it.';
	@override String get content_2 => 'Your parking spot is safe and always stays on your device.';
	@override String get content_3 => 'Save your parking spot in just 2 clicks.';
	@override String get action_1 => 'Continue';
}

// Path: intro.page_2
class _TranslationsIntroPage2En extends _TranslationsIntroPage2De {
	_TranslationsIntroPage2En._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

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
class _TranslationsSnackbarLockedEn extends _TranslationsSnackbarLockedDe {
	_TranslationsSnackbarLockedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Did you lock your car?';
	@override String get subtitle => 'This is a reminder if you locked your car';
	@override String get action => 'Yes, I did';
}

// Path: snackbar.shared_parking
class _TranslationsSnackbarSharedParkingEn extends _TranslationsSnackbarSharedParkingDe {
	_TranslationsSnackbarSharedParkingEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'A shared online parking space has been added';
	@override String get subtitle => 'Check the map or the list.';
}

// Path: snackbar.distance_calculation
class _TranslationsSnackbarDistanceCalculationEn extends _TranslationsSnackbarDistanceCalculationDe {
	_TranslationsSnackbarDistanceCalculationEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'How is the distance calculated?';
	@override String get subtitle => 'Distance is calculated using the Haversine formula. The formula is a special form of the Pythagorean formula used to calculate the distance between two points on a sphere. The formula is also known as "sphere distance".';
	@override String get subsubtitle => 'Click here to know more.';
}

// Path: dialog.navigation
class _TranslationsDialogNavigationEn extends _TranslationsDialogNavigationDe {
	_TranslationsDialogNavigationEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Location info';
	@override String distance_info({required Object distance}) => 'Distance to current location: ${distance} m';
	@override String get action_1 => 'Start navigation';
}

// Path: dialog.notifications
class _TranslationsDialogNotificationsEn extends _TranslationsDialogNotificationsDe {
	_TranslationsDialogNotificationsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogNotificationsNaEn na = _TranslationsDialogNotificationsNaEn._(_root);
	@override late final _TranslationsDialogNotificationsDeniedEn denied = _TranslationsDialogNotificationsDeniedEn._(_root);
	@override late final _TranslationsDialogNotificationsSentEn sent = _TranslationsDialogNotificationsSentEn._(_root);
	@override late final _TranslationsDialogNotificationsExpiringEn expiring = _TranslationsDialogNotificationsExpiringEn._(_root);
}

// Path: dialog.car_bottom_sheet
class _TranslationsDialogCarBottomSheetEn extends _TranslationsDialogCarBottomSheetDe {
	_TranslationsDialogCarBottomSheetEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogCarBottomSheetSyncEn sync = _TranslationsDialogCarBottomSheetSyncEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetSyncedEn synced = _TranslationsDialogCarBottomSheetSyncedEn._(_root);
	@override late final _TranslationsDialogCarBottomSheetSharingEn sharing = _TranslationsDialogCarBottomSheetSharingEn._(_root);
}

// Path: dialog.maps
class _TranslationsDialogMapsEn extends _TranslationsDialogMapsDe {
	_TranslationsDialogMapsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogMapsDrivingModeEn driving_mode = _TranslationsDialogMapsDrivingModeEn._(_root);
	@override late final _TranslationsDialogMapsLocationDeniedEn location_denied = _TranslationsDialogMapsLocationDeniedEn._(_root);
}

// Path: dialog.history
class _TranslationsDialogHistoryEn extends _TranslationsDialogHistoryDe {
	_TranslationsDialogHistoryEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogHistoryInfoEn info = _TranslationsDialogHistoryInfoEn._(_root);
	@override late final _TranslationsDialogHistoryDeleteEn delete = _TranslationsDialogHistoryDeleteEn._(_root);
}

// Path: dialog.leave_info
class _TranslationsDialogLeaveInfoEn extends _TranslationsDialogLeaveInfoDe {
	_TranslationsDialogLeaveInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Leave App';
	@override String get subtitle => 'Are you sure you want to leave the app?';
}

// Path: dialog.app_info
class _TranslationsDialogAppInfoEn extends _TranslationsDialogAppInfoDe {
	_TranslationsDialogAppInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'App Info';
	@override String get subtitle => 'This app was developed by Emre Yurtseven, is open-source and of course available on Github.';
	@override String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class _TranslationsDialogFeedbackEn extends _TranslationsDialogFeedbackDe {
	_TranslationsDialogFeedbackEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Feedback';
	@override String get subtitle => 'Feel free to email me, join our Telegram channel, or send me a private message on Telegram:';
	@override String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class _TranslationsDialogDataSecurityEn extends _TranslationsDialogDataSecurityDe {
	_TranslationsDialogDataSecurityEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Privacy Policy and Legal Notice';
	@override String get content_1 => 'Brief summary of privacy policy in our own words (as of 01/09/2023):';
	@override String get content_2 => '- The app communicates with Google Maps to display the map.';
	@override String get content_3 => '- The app communicates with my VPS server on German soil to display, create and manage synchronized parking spots.';
	@override String get content_4 => '- The app does not store any metadata, such as IP address, device name, or operating system version.';
	@override String get content_5 => '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ';
	@override String get content_6 => 'not to any third parties.';
	@override String get content_7 => '\n\n A data exchange with my server and with the servers of Google, when providing the Google Maps maps, takes place. ';
	@override String get content_8 => 'The app otherwise stores all data only on your device and you can delete them at any time, then they are also deleted from my server (in the settings at the bottom).';
	@override String get action_1 => 'Imprint';
	@override String get action_2 => 'Privacy';
}

// Path: dialog.app_data
class _TranslationsDialogAppDataEn extends _TranslationsDialogAppDataDe {
	_TranslationsDialogAppDataEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete App Data';
	@override String get subtitle => 'Are you sure you want to delete all app data?';
}

// Path: settings.theme
class _TranslationsSettingsThemeEn extends _TranslationsSettingsThemeDe {
	_TranslationsSettingsThemeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Theme';
	@override String get subtitle => 'Choose the theme you like best.';
	@override String get dropdown_1 => 'System';
	@override String get dropdown_2 => 'Light';
	@override String get dropdown_3 => 'Dark';
}

// Path: settings.color
class _TranslationsSettingsColorEn extends _TranslationsSettingsColorDe {
	_TranslationsSettingsColorEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get choice => 'Color';
}

// Path: settings.map_type
class _TranslationsSettingsMapTypeEn extends _TranslationsSettingsMapTypeDe {
	_TranslationsSettingsMapTypeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Map type';
	@override String get subtitle => 'Choose the map type you like best.';
	@override String get dropdown_1 => 'Normal';
	@override String get dropdown_2 => 'Satellite';
	@override String get dropdown_3 => 'Hybrid';
	@override String get dropdown_4 => 'Terrain';
}

// Path: settings.traffic
class _TranslationsSettingsTrafficEn extends _TranslationsSettingsTrafficDe {
	_TranslationsSettingsTrafficEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Traffic';
	@override String get subtitle => 'Show the current traffic situation on the map.';
}

// Path: settings.new_ios
class _TranslationsSettingsNewIosEn extends _TranslationsSettingsNewIosDe {
	_TranslationsSettingsNewIosEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'iOS only design';
	@override String get subtitle => 'Use the iOS only design with Cupertino widgets.';
}

// Path: settings.park_ticket
class _TranslationsSettingsParkTicketEn extends _TranslationsSettingsParkTicketDe {
	_TranslationsSettingsParkTicketEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking ticket time buffer';
	@override String get subtitle => 'Set a time buffer so you have time to renew the ticket or return to the car before the parking ticket expires.';
	@override String dropdown_value({required Object value}) => '${value} minutes';
}

// Path: settings.driving_mode
class _TranslationsSettingsDrivingModeEn extends _TranslationsSettingsDrivingModeDe {
	_TranslationsSettingsDrivingModeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Driving Mode Detection';
	@override String get subtitle => 'Set how fast you need to drive for the app to detect driving mode.';
	@override String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class _TranslationsSettingsAppInfoEn extends _TranslationsSettingsAppInfoDe {
	_TranslationsSettingsAppInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'App Info';
	@override String subtitle({required Object appVersion, required Object buildNumber}) => 'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class _TranslationsSettingsCreditsEn extends _TranslationsSettingsCreditsDe {
	_TranslationsSettingsCreditsEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Credits';
	@override String get subtitle => 'Thanks to Google Maps API and of course to the Flutter community.';
}

// Path: settings.woauto_server
class _TranslationsSettingsWoautoServerEn extends _TranslationsSettingsWoautoServerDe {
	_TranslationsSettingsWoautoServerEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'WoAuto Server';
	@override String subtitle({required Object status}) => 'Server status: ${status}';
}

// Path: settings.share
class _TranslationsSettingsShareEn extends _TranslationsSettingsShareDe {
	_TranslationsSettingsShareEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Share App';
	@override String get subtitle => 'Why not share the app with your friends and family?';
	@override String get share_content => 'Did you also forget where you parked last? No more. With WoAuto you can easily save your parking spot and view it later, share it with others and even navigate to it.\nYour parking spot is safe and always stays on your device.\n\nWhy don\'t you download it and try it out for yourself? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class _TranslationsSettingsFeedbackEn extends _TranslationsSettingsFeedbackDe {
	_TranslationsSettingsFeedbackEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Feedback';
	@override String get subtitle => 'Do you have any suggestions for improvement, bugs or anything else to say?';
}

// Path: settings.data_security
class _TranslationsSettingsDataSecurityEn extends _TranslationsSettingsDataSecurityDe {
	_TranslationsSettingsDataSecurityEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Privacy and Legal Notice';
	@override String get subtitle => 'Learn how your data is protected.';
}

// Path: settings.app_data
class _TranslationsSettingsAppDataEn extends _TranslationsSettingsAppDataDe {
	_TranslationsSettingsAppDataEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all app data';
	@override String get subtitle => 'Press and hold here to delete all your app data.';
	@override String get subtitle_ios => 'Tap here to delete all your app data.';
}

// Path: dialog.notifications.na
class _TranslationsDialogNotificationsNaEn extends _TranslationsDialogNotificationsNaDe {
	_TranslationsDialogNotificationsNaEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications are not available';
	@override String get subtitle => 'notifications are not available on your device';
}

// Path: dialog.notifications.denied
class _TranslationsDialogNotificationsDeniedEn extends _TranslationsDialogNotificationsDeniedDe {
	_TranslationsDialogNotificationsDeniedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifications access denied';
	@override String get subtitle => 'You have denied notifications access. Please go to settings and allow notifications.';
}

// Path: dialog.notifications.sent
class _TranslationsDialogNotificationsSentEn extends _TranslationsDialogNotificationsSentDe {
	_TranslationsDialogNotificationsSentEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Car parked';
}

// Path: dialog.notifications.expiring
class _TranslationsDialogNotificationsExpiringEn extends _TranslationsDialogNotificationsExpiringDe {
	_TranslationsDialogNotificationsExpiringEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Your parking ticket is about to expire';
	@override String subtitle({required Object minutesLeft}) => 'In about ${minutesLeft} minutes your parking ticket will expire, slowly prepare to leave.';
}

// Path: dialog.car_bottom_sheet.sync
class _TranslationsDialogCarBottomSheetSyncEn extends _TranslationsDialogCarBottomSheetSyncDe {
	_TranslationsDialogCarBottomSheetSyncEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sync parking spot';
	@override String get subtitle => 'Do you want to sync the parking spot?';
	@override String get action_1 => 'Sync';
}

// Path: dialog.car_bottom_sheet.synced
class _TranslationsDialogCarBottomSheetSyncedEn extends _TranslationsDialogCarBottomSheetSyncedDe {
	_TranslationsDialogCarBottomSheetSyncedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parking spot synced';
	@override String get subtitle => 'This parking spot is now on WoAuto\'s servers.\nWould you like to share the parking spot?';
}

// Path: dialog.car_bottom_sheet.sharing
class _TranslationsDialogCarBottomSheetSharingEn extends _TranslationsDialogCarBottomSheetSharingDe {
	_TranslationsDialogCarBottomSheetSharingEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sharing parking spot';
	@override String get subtitle => 'Have this QR code scanned to share your location';
	@override String get action_1 => 'Share link';
	@override String share_content({required Object woLink}) => 'Here is my synced parking:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class _TranslationsDialogMapsDrivingModeEn extends _TranslationsDialogMapsDrivingModeDe {
	_TranslationsDialogMapsDrivingModeEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Driving mode detected';
	@override String get subtitle => 'You are (probably) driving your car right now. Do you want to switch to the driving mode?';
}

// Path: dialog.maps.location_denied
class _TranslationsDialogMapsLocationDeniedEn extends _TranslationsDialogMapsLocationDeniedDe {
	_TranslationsDialogMapsLocationDeniedEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Location permission denied';
	@override String get subtitle => 'You have denied location permission. Please go to settings and allow access to your location.';
}

// Path: dialog.history.info
class _TranslationsDialogHistoryInfoEn extends _TranslationsDialogHistoryInfoDe {
	_TranslationsDialogHistoryInfoEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'History';
	@override String get subtitle => 'This will show you the last 15 parking spaces';
}

// Path: dialog.history.delete
class _TranslationsDialogHistoryDeleteEn extends _TranslationsDialogHistoryDeleteDe {
	_TranslationsDialogHistoryDeleteEn._(_TranslationsEn root) : this._root = root, super._(root);

	@override final _TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Delete all entries';
	@override String get subtitle => 'Are you sure you want to delete all entries?';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'constants.app_name': return 'WoAuto';
			case 'constants.default_park_title': return 'Mein Auto';
			case 'constants.default_shared_title': return 'Anderes Auto';
			case 'constants.default_park_info': return 'z.B. Parkdeck 2';
			case 'constants.default_address': return 'Keine Adresse gefunden';
			case 'constants.address_na': return 'Adresse nicht gefunden.';
			case 'constants.update': return 'Aktualisieren';
			case 'constants.error': return 'Fehler';
			case 'constants.error_description': return 'Es ist ein Fehler aufgetreten.';
			case 'constants.parked_rn': return 'gerade eben geparkt';
			case 'constants.parked_duration_string': return ({required Object duration}) => 'vor ${duration} geparkt';
			case 'park_duration.hours': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} Stunde',
				other: '${n} Stunden',
			);
			case 'park_duration.minutes': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} Minute',
				other: '${n} Minuten',
			);
			case 'park_duration.days': return ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
				one: '${n} Tag',
				other: '${n} Tage',
			);
			case 'park_dialog.title': return 'Neuer Parkplatz';
			case 'park_dialog.content_1': return 'Neuen Parkplatz speichern?';
			case 'park_dialog.park_name.label': return 'Name';
			case 'park_dialog.content_2': return 'Zusätzliche Infos';
			case 'park_dialog.info.label': return 'Info';
			case 'park_dialog.ticket.title': return 'Parkticket';
			case 'park_dialog.ticket.help': return 'Parkticket läuft ab um';
			case 'park_dialog.ticket.until': return ({required Object time}) => 'Parkticket gilt bis ${time} Uhr';
			case 'park_dialog.photo.title': return 'Foto';
			case 'marker_dialog.shared.content': return ({required Object address}) => 'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.';
			case 'marker_dialog.mine.content': return ({required Object formattedDate, required Object address, required Object description}) => 'Du hast ${formattedDate}.\n\nDein Auto steht an folgender Adresse:\n${address}.\n${description}';
			case 'marker_dialog.action_1': return 'Parkplatz löschen';
			case 'home.navigation_1': return 'Karte';
			case 'home.navigation_2': return 'Mein Auto';
			case 'home.navigation_3': return 'Historie';
			case 'home.navigation_4': return 'Einstellungen';
			case 'home.quick_actions.action_parkings': return 'Parkplätze ansehen';
			case 'home.quick_actions.action_save': return 'Parkplatz speichern';
			case 'history.title': return 'Historie';
			case 'history.empty.title': return 'Keine Einträge';
			case 'history.empty.subtitle': return 'Du hast noch keine Einträge in deiner Historie.';
			case 'history.export.title': return 'Exportiere als CSV';
			case 'history.export.subtitle': return 'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.';
			case 'history.delete.title': return 'Lösche alle Einträge';
			case 'history.delete.subtitle': return 'Lösche alle Einträge in deiner Historie.';
			case 'info_sheet.park_save': return 'Parkplatz speichern';
			case 'info_sheet.current_position': return 'Zur aktuellen Position';
			case 'info_sheet.parkings': return 'Parkplätze';
			case 'info_sheet.badge_label': return 'Sync';
			case 'top_header.driving_mode_tooltip': return 'Driving Modus';
			case 'car_bottom_sheet.empty.parkings': return 'Du hast keine Parkplätze.';
			case 'car_bottom_sheet.empty.shared_parkings': return 'Du hast keine geteilten Parkplätze.';
			case 'car_bottom_sheet.distance_calculation.title': return 'Wie wird die Entfernung berechnet, fragst du dich?';
			case 'car_bottom_sheet.parkings.title': return 'Parkplätze';
			case 'car_bottom_sheet.shared_parkings.title': return 'Geteilte Parkplätze';
			case 'car_bottom_sheet.menu.open_park_in_maps': return 'Karten App öffnen';
			case 'car_bottom_sheet.menu.share_park': return 'Parkplatz teilen';
			case 'car_bottom_sheet.menu.to_park': return 'Zum Parkplatz';
			case 'car_bottom_sheet.menu.delete_park': return 'Parkplatz löschen';
			case 'my_car.title': return 'Mein Auto';
			case 'my_car.shared_content': return 'Das ist mein Auto! 🚗';
			case 'my_car.built.title': return ({required Object baujahr, required Object jahre}) => 'Baujahr: ${baujahr} (${jahre} Jahre)';
			case 'my_car.built.title_short': return ({required Object baujahr}) => 'Baujahr: ${baujahr}';
			case 'my_car.built.title_dialog': return 'Baujahr';
			case 'my_car.built.subtitle': return 'Ändere das Baujahr deines Autos.';
			case 'my_car.built.default_year': return '2002';
			case 'my_car.built.validate_null': return 'Bitte gib ein gültiges Baujahr ein';
			case 'my_car.built.validate_year': return ({required Object year}) => 'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein';
			case 'my_car.driven.title': return ({required Object km}) => '${km} km gefahren';
			case 'my_car.driven.title_short': return ({required Object km}) => 'Kilometerstand: ${km}';
			case 'my_car.driven.title_dialog': return 'Kilometerstand';
			case 'my_car.driven.subtitle': return 'Ändere den Kilometerstand deines Autos.';
			case 'my_car.driven.hint': return '123456';
			case 'my_car.plate.title': return ({required Object plate}) => 'Kennzeichen: ${plate}';
			case 'my_car.plate.subtitle': return 'Ändere das Kennzeichen deines Autos.';
			case 'my_car.plate.title_short': return 'Kennzeichen';
			case 'my_car.plate.hint': return 'B-DE-1234';
			case 'my_car.park_name.title': return ({required Object name}) => 'Titel: ${name}';
			case 'my_car.park_name.subtitle': return 'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW';
			case 'my_car.park_name.park_title': return 'Name des Parkplatzes';
			case 'my_car.tuv.title': return ({required Object date}) => 'TÜV bis ${date}';
			case 'my_car.tuv.subtitle': return 'Ändere das Datum, an dem dein TÜV abläuft';
			case 'my_car.tuv.help': return 'Gebe als Tag den "1." an, also z.B. "1.1.2022"';
			case 'my_car.tuv.add_to_calender': return 'Zum Kalender hinzufügen';
			case 'my_car.tuv.calender_title': return 'TÜV abgelaufen';
			case 'my_car.tuv.calender_content': return 'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team';
			case 'my_car.tuv.expired_info': return 'Dein TÜV ist abgelaufen!';
			case 'my_car.tuv.expiring_info': return 'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.';
			case 'my_car.secure_notice': return 'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.';
			case 'maps.loading': return 'Lädt Karte...';
			case 'maps.traffic.show': return 'Verkehr anzeigen';
			case 'maps.traffic.hide': return 'Verkehr ausblenden';
			case 'intro.page_1.page_title': return 'WoAuto';
			case 'intro.page_1.title': return 'Willkommen bei WoAuto';
			case 'intro.page_1.content_1': return 'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.';
			case 'intro.page_1.content_2': return 'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.';
			case 'intro.page_1.content_3': return 'Speichere in nur 2 Klicks deinen Parkplatz.';
			case 'intro.page_1.action_1': return 'Weiter';
			case 'intro.page_2.page_title': return 'App-Voreinstellungen';
			case 'intro.page_2.parking_title': return 'Name für dein Auto setzen';
			case 'intro.page_2.parking_content': return 'Gib deinem Auto einen coolen Namen.';
			case 'intro.page_2.parking_hint': return 'Mein Auto';
			case 'intro.page_2.theme_title': return 'App-Theme einstellen';
			case 'intro.page_2.theme_content': return 'Wähle das Theme aus, das dir am besten gefällt.';
			case 'intro.page_2.location_title': return 'Echtzeit-Standortberechtigung erlauben';
			case 'intro.page_2.location_content': return 'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.';
			case 'intro.page_2.location_checkbox': return 'Echtzeit-Standortberechtigung';
			case 'intro.page_2.location_checkbox_error': return 'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.';
			case 'intro.page_2.notification_checkbox': return 'Benachrichtigungen (optional)';
			case 'intro.page_2.exact_notification_checkbox': return 'Geplante Benachrichtigungen (optional)';
			case 'intro.page_2.exact_notification_description': return 'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.';
			case 'intro.page_2.action_1': return 'Fertig';
			case 'bottom_sheet.photo': return 'Foto auswählen';
			case 'bottom_sheet.camera': return 'Foto aufnehmen';
			case 'bottom_sheet.photo_delete': return 'Foto löschen';
			case 'snackbar.locked.title': return 'Hast du dein Auto abgeschlossen?';
			case 'snackbar.locked.subtitle': return 'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.';
			case 'snackbar.locked.action': return 'Ja, hab\' ich';
			case 'snackbar.shared_parking.title': return 'Ein geteilter Online Parkplatz wurde hinzugefügt';
			case 'snackbar.shared_parking.subtitle': return 'Schaue auf der Karte oder in der Liste nach.';
			case 'snackbar.distance_calculation.title': return 'Wie wird die Entfernung berechnet?';
			case 'snackbar.distance_calculation.subtitle': return 'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.';
			case 'snackbar.distance_calculation.subsubtitle': return 'Tippe um mehr zu erfahren.';
			case 'dialog.abort': return 'Abbrechen';
			case 'dialog.delete': return 'Löschen';
			case 'dialog.leave': return 'Verlassen';
			case 'dialog.ok': return 'Ok';
			case 'dialog.yes': return 'Ja';
			case 'dialog.no': return 'Nein';
			case 'dialog.share': return 'Teilen';
			case 'dialog.save': return 'Speichern';
			case 'dialog.open_settings': return 'Einstellungen öffnen';
			case 'dialog.navigation.title': return 'Standort Info';
			case 'dialog.navigation.distance_info': return ({required Object distance}) => 'Abstand zum aktuellen Standort: ${distance} m';
			case 'dialog.navigation.action_1': return 'Navigation starten';
			case 'dialog.notifications.na.title': return 'Benachrichtigungen nicht verfügbar';
			case 'dialog.notifications.na.subtitle': return 'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.';
			case 'dialog.notifications.denied.title': return 'Benachrichtigungen verweigert';
			case 'dialog.notifications.denied.subtitle': return 'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.';
			case 'dialog.notifications.sent.title': return 'Auto geparkt';
			case 'dialog.notifications.expiring.title': return 'Dein Parkticket läuft bald ab';
			case 'dialog.notifications.expiring.subtitle': return ({required Object minutesLeft}) => 'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.';
			case 'dialog.car_bottom_sheet.sync.title': return 'Parkplatz synchronisieren';
			case 'dialog.car_bottom_sheet.sync.subtitle': return 'Möchtest du den Parkplatz synchronisieren?';
			case 'dialog.car_bottom_sheet.sync.action_1': return 'Synchronisieren';
			case 'dialog.car_bottom_sheet.synced.title': return 'Parkplatz synchronisiert';
			case 'dialog.car_bottom_sheet.synced.subtitle': return 'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?';
			case 'dialog.car_bottom_sheet.sharing.title': return 'Parkplatz teilen';
			case 'dialog.car_bottom_sheet.sharing.subtitle': return 'Lasse diesen QR Code scannen, um deinen Standort zu teilen';
			case 'dialog.car_bottom_sheet.sharing.action_1': return 'Link teilen';
			case 'dialog.car_bottom_sheet.sharing.share_content': return ({required Object woLink}) => 'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}';
			case 'dialog.maps.driving_mode.title': return 'Driving Modus erkannt';
			case 'dialog.maps.driving_mode.subtitle': return 'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?';
			case 'dialog.maps.location_denied.title': return 'Standortberechtigung verweigert';
			case 'dialog.maps.location_denied.subtitle': return 'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.';
			case 'dialog.history.info.title': return 'Historie';
			case 'dialog.history.info.subtitle': return 'Hier werden dir die letzten 15 Parkplätze angezeigt';
			case 'dialog.history.delete.title': return 'Lösche alle Einträge';
			case 'dialog.history.delete.subtitle': return 'Bist du sicher, dass du alle Einträge löschen möchtest?';
			case 'dialog.leave_info.title': return 'App verlassen';
			case 'dialog.leave_info.subtitle': return 'Bist du sicher, dass du die App verlassen möchtest?';
			case 'dialog.app_info.title': return 'App Info';
			case 'dialog.app_info.subtitle': return 'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.';
			case 'dialog.app_info.action_1': return 'GitHub';
			case 'dialog.feedback.title': return 'Feedback';
			case 'dialog.feedback.subtitle': return 'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:';
			case 'dialog.feedback.action_1': return 'Telegram';
			case 'dialog.data_security.title': return 'Datenschutz und Impressum';
			case 'dialog.data_security.content_1': return 'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 01.09.2023):';
			case 'dialog.data_security.content_2': return '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.';
			case 'dialog.data_security.content_3': return '- Die App kommuniziert mit meinem VPS Server auf Deutschem Boden, um synchronisierte Parkplätze anzuzeigen, anzulegen und zu verwalten.';
			case 'dialog.data_security.content_4': return '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.';
			case 'dialog.data_security.content_5': return '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ';
			case 'dialog.data_security.content_6': return 'nicht an Dritte weiter.';
			case 'dialog.data_security.content_7': return '\n\nEs findet ein Datenaustausch mit meinem Server und mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ';
			case 'dialog.data_security.content_8': return 'Die App speichert sont alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen, dann sind sie auch aus meinem Server gelöscht (in den Einstellungen ganz unten).';
			case 'dialog.data_security.action_1': return 'Impressum';
			case 'dialog.data_security.action_2': return 'Datenschutz';
			case 'dialog.app_data.title': return 'App-Daten löschen';
			case 'dialog.app_data.subtitle': return 'Bist du sicher, dass du alle App-Daten löschen möchtest?';
			case 'settings.title': return 'Einstellungen';
			case 'settings.theme.title': return 'Theme';
			case 'settings.theme.subtitle': return 'Wähle das Theme aus, das dir am besten gefällt.';
			case 'settings.theme.dropdown_1': return 'System';
			case 'settings.theme.dropdown_2': return 'Hell';
			case 'settings.theme.dropdown_3': return 'Dunkel';
			case 'settings.color.choice': return 'Farbe';
			case 'settings.map_type.title': return 'Karten Typ';
			case 'settings.map_type.subtitle': return 'Wähle den Karten Typ aus, der dir am besten gefällt.';
			case 'settings.map_type.dropdown_1': return 'Normal';
			case 'settings.map_type.dropdown_2': return 'Satellit';
			case 'settings.map_type.dropdown_3': return 'Hybrid';
			case 'settings.map_type.dropdown_4': return 'Terrain';
			case 'settings.traffic.title': return 'Verkehrslage';
			case 'settings.traffic.subtitle': return 'Zeige die aktuelle Verkehrslage auf der Karte an.';
			case 'settings.new_ios.title': return 'iOS Design';
			case 'settings.new_ios.subtitle': return 'Aktiviere das neue iOS Design mit Cupertino Widgets.';
			case 'settings.park_ticket.title': return 'Parkticket Zeitpuffer';
			case 'settings.park_ticket.subtitle': return 'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.';
			case 'settings.park_ticket.dropdown_value': return ({required Object value}) => '${value} Minuten';
			case 'settings.driving_mode.title': return 'Driving Modus Erkennung';
			case 'settings.driving_mode.subtitle': return 'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.';
			case 'settings.driving_mode.dropdown_value': return ({required Object value}) => '${value} km/h';
			case 'settings.app_info.title': return 'App Info';
			case 'settings.app_info.subtitle': return ({required Object appVersion, required Object buildNumber}) => 'Version ${appVersion}+${buildNumber}';
			case 'settings.credits.title': return 'Credits';
			case 'settings.credits.subtitle': return 'Dank an Google Maps API und natürlich an die Flutter Community.';
			case 'settings.woauto_server.title': return 'WoAuto Server';
			case 'settings.woauto_server.subtitle': return ({required Object status}) => 'Server Status: ${status}';
			case 'settings.share.title': return 'App Teilen';
			case 'settings.share.subtitle': return 'Teile die App doch mit deinen Freunden und deiner Familie.';
			case 'settings.share.share_content': return 'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto';
			case 'settings.feedback.title': return 'Feedback';
			case 'settings.feedback.subtitle': return 'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?';
			case 'settings.data_security.title': return 'Datenschutz und Impressum';
			case 'settings.data_security.subtitle': return 'Erfahre wie deine Daten geschützt werden.';
			case 'settings.app_data.title': return 'Lösche alle App-Daten';
			case 'settings.app_data.subtitle': return 'Halte hier gedrückt, um all deine App-Daten zu löschen.';
			case 'settings.app_data.subtitle_ios': return 'Tippe hier, um all deine App-Daten zu löschen.';
			default: return null;
		}
	}
}

extension on _TranslationsEn {
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
			case 'car_bottom_sheet.parkings.title': return 'Parkings';
			case 'car_bottom_sheet.shared_parkings.title': return 'Shared Parkings';
			case 'car_bottom_sheet.menu.open_park_in_maps': return 'Open in a maps app';
			case 'car_bottom_sheet.menu.share_park': return 'Share parking spot';
			case 'car_bottom_sheet.menu.to_park': return 'Go to parking spot';
			case 'car_bottom_sheet.menu.delete_park': return 'Delete parking spot';
			case 'my_car.title': return 'My Car';
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
			case 'dialog.ok': return 'Ok';
			case 'dialog.yes': return 'Yes';
			case 'dialog.no': return 'No';
			case 'dialog.share': return 'Share';
			case 'dialog.save': return 'Save';
			case 'dialog.open_settings': return 'Open settings';
			case 'dialog.navigation.title': return 'Location info';
			case 'dialog.navigation.distance_info': return ({required Object distance}) => 'Distance to current location: ${distance} m';
			case 'dialog.navigation.action_1': return 'Start navigation';
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
			case 'dialog.data_security.content_1': return 'Brief summary of privacy policy in our own words (as of 01/09/2023):';
			case 'dialog.data_security.content_2': return '- The app communicates with Google Maps to display the map.';
			case 'dialog.data_security.content_3': return '- The app communicates with my VPS server on German soil to display, create and manage synchronized parking spots.';
			case 'dialog.data_security.content_4': return '- The app does not store any metadata, such as IP address, device name, or operating system version.';
			case 'dialog.data_security.content_5': return '- The app stores, of course, among other things, your location, the name of the parking lot and the coordinates, but gives them ';
			case 'dialog.data_security.content_6': return 'not to any third parties.';
			case 'dialog.data_security.content_7': return '\n\n A data exchange with my server and with the servers of Google, when providing the Google Maps maps, takes place. ';
			case 'dialog.data_security.content_8': return 'The app otherwise stores all data only on your device and you can delete them at any time, then they are also deleted from my server (in the settings at the bottom).';
			case 'dialog.data_security.action_1': return 'Imprint';
			case 'dialog.data_security.action_2': return 'Privacy';
			case 'dialog.app_data.title': return 'Delete App Data';
			case 'dialog.app_data.subtitle': return 'Are you sure you want to delete all app data?';
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
			case 'settings.woauto_server.title': return 'WoAuto Server';
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
