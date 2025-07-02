///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsDe = Translations; // ignore: unused_element

class Translations implements BaseTranslations<AppLocale, Translations> {
  /// Returns the current translations of the given [context].
  ///
  /// Usage:
  /// final t = Translations.of(context);
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  Translations(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver,
      TranslationMetadata<AppLocale, Translations>? meta})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = meta ??
            TranslationMetadata(
              locale: AppLocale.de,
              overrides: overrides ?? {},
              cardinalResolver: cardinalResolver,
              ordinalResolver: ordinalResolver,
            ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <de>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this; // ignore: unused_field

  Translations $copyWith(
          {TranslationMetadata<AppLocale, Translations>? meta}) =>
      Translations(meta: meta ?? this.$meta);

  // Translations
  late final TranslationsConstantsDe constants =
      TranslationsConstantsDe.internal(_root);
  late final TranslationsParkDurationDe park_duration =
      TranslationsParkDurationDe.internal(_root);
  late final TranslationsLoginDialogDe login_dialog =
      TranslationsLoginDialogDe.internal(_root);
  late final TranslationsParkDialogDe park_dialog =
      TranslationsParkDialogDe.internal(_root);
  late final TranslationsMarkerDialogDe marker_dialog =
      TranslationsMarkerDialogDe.internal(_root);
  late final TranslationsHomeDe home = TranslationsHomeDe.internal(_root);
  late final TranslationsHistoryDe history =
      TranslationsHistoryDe.internal(_root);
  late final TranslationsInfoSheetDe info_sheet =
      TranslationsInfoSheetDe.internal(_root);
  late final TranslationsTopHeaderDe top_header =
      TranslationsTopHeaderDe.internal(_root);
  late final TranslationsCarBottomSheetDe car_bottom_sheet =
      TranslationsCarBottomSheetDe.internal(_root);
  late final TranslationsMyCarDe my_car = TranslationsMyCarDe.internal(_root);
  late final TranslationsMapsDe maps = TranslationsMapsDe.internal(_root);
  late final TranslationsIntroDe intro = TranslationsIntroDe.internal(_root);
  late final TranslationsBottomSheetDe bottom_sheet =
      TranslationsBottomSheetDe.internal(_root);
  late final TranslationsSnackbarDe snackbar =
      TranslationsSnackbarDe.internal(_root);
  late final TranslationsDialogDe dialog = TranslationsDialogDe.internal(_root);
  late final TranslationsSettingsDe settings =
      TranslationsSettingsDe.internal(_root);
}

// Path: constants
class TranslationsConstantsDe {
  TranslationsConstantsDe.internal(this._root);

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
  String parked_duration_string({required Object duration}) =>
      'vor ${duration} geparkt';
  String get navigate => 'Navigiere';
}

