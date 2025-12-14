///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsDe = Translations; // ignore: unused_element

class Translations with BaseTranslations<AppLocale, Translations> {
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

  /// de: 'WoAuto'
  String get app_name => 'WoAuto';

  /// de: 'Mein Auto'
  String get default_park_title => 'Mein Auto';

  /// de: 'Anderes Auto'
  String get default_shared_title => 'Anderes Auto';

  /// de: 'z.B. Parkdeck 2'
  String get default_park_info => 'z.B. Parkdeck 2';

  /// de: 'Keine Adresse gefunden'
  String get default_address => 'Keine Adresse gefunden';

  /// de: 'Adresse nicht gefunden.'
  String get address_na => 'Adresse nicht gefunden.';

  /// de: 'Aktualisieren'
  String get update => 'Aktualisieren';

  /// de: 'Fehler'
  String get error => 'Fehler';

  /// de: 'Es ist ein Fehler aufgetreten.'
  String get error_description => 'Es ist ein Fehler aufgetreten.';

  /// de: 'gerade eben geparkt'
  String get parked_rn => 'gerade eben geparkt';

  /// de: 'vor $duration geparkt'
  String parked_duration_string({required Object duration}) =>
      'vor ${duration} geparkt';

  /// de: 'Navigiere'
  String get navigate => 'Navigiere';
}

// Path: park_duration
class TranslationsParkDurationDe {
  TranslationsParkDurationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: '(one) {$n Stunde} (other) {$n Stunden}'
  String hours({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
        n,
        one: '${n} Stunde',
        other: '${n} Stunden',
      );

  /// de: '(one) {$n Minute} (other) {$n Minuten}'
  String minutes({required num n}) =>
      (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
        n,
        one: '${n} Minute',
        other: '${n} Minuten',
      );

  /// de: '(one) {$n Tag} (other) {$n Tage}'
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

  /// de: 'E-Mail'
  String get email => 'E-Mail';

  /// de: 'Passwort'
  String get password => 'Passwort';

  /// de: 'Bitte gebe etwas ein'
  String get empty_validation => 'Bitte gebe etwas ein';

  /// de: 'Bitte gebe eine gültige E-Mail Adresse ein'
  String get email_validation => 'Bitte gebe eine gültige E-Mail Adresse ein';

  /// de: 'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein'
  String get password_validation =>
      'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein';

  /// de: 'Passwort vergessen'
  String get password_forgot => 'Passwort vergessen';

  /// de: 'Generiere Passwort'
  String get password_generate => 'Generiere Passwort';

  /// de: 'Dein Passwort wird beim Generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!'
  String get password_generate_info =>
      'Dein Passwort wird beim Generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!';

  /// de: 'Registrieren'
  String get register => 'Registrieren';

  /// de: 'Einloggen'
  String get login => 'Einloggen';
}

// Path: park_dialog
class TranslationsParkDialogDe {
  TranslationsParkDialogDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Neuer Parkplatz'
  String get title => 'Neuer Parkplatz';

  /// de: 'Neuen Parkplatz speichern?'
  String get content_1 => 'Neuen Parkplatz speichern?';

  late final TranslationsParkDialogParkNameDe park_name =
      TranslationsParkDialogParkNameDe.internal(_root);

  /// de: 'Zusätzliche Infos'
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

  /// de: 'Parkplatz löschen'
  String get action_1 => 'Parkplatz löschen';
}

// Path: home
class TranslationsHomeDe {
  TranslationsHomeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Karte'
  String get navigation_1 => 'Karte';

  /// de: 'Mein Auto'
  String get navigation_2 => 'Mein Auto';

  /// de: 'Historie'
  String get navigation_3 => 'Historie';

  /// de: 'Einstellungen'
  String get navigation_4 => 'Einstellungen';

  late final TranslationsHomeQuickActionsDe quick_actions =
      TranslationsHomeQuickActionsDe.internal(_root);
}

// Path: history
class TranslationsHistoryDe {
  TranslationsHistoryDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Historie'
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

  /// de: 'Parkplatz speichern'
  String get park_save => 'Parkplatz speichern';

  /// de: 'Zur aktuellen Position'
  String get current_position => 'Zur aktuellen Position';

  /// de: 'Parkplätze'
  String get parkings => 'Parkplätze';

  /// de: 'Sync'
  String get badge_label => 'Sync';
}

// Path: top_header
class TranslationsTopHeaderDe {
  TranslationsTopHeaderDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Driving Modus'
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

  /// de: 'Mein Auto'
  String get title => 'Mein Auto';

  /// de: 'Einloggen oder jetzt Registrieren'
  String get login_register => 'Einloggen oder jetzt Registrieren';

  /// de: 'Das ist mein Auto! 🚗'
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

  /// de: 'Wenn du diese Einstellungen deaktivierst, wirst du nochmal nach einer Bestätigung der Aktion gefragt, da das ausschalten immer alle Daten vom Server zuerst löscht und dann das Speichern unterbindet, bis du es wieder einschaltest.'
  String get share_deactivate_info =>
      'Wenn du diese Einstellungen deaktivierst, wirst du nochmal nach einer Bestätigung der Aktion gefragt, da das ausschalten immer alle Daten vom Server zuerst löscht und dann das Speichern unterbindet, bis du es wieder einschaltest.';

  /// de: 'Teile meinen letzten Standort'
  String get share_my_last_location => 'Teile meinen letzten Standort';

  /// de: 'Während der App Nutzung wird dein Live-Standort auf unserem Server gespeichert und deine Freunde, nur sie, können ihn dann einsehen. Sobald die App geschlossen wurde, bleibt der zuletzt gesetzte Standort sichtbar.'
  String get share_my_last_location_description =>
      'Während der App Nutzung wird dein Live-Standort auf unserem Server gespeichert und deine Freunde, nur sie, können ihn dann einsehen. Sobald die App geschlossen wurde, bleibt der zuletzt gesetzte Standort sichtbar.';

  /// de: 'Wenn du dein Teilen beendest, wird erst dein Standort von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.'
  String get share_my_last_location_deactivate =>
      'Wenn du dein Teilen beendest, wird erst dein Standort von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';

  /// de: 'Teile meine Parkplätze'
  String get share_my_parkings => 'Teile meine Parkplätze';

  /// de: 'Hiermit werden deine Parkplätze in unseren Servern gespeichert und so können deine Freunde, nur sie, deine Parkplätze einsehen, niemals aber deine Parkplatzhistorie.'
  String get share_my_parkings_description =>
      'Hiermit werden deine Parkplätze in unseren Servern gespeichert und so können deine Freunde, nur sie, deine Parkplätze einsehen, niemals aber deine Parkplatzhistorie.';

  /// de: 'Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.'
  String get share_my_parkings_deactivate =>
      'Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';

  /// de: 'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.'
  String get secure_notice =>
      'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.';
}

// Path: maps
class TranslationsMapsDe {
  TranslationsMapsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Lädt Karte...'
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

  /// de: 'Foto auswählen'
  String get photo => 'Foto auswählen';

