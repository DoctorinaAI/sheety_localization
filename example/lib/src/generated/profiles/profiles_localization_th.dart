// This file is generated, do not edit it manually!

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'profiles_localization.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class ProfilesLocalizationTh extends ProfilesLocalization {
  ProfilesLocalizationTh([String locale = 'th']) : super(locale);

  @override
  String get chatDrawerTitle => 'บันทึกสุขภาพ';

  @override
  String get chatDrawerBadgeNew => 'ใหม่';

  @override
  String get bannerTitle => 'สร้างบันทึกสุขภาพของคุณ';

  @override
  String get bannerSubtitle =>
      'เมื่อสิ้นสุดการปรึกษาของคุณ ให้เพิ่มโปรไฟล์ของคุณ';

  @override
  String get bannerMoreProfilesTitle => 'เพิ่มโปรไฟล์เพิ่มเติม';

  @override
  String get bannerMoreProfilesSubtitle =>
      'เริ่มการปรึกษาสำหรับคนอื่นเพื่อสร้างโปรไฟล์ของพวกเขา';

  @override
  String get bannerSignUp => 'ลงทะเบียนเพื่อสร้างบันทึกสุขภาพของคุณ';

  @override
  String get errorRetryButton => 'ลองใหม่';

  @override
  String get dashboardDeleteError => 'ไม่สามารถลบโปรไฟล์ได้';

  @override
  String get dashboardSummaryLoadError => 'ไม่สามารถโหลดข้อมูลสรุปโปรไฟล์ได้';

  @override
  String get dashboardMenuViewFullRecord => 'ดูบันทึกทั้งหมด';

  @override
  String get dashboardMenuShare => 'แชร์';

  @override
  String get dashboardMenuDelete => 'ลบ';

  @override
  String get dashboardMetricAgeLabel => 'อายุ';

  @override
  String dashboardMetricAgeNumLabel(num value) {
    String _temp0 = intl.Intl.pluralLogic(
      value,
      locale: localeName,
      other: '$value ปี',
      one: '$value ปี',
    );
    return '$_temp0';
  }

  @override
  String get dashboardMetricWeightLabel => 'น้ำหนัก';

  @override
  String dashboardMetricWeightNumLabel(num value) {
    return '$value กก';
  }

  @override
  String get dashboardMetricHeightLabel => 'ความสูง';

  @override
  String dashboardMetricHeightNumLabel(num value) {
    return '$value ซม';
  }

  @override
  String get dashboardMetricNotAvailable => 'N/A';

  @override
  String get dashboardInfoAllergiesTitle => 'ภูมิแพ้';

  @override
  String get dashboardInfoChronicTitle => 'เรื้อรัง';

  @override
  String get dashboardInfoMedicationTitle => 'ยา';

  @override
  String get dashboardInfoDevicesTitle => 'อุปกรณ์';

  @override
  String get dashboardNavigationConsultations => 'การปรึกษา';

  @override
  String get dashboardNavigationDocuments => 'เอกสาร';

  @override
  String get dashboardDeleteRecordTitle => 'ลบข้อมูลสุขภาพ?';

  @override
  String get dashboardDeleteRecordSubtitle =>
      'นี่จะลบข้อมูลสุขภาพของคุณอย่างถาวรและไม่สามารถย้อนกลับได้ คุณจะสูญเสียบริบทที่เราใช้ในการแนะนำคุณ';

  @override
  String get dashboardDeleteRecordCancel => 'ยกเลิก';

  @override
  String get dashboardDeleteRecordConfirm => 'ลบ';

  @override
  String get dashboardDeleteRecordLoading => 'กำลังลบข้อมูลสุขภาพของคุณ...';

  @override
  String get dashboardDeleteRecordError => 'ไม่สามารถลบโปรไฟล์ได้';

  @override
  String get dashboardDeleteRecordSuccessTitle => 'ลบข้อมูลสุขภาพแล้ว';

  @override
  String get dashboardDeleteRecordSuccessSubtitle =>
      'คุณสามารถสร้างใหม่ได้ทุกเมื่อโดยการสนทนากับผู้ช่วย';

  @override
  String get dashboardDeleteRecordSuccessButton => 'กลับไปที่แชท';

  @override
  String get dataEditingScreenTitle => 'การแก้ไข';

  @override
  String get dataFailedToLoadError => 'ไม่สามารถโหลดข้อมูลโปรไฟล์ได้';

  @override
  String get dataRecordSavedTitle => 'บันทึกการเปลี่ยนแปลงเรียบร้อย';

  @override
  String get dataRecordSavedSubtitle =>
      'ข้อมูลของคุณได้รับการอัปเดตเรียบร้อยแล้ว';

  @override
  String get dataRecordSavedButton => 'กลับไปที่โปรไฟล์';

  @override
  String get dataRecordUpdateError => 'ไม่สามารถอัปเดตข้อมูลโปรไฟล์ได้';

  @override
  String get dataRecordDiscardTitle => 'ยกเลิกการเปลี่ยนแปลงหรือไม่?';

  @override
  String get dataRecordDiscardSubtitle =>
      'คุณได้ทำการเปลี่ยนแปลงบางอย่างในโปรไฟล์ของคุณ บันทึกการเปลี่ยนแปลงก่อนที่คุณจะออกจากระบบ หรือยกเลิกการเปลี่ยนแปลง';

  @override
  String get dataRecordDiscardCancel => 'แก้ไขต่อ';

  @override
  String get dataRecordDiscardConfirm => 'ทิ้ง';

  @override
  String get dataRecordEditTooltip => 'แก้ไข';

  @override
  String get dataRecordAddTag => 'เพิ่มบันทึก';

  @override
  String get consultationsSearch => 'ค้นหา';

  @override
  String get consultationsSearchEmpty => 'ไม่พบผลลัพธ์';

  @override
  String get documentsMenuDownload => 'ดาวน์โหลด';

  @override
  String get documentsMenuShare => 'แชร์';

  @override
  String get documentsMenuDelete => 'ลบ';

  @override
  String get documentsEmptyList => 'ไม่พบเอกสาร';

  @override
  String get documentsDeleteTitle => 'ลบเอกสารนี้ใช่ไหม?';

  @override
  String get documentsDeleteSubtitle => 'ไฟล์นี้จะถูกลบอย่างถาวร';

  @override
  String get documentsDeleteCancel => 'ยกเลิก';

  @override
  String get documentsDeleteButton => 'ลบ';

  @override
  String get documentsMoreActionsTooltip => 'การดำเนินการเพิ่มเติม';

  @override
  String get profilesSearch => 'ค้นหา';

  @override
  String get profilesEmptyList => 'ไม่พบโปรไฟล์';

  @override
  String get profilesViewMore => 'ดูเพิ่มเติม';

  @override
  String get profilesMore => 'เพิ่มเติม';

  @override
  String get profilesAnnouncementTitle1 => 'Doctorina จำสุขภาพของคุณได้แล้ว';

  @override
  String get profilesAnnouncementSubtitle1 =>
      'การปรึกษาของคุณจะสร้างและอัปเดตบันทึกสุขภาพของคุณโดยอัตโนมัติ';

  @override
  String get profilesAnnouncementTitle2 => 'บันทึกสุขภาพของคุณ กฎของคุณ';

  @override
  String get profilesAnnouncementSubtitle2 =>
      'ดู แก้ไข หรือเพิ่มอาการ ยา ประวัติ หรือเอกสารได้ทุกเมื่อ';

  @override
  String get profilesAnnouncementTitle3 => 'ดูแลครอบครัวของคุณทั้งหมด';

  @override
  String get profilesAnnouncementSubtitle3 =>
      'สร้างบันทึกสุขภาพสำหรับคนที่คุณรัก ลูกๆ ของคุณ พ่อแม่ หรือคู่ของคุณ';

  @override
  String get profilesAnnouncementTitle4 =>
      'พร้อมที่จะบันทึกประวัติสุขภาพของคุณหรือยัง?';

  @override
  String get profilesAnnouncementSubtitle4 =>
      'หลังจากการปรึกษาของคุณ ให้แตะ \"เพิ่มโปรไฟล์\" เพื่อบันทึกมัน';

  @override
  String get profilesNextButton => 'ถัดไป';

  @override
  String get profilesStartButton => 'เริ่มการปรึกษา';

  @override
  String get profilesLaterButton => 'อาจจะทีหลัง';

  @override
  String get profileSuccessCloseButton => 'ปิด';

  @override
  String get pdfHeaderTitle => 'บันทึกสุขภาพ';

  @override
  String pdfHeaderTitleWithName(String name) {
    return 'บันทึกสุขภาพ — $name';
  }

  @override
  String get expandableFieldMore => '...เพิ่มเติม';

  @override
  String get expandableFieldLess => '...น้อยลง';

  @override
  String get profiles_button_addnew => 'เพิ่มโปรไฟล์ใหม่';

  @override
  String get profiles_label_addnew =>
      'สร้างโปรไฟล์เพื่อบันทึกรายละเอียดของการปรึกษานี้';

  @override
  String get profiles_label_health_records_hint =>
      'คุณสามารถเข้าถึงได้ตลอดเวลาในบันทึกสุขภาพของคุณ';

  @override
  String get profiles_label_keep_talking_hint =>
      'หากคุณมีคำถามเพิ่มเติมเกี่ยวกับเรื่องนี้หรือเรื่องที่เกี่ยวข้อง อย่าลังเลที่จะพูดคุยกับฉันต่อ. ฉันพร้อมช่วยเหลือ';

  @override
  String get profile_section_basic_title => 'ข้อมูลทั่วไป';

  @override
  String get profile_section_basic_name_label => 'ชื่อ';

  @override
  String get profile_section_basic_name_placeholder => 'John Doe';

  @override
  String get profile_section_basic_first_name_label => 'ชื่อ';

  @override
  String get profile_section_basic_first_name_placeholder => 'John';

  @override
  String get profile_section_basic_last_name_label => 'นามสกุล';

  @override
  String get profile_section_basic_last_name_placeholder => 'Doe';

  @override
  String get profile_section_basic_sex_label => 'เพศ';

  @override
  String get profile_section_basic_sex_placeholder => 'กรุณาเลือก';

  @override
  String get profile_section_basic_sex_options_male => 'ชาย';

  @override
  String get profile_section_basic_sex_options_female => 'หญิง';

  @override
  String get profile_section_basic_sex_options_other => 'อื่นๆ';

  @override
  String get profile_section_basic_date_of_birth_label => 'วันเกิด';

  @override
  String get profile_section_basic_date_of_birth_placeholder => 'YYYY-MM-DD';

  @override
  String get profile_section_basic_age_str_label => 'อายุ';

  @override
  String get profile_section_basic_age_str_placeholder => 'เช่น 30';

  @override
  String get profile_section_basic_phonenumber_label => 'หมายเลขโทรศัพท์';

  @override
  String get profile_section_basic_phonenumber_placeholder =>
      '+xxx xxx xxx xxx';

  @override
  String get profile_section_basic_email_label => 'อีเมล';

  @override
  String get profile_section_basic_email_placeholder => 'example@example.com';

  @override
  String get profile_section_basic_location_label => 'ที่อยู่';

  @override
  String get profile_section_basic_location_placeholder => 'เช่น เมือง, ประเทศ';

  @override
  String get profile_section_body_diet_title => 'ร่างกาย & อาหาร';

  @override
  String get profile_section_body_diet_height_str_label => 'ความสูง';

  @override
  String get profile_section_body_diet_height_str_placeholder => 'เช่น 180 ซม';

  @override
  String get profile_section_body_diet_weight_str_label => 'น้ำหนัก';

  @override
  String get profile_section_body_diet_weight_str_placeholder => 'เช่น 75 กก';

  @override
  String get profile_section_body_diet_menstrual_cycle_label => 'รอบเดือน';

  @override
  String get profile_section_body_diet_menstrual_cycle_placeholder =>
      'เช่น สม่ำเสมอ, ไม่สม่ำเสมอ';

  @override
  String get profile_section_body_diet_dietary_restrictions_label =>
      'ข้อจำกัดด้านอาหาร';

  @override
  String get profile_section_body_diet_dietary_restrictions_placeholder =>
      'โปรดเลือก';

  @override
  String get profile_section_body_diet_dietary_restrictions_hint =>
      'บอกเราหน่อยว่าคุณกินอะไรและมีข้อจำกัดอะไรบ้าง';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_none =>
      'ไม่มี';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_vegetarian =>
          'มังสวิรัติ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_vegan =>
      'วีแกน';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_gluten_free =>
          'ปราศจากกลูเตน';

  @override
  String get profile_section_body_diet_bmi_label => 'ดัชนีมวลกาย (BMI)';

  @override
  String get profile_section_body_diet_bmi_placeholder => 'เช่น 24.5';

  @override
  String get profile_section_health_profile_title => 'ข้อมูลสุขภาพ';

  @override
  String get profile_section_health_profile_chronic_illnesses_label =>
      'โรคเรื้อรัง';

  @override
  String get profile_section_health_profile_chronic_illnesses_placeholder =>
      'เช่น เบาหวานชนิดที่ 2';

  @override
  String get profile_section_health_profile_chronic_illnesses_hint =>
      'โปรดระบุโรคเรื้อรังทั้งหมดและรวมถึงเมื่อใดที่ได้รับการวินิจฉัยและภาวะแทรกซ้อนใด ๆ';

  @override
  String get profile_section_health_profile_past_illnesses_label =>
      'ประวัติการเจ็บป่วย';

  @override
  String get profile_section_health_profile_past_illnesses_placeholder =>
      'เช่น ไข้หวัดใหญ่บ่อย';

  @override
  String get profile_section_health_profile_past_illnesses_hint =>
      'โปรดระบุโรคร้ายแรงที่คุณเคยเป็นในอดีต แม้ว่าคุณจะหายแล้วก็ตาม';

  @override
  String get profile_section_health_profile_surgical_history_label =>
      'ประวัติการผ่าตัด';

  @override
  String get profile_section_health_profile_surgical_history_placeholder =>
      'เช่น ผ่าตัดไส้ติ่ง';

  @override
  String get profile_section_health_profile_surgical_history_hint =>
      'กรุณาระบุการผ่าตัดทั้งหมดและรวมถึงปีและว่ามีภาวะแทรกซ้อนหรือไม่';

  @override
  String get profile_section_health_profile_occasional_medications_label =>
      'ยาที่ใช้เป็นครั้งคราว';

  @override
  String
      get profile_section_health_profile_occasional_medications_placeholder =>
          'เช่น ไอบูโพรเฟน';

  @override
  String get profile_section_health_profile_occasional_medications_hint =>
      'กรุณาระบุยาที่คุณทานเป็นครั้งคราว (เช่น: ยาแก้ปวด, ยาแก้แพ้) รวมถึงขนาดและเหตุผลในการใช้';

  @override
  String get profile_section_health_profile_regular_medications_label =>
      'ยาที่ใช้เป็นประจำ';

  @override
  String get profile_section_health_profile_regular_medications_placeholder =>
      'เช่น เมตฟอร์มิน';

  @override
  String get profile_section_health_profile_regular_medications_hint =>
      'โปรดระบุชื่อยาที่คุณทานเป็นประจำ รวมถึงชื่อ ขนาดยา จำนวนครั้งต่อวันที่คุณทาน และอาการที่ใช้รักษา';

  @override
  String get profile_section_health_profile_allergies_label => 'การแพ้';

  @override
  String get profile_section_health_profile_allergies_placeholder =>
      'เช่น เพนิซิลลิน – ทำให้เกิดผื่น';

  @override
  String get profile_section_health_profile_allergies_hint =>
      'กรุณาระบุอาการแพ้ทั้งหมด (ยา, อาหาร, สิ่งแวดล้อม) และอธิบายปฏิกิริยาที่คุณมี (เช่น: ผื่น, บวม, ปัญหาการหายใจ)';

  @override
  String get profile_section_health_profile_special_conditions_label =>
      'ภาวะพิเศษ';

  @override
  String get profile_section_health_profile_special_conditions_placeholder =>
      'เช่น การตั้งครรภ์, ความพิการ';

  @override
  String get profile_section_health_profile_special_conditions_hint =>
      'หากคุณมีเงื่อนไขทางการแพทย์ที่สำคัญที่แพทย์ควรรู้เสมอ (เช่น: การตั้งครรภ์, อุปกรณ์ที่ฝัง, ความพิการ, การบำบัดด้วยยาต้านการแข็งตัวของเลือด) กรุณาอธิบายเงื่อนไขเหล่านั้น หากไม่มี คุณสามารถปล่อยว่างไว้ได้.';

  @override
  String get profile_section_health_profile_family_history_label =>
      'ประวัติครอบครัว';

  @override
  String get profile_section_health_profile_family_history_placeholder =>
      'เช่น โรคหัวใจ, มะเร็ง';

  @override
  String get profile_section_health_profile_family_history_hint =>
      'โปรดอธิบายโรคที่สำคัญในครอบครัวของคุณ (เช่น เบาหวาน ความดันโลหิตสูง โรคหัวใจ มะเร็ง โรคทางพันธุกรรม) และระบุว่าญาติคนไหนที่มีอาการนี้';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_label =>
      'ปัจจัยทางสังคม & วิถีชีวิต';

  @override
  String
      get profile_section_health_profile_social_lifestyle_factors_placeholder =>
          'เช่น การสูบบุหรี่, การดื่มแอลกอฮอล์';

  @override
  String get profile_section_health_profile_social_lifestyle_factors_hint =>
      'โปรดอธิบายปัจจัยด้านวิถีชีวิตที่สามารถส่งผลต่อสุขภาพของคุณ เช่น การสูบบุหรี่ แอลกอฮอล์ กิจกรรมทางกาย อาหาร การนอนหลับ และอาชีพ';

  @override
  String get profile_section_health_profile_devices_label => 'อุปกรณ์การแพทย์';

  @override
  String get profile_section_health_profile_devices_placeholder =>
      'เช่น เครื่องกระตุ้นหัวใจ, เครื่องช่วยฟัง, ปั๊มอินซูลิน';

  @override
  String get profile_section_health_profile_devices_hint =>
      'โปรดระบุอุปกรณ์ทางการแพทย์ที่คุณใช้หรือมีการฝัง เช่น เครื่องกระตุ้นหัวใจ ปั๊มอินซูลิน เครื่องช่วยฟัง ขาเทียม หรืออุปกรณ์ช่วยเหลือหรือเฝ้าติดตามอื่น ๆ รวมถึงรายละเอียดที่เกี่ยวข้องหากมี';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_omnivorous =>
          'กินทุกอย่าง';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_fast_food =>
      'ฟาสต์ฟู้ด';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_pescatarian =>
          'กินปลาแต่ไม่กินเนื้อสัตว์';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_lactose_free =>
          'ปราศจากแลคโตส';

  @override
  String
      get profile_section_body_diet_dietary_restrictions_options_low_sodium =>
          'อาหารโซเดียมต่ำ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_low_sugar =>
      'อาหารลดน้ำตาล';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_cardiac =>
      'อาหารสำหรับโรคหัวใจ';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_renal =>
      'อาหารสำหรับโรคไต';

  @override
  String get profile_section_body_diet_dietary_restrictions_options_other =>
      'อื่นๆ';
}
