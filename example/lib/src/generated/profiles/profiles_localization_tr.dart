// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class ProfilesLocalizationTr extends ProfilesLocalization {
  ProfilesLocalizationTr([String locale = 'tr']) : super(locale);

  @override
  String get chatDrawerTitle => 'Sağlık Kayıtları';

  @override
  String get chatDrawerBadgeNew => 'YENİ';

  @override
  String get bannerTitle => 'Sağlık Kaydınızı Oluşturun';

  @override
  String get bannerSubtitle => 'Danışmanlığınızın sonunda profilinizi ekleyin.';

  @override
  String get bannerMoreProfilesTitle => 'Daha fazla profil ekle';

  @override
  String get bannerMoreProfilesSubtitle =>
      'Başka biri için profil oluşturmak üzere bir danışma başlatın.';

  @override
  String get bannerSignUp => 'Sağlık Kaydınızı oluşturmak için kaydolun';

  @override
  String get errorRetryButton => 'Tekrar Dene';

  @override
  String get dashboardDeleteError => 'Profil silinemedi';

  @override
  String get dashboardSummaryLoadError => 'Profil özeti yüklenemedi';

  @override
  String get dashboardMenuViewFullRecord => 'Tam Kaydı Görüntüle';

  @override
  String get dashboardMenuShare => 'Paylaş';

  @override
  String get dashboardMenuDelete => 'Sil';

  @override
  String get dashboardMetricAgeLabel => 'Yaş';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value yıl',
      one: '$value yıl',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'Ağırlık';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value kg';
  }

  @override
  String get dashboardMetricHeightLabel => 'Boy';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value cm';
  }

  @override
  String get dashboardMetricNotAvailable => '-';

  @override
  String get dashboardInfoAllergiesTitle => 'Alerjiler';

  @override
  String get dashboardInfoChronicTitle => 'Kronik';

  @override
  String get dashboardInfoMedicationTitle => 'İlaç';

  @override
  String get dashboardInfoDevicesTitle => 'Cihazlar';

  @override
  String get dashboardNavigationConsultations => 'Danışmanlıklar';

  @override
  String get dashboardNavigationDocuments => 'Belgeler';

  @override
  String get dashboardDeleteRecordTitle =>
      'Sağlık Kaydını Silmek İstiyor musunuz?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'Bu, sağlık verilerinizi kalıcı olarak kaldıracak ve geri alınamaz. Size rehberlik etmek için kullandığımız bağlamı kaybedeceksiniz.';

  @override
  String get dashboardDeleteRecordCancel => 'İptal';

  @override
  String get dashboardDeleteRecordConfirm => 'Sil';

  @override
  String get dashboardDeleteRecordLoading => 'Sağlık kaydınızı siliyoruz...';

  @override
  String get dashboardDeleteRecordError => 'Profil silinemedi';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'Sağlık kaydı silindi';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'Asistanla sohbet ederek istediğiniz zaman yenisini oluşturabilirsiniz.';

  @override
  String get dashboardDeleteRecordSuccessButton => 'Sohbete Dön';

  @override
  String get dataEditingScreenTitle => 'Düzenleme';

  @override
  String get dataFailedToLoadError => 'Profil verisi yüklenemedi';

  @override
  String get dataRecordSavedTitle => 'Değişiklikler kaydedildi';

  @override
  String get dataRecordSavedSubtitle => 'Bilgileriniz başarıyla güncellendi.';

  @override
  String get dataRecordSavedButton => 'Profile\'e dön';

  @override
  String get dataRecordUpdateError =>
      'Profil verilerini güncellemeye başarısız oldu';

  @override
  String get dataRecordDiscardTitle => 'Değişiklikleri iptal et?';

  @override
  String get dataRecordDiscardSubtitle =>
      'Profilinizde bazı değişiklikler yaptınız. Gitmeden önce bunları kaydedin veya iptal edin.';

  @override
  String get dataRecordDiscardCancel => 'Düzenlemeye devam et';

  @override
  String get dataRecordDiscardConfirm => 'İptal et';

  @override
  String get dataRecordEditTooltip => 'Düzenle';

  @override
  String get dataRecordAddTag => 'Kayıt ekle';

  @override
  String get consultationsSearch => 'Ara';

  @override
  String get consultationsSearchEmpty => 'Sonuç bulunamadı';

  @override
  String get documentsMenuDownload => 'İndir';

  @override
  String get documentsMenuShare => 'Paylaş';

  @override
  String get documentsMenuDelete => 'Sil';

  @override
  String get documentsEmptyList => 'Hiç belge bulunamadı';

  @override
  String get documentsDeleteTitle => 'Bu belgeyi silmek istiyor musunuz?';

  @override
  String get documentsDeleteSubtitle => 'Bu dosya kalıcı olarak silinecek';

  @override
  String get documentsDeleteCancel => 'İptal';

  @override
  String get documentsDeleteButton => 'Sil';

  @override
  String get documentsMoreActionsTooltip => 'Diğer işlemler';

  @override
  String get profilesSearch => 'Ara';

  @override
  String get profilesEmptyList => 'Profil bulunamadı';

  @override
  String get profilesViewMore => 'Daha fazla görüntüle';

  @override
  String get profilesMore => 'Daha Fazla';

  @override
  String get profilesAnnouncementTitle1 =>
      'Doctorina artık sağlığınızı hatırlıyor';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'Danışmanlıklarınız artık Sağlık Kaydınızı otomatik olarak oluşturup güncelliyor.';

  @override
  String get profilesAnnouncementTitle2 =>
      'Sağlık Kaydınız, sizin kurallarınız';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'Semptomları, ilaçları, geçmişi veya belgeleri istediğiniz zaman görüntüleyin, düzenleyin veya ekleyin.';

  @override
  String get profilesAnnouncementTitle3 => 'Tüm aileniz için bakım';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'Sevdikleriniz, çocuklarınız, ebeveynleriniz veya partneriniz için bir Sağlık Kaydı oluşturun.';

  @override
  String get profilesAnnouncementTitle4 =>
      'Sağlık Kaydınızı kaydetmeye hazır mısınız?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'Danışmanlığınızdan sonra, kaydetmek için \"Profil ekle\"ye dokunun.';

  @override
  String get profilesNextButton => 'İleri';

  @override
  String get profilesStartButton => 'Bir danışma başlat';

  @override
  String get profilesLaterButton => 'Belki daha sonra';

  @override
  String get profileSuccessCloseButton => 'Kapat';

  @override
  String get pdfHeaderTitle => 'Sağlık Kaydı';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'Sağlık Kaydı — $name';
  }

  @override
  String get expandableFieldMore => '...daha fazla';

  @override
  String get expandableFieldLess => '...daha az';

  @override
  String get profiles_button_addnew => 'Yeni profil ekle';

  @override
  String get profiles_label_addnew =>
      'Bu danışmanın detaylarını kaydetmek için bir profil oluşturun.';

  @override
  String get profiles_label_health_records_hint =>
      'Health Records\'ınızda onu istediğiniz zaman görüntüleyebilirsiniz';

  @override
  String get profiles_label_keep_talking_hint =>
      'Bu veya bununla ilgili başka sorularınız olursa, benimle konuşmaya devam etmekten çekinmeyin. Yardım etmek için buradayım';

  @override
  String get profile_section_basic_title => 'Genel Bilgiler';

  @override
  String get profile_section_basic_name_label => 'Ad';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'Ad';

  @override
  String get profile_section_basic_first_name_placeholder => 'Ahmet';

  @override
  String get profile_section_basic_last_name_label => 'Soyadı';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'Cinsiyet';

  @override
  String get profile_section_basic_sex_placeholder => 'Lütfen seçiniz';

  @override
  String get profile_section_basic_sex_options_male => 'Erkek';

  @override
  String get profile_section_basic_sex_options_female => 'Kadın';

  @override
  String get profile_section_basic_sex_options_other => 'Diğer';

  @override
  String get profile_section_basic_date_of_birth_label => 'Doğum Tarihi';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'Yaş';

  @override
  String get profile_section_basic_age_str_placeholder => 'örn. 30';

  @override
  String get profile_section_basic_phonenumber_label => 'Telefon numarası';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'E-posta';

  @override
  String get profile_section_basic_email_placeholder => 'ornek@ornek.com';

  @override
  String get profile_section_basic_location_label => 'Konum';

  @override
  String get profile_section_basic_location_placeholder => 'örn. Şehir, Ülke';

  @override
  String get profile_section_body_diet_title => 'Vücut & Beslenme';

  @override
  String get profile_section_body_diet_height_str_label => 'Boy';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'örn. 180 cm';

  @override
  String get profile_section_body_diet_weight_str_label => 'Kilo';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'örn. 75 kg';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => 'Adet Döngüsü';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'örn. Düzenli, Düzensiz';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'Diyet Kısıtlamaları';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'Lütfen seçiniz';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'Ne yediğinizi ve sahip olduğunuz kısıtlamaları bize bildirin';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'Yok';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'Vejetaryen';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'Vegan';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'Glutensiz';

  @override
  String get profile_section_body_diet_bmi_label => 'Vücut Kitle İndeksi (VKİ)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'örn. 24,5';

  @override
  String get profile_section_health_profile_title => 'Sağlık Profili';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'Kronik Hastalıklar';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'örneğin, Tip 2 Diyabet';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'Lütfen tüm kronik hastalıkları listeleyin ve ne zaman teşhis edildiğini ve herhangi bir komplikasyonu ekleyin.';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'Geçmiş Hastalıklar';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'örneğin, sık sık soğuk algınlığı';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'Lütfen geçmişte geçirdiğiniz ciddi hastalıkları listeleyin, iyileşseniz bile.';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'Ameliyat Geçmişi';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'örn. Apendektomi';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'Lütfen tüm ameliyatları listeleyin ve yılı ile birlikte herhangi bir komplikasyon olup olmadığını belirtin.';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'Ara sıra kullanılan ilaçlar';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'örneğin: İbuprofen';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'Lütfen zaman zaman aldığınız ilaçları (örneğin: ağrı kesiciler, alerji ilaçları) doz ve kullanım nedeni ile birlikte listeleyin.';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'Düzenli İlaçlar';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'örneğin: Metformin';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'Lütfen düzenli olarak aldığınız tüm ilaçları, adını, dozunu, günde kaç kez aldığınızı ve hangi durum için olduğunu listeleyin.';

  @override
  String get profile_section_health_profile_allergies_label => 'Alerjiler';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'örn. Penisilin - döküntü yapar';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'Lütfen tüm alerjilerinizi (ilaçlar, yiyecekler, çevresel) listeleyin ve hangi reaksiyonu gösterdiğinizi açıklayın (örneğin: döküntü, şişlik, nefes alma sorunları).';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'Özel Durumlar';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'örn. Gebelik, Engellilik';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'Doktorların her zaman bilmesi gereken önemli tıbbi durumlarınız varsa (örneğin: hamilelik, implante cihazlar, engellilik, antikoagülasyon tedavisi), lütfen bunları tanımlayın. Yoksa, bunu boş bırakabilirsiniz.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'Aile Öyküsü';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'örn. Kalp hastalığı, kanser';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'Ailenizdeki önemli hastalıkları tanımlayın (örneğin: diyabet, hipertansiyon, kalp hastalığı, kanser, genetik hastalıklar) ve hangi aile üyesinin bu durumu yaşadığını belirtin.';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'Sosyal & Yaşam Tarzı Faktörleri';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'örn. Sigara içme, Alkol tüketimi';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'Sağlığınızı etkileyebilecek yaşam tarzı faktörlerini, örneğin sigara içme, alkol, fiziksel aktivite, diyet, uyku ve meslek gibi, lütfen tanımlayın.';

  @override
  String get profile_section_health_profile_devices_label => 'Tıbbi Cihazlar';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'örn. Kalp Pili, İşitme Cihazı, İnsülin Pompası';

  @override
  String get profile_section_health_profile_devices_hint =>
      'Kullandığınız veya implante edilmiş herhangi bir tıbbi cihazı listeleyin, örneğin pacemaker\'lar, insülin pompaları, işitme cihazları, protezler veya diğer yardımcı veya izleme cihazları. Uygun detayları ekleyin.';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'Omnivor';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'Fast Food';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'Balık yiyen vejetaryen';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'Laktozsuz';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'Düşük sodyumlu diyet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'Az şekerli diyet';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'Kalp diyeti';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'Böbrek diyeti';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'Diğer';
}