  /// de: 'Foto aufnehmen'
  String get camera => 'Foto aufnehmen';

  /// de: 'Foto löschen'
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

  /// de: 'Abbrechen'
  String get abort => 'Abbrechen';

  /// de: 'Löschen'
  String get delete => 'Löschen';

  /// de: 'Verlassen'
  String get leave => 'Verlassen';

  /// de: 'Ausloggen'
  String get logout => 'Ausloggen';

  /// de: 'Ok'
  String get ok => 'Ok';

  /// de: 'Ja'
  String get yes => 'Ja';

  /// de: 'Nein'
  String get no => 'Nein';

  /// de: 'Teilen'
  String get share => 'Teilen';

  /// de: 'Speichern'
  String get save => 'Speichern';

  /// de: 'Einstellungen öffnen'
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

  /// de: 'Bist du dir sicher, dass du dich ausloggen möchtest?'
  String get logout_confirm =>
      'Bist du dir sicher, dass du dich ausloggen möchtest?';
}

// Path: settings
class TranslationsSettingsDe {
  TranslationsSettingsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Einstellungen'
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

  /// de: 'Name'
  String get label => 'Name';
}

// Path: park_dialog.info
class TranslationsParkDialogInfoDe {
  TranslationsParkDialogInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Info'
  String get label => 'Info';
}

// Path: park_dialog.ticket
class TranslationsParkDialogTicketDe {
  TranslationsParkDialogTicketDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Parkticket'
  String get title => 'Parkticket';

  /// de: 'Parkticket läuft ab um'
  String get help => 'Parkticket läuft ab um';

  /// de: 'Parkticket gilt bis $time Uhr'
  String until({required Object time}) => 'Parkticket gilt bis ${time} Uhr';
}

// Path: park_dialog.photo
class TranslationsParkDialogPhotoDe {
  TranslationsParkDialogPhotoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Foto'
  String get title => 'Foto';
}

// Path: marker_dialog.shared
class TranslationsMarkerDialogSharedDe {
  TranslationsMarkerDialogSharedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Dieser Parkplatz wurde dir geteilt. Das Auto steht an folgender Adresse: $address.'
  String content({required Object address}) =>
      'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.';
}

// Path: marker_dialog.mine
class TranslationsMarkerDialogMineDe {
  TranslationsMarkerDialogMineDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Du hast $formattedDate. Dein Auto steht an folgender Adresse: $address. $description'
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

  /// de: 'Parkplätze ansehen'
  String get action_parkings => 'Parkplätze ansehen';

  /// de: 'Parkplatz speichern'
  String get action_save => 'Parkplatz speichern';
}

// Path: history.empty
class TranslationsHistoryEmptyDe {
  TranslationsHistoryEmptyDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Keine Einträge'
  String get title => 'Keine Einträge';

  /// de: 'Du hast noch keine Einträge in deiner Historie.'
  String get subtitle => 'Du hast noch keine Einträge in deiner Historie.';
}

// Path: history.export
class TranslationsHistoryExportDe {
  TranslationsHistoryExportDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Exportiere als CSV'
  String get title => 'Exportiere als CSV';

  /// de: 'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.'
  String get subtitle =>
      'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.';
}

// Path: history.delete
class TranslationsHistoryDeleteDe {
  TranslationsHistoryDeleteDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Lösche alle Einträge'
  String get title => 'Lösche alle Einträge';

  /// de: 'Lösche alle Einträge in deiner Historie.'
  String get subtitle => 'Lösche alle Einträge in deiner Historie.';
}

// Path: car_bottom_sheet.empty
class TranslationsCarBottomSheetEmptyDe {
  TranslationsCarBottomSheetEmptyDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Du hast keine Parkplätze.'
  String get parkings => 'Du hast keine Parkplätze.';

  /// de: 'Du hast keine geteilten Parkplätze.'
  String get shared_parkings => 'Du hast keine geteilten Parkplätze.';
}

// Path: car_bottom_sheet.distance_calculation
class TranslationsCarBottomSheetDistanceCalculationDe {
  TranslationsCarBottomSheetDistanceCalculationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Wie wird die Entfernung berechnet, fragst du dich?'
  String get title => 'Wie wird die Entfernung berechnet, fragst du dich?';
}

// Path: car_bottom_sheet.you
class TranslationsCarBottomSheetYouDe {
  TranslationsCarBottomSheetYouDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Du'
  String get title => 'Du';

  /// de: 'Bei dir'
  String get address => 'Bei dir';
}

// Path: car_bottom_sheet.friends
class TranslationsCarBottomSheetFriendsDe {
  TranslationsCarBottomSheetFriendsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Freunde'
  String get title => 'Freunde';

  /// de: 'Parkplatz'
  String get park => 'Parkplatz';
}

// Path: car_bottom_sheet.menu
class TranslationsCarBottomSheetMenuDe {
  TranslationsCarBottomSheetMenuDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Karten App öffnen'
  String get open_park_in_maps => 'Karten App öffnen';

  /// de: 'Parkplatz teilen'
  String get share_park => 'Parkplatz teilen';

  /// de: 'Zum Parkplatz'
  String get to_park => 'Zum Parkplatz';

  /// de: 'Parkplatz löschen'
  String get delete_park => 'Parkplatz löschen';
}

// Path: my_car.built
class TranslationsMyCarBuiltDe {
  TranslationsMyCarBuiltDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Baujahr: $baujahr ($jahre Jahre)'
  String title({required Object baujahr, required Object jahre}) =>
      'Baujahr: ${baujahr} (${jahre} Jahre)';

  /// de: 'Baujahr: $baujahr'
  String title_short({required Object baujahr}) => 'Baujahr: ${baujahr}';

  /// de: 'Baujahr'
  String get title_dialog => 'Baujahr';

  /// de: 'Ändere das Baujahr deines Autos.'
  String get subtitle => 'Ändere das Baujahr deines Autos.';

  /// de: '2002'
  String get default_year => '2002';

  /// de: 'Bitte gib ein gültiges Baujahr ein'
  String get validate_null => 'Bitte gib ein gültiges Baujahr ein';

  /// de: 'Bitte gib ein gültiges Baujahr zwischen 1900 und $year ein'
  String validate_year({required Object year}) =>
      'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein';
}

// Path: my_car.driven
class TranslationsMyCarDrivenDe {
  TranslationsMyCarDrivenDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: '$km km gefahren'
  String title({required Object km}) => '${km} km gefahren';

  /// de: 'Kilometerstand: $km'
  String title_short({required Object km}) => 'Kilometerstand: ${km}';

  /// de: 'Kilometerstand'
  String get title_dialog => 'Kilometerstand';

  /// de: 'Ändere den Kilometerstand deines Autos.'
  String get subtitle => 'Ändere den Kilometerstand deines Autos.';

  /// de: '123456'
  String get hint => '123456';
}

// Path: my_car.plate
class TranslationsMyCarPlateDe {
  TranslationsMyCarPlateDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Kennzeichen: $plate'
  String title({required Object plate}) => 'Kennzeichen: ${plate}';