// Path: park_duration
class TranslationsParkDurationDe {
  TranslationsParkDurationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String hours({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
        n,
        one: '${n} Stunde',
        other: '${n} Stunden',
      );
  String minutes({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
        n,
        one: '${n} Minute',
        other: '${n} Minuten',
      );
  String days({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
        n,
        one: '${n} Tag',
        other: '${n} Tage',
      );
}

// Path: login_dialog
class TranslationsLoginDialogDe {
  TranslationsLoginDialogDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get email => 'E-Mail';
  String get password => 'Passwort';
  String get empty_validation => 'Bitte gebe etwas ein';
  String get email_validation => 'Bitte gebe eine gültige E-Mail Adresse ein';
  String get password_validation =>
      'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein';
  String get password_forgot => 'Passwort vergessen';
  String get password_generate => 'Generiere Passwort';
  String get password_generate_info =>
      'Dein Passwort wird beim Generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!';
  String get register => 'Registrieren';
  String get login => 'Einloggen';
}

// Path: park_dialog
class TranslationsParkDialogDe {
  TranslationsParkDialogDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Neuer Parkplatz';
  String get content_1 => 'Neuen Parkplatz speichern?';
  late final TranslationsParkDialogParkNameDe park_name =
      TranslationsParkDialogParkNameDe.internal(_root);
  String get content_2 => 'Zusätzliche Infos';
  late final TranslationsParkDialogInfoDe info =
      TranslationsParkDialogInfoDe.internal(_root);
  late final TranslationsParkDialogTicketDe ticket =
      TranslationsParkDialogTicketDe.internal(_root);
  late final TranslationsParkDialogPhotoDe photo =
      TranslationsParkDialogPhotoDe.internal(_root);
}

// Path: marker_dialog
class TranslationsMarkerDialogDe {
  TranslationsMarkerDialogDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsMarkerDialogSharedDe shared =
      TranslationsMarkerDialogSharedDe.internal(_root);
  late final TranslationsMarkerDialogMineDe mine =
      TranslationsMarkerDialogMineDe.internal(_root);
  String get action_1 => 'Parkplatz löschen';
}

// Path: home
class TranslationsHomeDe {
  TranslationsHomeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get navigation_1 => 'Karte';
  String get navigation_2 => 'Mein Auto';
  String get navigation_3 => 'Historie';
  String get navigation_4 => 'Einstellungen';
  late final TranslationsHomeQuickActionsDe quick_actions =
      TranslationsHomeQuickActionsDe.internal(_root);
}

// Path: history
class TranslationsHistoryDe {
  TranslationsHistoryDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Historie';
  late final TranslationsHistoryEmptyDe empty =
      TranslationsHistoryEmptyDe.internal(_root);
  late final TranslationsHistoryExportDe export =
      TranslationsHistoryExportDe.internal(_root);
  late final TranslationsHistoryDeleteDe delete =
      TranslationsHistoryDeleteDe.internal(_root);
}

// Path: info_sheet
class TranslationsInfoSheetDe {
  TranslationsInfoSheetDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get park_save => 'Parkplatz speichern';
  String get current_position => 'Zur aktuellen Position';
  String get parkings => 'Parkplätze';
  String get badge_label => 'Sync';
}

// Path: top_header
class TranslationsTopHeaderDe {
  TranslationsTopHeaderDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get driving_mode_tooltip => 'Driving Modus';
}

// Path: car_bottom_sheet
class TranslationsCarBottomSheetDe {
  TranslationsCarBottomSheetDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsCarBottomSheetEmptyDe empty =
      TranslationsCarBottomSheetEmptyDe.internal(_root);
  late final TranslationsCarBottomSheetDistanceCalculationDe
      distance_calculation =
      TranslationsCarBottomSheetDistanceCalculationDe.internal(_root);
  late final TranslationsCarBottomSheetYouDe you =
      TranslationsCarBottomSheetYouDe.internal(_root);
  late final TranslationsCarBottomSheetFriendsDe friends =
      TranslationsCarBottomSheetFriendsDe.internal(_root);
  late final TranslationsCarBottomSheetMenuDe menu =
      TranslationsCarBottomSheetMenuDe.internal(_root);
}

// Path: my_car
class TranslationsMyCarDe {
  TranslationsMyCarDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Mein Auto';
  String get login_register => 'Einloggen oder jetzt Registrieren';
  String get shared_content => 'Das ist mein Auto! 🚗';
  late final TranslationsMyCarBuiltDe built =
      TranslationsMyCarBuiltDe.internal(_root);
  late final TranslationsMyCarDrivenDe driven =
      TranslationsMyCarDrivenDe.internal(_root);
  late final TranslationsMyCarPlateDe plate =
      TranslationsMyCarPlateDe.internal(_root);
  late final TranslationsMyCarParkNameDe park_name =
      TranslationsMyCarParkNameDe.internal(_root);
  late final TranslationsMyCarTuvDe tuv =
      TranslationsMyCarTuvDe.internal(_root);
  String get share_deactivate_info =>
      'Wenn du diese Einstellungen deaktivierst, wirst du nochmal nach einer Bestätigung der Aktion gefragt, da das ausschalten immer alle Daten vom Server zuerst löscht und dann das Speichern unterbindet, bis du es wieder einschaltest.';
  String get share_my_last_location => 'Teile meinen letzten Standort';
  String get share_my_last_location_description =>
      'Während der App Nutzung wird dein Live-Standort auf unserem Server gespeichert und deine Freunde, nur sie, können ihn dann einsehen. Sobald die App geschlossen wurde, bleibt der zuletzt gesetzte Standort sichtbar.';
  String get share_my_last_location_deactivate =>
      'Wenn du dein Teilen beendest, wird erst dein Standort von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
  String get share_my_parkings => 'Teile meine Parkplätze';
  String get share_my_parkings_description =>
      'Hiermit werden deine Parkplätze in unseren Servern gespeichert und so können deine Freunde, nur sie, deine Parkplätze einsehen, niemals aber deine Parkplatzhistorie.';
  String get share_my_parkings_deactivate =>
      'Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
  String get secure_notice =>
      'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.';
}

// Path: maps
class TranslationsMapsDe {
  TranslationsMapsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get loading => 'Lädt Karte...';
  late final TranslationsMapsTrafficDe traffic =
      TranslationsMapsTrafficDe.internal(_root);
}

// Path: intro
class TranslationsIntroDe {
  TranslationsIntroDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsIntroPage1De page_1 =
      TranslationsIntroPage1De.internal(_root);
  late final TranslationsIntroPage2De page_2 =
      TranslationsIntroPage2De.internal(_root);
}

// Path: bottom_sheet
class TranslationsBottomSheetDe {
  TranslationsBottomSheetDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get photo => 'Foto auswählen';
  String get camera => 'Foto aufnehmen';
  String get photo_delete => 'Foto löschen';
}

// Path: snackbar
class TranslationsSnackbarDe {
  TranslationsSnackbarDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsSnackbarLockedDe locked =
      TranslationsSnackbarLockedDe.internal(_root);
  late final TranslationsSnackbarSharedParkingDe shared_parking =
      TranslationsSnackbarSharedParkingDe.internal(_root);
  late final TranslationsSnackbarDistanceCalculationDe distance_calculation =
      TranslationsSnackbarDistanceCalculationDe.internal(_root);
}

// Path: dialog
class TranslationsDialogDe {
  TranslationsDialogDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get abort => 'Abbrechen';
  String get delete => 'Löschen';
  String get leave => 'Verlassen';
  String get logout => 'Ausloggen';
  String get ok => 'Ok';
  String get yes => 'Ja';
  String get no => 'Nein';
  String get share => 'Teilen';
  String get save => 'Speichern';
  String get open_settings => 'Einstellungen öffnen';
  late final TranslationsDialogShareLocationParkingsDe share_location_parkings =
      TranslationsDialogShareLocationParkingsDe.internal(_root);
  late final TranslationsDialogDistanceDe distance =
      TranslationsDialogDistanceDe.internal(_root);
  late final TranslationsDialogNotificationsDe notifications =
      TranslationsDialogNotificationsDe.internal(_root);
  late final TranslationsDialogCarBottomSheetDe car_bottom_sheet =
      TranslationsDialogCarBottomSheetDe.internal(_root);
  late final TranslationsDialogMapsDe maps =
      TranslationsDialogMapsDe.internal(_root);
  late final TranslationsDialogHistoryDe history =
      TranslationsDialogHistoryDe.internal(_root);
  late final TranslationsDialogLeaveInfoDe leave_info =
      TranslationsDialogLeaveInfoDe.internal(_root);
  late final TranslationsDialogAppInfoDe app_info =
      TranslationsDialogAppInfoDe.internal(_root);
  late final TranslationsDialogFeedbackDe feedback =
      TranslationsDialogFeedbackDe.internal(_root);
  late final TranslationsDialogDataSecurityDe data_security =
      TranslationsDialogDataSecurityDe.internal(_root);
  late final TranslationsDialogAppDataDe app_data =
      TranslationsDialogAppDataDe.internal(_root);
  late final TranslationsDialogAccountDataDe account_data =
      TranslationsDialogAccountDataDe.internal(_root);
  String get logout_confirm =>
      'Bist du dir sicher, dass du dich ausloggen möchtest?';
}

// Path: settings
class TranslationsSettingsDe {
  TranslationsSettingsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Einstellungen';
  late final TranslationsSettingsThemeDe theme =
      TranslationsSettingsThemeDe.internal(_root);
  late final TranslationsSettingsColorDe color =
      TranslationsSettingsColorDe.internal(_root);
  late final TranslationsSettingsMapTypeDe map_type =
      TranslationsSettingsMapTypeDe.internal(_root);
  late final TranslationsSettingsTrafficDe traffic =
      TranslationsSettingsTrafficDe.internal(_root);
  late final TranslationsSettingsNewIosDe new_ios =
      TranslationsSettingsNewIosDe.internal(_root);
  late final TranslationsSettingsParkTicketDe park_ticket =
      TranslationsSettingsParkTicketDe.internal(_root);
  late final TranslationsSettingsDrivingModeDe driving_mode =
      TranslationsSettingsDrivingModeDe.internal(_root);
  late final TranslationsSettingsAppInfoDe app_info =
      TranslationsSettingsAppInfoDe.internal(_root);
  late final TranslationsSettingsCreditsDe credits =
      TranslationsSettingsCreditsDe.internal(_root);
  late final TranslationsSettingsWoautoServerDe woauto_server =
      TranslationsSettingsWoautoServerDe.internal(_root);
  late final TranslationsSettingsShareDe share =
      TranslationsSettingsShareDe.internal(_root);
  late final TranslationsSettingsFeedbackDe feedback =
      TranslationsSettingsFeedbackDe.internal(_root);
  late final TranslationsSettingsDataSecurityDe data_security =
      TranslationsSettingsDataSecurityDe.internal(_root);
  late final TranslationsSettingsAppDataDe app_data =
      TranslationsSettingsAppDataDe.internal(_root);
}

// Path: park_dialog.park_name
class TranslationsParkDialogParkNameDe {
  TranslationsParkDialogParkNameDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label => 'Name';
}

// Path: park_dialog.info
class TranslationsParkDialogInfoDe {
  TranslationsParkDialogInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get label => 'Info';
}

// Path: park_dialog.ticket
class TranslationsParkDialogTicketDe {
  TranslationsParkDialogTicketDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Parkticket';
  String get help => 'Parkticket läuft ab um';
  String until({required Object time}) => 'Parkticket gilt bis ${time} Uhr';
}

// Path: park_dialog.photo
class TranslationsParkDialogPhotoDe {
  TranslationsParkDialogPhotoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Foto';
}

// Path: marker_dialog.shared
class TranslationsMarkerDialogSharedDe {
  TranslationsMarkerDialogSharedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String content({required Object address}) =>
      'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.';
}

// Path: marker_dialog.mine
class TranslationsMarkerDialogMineDe {
  TranslationsMarkerDialogMineDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String content(
          {required Object formattedDate,
          required Object address,
          required Object description}) =>
      'Du hast ${formattedDate}.\n\nDein Auto steht an folgender Adresse:\n${address}.\n${description}';
}

// Path: home.quick_actions
class TranslationsHomeQuickActionsDe {
  TranslationsHomeQuickActionsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get action_parkings => 'Parkplätze ansehen';
  String get action_save => 'Parkplatz speichern';
}

// Path: history.empty
class TranslationsHistoryEmptyDe {
  TranslationsHistoryEmptyDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Keine Einträge';
  String get subtitle => 'Du hast noch keine Einträge in deiner Historie.';
}

// Path: history.export
class TranslationsHistoryExportDe {
  TranslationsHistoryExportDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Exportiere als CSV';
  String get subtitle =>
      'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.';
}

// Path: history.delete
class TranslationsHistoryDeleteDe {
  TranslationsHistoryDeleteDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Lösche alle Einträge';
  String get subtitle => 'Lösche alle Einträge in deiner Historie.';
}

// Path: car_bottom_sheet.empty
class TranslationsCarBottomSheetEmptyDe {
  TranslationsCarBottomSheetEmptyDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get parkings => 'Du hast keine Parkplätze.';
  String get shared_parkings => 'Du hast keine geteilten Parkplätze.';
}

// Path: car_bottom_sheet.distance_calculation
class TranslationsCarBottomSheetDistanceCalculationDe {
  TranslationsCarBottomSheetDistanceCalculationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Wie wird die Entfernung berechnet, fragst du dich?';
}

// Path: car_bottom_sheet.you
class TranslationsCarBottomSheetYouDe {
  TranslationsCarBottomSheetYouDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Du';
  String get address => 'Bei dir';
}

// Path: car_bottom_sheet.friends
class TranslationsCarBottomSheetFriendsDe {
  TranslationsCarBottomSheetFriendsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Freunde';
  String get park => 'Parkplatz';
}

// Path: car_bottom_sheet.menu
class TranslationsCarBottomSheetMenuDe {
  TranslationsCarBottomSheetMenuDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get open_park_in_maps => 'Karten App öffnen';
  String get share_park => 'Parkplatz teilen';
  String get to_park => 'Zum Parkplatz';
  String get delete_park => 'Parkplatz löschen';
}

// Path: my_car.built
class TranslationsMyCarBuiltDe {
  TranslationsMyCarBuiltDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String title({required Object baujahr, required Object jahre}) =>
      'Baujahr: ${baujahr} (${jahre} Jahre)';
  String title_short({required Object baujahr}) => 'Baujahr: ${baujahr}';
  String get title_dialog => 'Baujahr';
  String get subtitle => 'Ändere das Baujahr deines Autos.';
  String get default_year => '2002';
  String get validate_null => 'Bitte gib ein gültiges Baujahr ein';
  String validate_year({required Object year}) =>
      'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein';
}

// Path: my_car.driven
class TranslationsMyCarDrivenDe {
  TranslationsMyCarDrivenDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String title({required Object km}) => '${km} km gefahren';
  String title_short({required Object km}) => 'Kilometerstand: ${km}';
  String get title_dialog => 'Kilometerstand';
  String get subtitle => 'Ändere den Kilometerstand deines Autos.';
  String get hint => '123456';
}

// Path: my_car.plate
class TranslationsMyCarPlateDe {
  TranslationsMyCarPlateDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String title({required Object plate}) => 'Kennzeichen: ${plate}';
  String get subtitle => 'Ändere das Kennzeichen deines Autos.';
  String get title_short => 'Kennzeichen';
  String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class TranslationsMyCarParkNameDe {
  TranslationsMyCarParkNameDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String title({required Object name}) => 'Titel: ${name}';
  String get subtitle =>
      'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW';
  String get park_title => 'Name des Parkplatzes';
}

// Path: my_car.tuv
class TranslationsMyCarTuvDe {
  TranslationsMyCarTuvDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String title({required Object date}) => 'TÜV bis ${date}';
  String get subtitle => 'Ändere das Datum, an dem dein TÜV abläuft';
  String get help => 'Gebe als Tag den "1." an, also z.B. "1.1.2022"';
  String get add_to_calender => 'Zum Kalender hinzufügen';
  String get calender_title => 'TÜV abgelaufen';
  String get calender_content =>
      'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team';
  String get expired_info => 'Dein TÜV ist abgelaufen!';
  String get expiring_info =>
      'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.';
}

// Path: maps.traffic
class TranslationsMapsTrafficDe {
  TranslationsMapsTrafficDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get show => 'Verkehr anzeigen';
  String get hide => 'Verkehr ausblenden';
}

// Path: intro.page_1
class TranslationsIntroPage1De {
  TranslationsIntroPage1De.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get page_title => 'WoAuto';
  String get title => 'Willkommen bei WoAuto';
  String get content_1 =>
      'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.';
  String get content_2 =>
      'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.';
  String get content_3 => 'Speichere in nur 2 Klicks deinen Parkplatz.';
  String get action_1 => 'Weiter';
}

// Path: intro.page_2
class TranslationsIntroPage2De {
  TranslationsIntroPage2De.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get page_title => 'App-Voreinstellungen';
  String get parking_title => 'Name für dein Auto setzen';
  String get parking_content => 'Gib deinem Auto einen coolen Namen.';
  String get parking_hint => 'Mein Auto';
  String get theme_title => 'App-Theme einstellen';
  String get theme_content => 'Wähle das Theme aus, das dir am besten gefällt.';
  String get location_title => 'Echtzeit-Standortberechtigung erlauben';
  String get location_content =>
      'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.';
  String get location_checkbox => 'Echtzeit-Standortberechtigung';
  String get location_checkbox_error =>
      'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.';
  String get notification_checkbox => 'Benachrichtigungen (optional)';
  String get exact_notification_checkbox =>
      'Geplante Benachrichtigungen (optional)';
  String get exact_notification_description =>
      'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.';
  String get action_1 => 'Fertig';
}

// Path: snackbar.locked
class TranslationsSnackbarLockedDe {
  TranslationsSnackbarLockedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Hast du dein Auto abgeschlossen?';
  String get subtitle =>
      'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.';
  String get action => 'Ja, hab\' ich';
}

// Path: snackbar.shared_parking
class TranslationsSnackbarSharedParkingDe {
  TranslationsSnackbarSharedParkingDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Ein geteilter Online Parkplatz wurde hinzugefügt';
  String get subtitle => 'Schaue auf der Karte oder in der Liste nach.';
}

// Path: snackbar.distance_calculation
class TranslationsSnackbarDistanceCalculationDe {
  TranslationsSnackbarDistanceCalculationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Wie wird die Entfernung berechnet?';
  String get subtitle =>
      'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.';
  String get subsubtitle => 'Tippe um mehr zu erfahren.';
}

// Path: dialog.share_location_parkings
class TranslationsDialogShareLocationParkingsDe {
  TranslationsDialogShareLocationParkingsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Teilen beenden';
  String get content_1 => '';
  String get content_2 =>
      'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
  String get deactivate => 'Ausschalten';
}

// Path: dialog.distance
class TranslationsDialogDistanceDe {
  TranslationsDialogDistanceDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Standort Entfernung';
  String content({required Object distance}) =>
      'Abstand zum Standort: ${distance}';
}

// Path: dialog.notifications
class TranslationsDialogNotificationsDe {
  TranslationsDialogNotificationsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsDialogNotificationsNaDe na =
      TranslationsDialogNotificationsNaDe.internal(_root);
  late final TranslationsDialogNotificationsDeniedDe denied =
      TranslationsDialogNotificationsDeniedDe.internal(_root);
  late final TranslationsDialogNotificationsSentDe sent =
      TranslationsDialogNotificationsSentDe.internal(_root);
  late final TranslationsDialogNotificationsExpiringDe expiring =
      TranslationsDialogNotificationsExpiringDe.internal(_root);
}

// Path: dialog.car_bottom_sheet
class TranslationsDialogCarBottomSheetDe {
  TranslationsDialogCarBottomSheetDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsDialogCarBottomSheetSyncDe sync =
      TranslationsDialogCarBottomSheetSyncDe.internal(_root);
  late final TranslationsDialogCarBottomSheetSyncedDe synced =
      TranslationsDialogCarBottomSheetSyncedDe.internal(_root);
  late final TranslationsDialogCarBottomSheetSharingDe sharing =
      TranslationsDialogCarBottomSheetSharingDe.internal(_root);
}

// Path: dialog.maps
class TranslationsDialogMapsDe {
  TranslationsDialogMapsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsDialogMapsDrivingModeDe driving_mode =
      TranslationsDialogMapsDrivingModeDe.internal(_root);
  late final TranslationsDialogMapsLocationDeniedDe location_denied =
      TranslationsDialogMapsLocationDeniedDe.internal(_root);
}

// Path: dialog.history
class TranslationsDialogHistoryDe {
  TranslationsDialogHistoryDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  late final TranslationsDialogHistoryInfoDe info =
      TranslationsDialogHistoryInfoDe.internal(_root);
  late final TranslationsDialogHistoryDeleteDe delete =
      TranslationsDialogHistoryDeleteDe.internal(_root);
}

// Path: dialog.leave_info
class TranslationsDialogLeaveInfoDe {
  TranslationsDialogLeaveInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'App verlassen';
  String get subtitle => 'Bist du sicher, dass du die App verlassen möchtest?';
}

// Path: dialog.app_info
class TranslationsDialogAppInfoDe {
  TranslationsDialogAppInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'App Info';
  String get subtitle =>
      'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.';
  String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class TranslationsDialogFeedbackDe {
  TranslationsDialogFeedbackDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Feedback';
  String get subtitle =>
      'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:';
  String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class TranslationsDialogDataSecurityDe {
  TranslationsDialogDataSecurityDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Datenschutz und Impressum';
  String get content_1 =>
      'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 25.08.2024):';
  String get content_2 =>
      '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.';
  String get content_3 =>
      '- Die App kommuniziert mit meinem VPS Server auf Deutschem Boden, um synchronisierte Parkplätze anzuzeigen, anzulegen und zu verwalten. Zusätzlich deinen letzten Live Standort, aber auch nur sobald du es erlaubst.';
  String get content_4 =>
      '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.';
  String get content_5 =>
      '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ';
  String get content_6 => 'nicht an Dritte weiter.';
  String get content_7 =>
      '\n\nEs findet ein Datenaustausch mit meinem Server und mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ';
  String get content_8 =>
      'Die App speichert sont alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen, dann sind sie auch aus meinem Server gelöscht (in den Einstellungen ganz unten).';
  String get action_1 => 'Impressum';
  String get action_2 => 'Datenschutz';
}

// Path: dialog.app_data
class TranslationsDialogAppDataDe {
  TranslationsDialogAppDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'App Daten löschen';
  String get subtitle =>
      'Bist du sicher, dass du alle App Daten löschen? Dein Account bleibt bestehen.';
}

// Path: dialog.account_data
class TranslationsDialogAccountDataDe {
  TranslationsDialogAccountDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Konto & Daten löschen';
  String get content =>
      'Hiermit wird dein Account gelöscht, mit samt allen Daten, die mit dir in Zusammenhang stecken, Parkplätze, Live Standorte etc. Außerdem werden alle App Daten gelöscht.';
}

// Path: settings.theme
class TranslationsSettingsThemeDe {
  TranslationsSettingsThemeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Theme';
  String get subtitle => 'Wähle das Theme aus, das dir am besten gefällt.';
  String get dropdown_1 => 'System';
  String get dropdown_2 => 'Hell';
  String get dropdown_3 => 'Dunkel';
}

// Path: settings.color
class TranslationsSettingsColorDe {
  TranslationsSettingsColorDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get choice => 'Farbe';
}

// Path: settings.map_type
class TranslationsSettingsMapTypeDe {
  TranslationsSettingsMapTypeDe.internal(this._root);

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
class TranslationsSettingsTrafficDe {
  TranslationsSettingsTrafficDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Verkehrslage';
  String get subtitle => 'Zeige die aktuelle Verkehrslage auf der Karte an.';
}

// Path: settings.new_ios
class TranslationsSettingsNewIosDe {
  TranslationsSettingsNewIosDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'iOS Design';
  String get subtitle => 'Aktiviere das neue iOS Design mit Cupertino Widgets.';
}

// Path: settings.park_ticket
class TranslationsSettingsParkTicketDe {
  TranslationsSettingsParkTicketDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Parkticket Zeitpuffer';
  String get subtitle =>
      'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.';
  String dropdown_value({required Object value}) => '${value} Minuten';
}

// Path: settings.driving_mode
class TranslationsSettingsDrivingModeDe {
  TranslationsSettingsDrivingModeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Driving Modus Erkennung';
  String get subtitle =>
      'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.';
  String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class TranslationsSettingsAppInfoDe {
  TranslationsSettingsAppInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'App Info';
  String subtitle({required Object appVersion, required Object buildNumber}) =>
      'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class TranslationsSettingsCreditsDe {
  TranslationsSettingsCreditsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Credits';
  String get subtitle =>
      'Dank an Google Maps API und natürlich an die Flutter Community.';
}

// Path: settings.woauto_server
class TranslationsSettingsWoautoServerDe {
  TranslationsSettingsWoautoServerDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'WoAuto Server (PocketBase)';
  String subtitle({required Object status}) => 'Server Status: ${status}';
}

// Path: settings.share
class TranslationsSettingsShareDe {
  TranslationsSettingsShareDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'App Teilen';
  String get subtitle =>
      'Teile die App doch mit deinen Freunden und deiner Familie.';
  String get share_content =>
      'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class TranslationsSettingsFeedbackDe {
  TranslationsSettingsFeedbackDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Feedback';
  String get subtitle =>
      'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?';
}

// Path: settings.data_security
class TranslationsSettingsDataSecurityDe {
  TranslationsSettingsDataSecurityDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Datenschutz und Impressum';
  String get subtitle => 'Erfahre wie deine Daten geschützt werden.';
}

// Path: settings.app_data
class TranslationsSettingsAppDataDe {
  TranslationsSettingsAppDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Lösche alle App-Daten';
  String get subtitle =>
      'Halte hier gedrückt, um all deine App-Daten zu löschen.';
  String get subtitle_ios => 'Tippe hier, um all deine App-Daten zu löschen.';
}

// Path: dialog.notifications.na
class TranslationsDialogNotificationsNaDe {
  TranslationsDialogNotificationsNaDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Benachrichtigungen nicht verfügbar';
  String get subtitle =>
      'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.';
}

// Path: dialog.notifications.denied
class TranslationsDialogNotificationsDeniedDe {
  TranslationsDialogNotificationsDeniedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Benachrichtigungen verweigert';
  String get subtitle =>
      'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.';
}

// Path: dialog.notifications.sent
class TranslationsDialogNotificationsSentDe {
  TranslationsDialogNotificationsSentDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Auto geparkt';
}

// Path: dialog.notifications.expiring
class TranslationsDialogNotificationsExpiringDe {
  TranslationsDialogNotificationsExpiringDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Dein Parkticket läuft bald ab';
  String subtitle({required Object minutesLeft}) =>
      'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.';
}

// Path: dialog.car_bottom_sheet.sync
class TranslationsDialogCarBottomSheetSyncDe {
  TranslationsDialogCarBottomSheetSyncDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Parkplatz synchronisieren';
  String get subtitle => 'Möchtest du den Parkplatz synchronisieren?';
  String get action_1 => 'Synchronisieren';
}

// Path: dialog.car_bottom_sheet.synced
class TranslationsDialogCarBottomSheetSyncedDe {
  TranslationsDialogCarBottomSheetSyncedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Parkplatz synchronisiert';
  String get subtitle =>
      'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?';
}

// Path: dialog.car_bottom_sheet.sharing
class TranslationsDialogCarBottomSheetSharingDe {
  TranslationsDialogCarBottomSheetSharingDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Parkplatz teilen';
  String get subtitle =>
      'Lasse diesen QR Code scannen, um deinen Standort zu teilen';
  String get action_1 => 'Link teilen';
  String share_content({required Object woLink}) =>
      'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class TranslationsDialogMapsDrivingModeDe {
  TranslationsDialogMapsDrivingModeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Driving Modus erkannt';
  String get subtitle =>
      'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?';
}

// Path: dialog.maps.location_denied
class TranslationsDialogMapsLocationDeniedDe {
  TranslationsDialogMapsLocationDeniedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Standortberechtigung verweigert';
  String get subtitle =>
      'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.';
}

// Path: dialog.history.info
class TranslationsDialogHistoryInfoDe {
  TranslationsDialogHistoryInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Historie';
  String get subtitle => 'Hier werden dir die letzten 15 Parkplätze angezeigt';
}

// Path: dialog.history.delete
class TranslationsDialogHistoryDeleteDe {
  TranslationsDialogHistoryDeleteDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations
  String get title => 'Lösche alle Einträge';
  String get subtitle =>
      'Bist du sicher, dass du alle Einträge löschen möchtest?';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'constants.app_name':
        return 'WoAuto';
      case 'constants.default_park_title':
        return 'Mein Auto';
      case 'constants.default_shared_title':
        return 'Anderes Auto';
      case 'constants.default_park_info':
        return 'z.B. Parkdeck 2';
      case 'constants.default_address':
        return 'Keine Adresse gefunden';
      case 'constants.address_na':
        return 'Adresse nicht gefunden.';
      case 'constants.update':
        return 'Aktualisieren';
      case 'constants.error':
        return 'Fehler';
      case 'constants.error_description':
        return 'Es ist ein Fehler aufgetreten.';
      case 'constants.parked_rn':
        return 'gerade eben geparkt';
      case 'constants.parked_duration_string':
        return ({required Object duration}) => 'vor ${duration} geparkt';
      case 'constants.navigate':
        return 'Navigiere';
      case 'park_duration.hours':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
              n,
              one: '${n} Stunde',
              other: '${n} Stunden',
            );
      case 'park_duration.minutes':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
              n,
              one: '${n} Minute',
              other: '${n} Minuten',
            );
      case 'park_duration.days':
        return ({required num n}) =>
            (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
              n,
              one: '${n} Tag',
              other: '${n} Tage',
            );
      case 'login_dialog.email':
        return 'E-Mail';
      case 'login_dialog.password':
        return 'Passwort';
      case 'login_dialog.empty_validation':
        return 'Bitte gebe etwas ein';
      case 'login_dialog.email_validation':
        return 'Bitte gebe eine gültige E-Mail Adresse ein';
      case 'login_dialog.password_validation':
        return 'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein';
      case 'login_dialog.password_forgot':
        return 'Passwort vergessen';
      case 'login_dialog.password_generate':
        return 'Generiere Passwort';
      case 'login_dialog.password_generate_info':
        return 'Dein Passwort wird beim Generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!';
      case 'login_dialog.register':
        return 'Registrieren';
      case 'login_dialog.login':
        return 'Einloggen';
      case 'park_dialog.title':
        return 'Neuer Parkplatz';
      case 'park_dialog.content_1':
        return 'Neuen Parkplatz speichern?';
      case 'park_dialog.park_name.label':
        return 'Name';
      case 'park_dialog.content_2':
        return 'Zusätzliche Infos';
      case 'park_dialog.info.label':
        return 'Info';
      case 'park_dialog.ticket.title':
        return 'Parkticket';
      case 'park_dialog.ticket.help':
        return 'Parkticket läuft ab um';
      case 'park_dialog.ticket.until':
        return ({required Object time}) => 'Parkticket gilt bis ${time} Uhr';
      case 'park_dialog.photo.title':
        return 'Foto';
      case 'marker_dialog.shared.content':
        return ({required Object address}) =>
            'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.';
      case 'marker_dialog.mine.content':
        return (
                {required Object formattedDate,
                required Object address,
                required Object description}) =>
            'Du hast ${formattedDate}.\n\nDein Auto steht an folgender Adresse:\n${address}.\n${description}';
      case 'marker_dialog.action_1':
        return 'Parkplatz löschen';
      case 'home.navigation_1':
        return 'Karte';
      case 'home.navigation_2':
        return 'Mein Auto';
      case 'home.navigation_3':
        return 'Historie';
      case 'home.navigation_4':
        return 'Einstellungen';
      case 'home.quick_actions.action_parkings':
        return 'Parkplätze ansehen';
      case 'home.quick_actions.action_save':
        return 'Parkplatz speichern';
      case 'history.title':
        return 'Historie';
      case 'history.empty.title':
        return 'Keine Einträge';
      case 'history.empty.subtitle':
        return 'Du hast noch keine Einträge in deiner Historie.';
      case 'history.export.title':
        return 'Exportiere als CSV';
      case 'history.export.subtitle':
        return 'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.';
      case 'history.delete.title':
        return 'Lösche alle Einträge';
      case 'history.delete.subtitle':
        return 'Lösche alle Einträge in deiner Historie.';
      case 'info_sheet.park_save':
        return 'Parkplatz speichern';
      case 'info_sheet.current_position':
        return 'Zur aktuellen Position';
      case 'info_sheet.parkings':
        return 'Parkplätze';
      case 'info_sheet.badge_label':
        return 'Sync';
      case 'top_header.driving_mode_tooltip':
        return 'Driving Modus';
      case 'car_bottom_sheet.empty.parkings':
        return 'Du hast keine Parkplätze.';
      case 'car_bottom_sheet.empty.shared_parkings':
        return 'Du hast keine geteilten Parkplätze.';
      case 'car_bottom_sheet.distance_calculation.title':
        return 'Wie wird die Entfernung berechnet, fragst du dich?';
      case 'car_bottom_sheet.you.title':
        return 'Du';
      case 'car_bottom_sheet.you.address':
        return 'Bei dir';
      case 'car_bottom_sheet.friends.title':
        return 'Freunde';
      case 'car_bottom_sheet.friends.park':
        return 'Parkplatz';
      case 'car_bottom_sheet.menu.open_park_in_maps':
        return 'Karten App öffnen';
      case 'car_bottom_sheet.menu.share_park':
        return 'Parkplatz teilen';
      case 'car_bottom_sheet.menu.to_park':
        return 'Zum Parkplatz';
      case 'car_bottom_sheet.menu.delete_park':
        return 'Parkplatz löschen';
      case 'my_car.title':
        return 'Mein Auto';
      case 'my_car.login_register':
        return 'Einloggen oder jetzt Registrieren';
      case 'my_car.shared_content':
        return 'Das ist mein Auto! 🚗';
      case 'my_car.built.title':
        return ({required Object baujahr, required Object jahre}) =>
            'Baujahr: ${baujahr} (${jahre} Jahre)';
      case 'my_car.built.title_short':
        return ({required Object baujahr}) => 'Baujahr: ${baujahr}';
      case 'my_car.built.title_dialog':
        return 'Baujahr';
      case 'my_car.built.subtitle':
        return 'Ändere das Baujahr deines Autos.';
      case 'my_car.built.default_year':
        return '2002';
      case 'my_car.built.validate_null':
        return 'Bitte gib ein gültiges Baujahr ein';
      case 'my_car.built.validate_year':
        return ({required Object year}) =>
            'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein';
      case 'my_car.driven.title':
        return ({required Object km}) => '${km} km gefahren';
      case 'my_car.driven.title_short':
        return ({required Object km}) => 'Kilometerstand: ${km}';
      case 'my_car.driven.title_dialog':
        return 'Kilometerstand';
      case 'my_car.driven.subtitle':
        return 'Ändere den Kilometerstand deines Autos.';
      case 'my_car.driven.hint':
        return '123456';
      case 'my_car.plate.title':
        return ({required Object plate}) => 'Kennzeichen: ${plate}';
      case 'my_car.plate.subtitle':
        return 'Ändere das Kennzeichen deines Autos.';
      case 'my_car.plate.title_short':
        return 'Kennzeichen';
      case 'my_car.plate.hint':
        return 'B-DE-1234';
      case 'my_car.park_name.title':
        return ({required Object name}) => 'Titel: ${name}';
      case 'my_car.park_name.subtitle':
        return 'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW';
      case 'my_car.park_name.park_title':
        return 'Name des Parkplatzes';
      case 'my_car.tuv.title':
        return ({required Object date}) => 'TÜV bis ${date}';
      case 'my_car.tuv.subtitle':
        return 'Ändere das Datum, an dem dein TÜV abläuft';
      case 'my_car.tuv.help':
        return 'Gebe als Tag den "1." an, also z.B. "1.1.2022"';
      case 'my_car.tuv.add_to_calender':
        return 'Zum Kalender hinzufügen';
      case 'my_car.tuv.calender_title':
        return 'TÜV abgelaufen';
      case 'my_car.tuv.calender_content':
        return 'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team';
      case 'my_car.tuv.expired_info':
        return 'Dein TÜV ist abgelaufen!';
      case 'my_car.tuv.expiring_info':
        return 'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.';
      case 'my_car.share_deactivate_info':
        return 'Wenn du diese Einstellungen deaktivierst, wirst du nochmal nach einer Bestätigung der Aktion gefragt, da das ausschalten immer alle Daten vom Server zuerst löscht und dann das Speichern unterbindet, bis du es wieder einschaltest.';
      case 'my_car.share_my_last_location':
        return 'Teile meinen letzten Standort';
      case 'my_car.share_my_last_location_description':
        return 'Während der App Nutzung wird dein Live-Standort auf unserem Server gespeichert und deine Freunde, nur sie, können ihn dann einsehen. Sobald die App geschlossen wurde, bleibt der zuletzt gesetzte Standort sichtbar.';
      case 'my_car.share_my_last_location_deactivate':
        return 'Wenn du dein Teilen beendest, wird erst dein Standort von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
      case 'my_car.share_my_parkings':
        return 'Teile meine Parkplätze';
      case 'my_car.share_my_parkings_description':
        return 'Hiermit werden deine Parkplätze in unseren Servern gespeichert und so können deine Freunde, nur sie, deine Parkplätze einsehen, niemals aber deine Parkplatzhistorie.';
      case 'my_car.share_my_parkings_deactivate':
        return 'Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
      case 'my_car.secure_notice':
        return 'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.';
      case 'maps.loading':
        return 'Lädt Karte...';
      case 'maps.traffic.show':
        return 'Verkehr anzeigen';
      case 'maps.traffic.hide':
        return 'Verkehr ausblenden';
      case 'intro.page_1.page_title':
        return 'WoAuto';
      case 'intro.page_1.title':
        return 'Willkommen bei WoAuto';
      case 'intro.page_1.content_1':
        return 'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.';
      case 'intro.page_1.content_2':
        return 'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.';
      case 'intro.page_1.content_3':
        return 'Speichere in nur 2 Klicks deinen Parkplatz.';
      case 'intro.page_1.action_1':
        return 'Weiter';
      case 'intro.page_2.page_title':
        return 'App-Voreinstellungen';
      case 'intro.page_2.parking_title':
        return 'Name für dein Auto setzen';
      case 'intro.page_2.parking_content':
        return 'Gib deinem Auto einen coolen Namen.';
      case 'intro.page_2.parking_hint':
        return 'Mein Auto';
      case 'intro.page_2.theme_title':
        return 'App-Theme einstellen';
      case 'intro.page_2.theme_content':
        return 'Wähle das Theme aus, das dir am besten gefällt.';
      case 'intro.page_2.location_title':
        return 'Echtzeit-Standortberechtigung erlauben';
      case 'intro.page_2.location_content':
        return 'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.';
      case 'intro.page_2.location_checkbox':
        return 'Echtzeit-Standortberechtigung';
      case 'intro.page_2.location_checkbox_error':
        return 'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.';
      case 'intro.page_2.notification_checkbox':
        return 'Benachrichtigungen (optional)';
      case 'intro.page_2.exact_notification_checkbox':
        return 'Geplante Benachrichtigungen (optional)';
      case 'intro.page_2.exact_notification_description':
        return 'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.';
      case 'intro.page_2.action_1':
        return 'Fertig';
      case 'bottom_sheet.photo':
        return 'Foto auswählen';
      case 'bottom_sheet.camera':
        return 'Foto aufnehmen';
      case 'bottom_sheet.photo_delete':
        return 'Foto löschen';
      case 'snackbar.locked.title':
        return 'Hast du dein Auto abgeschlossen?';
      case 'snackbar.locked.subtitle':
        return 'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.';
      case 'snackbar.locked.action':
        return 'Ja, hab\' ich';
      case 'snackbar.shared_parking.title':
        return 'Ein geteilter Online Parkplatz wurde hinzugefügt';
      case 'snackbar.shared_parking.subtitle':
        return 'Schaue auf der Karte oder in der Liste nach.';
      case 'snackbar.distance_calculation.title':
        return 'Wie wird die Entfernung berechnet?';
      case 'snackbar.distance_calculation.subtitle':
        return 'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.';
      case 'snackbar.distance_calculation.subsubtitle':
        return 'Tippe um mehr zu erfahren.';
      case 'dialog.abort':
        return 'Abbrechen';
      case 'dialog.delete':
        return 'Löschen';
      case 'dialog.leave':
        return 'Verlassen';
      case 'dialog.logout':
        return 'Ausloggen';
      case 'dialog.ok':
        return 'Ok';
      case 'dialog.yes':
        return 'Ja';
      case 'dialog.no':
        return 'Nein';
      case 'dialog.share':
        return 'Teilen';
      case 'dialog.save':
        return 'Speichern';
      case 'dialog.open_settings':
        return 'Einstellungen öffnen';
      case 'dialog.share_location_parkings.title':
        return 'Teilen beenden';
      case 'dialog.share_location_parkings.content_1':
        return '';
      case 'dialog.share_location_parkings.content_2':
        return 'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';
      case 'dialog.share_location_parkings.deactivate':
        return 'Ausschalten';
      case 'dialog.distance.title':
        return 'Standort Entfernung';
      case 'dialog.distance.content':
        return ({required Object distance}) =>
            'Abstand zum Standort: ${distance}';
      case 'dialog.notifications.na.title':
        return 'Benachrichtigungen nicht verfügbar';
      case 'dialog.notifications.na.subtitle':
        return 'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.';
      case 'dialog.notifications.denied.title':
        return 'Benachrichtigungen verweigert';
      case 'dialog.notifications.denied.subtitle':
        return 'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.';
      case 'dialog.notifications.sent.title':
        return 'Auto geparkt';
      case 'dialog.notifications.expiring.title':
        return 'Dein Parkticket läuft bald ab';
      case 'dialog.notifications.expiring.subtitle':
        return ({required Object minutesLeft}) =>
            'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.';
      case 'dialog.car_bottom_sheet.sync.title':
        return 'Parkplatz synchronisieren';
      case 'dialog.car_bottom_sheet.sync.subtitle':
        return 'Möchtest du den Parkplatz synchronisieren?';
      case 'dialog.car_bottom_sheet.sync.action_1':
        return 'Synchronisieren';
      case 'dialog.car_bottom_sheet.synced.title':
        return 'Parkplatz synchronisiert';
      case 'dialog.car_bottom_sheet.synced.subtitle':
        return 'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?';
      case 'dialog.car_bottom_sheet.sharing.title':
        return 'Parkplatz teilen';
      case 'dialog.car_bottom_sheet.sharing.subtitle':
        return 'Lasse diesen QR Code scannen, um deinen Standort zu teilen';
      case 'dialog.car_bottom_sheet.sharing.action_1':
        return 'Link teilen';
      case 'dialog.car_bottom_sheet.sharing.share_content':
        return ({required Object woLink}) =>
            'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}';
      case 'dialog.maps.driving_mode.title':
        return 'Driving Modus erkannt';
      case 'dialog.maps.driving_mode.subtitle':
        return 'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?';
      case 'dialog.maps.location_denied.title':
        return 'Standortberechtigung verweigert';
      case 'dialog.maps.location_denied.subtitle':
        return 'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.';
      case 'dialog.history.info.title':
        return 'Historie';
      case 'dialog.history.info.subtitle':
        return 'Hier werden dir die letzten 15 Parkplätze angezeigt';
      case 'dialog.history.delete.title':
        return 'Lösche alle Einträge';
      case 'dialog.history.delete.subtitle':
        return 'Bist du sicher, dass du alle Einträge löschen möchtest?';
      case 'dialog.leave_info.title':
        return 'App verlassen';
      case 'dialog.leave_info.subtitle':
        return 'Bist du sicher, dass du die App verlassen möchtest?';
      case 'dialog.app_info.title':
        return 'App Info';
      case 'dialog.app_info.subtitle':
        return 'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.';
      case 'dialog.app_info.action_1':
        return 'GitHub';
      case 'dialog.feedback.title':
        return 'Feedback';
      case 'dialog.feedback.subtitle':
        return 'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:';
      case 'dialog.feedback.action_1':
        return 'Telegram';
      case 'dialog.data_security.title':
        return 'Datenschutz und Impressum';
      case 'dialog.data_security.content_1':
        return 'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 25.08.2024):';
      case 'dialog.data_security.content_2':
        return '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.';
      case 'dialog.data_security.content_3':
        return '- Die App kommuniziert mit meinem VPS Server auf Deutschem Boden, um synchronisierte Parkplätze anzuzeigen, anzulegen und zu verwalten. Zusätzlich deinen letzten Live Standort, aber auch nur sobald du es erlaubst.';
      case 'dialog.data_security.content_4':
        return '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.';
      case 'dialog.data_security.content_5':
        return '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ';
      case 'dialog.data_security.content_6':
        return 'nicht an Dritte weiter.';
      case 'dialog.data_security.content_7':
        return '\n\nEs findet ein Datenaustausch mit meinem Server und mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ';
      case 'dialog.data_security.content_8':
        return 'Die App speichert sont alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen, dann sind sie auch aus meinem Server gelöscht (in den Einstellungen ganz unten).';
      case 'dialog.data_security.action_1':
        return 'Impressum';
      case 'dialog.data_security.action_2':
        return 'Datenschutz';
      case 'dialog.app_data.title':
        return 'App Daten löschen';
      case 'dialog.app_data.subtitle':
        return 'Bist du sicher, dass du alle App Daten löschen? Dein Account bleibt bestehen.';
      case 'dialog.account_data.title':
        return 'Konto & Daten löschen';
      case 'dialog.account_data.content':
        return 'Hiermit wird dein Account gelöscht, mit samt allen Daten, die mit dir in Zusammenhang stecken, Parkplätze, Live Standorte etc. Außerdem werden alle App Daten gelöscht.';
      case 'dialog.logout_confirm':
        return 'Bist du dir sicher, dass du dich ausloggen möchtest?';
      case 'settings.title':
        return 'Einstellungen';
      case 'settings.theme.title':
        return 'Theme';
      case 'settings.theme.subtitle':
        return 'Wähle das Theme aus, das dir am besten gefällt.';
      case 'settings.theme.dropdown_1':
        return 'System';
      case 'settings.theme.dropdown_2':
        return 'Hell';
      case 'settings.theme.dropdown_3':
        return 'Dunkel';
      case 'settings.color.choice':
        return 'Farbe';
      case 'settings.map_type.title':
        return 'Karten Typ';
      case 'settings.map_type.subtitle':
        return 'Wähle den Karten Typ aus, der dir am besten gefällt.';
      case 'settings.map_type.dropdown_1':
        return 'Normal';
      case 'settings.map_type.dropdown_2':
        return 'Satellit';
      case 'settings.map_type.dropdown_3':
        return 'Hybrid';
      case 'settings.map_type.dropdown_4':
        return 'Terrain';
      case 'settings.traffic.title':
        return 'Verkehrslage';
      case 'settings.traffic.subtitle':
        return 'Zeige die aktuelle Verkehrslage auf der Karte an.';
      case 'settings.new_ios.title':
        return 'iOS Design';
      case 'settings.new_ios.subtitle':
        return 'Aktiviere das neue iOS Design mit Cupertino Widgets.';
      case 'settings.park_ticket.title':
        return 'Parkticket Zeitpuffer';
      case 'settings.park_ticket.subtitle':
        return 'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.';
      case 'settings.park_ticket.dropdown_value':
        return ({required Object value}) => '${value} Minuten';
      case 'settings.driving_mode.title':
        return 'Driving Modus Erkennung';
      case 'settings.driving_mode.subtitle':
        return 'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.';
      case 'settings.driving_mode.dropdown_value':
        return ({required Object value}) => '${value} km/h';
      case 'settings.app_info.title':
        return 'App Info';
      case 'settings.app_info.subtitle':
        return ({required Object appVersion, required Object buildNumber}) =>
            'Version ${appVersion}+${buildNumber}';
      case 'settings.credits.title':
        return 'Credits';
      case 'settings.credits.subtitle':
        return 'Dank an Google Maps API und natürlich an die Flutter Community.';
      case 'settings.woauto_server.title':
        return 'WoAuto Server (PocketBase)';
      case 'settings.woauto_server.subtitle':
        return ({required Object status}) => 'Server Status: ${status}';
      case 'settings.share.title':
        return 'App Teilen';
      case 'settings.share.subtitle':
        return 'Teile die App doch mit deinen Freunden und deiner Familie.';
      case 'settings.share.share_content':
        return 'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto';
      case 'settings.feedback.title':
        return 'Feedback';
      case 'settings.feedback.subtitle':
        return 'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?';
      case 'settings.data_security.title':
        return 'Datenschutz und Impressum';
      case 'settings.data_security.subtitle':
        return 'Erfahre wie deine Daten geschützt werden.';
      case 'settings.app_data.title':
        return 'Lösche alle App-Daten';
      case 'settings.app_data.subtitle':
        return 'Halte hier gedrückt, um all deine App-Daten zu löschen.';
      case 'settings.app_data.subtitle_ios':
        return 'Tippe hier, um all deine App-Daten zu löschen.';
      default:
        return null;
    }
  }
}