  /// de: 'Ändere das Kennzeichen deines Autos.'
  String get subtitle => 'Ändere das Kennzeichen deines Autos.';

  /// de: 'Kennzeichen'
  String get title_short => 'Kennzeichen';

  /// de: 'B-DE-1234'
  String get hint => 'B-DE-1234';
}

// Path: my_car.park_name
class TranslationsMyCarParkNameDe {
  TranslationsMyCarParkNameDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Titel: $name'
  String title({required Object name}) => 'Titel: ${name}';

  /// de: 'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW'
  String get subtitle =>
      'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW';

  /// de: 'Name des Parkplatzes'
  String get park_title => 'Name des Parkplatzes';
}

// Path: my_car.tuv
class TranslationsMyCarTuvDe {
  TranslationsMyCarTuvDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'TÜV bis $date'
  String title({required Object date}) => 'TÜV bis ${date}';

  /// de: 'Ändere das Datum, an dem dein TÜV abläuft'
  String get subtitle => 'Ändere das Datum, an dem dein TÜV abläuft';

  /// de: 'Gebe als Tag den "1." an, also z.B. "1.1.2022"'
  String get help => 'Gebe als Tag den "1." an, also z.B. "1.1.2022"';

  /// de: 'Zum Kalender hinzufügen'
  String get add_to_calender => 'Zum Kalender hinzufügen';

  /// de: 'TÜV abgelaufen'
  String get calender_title => 'TÜV abgelaufen';

  /// de: 'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin. Lg. Dein WoAuto-Team'
  String get calender_content =>
      'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team';

  /// de: 'Dein TÜV ist abgelaufen!'
  String get expired_info => 'Dein TÜV ist abgelaufen!';

  /// de: 'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.'
  String get expiring_info =>
      'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.';
}

// Path: maps.traffic
class TranslationsMapsTrafficDe {
  TranslationsMapsTrafficDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Verkehr anzeigen'
  String get show => 'Verkehr anzeigen';

  /// de: 'Verkehr ausblenden'
  String get hide => 'Verkehr ausblenden';
}

// Path: intro.page_1
class TranslationsIntroPage1De {
  TranslationsIntroPage1De.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'WoAuto'
  String get page_title => 'WoAuto';

  /// de: 'Willkommen bei WoAuto'
  String get title => 'Willkommen bei WoAuto';

  /// de: 'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.'
  String get content_1 =>
      'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.';

  /// de: 'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.'
  String get content_2 =>
      'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.';

  /// de: 'Speichere in nur 2 Klicks deinen Parkplatz.'
  String get content_3 => 'Speichere in nur 2 Klicks deinen Parkplatz.';

  /// de: 'Weiter'
  String get action_1 => 'Weiter';
}

// Path: intro.page_2
class TranslationsIntroPage2De {
  TranslationsIntroPage2De.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'App-Voreinstellungen'
  String get page_title => 'App-Voreinstellungen';

  /// de: 'Name für dein Auto setzen'
  String get parking_title => 'Name für dein Auto setzen';

  /// de: 'Gib deinem Auto einen coolen Namen.'
  String get parking_content => 'Gib deinem Auto einen coolen Namen.';

  /// de: 'Mein Auto'
  String get parking_hint => 'Mein Auto';

  /// de: 'App-Theme einstellen'
  String get theme_title => 'App-Theme einstellen';

  /// de: 'Wähle das Theme aus, das dir am besten gefällt.'
  String get theme_content => 'Wähle das Theme aus, das dir am besten gefällt.';

  /// de: 'Echtzeit-Standortberechtigung erlauben'
  String get location_title => 'Echtzeit-Standortberechtigung erlauben';

  /// de: 'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.'
  String get location_content =>
      'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.';

  /// de: 'Echtzeit-Standortberechtigung'
  String get location_checkbox => 'Echtzeit-Standortberechtigung';

  /// de: 'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.'
  String get location_checkbox_error =>
      'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.';

  /// de: 'Benachrichtigungen (optional)'
  String get notification_checkbox => 'Benachrichtigungen (optional)';

  /// de: 'Geplante Benachrichtigungen (optional)'
  String get exact_notification_checkbox =>
      'Geplante Benachrichtigungen (optional)';

  /// de: 'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.'
  String get exact_notification_description =>
      'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.';

  /// de: 'Fertig'
  String get action_1 => 'Fertig';
}

// Path: snackbar.locked
class TranslationsSnackbarLockedDe {
  TranslationsSnackbarLockedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Hast du dein Auto abgeschlossen?'
  String get title => 'Hast du dein Auto abgeschlossen?';

  /// de: 'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.'
  String get subtitle =>
      'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.';

  /// de: 'Ja, hab' ich'
  String get action => 'Ja, hab\' ich';
}

// Path: snackbar.shared_parking
class TranslationsSnackbarSharedParkingDe {
  TranslationsSnackbarSharedParkingDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Ein geteilter Online Parkplatz wurde hinzugefügt'
  String get title => 'Ein geteilter Online Parkplatz wurde hinzugefügt';

  /// de: 'Schaue auf der Karte oder in der Liste nach.'
  String get subtitle => 'Schaue auf der Karte oder in der Liste nach.';
}

// Path: snackbar.distance_calculation
class TranslationsSnackbarDistanceCalculationDe {
  TranslationsSnackbarDistanceCalculationDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Wie wird die Entfernung berechnet?'
  String get title => 'Wie wird die Entfernung berechnet?';

  /// de: 'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.'
  String get subtitle =>
      'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.';

  /// de: 'Tippe um mehr zu erfahren.'
  String get subsubtitle => 'Tippe um mehr zu erfahren.';
}

// Path: dialog.share_location_parkings
class TranslationsDialogShareLocationParkingsDe {
  TranslationsDialogShareLocationParkingsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Teilen beenden'
  String get title => 'Teilen beenden';

  /// de: ''
  String get content_1 => '';

  /// de: 'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.'
  String get content_2 =>
      'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.';

  /// de: 'Ausschalten'
  String get deactivate => 'Ausschalten';
}

// Path: dialog.distance
class TranslationsDialogDistanceDe {
  TranslationsDialogDistanceDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Standort Entfernung'
  String get title => 'Standort Entfernung';

  /// de: 'Abstand zum Standort: $distance'
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

  /// de: 'App verlassen'
  String get title => 'App verlassen';

  /// de: 'Bist du sicher, dass du die App verlassen möchtest?'
  String get subtitle => 'Bist du sicher, dass du die App verlassen möchtest?';
}

// Path: dialog.app_info
class TranslationsDialogAppInfoDe {
  TranslationsDialogAppInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'App Info'
  String get title => 'App Info';

  /// de: 'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.'
  String get subtitle =>
      'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.';

  /// de: 'GitHub'
  String get action_1 => 'GitHub';
}

// Path: dialog.feedback
class TranslationsDialogFeedbackDe {
  TranslationsDialogFeedbackDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Feedback'
  String get title => 'Feedback';

  /// de: 'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:'
  String get subtitle =>
      'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:';

  /// de: 'Telegram'
  String get action_1 => 'Telegram';
}

// Path: dialog.data_security
class TranslationsDialogDataSecurityDe {
  TranslationsDialogDataSecurityDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Datenschutz und Impressum'
  String get title => 'Datenschutz und Impressum';

  /// de: 'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 14. Dezember 2025):'
  String get content_1 =>
      'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 14. Dezember 2025):';

  /// de: '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.'
  String get content_2 =>
      '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.';

  /// de: '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.'
  String get content_4 =>
      '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.';

  /// de: '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber '
  String get content_5 =>
      '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ';

  /// de: 'nicht an Dritte weiter.'
  String get content_6 => 'nicht an Dritte weiter.';

  /// de: ' Es findet ein Datenaustausch mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. '
  String get content_7 =>
      '\n\nEs findet ein Datenaustausch mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ';

  /// de: 'Die App speichert alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen.'
  String get content_8 =>
      'Die App speichert alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen.';

  /// de: 'Impressum'
  String get action_1 => 'Impressum';

  /// de: 'Datenschutz'
  String get action_2 => 'Datenschutz';
}

// Path: dialog.app_data
class TranslationsDialogAppDataDe {
  TranslationsDialogAppDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'App Daten löschen'
  String get title => 'App Daten löschen';

  /// de: 'Bist du sicher, dass du alle App Daten löschen? Dein Account bleibt bestehen.'
  String get subtitle =>
      'Bist du sicher, dass du alle App Daten löschen? Dein Account bleibt bestehen.';
}

// Path: dialog.account_data
class TranslationsDialogAccountDataDe {
  TranslationsDialogAccountDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Konto & Daten löschen'
  String get title => 'Konto & Daten löschen';

  /// de: 'Hiermit wird dein Account gelöscht, mit samt allen Daten, die mit dir in Zusammenhang stecken, Parkplätze, Live Standorte etc. Außerdem werden alle App Daten gelöscht.'
  String get content =>
      'Hiermit wird dein Account gelöscht, mit samt allen Daten, die mit dir in Zusammenhang stecken, Parkplätze, Live Standorte etc. Außerdem werden alle App Daten gelöscht.';
}

// Path: settings.theme
class TranslationsSettingsThemeDe {
  TranslationsSettingsThemeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Theme'
  String get title => 'Theme';

  /// de: 'Wähle das Theme aus, das dir am besten gefällt.'
  String get subtitle => 'Wähle das Theme aus, das dir am besten gefällt.';

  /// de: 'System'
  String get dropdown_1 => 'System';

  /// de: 'Hell'
  String get dropdown_2 => 'Hell';

  /// de: 'Dunkel'
  String get dropdown_3 => 'Dunkel';
}

// Path: settings.color
class TranslationsSettingsColorDe {
  TranslationsSettingsColorDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Farbe'
  String get choice => 'Farbe';
}

// Path: settings.map_type
class TranslationsSettingsMapTypeDe {
  TranslationsSettingsMapTypeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Karten Typ'
  String get title => 'Karten Typ';

  /// de: 'Wähle den Karten Typ aus, der dir am besten gefällt.'
  String get subtitle => 'Wähle den Karten Typ aus, der dir am besten gefällt.';

  /// de: 'Normal'
  String get dropdown_1 => 'Normal';

  /// de: 'Satellit'
  String get dropdown_2 => 'Satellit';

  /// de: 'Hybrid'
  String get dropdown_3 => 'Hybrid';

  /// de: 'Terrain'
  String get dropdown_4 => 'Terrain';
}

// Path: settings.traffic
class TranslationsSettingsTrafficDe {
  TranslationsSettingsTrafficDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Verkehrslage'
  String get title => 'Verkehrslage';

  /// de: 'Zeige die aktuelle Verkehrslage auf der Karte an.'
  String get subtitle => 'Zeige die aktuelle Verkehrslage auf der Karte an.';
}

// Path: settings.new_ios
class TranslationsSettingsNewIosDe {
  TranslationsSettingsNewIosDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'iOS Design'
  String get title => 'iOS Design';

  /// de: 'Aktiviere das neue iOS Design mit Cupertino Widgets.'
  String get subtitle => 'Aktiviere das neue iOS Design mit Cupertino Widgets.';
}

// Path: settings.park_ticket
class TranslationsSettingsParkTicketDe {
  TranslationsSettingsParkTicketDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Parkticket Zeitpuffer'
  String get title => 'Parkticket Zeitpuffer';

  /// de: 'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.'
  String get subtitle =>
      'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.';

  /// de: '$value Minuten'
  String dropdown_value({required Object value}) => '${value} Minuten';
}

// Path: settings.driving_mode
class TranslationsSettingsDrivingModeDe {
  TranslationsSettingsDrivingModeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Driving Modus Erkennung'
  String get title => 'Driving Modus Erkennung';

  /// de: 'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.'
  String get subtitle =>
      'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.';

  /// de: '$value km/h'
  String dropdown_value({required Object value}) => '${value} km/h';
}

// Path: settings.app_info
class TranslationsSettingsAppInfoDe {
  TranslationsSettingsAppInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'App Info'
  String get title => 'App Info';

  /// de: 'Version $appVersion+$buildNumber'
  String subtitle({required Object appVersion, required Object buildNumber}) =>
      'Version ${appVersion}+${buildNumber}';
}

// Path: settings.credits
class TranslationsSettingsCreditsDe {
  TranslationsSettingsCreditsDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Credits'
  String get title => 'Credits';

  /// de: 'Dank an Google Maps API und natürlich an die Flutter Community.'
  String get subtitle =>
      'Dank an Google Maps API und natürlich an die Flutter Community.';
}

// Path: settings.woauto_server
class TranslationsSettingsWoautoServerDe {
  TranslationsSettingsWoautoServerDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'WoAuto Server (PocketBase)'
  String get title => 'WoAuto Server (PocketBase)';

  /// de: 'Server Status: $status'
  String subtitle({required Object status}) => 'Server Status: ${status}';
}

// Path: settings.share
class TranslationsSettingsShareDe {
  TranslationsSettingsShareDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'App Teilen'
  String get title => 'App Teilen';

  /// de: 'Teile die App doch mit deinen Freunden und deiner Familie.'
  String get subtitle =>
      'Teile die App doch mit deinen Freunden und deiner Familie.';

  /// de: 'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren. Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät. Warum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto'
  String get share_content =>
      'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto';
}

// Path: settings.feedback
class TranslationsSettingsFeedbackDe {
  TranslationsSettingsFeedbackDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Feedback'
  String get title => 'Feedback';

  /// de: 'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?'
  String get subtitle =>
      'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?';
}

// Path: settings.data_security
class TranslationsSettingsDataSecurityDe {
  TranslationsSettingsDataSecurityDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Datenschutz und Impressum'
  String get title => 'Datenschutz und Impressum';

  /// de: 'Erfahre wie deine Daten geschützt werden.'
  String get subtitle => 'Erfahre wie deine Daten geschützt werden.';
}

// Path: settings.app_data
class TranslationsSettingsAppDataDe {
  TranslationsSettingsAppDataDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Lösche alle App-Daten'
  String get title => 'Lösche alle App-Daten';

  /// de: 'Halte hier gedrückt, um all deine App-Daten zu löschen.'
  String get subtitle =>
      'Halte hier gedrückt, um all deine App-Daten zu löschen.';

  /// de: 'Tippe hier, um all deine App-Daten zu löschen.'
  String get subtitle_ios => 'Tippe hier, um all deine App-Daten zu löschen.';
}

// Path: dialog.notifications.na
class TranslationsDialogNotificationsNaDe {
  TranslationsDialogNotificationsNaDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Benachrichtigungen nicht verfügbar'
  String get title => 'Benachrichtigungen nicht verfügbar';

  /// de: 'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.'
  String get subtitle =>
      'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.';
}

// Path: dialog.notifications.denied
class TranslationsDialogNotificationsDeniedDe {
  TranslationsDialogNotificationsDeniedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Benachrichtigungen verweigert'
  String get title => 'Benachrichtigungen verweigert';

  /// de: 'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.'
  String get subtitle =>
      'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.';
}

// Path: dialog.notifications.sent
class TranslationsDialogNotificationsSentDe {
  TranslationsDialogNotificationsSentDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Auto geparkt'
  String get title => 'Auto geparkt';
}

// Path: dialog.notifications.expiring
class TranslationsDialogNotificationsExpiringDe {
  TranslationsDialogNotificationsExpiringDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Dein Parkticket läuft bald ab'
  String get title => 'Dein Parkticket läuft bald ab';

  /// de: 'In ca. $minutesLeft Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.'
  String subtitle({required Object minutesLeft}) =>
      'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.';
}

// Path: dialog.car_bottom_sheet.sync
class TranslationsDialogCarBottomSheetSyncDe {
  TranslationsDialogCarBottomSheetSyncDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Parkplatz synchronisieren'
  String get title => 'Parkplatz synchronisieren';

  /// de: 'Möchtest du den Parkplatz synchronisieren?'
  String get subtitle => 'Möchtest du den Parkplatz synchronisieren?';

  /// de: 'Synchronisieren'
  String get action_1 => 'Synchronisieren';
}

// Path: dialog.car_bottom_sheet.synced
class TranslationsDialogCarBottomSheetSyncedDe {
  TranslationsDialogCarBottomSheetSyncedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Parkplatz synchronisiert'
  String get title => 'Parkplatz synchronisiert';

  /// de: 'Dieser Parkplatz ist nun auf den Servern von WoAuto. Möchtest du den Parkplatz teilen?'
  String get subtitle =>
      'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?';
}

// Path: dialog.car_bottom_sheet.sharing
class TranslationsDialogCarBottomSheetSharingDe {
  TranslationsDialogCarBottomSheetSharingDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Parkplatz teilen'
  String get title => 'Parkplatz teilen';

  /// de: 'Lasse diesen QR Code scannen, um deinen Standort zu teilen'
  String get subtitle =>
      'Lasse diesen QR Code scannen, um deinen Standort zu teilen';

  /// de: 'Link teilen'
  String get action_1 => 'Link teilen';

  /// de: 'Hier ist mein synchronisierter Parkplatz: $woLink'
  String share_content({required Object woLink}) =>
      'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}';
}

// Path: dialog.maps.driving_mode
class TranslationsDialogMapsDrivingModeDe {
  TranslationsDialogMapsDrivingModeDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Driving Modus erkannt'
  String get title => 'Driving Modus erkannt';

  /// de: 'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?'
  String get subtitle =>
      'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?';
}

// Path: dialog.maps.location_denied
class TranslationsDialogMapsLocationDeniedDe {
  TranslationsDialogMapsLocationDeniedDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Standortberechtigung verweigert'
  String get title => 'Standortberechtigung verweigert';

  /// de: 'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.'
  String get subtitle =>
      'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.';
}

// Path: dialog.history.info
class TranslationsDialogHistoryInfoDe {
  TranslationsDialogHistoryInfoDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Historie'
  String get title => 'Historie';

  /// de: 'Hier werden dir die letzten 15 Parkplätze angezeigt'
  String get subtitle => 'Hier werden dir die letzten 15 Parkplätze angezeigt';
}

// Path: dialog.history.delete
class TranslationsDialogHistoryDeleteDe {
  TranslationsDialogHistoryDeleteDe.internal(this._root);

  final Translations _root; // ignore: unused_field

  // Translations

  /// de: 'Lösche alle Einträge'
  String get title => 'Lösche alle Einträge';

  /// de: 'Bist du sicher, dass du alle Einträge löschen möchtest?'
  String get subtitle =>
      'Bist du sicher, dass du alle Einträge löschen möchtest?';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
      'constants.app_name' => 'WoAuto',
      'constants.default_park_title' => 'Mein Auto',
      'constants.default_shared_title' => 'Anderes Auto',
      'constants.default_park_info' => 'z.B. Parkdeck 2',
      'constants.default_address' => 'Keine Adresse gefunden',
      'constants.address_na' => 'Adresse nicht gefunden.',
      'constants.update' => 'Aktualisieren',
      'constants.error' => 'Fehler',
      'constants.error_description' => 'Es ist ein Fehler aufgetreten.',
      'constants.parked_rn' => 'gerade eben geparkt',
      'constants.parked_duration_string' => ({required Object duration}) =>
          'vor ${duration} geparkt',
      'constants.navigate' => 'Navigiere',
      'park_duration.hours' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
            n,
            one: '${n} Stunde',
            other: '${n} Stunden',
          ),
      'park_duration.minutes' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
            n,
            one: '${n} Minute',
            other: '${n} Minuten',
          ),
      'park_duration.days' => ({required num n}) =>
          (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(
            n,
            one: '${n} Tag',
            other: '${n} Tage',
          ),
      'login_dialog.email' => 'E-Mail',
      'login_dialog.password' => 'Passwort',
      'login_dialog.empty_validation' => 'Bitte gebe etwas ein',
      'login_dialog.email_validation' =>
        'Bitte gebe eine gültige E-Mail Adresse ein',
      'login_dialog.password_validation' =>
        'Bitte gebe eine sicheres mind. 10-stelliges Passwort ein',
      'login_dialog.password_forgot' => 'Passwort vergessen',
      'login_dialog.password_generate' => 'Generiere Passwort',
      'login_dialog.password_generate_info' =>
        'Dein Passwort wird beim Generieren in das Textfeld eingefügt. Es wird nicht von uns gespeichert! Guck dir den Code an, wenn du dir nicht sicher bist!',
      'login_dialog.register' => 'Registrieren',
      'login_dialog.login' => 'Einloggen',
      'park_dialog.title' => 'Neuer Parkplatz',
      'park_dialog.content_1' => 'Neuen Parkplatz speichern?',
      'park_dialog.park_name.label' => 'Name',
      'park_dialog.content_2' => 'Zusätzliche Infos',
      'park_dialog.info.label' => 'Info',
      'park_dialog.ticket.title' => 'Parkticket',
      'park_dialog.ticket.help' => 'Parkticket läuft ab um',
      'park_dialog.ticket.until' => ({required Object time}) =>
          'Parkticket gilt bis ${time} Uhr',
      'park_dialog.photo.title' => 'Foto',
      'marker_dialog.shared.content' => ({required Object address}) =>
          'Dieser Parkplatz wurde dir geteilt.\n\nDas Auto steht an folgender Adresse:\n${address}.',
      'marker_dialog.mine.content' => (
              {required Object formattedDate,
              required Object address,
              required Object description}) =>
          'Du hast ${formattedDate}.\n\nDein Auto steht an folgender Adresse:\n${address}.\n${description}',
      'marker_dialog.action_1' => 'Parkplatz löschen',
      'home.navigation_1' => 'Karte',
      'home.navigation_2' => 'Mein Auto',
      'home.navigation_3' => 'Historie',
      'home.navigation_4' => 'Einstellungen',
      'home.quick_actions.action_parkings' => 'Parkplätze ansehen',
      'home.quick_actions.action_save' => 'Parkplatz speichern',
      'history.title' => 'Historie',
      'history.empty.title' => 'Keine Einträge',
      'history.empty.subtitle' =>
        'Du hast noch keine Einträge in deiner Historie.',
      'history.export.title' => 'Exportiere als CSV',
      'history.export.subtitle' =>
        'Exportiere deine Historie als CSV-Datei. Hier werden alle alte Parkplätze exportiert.',
      'history.delete.title' => 'Lösche alle Einträge',
      'history.delete.subtitle' => 'Lösche alle Einträge in deiner Historie.',
      'info_sheet.park_save' => 'Parkplatz speichern',
      'info_sheet.current_position' => 'Zur aktuellen Position',
      'info_sheet.parkings' => 'Parkplätze',
      'info_sheet.badge_label' => 'Sync',
      'top_header.driving_mode_tooltip' => 'Driving Modus',
      'car_bottom_sheet.empty.parkings' => 'Du hast keine Parkplätze.',
      'car_bottom_sheet.empty.shared_parkings' =>
        'Du hast keine geteilten Parkplätze.',
      'car_bottom_sheet.distance_calculation.title' =>
        'Wie wird die Entfernung berechnet, fragst du dich?',
      'car_bottom_sheet.you.title' => 'Du',
      'car_bottom_sheet.you.address' => 'Bei dir',
      'car_bottom_sheet.friends.title' => 'Freunde',
      'car_bottom_sheet.friends.park' => 'Parkplatz',
      'car_bottom_sheet.menu.open_park_in_maps' => 'Karten App öffnen',
      'car_bottom_sheet.menu.share_park' => 'Parkplatz teilen',
      'car_bottom_sheet.menu.to_park' => 'Zum Parkplatz',
      'car_bottom_sheet.menu.delete_park' => 'Parkplatz löschen',
      'my_car.title' => 'Mein Auto',
      'my_car.login_register' => 'Einloggen oder jetzt Registrieren',
      'my_car.shared_content' => 'Das ist mein Auto! 🚗',
      'my_car.built.title' => (
              {required Object baujahr, required Object jahre}) =>
          'Baujahr: ${baujahr} (${jahre} Jahre)',
      'my_car.built.title_short' => ({required Object baujahr}) =>
          'Baujahr: ${baujahr}',
      'my_car.built.title_dialog' => 'Baujahr',
      'my_car.built.subtitle' => 'Ändere das Baujahr deines Autos.',
      'my_car.built.default_year' => '2002',
      'my_car.built.validate_null' => 'Bitte gib ein gültiges Baujahr ein',
      'my_car.built.validate_year' => ({required Object year}) =>
          'Bitte gib ein gültiges Baujahr zwischen 1900 und ${year} ein',
      'my_car.driven.title' => ({required Object km}) => '${km} km gefahren',
      'my_car.driven.title_short' => ({required Object km}) =>
          'Kilometerstand: ${km}',
      'my_car.driven.title_dialog' => 'Kilometerstand',
      'my_car.driven.subtitle' => 'Ändere den Kilometerstand deines Autos.',
      'my_car.driven.hint' => '123456',
      'my_car.plate.title' => ({required Object plate}) =>
          'Kennzeichen: ${plate}',
      'my_car.plate.subtitle' => 'Ändere das Kennzeichen deines Autos.',
      'my_car.plate.title_short' => 'Kennzeichen',
      'my_car.plate.hint' => 'B-DE-1234',
      'my_car.park_name.title' => ({required Object name}) => 'Titel: ${name}',
      'my_car.park_name.subtitle' =>
        'Ändere den Titel, der auf deinem Parkplatz steht, z.B: Mercedes, Audi oder BMW',
      'my_car.park_name.park_title' => 'Name des Parkplatzes',
      'my_car.tuv.title' => ({required Object date}) => 'TÜV bis ${date}',
      'my_car.tuv.subtitle' => 'Ändere das Datum, an dem dein TÜV abläuft',
      'my_car.tuv.help' => 'Gebe als Tag den "1." an, also z.B. "1.1.2022"',
      'my_car.tuv.add_to_calender' => 'Zum Kalender hinzufügen',
      'my_car.tuv.calender_title' => 'TÜV abgelaufen',
      'my_car.tuv.calender_content' =>
        'Dein TÜV ist abgelaufen! Bitte vereinbare einen Termin.\n\nLg. Dein WoAuto-Team',
      'my_car.tuv.expired_info' => 'Dein TÜV ist abgelaufen!',
      'my_car.tuv.expiring_info' =>
        'Dein TÜV läuft bald ab! Bitte vereinbare einen Termin.',
      'my_car.share_deactivate_info' =>
        'Wenn du diese Einstellungen deaktivierst, wirst du nochmal nach einer Bestätigung der Aktion gefragt, da das ausschalten immer alle Daten vom Server zuerst löscht und dann das Speichern unterbindet, bis du es wieder einschaltest.',
      'my_car.share_my_last_location' => 'Teile meinen letzten Standort',
      'my_car.share_my_last_location_description' =>
        'Während der App Nutzung wird dein Live-Standort auf unserem Server gespeichert und deine Freunde, nur sie, können ihn dann einsehen. Sobald die App geschlossen wurde, bleibt der zuletzt gesetzte Standort sichtbar.',
      'my_car.share_my_last_location_deactivate' =>
        'Wenn du dein Teilen beendest, wird erst dein Standort von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.',
      'my_car.share_my_parkings' => 'Teile meine Parkplätze',
      'my_car.share_my_parkings_description' =>
        'Hiermit werden deine Parkplätze in unseren Servern gespeichert und so können deine Freunde, nur sie, deine Parkplätze einsehen, niemals aber deine Parkplatzhistorie.',
      'my_car.share_my_parkings_deactivate' =>
        'Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.',
      'my_car.secure_notice' =>
        'Deine privaten Auto-Daten werden lokal auf deinem Gerät gespeichert. Wir haben keinen Zugriff auf deine Daten. Du kannst deine Daten außerdem jederzeit in den Einstellungen löschen.',
      'maps.loading' => 'Lädt Karte...',
      'maps.traffic.show' => 'Verkehr anzeigen',
      'maps.traffic.hide' => 'Verkehr ausblenden',
      'intro.page_1.page_title' => 'WoAuto',
      'intro.page_1.title' => 'Willkommen bei WoAuto',
      'intro.page_1.content_1' =>
        'Mit WoAuto kannst du deinen Parkplatz speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.',
      'intro.page_1.content_2' =>
        'Dein Parkplatz ist sicher und bleibt immer auf deinem Gerät.',
      'intro.page_1.content_3' => 'Speichere in nur 2 Klicks deinen Parkplatz.',
      'intro.page_1.action_1' => 'Weiter',
      'intro.page_2.page_title' => 'App-Voreinstellungen',
      'intro.page_2.parking_title' => 'Name für dein Auto setzen',
      'intro.page_2.parking_content' => 'Gib deinem Auto einen coolen Namen.',
      'intro.page_2.parking_hint' => 'Mein Auto',
      'intro.page_2.theme_title' => 'App-Theme einstellen',
      'intro.page_2.theme_content' =>
        'Wähle das Theme aus, das dir am besten gefällt.',
      'intro.page_2.location_title' => 'Echtzeit-Standortberechtigung erlauben',
      'intro.page_2.location_content' =>
        'Damit WoAuto deinen Standort speichern kann, musst du die Echtzeit-Standortberechtigung erlauben. Dies ist notwendig, um deinen Parkplatz zu finden und die Karte zu laden.',
      'intro.page_2.location_checkbox' => 'Echtzeit-Standortberechtigung',
      'intro.page_2.location_checkbox_error' =>
        'Bitte erlaube der App, deinen Standort während der App-Nutzung abzufragen.',
      'intro.page_2.notification_checkbox' => 'Benachrichtigungen (optional)',
      'intro.page_2.exact_notification_checkbox' =>
        'Geplante Benachrichtigungen (optional)',
      'intro.page_2.exact_notification_description' =>
        'Erhalte somit Benachrichtigungen, wenn dein Parkticket bald abläuft.',
      'intro.page_2.action_1' => 'Fertig',
      'bottom_sheet.photo' => 'Foto auswählen',
      'bottom_sheet.camera' => 'Foto aufnehmen',
      'bottom_sheet.photo_delete' => 'Foto löschen',
      'snackbar.locked.title' => 'Hast du dein Auto abgeschlossen?',
      'snackbar.locked.subtitle' =>
        'Dies ist eine Erinnerung, ob du dein Auto abgeschlossen hast.',
      'snackbar.locked.action' => 'Ja, hab\' ich',
      'snackbar.shared_parking.title' =>
        'Ein geteilter Online Parkplatz wurde hinzugefügt',
      'snackbar.shared_parking.subtitle' =>
        'Schaue auf der Karte oder in der Liste nach.',
      'snackbar.distance_calculation.title' =>
        'Wie wird die Entfernung berechnet?',
      'snackbar.distance_calculation.subtitle' =>
        'Die Entfernung wird mit Hilfe der Haversine-Formel berechnet. Die Formel ist eine spezielle Form der Pythagoras-Formel, die für die Berechnung der Entfernung zwischen zwei Punkten auf einer Kugel verwendet wird. Die Formel ist auch als "Kugelentfernung" bekannt.',
      'snackbar.distance_calculation.subsubtitle' =>
        'Tippe um mehr zu erfahren.',
      'dialog.abort' => 'Abbrechen',
      'dialog.delete' => 'Löschen',
      'dialog.leave' => 'Verlassen',
      'dialog.logout' => 'Ausloggen',
      'dialog.ok' => 'Ok',
      'dialog.yes' => 'Ja',
      'dialog.no' => 'Nein',
      'dialog.share' => 'Teilen',
      'dialog.save' => 'Speichern',
      'dialog.open_settings' => 'Einstellungen öffnen',
      'dialog.share_location_parkings.title' => 'Teilen beenden',
      'dialog.share_location_parkings.content_1' => '',
      'dialog.share_location_parkings.content_2' =>
        'TODO Wenn du dein Teilen beendest, werden erst deine Standorte deiner Parkplätze von unserem Server gelöscht und das Speichern unterbunden, bis du es wieder einschaltest.',
      'dialog.share_location_parkings.deactivate' => 'Ausschalten',
      'dialog.distance.title' => 'Standort Entfernung',
      'dialog.distance.content' => ({required Object distance}) =>
          'Abstand zum Standort: ${distance}',
      'dialog.notifications.na.title' => 'Benachrichtigungen nicht verfügbar',
      'dialog.notifications.na.subtitle' =>
        'Benachrichtigungen sind auf deinem Gerät nicht verfügbar.',
      'dialog.notifications.denied.title' => 'Benachrichtigungen verweigert',
      'dialog.notifications.denied.subtitle' =>
        'Du hast die Benachrichtigungen verweigert. Bitte gehe in die Einstellungen und erlaube die Benachrichtigungen.',
      'dialog.notifications.sent.title' => 'Auto geparkt',
      'dialog.notifications.expiring.title' => 'Dein Parkticket läuft bald ab',
      'dialog.notifications.expiring.subtitle' => (
              {required Object minutesLeft}) =>
          'In ca. ${minutesLeft} Minuten läuft dein Parkticket ab, bereite dich langsam auf die Abfahrt vor.',
      'dialog.car_bottom_sheet.sync.title' => 'Parkplatz synchronisieren',
      'dialog.car_bottom_sheet.sync.subtitle' =>
        'Möchtest du den Parkplatz synchronisieren?',
      'dialog.car_bottom_sheet.sync.action_1' => 'Synchronisieren',
      'dialog.car_bottom_sheet.synced.title' => 'Parkplatz synchronisiert',
      'dialog.car_bottom_sheet.synced.subtitle' =>
        'Dieser Parkplatz ist nun auf den Servern von WoAuto.\nMöchtest du den Parkplatz teilen?',
      'dialog.car_bottom_sheet.sharing.title' => 'Parkplatz teilen',
      'dialog.car_bottom_sheet.sharing.subtitle' =>
        'Lasse diesen QR Code scannen, um deinen Standort zu teilen',
      'dialog.car_bottom_sheet.sharing.action_1' => 'Link teilen',
      'dialog.car_bottom_sheet.sharing.share_content' => (
              {required Object woLink}) =>
          'Hier ist mein synchronisierter Parkplatz:\n\n${woLink}',
      'dialog.maps.driving_mode.title' => 'Driving Modus erkannt',
      'dialog.maps.driving_mode.subtitle' =>
        'Du bist gerade (wahrscheinlich) mit deinem Auto unterwegs. Möchtest du in den Driving Modus wechseln?',
      'dialog.maps.location_denied.title' => 'Standortberechtigung verweigert',
      'dialog.maps.location_denied.subtitle' =>
        'Du hast die Standortberechtigung verweigert. Bitte gehe in die Einstellungen und erlaube den Zugriff auf deinen Standort.',
      'dialog.history.info.title' => 'Historie',
      'dialog.history.info.subtitle' =>
        'Hier werden dir die letzten 15 Parkplätze angezeigt',
      'dialog.history.delete.title' => 'Lösche alle Einträge',
      'dialog.history.delete.subtitle' =>
        'Bist du sicher, dass du alle Einträge löschen möchtest?',
      'dialog.leave_info.title' => 'App verlassen',
      'dialog.leave_info.subtitle' =>
        'Bist du sicher, dass du die App verlassen möchtest?',
      'dialog.app_info.title' => 'App Info',
      'dialog.app_info.subtitle' =>
        'Diese App wurde von Emre Yurtseven entwickelt, ist Open-Source und natürlich auf Github verfügbar.',
      'dialog.app_info.action_1' => 'GitHub',
      'dialog.feedback.title' => 'Feedback',
      'dialog.feedback.subtitle' =>
        'Schreibe mir gerne eine E-Mail, trete unserem Telegram-Channel bei oder schreibe mir eine private Nachricht auf Telegram:',
      'dialog.feedback.action_1' => 'Telegram',
      'dialog.data_security.title' => 'Datenschutz und Impressum',
      'dialog.data_security.content_1' =>
        'Kurze Zusammenfassung der Datenschutzerklärung in eigenen Worten (Stand 14. Dezember 2025):',
      'dialog.data_security.content_2' =>
        '- Die App kommuniziert mit Google Maps, um die Karte anzuzeigen.',
      'dialog.data_security.content_4' =>
        '- Die App speichert keine Metadaten, wie z.B. die IP-Adresse, Gerätename oder Betriebssystemversion.',
      'dialog.data_security.content_5' =>
        '- Die App speichert natürlich, unter anderem, deinen Standort, den Namen des Parkplatzes und die Koordinaten, gibt diese aber ',
      'dialog.data_security.content_6' => 'nicht an Dritte weiter.',
      'dialog.data_security.content_7' =>
        '\n\nEs findet ein Datenaustausch mit den Servern von Google bei der Bereitstellung der Google Maps Karten statt. ',
      'dialog.data_security.content_8' =>
        'Die App speichert alle Daten nur auf deinem Gerät und du kannst sie jederzeit löschen.',
      'dialog.data_security.action_1' => 'Impressum',
      'dialog.data_security.action_2' => 'Datenschutz',
      'dialog.app_data.title' => 'App Daten löschen',
      'dialog.app_data.subtitle' =>
        'Bist du sicher, dass du alle App Daten löschen? Dein Account bleibt bestehen.',
      'dialog.account_data.title' => 'Konto & Daten löschen',
      'dialog.account_data.content' =>
        'Hiermit wird dein Account gelöscht, mit samt allen Daten, die mit dir in Zusammenhang stecken, Parkplätze, Live Standorte etc. Außerdem werden alle App Daten gelöscht.',
      'dialog.logout_confirm' =>
        'Bist du dir sicher, dass du dich ausloggen möchtest?',
      'settings.title' => 'Einstellungen',
      'settings.theme.title' => 'Theme',
      'settings.theme.subtitle' =>
        'Wähle das Theme aus, das dir am besten gefällt.',
      'settings.theme.dropdown_1' => 'System',
      'settings.theme.dropdown_2' => 'Hell',
      'settings.theme.dropdown_3' => 'Dunkel',
      'settings.color.choice' => 'Farbe',
      'settings.map_type.title' => 'Karten Typ',
      'settings.map_type.subtitle' =>
        'Wähle den Karten Typ aus, der dir am besten gefällt.',
      'settings.map_type.dropdown_1' => 'Normal',
      'settings.map_type.dropdown_2' => 'Satellit',
      'settings.map_type.dropdown_3' => 'Hybrid',
      'settings.map_type.dropdown_4' => 'Terrain',
      'settings.traffic.title' => 'Verkehrslage',
      'settings.traffic.subtitle' =>
        'Zeige die aktuelle Verkehrslage auf der Karte an.',
      'settings.new_ios.title' => 'iOS Design',
      'settings.new_ios.subtitle' =>
        'Aktiviere das neue iOS Design mit Cupertino Widgets.',
      'settings.park_ticket.title' => 'Parkticket Zeitpuffer',
      'settings.park_ticket.subtitle' =>
        'Lege einen Zeitpuffer fest, damit du vor dem Parkticketablauf noch Zeit hast, das Ticket zu erneuern oder zum Auto zurückzukehren.',
      'settings.park_ticket.dropdown_value' => ({required Object value}) =>
          '${value} Minuten',
      'settings.driving_mode.title' => 'Driving Modus Erkennung',
      'settings.driving_mode.subtitle' =>
        'Lege fest, wie schnell du fahren musst, damit die App den Driving Modus erkennt.',
      'settings.driving_mode.dropdown_value' => ({required Object value}) =>
          '${value} km/h',
      'settings.app_info.title' => 'App Info',
      'settings.app_info.subtitle' => (
              {required Object appVersion, required Object buildNumber}) =>
          'Version ${appVersion}+${buildNumber}',
      'settings.credits.title' => 'Credits',
      'settings.credits.subtitle' =>
        'Dank an Google Maps API und natürlich an die Flutter Community.',
      'settings.woauto_server.title' => 'WoAuto Server (PocketBase)',
      'settings.woauto_server.subtitle' => ({required Object status}) =>
          'Server Status: ${status}',
      'settings.share.title' => 'App Teilen',
      'settings.share.subtitle' =>
        'Teile die App doch mit deinen Freunden und deiner Familie.',
      'settings.share.share_content' =>
        'Hast du auch vergessen, wo du zuletzt geparkt hast? Jetzt ist Schluss. Mit WoAuto kannst du deinen Parkplatz ganz einfach speichern und später ansehen, mit anderen teilen und sogar dorthin navigieren.\nDein Parkplatz ist sicher und bleibt immer auf deinem Gerät.\n\nWarum lädst du es nicht herunter und probierst es selbst aus? https://play.google.com/store/apps/details?id=de.emredev.woauto',
      'settings.feedback.title' => 'Feedback',
      'settings.feedback.subtitle' =>
        'Hast du Verbesserungsvorschläge, Fehler oder etwas anderes zu sagen?',
      'settings.data_security.title' => 'Datenschutz und Impressum',
      'settings.data_security.subtitle' =>
        'Erfahre wie deine Daten geschützt werden.',
      'settings.app_data.title' => 'Lösche alle App-Daten',
      'settings.app_data.subtitle' =>
        'Halte hier gedrückt, um all deine App-Daten zu löschen.',
      'settings.app_data.subtitle_ios' =>
        'Tippe hier, um all deine App-Daten zu löschen.',
      _ => null,
    };
  }
}
