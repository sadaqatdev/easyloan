// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `EasyLoan`
  String get app_name {
    return Intl.message(
      'EasyLoan',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Amount`
  String get max_amount {
    return Intl.message(
      'Maximum Amount',
      name: 'max_amount',
      desc: '',
      args: [],
    );
  }

  /// `Loan Term`
  String get loan_term {
    return Intl.message(
      'Loan Term',
      name: 'loan_term',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Apply Now`
  String get apply_now {
    return Intl.message(
      'Apply Now',
      name: 'apply_now',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Number of users`
  String get number_of_users {
    return Intl.message(
      'Number of users',
      name: 'number_of_users',
      desc: '',
      args: [],
    );
  }

  /// `GO`
  String get go_text {
    return Intl.message(
      'GO',
      name: 'go_text',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code`
  String get login_code_empty {
    return Intl.message(
      'Please enter the verification code',
      name: 'login_code_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the phone number`
  String get login_phone_empty {
    return Intl.message(
      'Please enter the phone number',
      name: 'login_phone_empty',
      desc: '',
      args: [],
    );
  }

  /// `The phone number is abnormal, please re-enter.`
  String get login_phone_len_hint {
    return Intl.message(
      'The phone number is abnormal, please re-enter.',
      name: 'login_phone_len_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone`
  String get login_enter_phone {
    return Intl.message(
      'Enter Phone',
      name: 'login_enter_phone',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get login_number {
    return Intl.message(
      'Number',
      name: 'login_number',
      desc: '',
      args: [],
    );
  }

  /// `If you want to receive money via Mobile Wallet,Please use a number that is registered on Mobile Wallet.`
  String get login_hint {
    return Intl.message(
      'If you want to receive money via Mobile Wallet,Please use a number that is registered on Mobile Wallet.',
      name: 'login_hint',
      desc: '',
      args: [],
    );
  }

  /// `03XXXXXXXXX`
  String get login_input_text_hint {
    return Intl.message(
      '03XXXXXXXXX',
      name: 'login_input_text_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter OTP code`
  String get login_input_code {
    return Intl.message(
      'Please enter OTP code',
      name: 'login_input_code',
      desc: '',
      args: [],
    );
  }

  /// `OTP code`
  String get login_input_code_hint {
    return Intl.message(
      'OTP code',
      name: 'login_input_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Get OTP`
  String get get_otp {
    return Intl.message(
      'Get OTP',
      name: 'get_otp',
      desc: '',
      args: [],
    );
  }

  /// `Re-send the\n code in %ss`
  String get resend_text {
    return Intl.message(
      'Re-send the\n code in %ss',
      name: 'resend_text',
      desc: '',
      args: [],
    );
  }

  /// `Please tick the agreement first`
  String get login_permission_hint {
    return Intl.message(
      'Please tick the agreement first',
      name: 'login_permission_hint',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your real information,which will help you to pass the credit check faster.`
  String get basic_information_top_hint {
    return Intl.message(
      'Fill in your real information,which will help you to pass the credit check faster.',
      name: 'basic_information_top_hint',
      desc: '',
      args: [],
    );
  }

  /// `Basic Information`
  String get basic_information {
    return Intl.message(
      'Basic Information',
      name: 'basic_information',
      desc: '',
      args: [],
    );
  }

  /// `Current Province`
  String get current_province {
    return Intl.message(
      'Current Province',
      name: 'current_province',
      desc: '',
      args: [],
    );
  }

  /// `Current Address`
  String get current_address {
    return Intl.message(
      'Current Address',
      name: 'current_address',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get marital_status {
    return Intl.message(
      'Marital Status',
      name: 'marital_status',
      desc: '',
      args: [],
    );
  }

  /// `Loan Purpose`
  String get loan_purpose {
    return Intl.message(
      'Loan Purpose',
      name: 'loan_purpose',
      desc: '',
      args: [],
    );
  }

  /// `Get Quota`
  String get get_quota {
    return Intl.message(
      'Get Quota',
      name: 'get_quota',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Continue to fill in, The amount is +PKR`
  String get next_hint {
    return Intl.message(
      'Continue to fill in, The amount is +PKR',
      name: 'next_hint',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Fill in your real work information, which will help you get more loan.`
  String get prof_information_top_hint {
    return Intl.message(
      'Fill in your real work information, which will help you get more loan.',
      name: 'prof_information_top_hint',
      desc: '',
      args: [],
    );
  }

  /// `Professional Information`
  String get professional_information {
    return Intl.message(
      'Professional Information',
      name: 'professional_information',
      desc: '',
      args: [],
    );
  }

  /// `Occupation`
  String get occupation {
    return Intl.message(
      'Occupation',
      name: 'occupation',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Income`
  String get monthly_income {
    return Intl.message(
      'Monthly Income',
      name: 'monthly_income',
      desc: '',
      args: [],
    );
  }

  /// `Salary Pay Date`
  String get salary_pay_date {
    return Intl.message(
      'Salary Pay Date',
      name: 'salary_pay_date',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get company_name {
    return Intl.message(
      'Company Name',
      name: 'company_name',
      desc: '',
      args: [],
    );
  }

  /// `Company Phone number`
  String get company_phone_number {
    return Intl.message(
      'Company Phone number',
      name: 'company_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `(Optional)`
  String get optional {
    return Intl.message(
      '(Optional)',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `Job Type`
  String get job_type {
    return Intl.message(
      'Job Type',
      name: 'job_type',
      desc: '',
      args: [],
    );
  }

  /// `Company Address`
  String get company_address {
    return Intl.message(
      'Company Address',
      name: 'company_address',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Please ensure that the contact person you fill in agrees to be the contact person for your application for Easyloan loan, and we will ensure the security of your information`
  String get contact_top_hint {
    return Intl.message(
      'Please ensure that the contact person you fill in agrees to be the contact person for your application for Easyloan loan, and we will ensure the security of your information',
      name: 'contact_top_hint',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contact 1`
  String get emergency_contact_1 {
    return Intl.message(
      'Emergency Contact 1',
      name: 'emergency_contact_1',
      desc: '',
      args: [],
    );
  }

  /// `Emergency Contact 2`
  String get emergency_contact_2 {
    return Intl.message(
      'Emergency Contact 2',
      name: 'emergency_contact_2',
      desc: '',
      args: [],
    );
  }

  /// `Relationship`
  String get relationship {
    return Intl.message(
      'Relationship',
      name: 'relationship',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Phone Number`
  String get mobile_phone_number {
    return Intl.message(
      'Mobile Phone Number',
      name: 'mobile_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `The contact cannot be the same, select again`
  String get contact_same_hint {
    return Intl.message(
      'The contact cannot be the same, select again',
      name: 'contact_same_hint',
      desc: '',
      args: [],
    );
  }

  /// `CNIC`
  String get cnic {
    return Intl.message(
      'CNIC',
      name: 'cnic',
      desc: '',
      args: [],
    );
  }

  /// `This information is only used for credit evaluation and to ensure your information security.`
  String get cnic_top_hint {
    return Intl.message(
      'This information is only used for credit evaluation and to ensure your information security.',
      name: 'cnic_top_hint',
      desc: '',
      args: [],
    );
  }

  /// `Upload CNIC`
  String get upload_cnic {
    return Intl.message(
      'Upload CNIC',
      name: 'upload_cnic',
      desc: '',
      args: [],
    );
  }

  /// `Please take a photo of the original card:`
  String get please_take {
    return Intl.message(
      'Please take a photo of the original card:',
      name: 'please_take',
      desc: '',
      args: [],
    );
  }

  /// `Front`
  String get front {
    return Intl.message(
      'Front',
      name: 'front',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Enter CNIC Information`
  String get enter_cnic_information {
    return Intl.message(
      'Enter CNIC Information',
      name: 'enter_cnic_information',
      desc: '',
      args: [],
    );
  }

  /// `CNIC Number`
  String get cnic_number {
    return Intl.message(
      'CNIC Number',
      name: 'cnic_number',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Date of Issue`
  String get date_of_issue {
    return Intl.message(
      'Date of Issue',
      name: 'date_of_issue',
      desc: '',
      args: [],
    );
  }

  /// `Face Recognition`
  String get face_recognition {
    return Intl.message(
      'Face Recognition',
      name: 'face_recognition',
      desc: '',
      args: [],
    );
  }

  /// `Please upload the front and back of the ID card`
  String get id_card_empty {
    return Intl.message(
      'Please upload the front and back of the ID card',
      name: 'id_card_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the correct account number to ensure that the loan is issued to your account.`
  String get bank_card_top_hint {
    return Intl.message(
      'Please enter the correct account number to ensure that the loan is issued to your account.',
      name: 'bank_card_top_hint',
      desc: '',
      args: [],
    );
  }

  /// `Method to Receive Money`
  String get bank_card_title {
    return Intl.message(
      'Method to Receive Money',
      name: 'bank_card_title',
      desc: '',
      args: [],
    );
  }

  /// `Arrival Amount`
  String get arrival_amount {
    return Intl.message(
      'Arrival Amount',
      name: 'arrival_amount',
      desc: '',
      args: [],
    );
  }

  /// `Choose the method to receive the money`
  String get choose_the_method {
    return Intl.message(
      'Choose the method to receive the money',
      name: 'choose_the_method',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Wallet`
  String get mobile_wallet {
    return Intl.message(
      'Mobile Wallet',
      name: 'mobile_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Bank card`
  String get bank_card {
    return Intl.message(
      'Bank card',
      name: 'bank_card',
      desc: '',
      args: [],
    );
  }

  /// `You can receive loans through your mobile wallet`
  String get mobile_wallet_hint {
    return Intl.message(
      'You can receive loans through your mobile wallet',
      name: 'mobile_wallet_hint',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Wallet Account`
  String get mobile_wallet_account {
    return Intl.message(
      'Mobile Wallet Account',
      name: 'mobile_wallet_account',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Mobile Wallet Account`
  String get confirm_mobile_wallet_account {
    return Intl.message(
      'Confirm Mobile Wallet Account',
      name: 'confirm_mobile_wallet_account',
      desc: '',
      args: [],
    );
  }

  /// `We will send the money to your bank account, please fill in the correct information`
  String get bank_card_hint {
    return Intl.message(
      'We will send the money to your bank account, please fill in the correct information',
      name: 'bank_card_hint',
      desc: '',
      args: [],
    );
  }

  /// `Bank Account`
  String get bank_account {
    return Intl.message(
      'Bank Account',
      name: 'bank_account',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Bank Account`
  String get confirm_bank_account {
    return Intl.message(
      'Confirm Bank Account',
      name: 'confirm_bank_account',
      desc: '',
      args: [],
    );
  }

  /// `You can receive loans through your CNIC number.`
  String get cnic_hint {
    return Intl.message(
      'You can receive loans through your CNIC number.',
      name: 'cnic_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm CNIC Number`
  String get confirm_cnic_number {
    return Intl.message(
      'Confirm CNIC Number',
      name: 'confirm_cnic_number',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank {
    return Intl.message(
      'Bank',
      name: 'bank',
      desc: '',
      args: [],
    );
  }

  /// `Branch Code`
  String get branch_code {
    return Intl.message(
      'Branch Code',
      name: 'branch_code',
      desc: '',
      args: [],
    );
  }

  /// `Loan Amount`
  String get loan_amount {
    return Intl.message(
      'Loan Amount',
      name: 'loan_amount',
      desc: '',
      args: [],
    );
  }

  /// `Repayment Date`
  String get repayment_date {
    return Intl.message(
      'Repayment Date',
      name: 'repayment_date',
      desc: '',
      args: [],
    );
  }

  /// `Interest`
  String get interest {
    return Intl.message(
      'Interest',
      name: 'interest',
      desc: '',
      args: [],
    );
  }

  /// `Repayment Amount`
  String get repayment_amount {
    return Intl.message(
      'Repayment Amount',
      name: 'repayment_amount',
      desc: '',
      args: [],
    );
  }

  /// `Processing Fee`
  String get processing_Fee {
    return Intl.message(
      'Processing Fee',
      name: 'processing_Fee',
      desc: '',
      args: [],
    );
  }

  /// `Service Charge`
  String get service_charge {
    return Intl.message(
      'Service Charge',
      name: 'service_charge',
      desc: '',
      args: [],
    );
  }

  /// `NADRA Verification`
  String get nadra_verification {
    return Intl.message(
      'NADRA Verification',
      name: 'nadra_verification',
      desc: '',
      args: [],
    );
  }

  /// `CIB-Tasdeeq`
  String get cib_tasdeeq {
    return Intl.message(
      'CIB-Tasdeeq',
      name: 'cib_tasdeeq',
      desc: '',
      args: [],
    );
  }

  /// `AML/CFT Fee`
  String get aml_cft_fee {
    return Intl.message(
      'AML/CFT Fee',
      name: 'aml_cft_fee',
      desc: '',
      args: [],
    );
  }

  /// `Transcation Fee`
  String get transcation_fee {
    return Intl.message(
      'Transcation Fee',
      name: 'transcation_fee',
      desc: '',
      args: [],
    );
  }

  /// `SMS Charges`
  String get sms_charges {
    return Intl.message(
      'SMS Charges',
      name: 'sms_charges',
      desc: '',
      args: [],
    );
  }

  /// `Disbursal Amount`
  String get disbursal_amount {
    return Intl.message(
      'Disbursal Amount',
      name: 'disbursal_amount',
      desc: '',
      args: [],
    );
  }

  /// `DETAIL`
  String get detail {
    return Intl.message(
      'DETAIL',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `91Days`
  String get days91 {
    return Intl.message(
      '91Days',
      name: 'days91',
      desc: '',
      args: [],
    );
  }

  /// `182Days`
  String get days182 {
    return Intl.message(
      '182Days',
      name: 'days182',
      desc: '',
      args: [],
    );
  }

  /// `Stage1/3`
  String get stage1 {
    return Intl.message(
      'Stage1/3',
      name: 'stage1',
      desc: '',
      args: [],
    );
  }

  /// `Stage2/3`
  String get stage2 {
    return Intl.message(
      'Stage2/3',
      name: 'stage2',
      desc: '',
      args: [],
    );
  }

  /// `Stage3/3`
  String get stage3 {
    return Intl.message(
      'Stage3/3',
      name: 'stage3',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Your loan application has been Submitted successfully.`
  String get success_hint {
    return Intl.message(
      'Your loan application has been Submitted successfully.',
      name: 'success_hint',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Loanable`
  String get loanable {
    return Intl.message(
      'Loanable',
      name: 'loanable',
      desc: '',
      args: [],
    );
  }

  /// `Under Review`
  String get under_review {
    return Intl.message(
      'Under Review',
      name: 'under_review',
      desc: '',
      args: [],
    );
  }

  /// `Pending Repayment`
  String get pending_repayment {
    return Intl.message(
      'Pending Repayment',
      name: 'pending_repayment',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get overdue {
    return Intl.message(
      'Overdue',
      name: 'overdue',
      desc: '',
      args: [],
    );
  }

  /// `Reject Application`
  String get reject_application {
    return Intl.message(
      'Reject Application',
      name: 'reject_application',
      desc: '',
      args: [],
    );
  }

  /// `Loan Failed`
  String get loan_failed {
    return Intl.message(
      'Loan Failed',
      name: 'loan_failed',
      desc: '',
      args: [],
    );
  }

  /// `Update receiving account`
  String get update_bank_card {
    return Intl.message(
      'Update receiving account',
      name: 'update_bank_card',
      desc: '',
      args: [],
    );
  }

  /// `Repay`
  String get repay {
    return Intl.message(
      'Repay',
      name: 'repay',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get please_wait {
    return Intl.message(
      'Please Wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Loan\nfailed`
  String get Loan_n_failed {
    return Intl.message(
      'Loan\nfailed',
      name: 'Loan_n_failed',
      desc: '',
      args: [],
    );
  }

  /// `Under\nReview`
  String get under_n_review {
    return Intl.message(
      'Under\nReview',
      name: 'under_n_review',
      desc: '',
      args: [],
    );
  }

  /// `Pending\nRepayment`
  String get pending_n_repayment {
    return Intl.message(
      'Pending\nRepayment',
      name: 'pending_n_repayment',
      desc: '',
      args: [],
    );
  }

  /// `Overdue\n0 days`
  String get overdue_n_0_days {
    return Intl.message(
      'Overdue\n0 days',
      name: 'overdue_n_0_days',
      desc: '',
      args: [],
    );
  }

  /// `Reject\nApplication`
  String get reject_n_application {
    return Intl.message(
      'Reject\nApplication',
      name: 'reject_n_application',
      desc: '',
      args: [],
    );
  }

  /// `Date of Application`
  String get date_of_application {
    return Intl.message(
      'Date of Application',
      name: 'date_of_application',
      desc: '',
      args: [],
    );
  }

  /// `We are estimating your loan,it will cost seconds. Please pay attention to the review results on the APP.`
  String get under_review_hint {
    return Intl.message(
      'We are estimating your loan,it will cost seconds. Please pay attention to the review results on the APP.',
      name: 'under_review_hint',
      desc: '',
      args: [],
    );
  }

  /// `1  Copy the Consumer ID for %s repayment`
  String get easypaisa_hint1 {
    return Intl.message(
      '1  Copy the Consumer ID for %s repayment',
      name: 'easypaisa_hint1',
      desc: '',
      args: [],
    );
  }

  /// `2  There are 3 repayment methods as following:`
  String get easypaisa_hint21 {
    return Intl.message(
      '2  There are 3 repayment methods as following:',
      name: 'easypaisa_hint21',
      desc: '',
      args: [],
    );
  }

  /// `(Please click on the name to view the repayment details)`
  String get easypaisa_hint22 {
    return Intl.message(
      '(Please click on the name to view the repayment details)',
      name: 'easypaisa_hint22',
      desc: '',
      args: [],
    );
  }

  /// `2  There are repayment methods as following:`
  String get easypaisa_hint23 {
    return Intl.message(
      '2  There are repayment methods as following:',
      name: 'easypaisa_hint23',
      desc: '',
      args: [],
    );
  }

  /// `Easypaisa APP`
  String get easypaisa_app {
    return Intl.message(
      'Easypaisa APP',
      name: 'easypaisa_app',
      desc: '',
      args: [],
    );
  }

  /// `Easypaisa Retailer`
  String get easypaisa_retailer {
    return Intl.message(
      'Easypaisa Retailer',
      name: 'easypaisa_retailer',
      desc: '',
      args: [],
    );
  }

  /// `Easypaisa USSD`
  String get easypaisa_ussd {
    return Intl.message(
      'Easypaisa USSD',
      name: 'easypaisa_ussd',
      desc: '',
      args: [],
    );
  }

  /// `consumer ID：`
  String get consumer_id {
    return Intl.message(
      'consumer ID：',
      name: 'consumer_id',
      desc: '',
      args: [],
    );
  }

  /// `If you have already finished the repayment operation, there will be a 10-30 minute delay because of  the system or network! please wait patiently!`
  String get easypaisa_warn_hint {
    return Intl.message(
      'If you have already finished the repayment operation, there will be a 10-30 minute delay because of  the system or network! please wait patiently!',
      name: 'easypaisa_warn_hint',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pay {
    return Intl.message(
      'Pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `Your loan is now overdue.If you still refuse to repay or delay repayment,all the consequences will be face by you,including increasing fines,reducing credit,freezing bank cards,legal action,etc`
  String get overdue_warn {
    return Intl.message(
      'Your loan is now overdue.If you still refuse to repay or delay repayment,all the consequences will be face by you,including increasing fines,reducing credit,freezing bank cards,legal action,etc',
      name: 'overdue_warn',
      desc: '',
      args: [],
    );
  }

  /// `warning!`
  String get warning {
    return Intl.message(
      'warning!',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Late payment charge`
  String get late_payment_charge {
    return Intl.message(
      'Late payment charge',
      name: 'late_payment_charge',
      desc: '',
      args: [],
    );
  }

  /// `Sorry`
  String get sorry {
    return Intl.message(
      'Sorry',
      name: 'sorry',
      desc: '',
      args: [],
    );
  }

  /// `The system has detected that your receiving account information is incorrectly filled, please upload it again.`
  String get failed_hint {
    return Intl.message(
      'The system has detected that your receiving account information is incorrectly filled, please upload it again.',
      name: 'failed_hint',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you did not pass the review, please try again in a few days.`
  String get reject_hint1 {
    return Intl.message(
      'Sorry, you did not pass the review, please try again in a few days.',
      name: 'reject_hint1',
      desc: '',
      args: [],
    );
  }

  /// `The reason for rejection might be:\n·The information you filled in is incorrect.\n·Your CNIC photo is not clear.\n·Your information needs further review.`
  String get reject_hint2 {
    return Intl.message(
      'The reason for rejection might be:\n·The information you filled in is incorrect.\n·Your CNIC photo is not clear.\n·Your information needs further review.',
      name: 'reject_hint2',
      desc: '',
      args: [],
    );
  }

  /// `Jazz Cash APP`
  String get jazz_cash_app {
    return Intl.message(
      'Jazz Cash APP',
      name: 'jazz_cash_app',
      desc: '',
      args: [],
    );
  }

  /// `Hello！`
  String get dialog_hello {
    return Intl.message(
      'Hello！',
      name: 'dialog_hello',
      desc: '',
      args: [],
    );
  }

  /// `Please experience the free loans！`
  String get dialog_vip_hint {
    return Intl.message(
      'Please experience the free loans！',
      name: 'dialog_vip_hint',
      desc: '',
      args: [],
    );
  }

  /// `Telephone Number`
  String get telephone_number {
    return Intl.message(
      'Telephone Number',
      name: 'telephone_number',
      desc: '',
      args: [],
    );
  }

  /// `Extended Fee`
  String get extended_fee {
    return Intl.message(
      'Extended Fee',
      name: 'extended_fee',
      desc: '',
      args: [],
    );
  }

  /// `A one-time payment of PKR %s, the refund due date can be extended by %s.The lump sum payment is less than PKR %s and the refund due date remains the same. Pay on time.`
  String get extended_hint {
    return Intl.message(
      'A one-time payment of PKR %s, the refund due date can be extended by %s.The lump sum payment is less than PKR %s and the refund due date remains the same. Pay on time.',
      name: 'extended_hint',
      desc: '',
      args: [],
    );
  }

  /// `Update Due Date`
  String get update_due_date {
    return Intl.message(
      'Update Due Date',
      name: 'update_due_date',
      desc: '',
      args: [],
    );
  }

  /// `Payment Amount`
  String get payment_amount {
    return Intl.message(
      'Payment Amount',
      name: 'payment_amount',
      desc: '',
      args: [],
    );
  }

  /// `Overdue\n%s days`
  String get overdue_n_0_days_format {
    return Intl.message(
      'Overdue\n%s days',
      name: 'overdue_n_0_days_format',
      desc: '',
      args: [],
    );
  }

  /// `Overdue %s days`
  String get overdue_0_days_format {
    return Intl.message(
      'Overdue %s days',
      name: 'overdue_0_days_format',
      desc: '',
      args: [],
    );
  }

  /// `List of Overdue:`
  String get list_of_overdue {
    return Intl.message(
      'List of Overdue:',
      name: 'list_of_overdue',
      desc: '',
      args: [],
    );
  }

  /// `Tips`
  String get tips {
    return Intl.message(
      'Tips',
      name: 'tips',
      desc: '',
      args: [],
    );
  }

  /// `Receipts and repayments may be affected by bank working hours.to protect your benefits,please use online banking to receive payment and repayment.`
  String get update_wallet_hint {
    return Intl.message(
      'Receipts and repayments may be affected by bank working hours.to protect your benefits,please use online banking to receive payment and repayment.',
      name: 'update_wallet_hint',
      desc: '',
      args: [],
    );
  }

  /// `Change \nLanguage`
  String get change_language {
    return Intl.message(
      'Change \nLanguage',
      name: 'change_language',
      desc: '',
      args: [],
    );
  }

  /// `Notice of\n Privacy`
  String get notice_of_privacy {
    return Intl.message(
      'Notice of\n Privacy',
      name: 'notice_of_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Customer \nService`
  String get customer_service {
    return Intl.message(
      'Customer \nService',
      name: 'customer_service',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get log_out {
    return Intl.message(
      'Log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `The two entries are inconsistent.`
  String get input_error {
    return Intl.message(
      'The two entries are inconsistent.',
      name: 'input_error',
      desc: '',
      args: [],
    );
  }

  /// `The system is evaluating your credit!`
  String get wait_hint {
    return Intl.message(
      'The system is evaluating your credit!',
      name: 'wait_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait！`
  String get please_wait_i {
    return Intl.message(
      'Please Wait！',
      name: 'please_wait_i',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_text {
    return Intl.message(
      'Continue',
      name: 'continue_text',
      desc: '',
      args: [],
    );
  }

  /// `My Order`
  String get my_order {
    return Intl.message(
      'My Order',
      name: 'my_order',
      desc: '',
      args: [],
    );
  }

  /// `If you still refuse to repay or delay repayment,all the consequences will be face by you, including increasing fines,reducing credit,freezing bank cards, legal action,etc.`
  String get order_item_overdue_hint {
    return Intl.message(
      'If you still refuse to repay or delay repayment,all the consequences will be face by you, including increasing fines,reducing credit,freezing bank cards, legal action,etc.',
      name: 'order_item_overdue_hint',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, your credit score is lower than the minimum requirement for platform loans. Please try again later.`
  String get order_item_reject_hint {
    return Intl.message(
      'Sorry, your credit score is lower than the minimum requirement for platform loans. Please try again later.',
      name: 'order_item_reject_hint',
      desc: '',
      args: [],
    );
  }

  /// `The system has detected that your receiving account information is incorrectly filled, please upload it again.`
  String get order_item_failed_hint {
    return Intl.message(
      'The system has detected that your receiving account information is incorrectly filled, please upload it again.',
      name: 'order_item_failed_hint',
      desc: '',
      args: [],
    );
  }

  /// `7 Days`
  String get qi_day {
    return Intl.message(
      '7 Days',
      name: 'qi_day',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `you have successfuliy repaid！`
  String get order_item_finish_hint {
    return Intl.message(
      'you have successfuliy repaid！',
      name: 'order_item_finish_hint',
      desc: '',
      args: [],
    );
  }

  /// `APPLY AGAIN`
  String get apply_again {
    return Intl.message(
      'APPLY AGAIN',
      name: 'apply_again',
      desc: '',
      args: [],
    );
  }

  /// `No related order found`
  String get order_no_date {
    return Intl.message(
      'No related order found',
      name: 'order_no_date',
      desc: '',
      args: [],
    );
  }

  /// `The expiration date\n +%s days`
  String get extend_duration_format {
    return Intl.message(
      'The expiration date\n +%s days',
      name: 'extend_duration_format',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get change_language_hori {
    return Intl.message(
      'Change Language',
      name: 'change_language_hori',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `please enter your vaild email`
  String get email_error {
    return Intl.message(
      'please enter your vaild email',
      name: 'email_error',
      desc: '',
      args: [],
    );
  }

  /// `%s repayment due date`
  String get calendar_title {
    return Intl.message(
      '%s repayment due date',
      name: 'calendar_title',
      desc: '',
      args: [],
    );
  }

  /// `%s repayment due date, please pay on time!`
  String get calendar_description {
    return Intl.message(
      '%s repayment due date, please pay on time!',
      name: 'calendar_description',
      desc: '',
      args: [],
    );
  }

  /// `Disclaimer : only download App if you want loan for emergency matters or for essential matters`
  String get splash_hint {
    return Intl.message(
      'Disclaimer : only download App if you want loan for emergency matters or for essential matters',
      name: 'splash_hint',
      desc: '',
      args: [],
    );
  }

  /// `This product Launched by Sarmaya Microfinance Private Limited（License plate number：SC/NBFC-I-212/SMPL/2021/01`
  String get splash_hint1 {
    return Intl.message(
      'This product Launched by Sarmaya Microfinance Private Limited（License plate number：SC/NBFC-I-212/SMPL/2021/01',
      name: 'splash_hint1',
      desc: '',
      args: [],
    );
  }

  /// `Launched by Sarmaya Microfinance Private Limited licensed by SECP`
  String get secp_text {
    return Intl.message(
      'Launched by Sarmaya Microfinance Private Limited licensed by SECP',
      name: 'secp_text',
      desc: '',
      args: [],
    );
  }

  /// `Consumer Hotline`
  String get consumer_hotline {
    return Intl.message(
      'Consumer Hotline',
      name: 'consumer_hotline',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get hotline_phone {
    return Intl.message(
      'Phone',
      name: 'hotline_phone',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp`
  String get hotline_whatsapp {
    return Intl.message(
      'Whatsapp',
      name: 'hotline_whatsapp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get hotline_email {
    return Intl.message(
      'Email',
      name: 'hotline_email',
      desc: '',
      args: [],
    );
  }

  /// `Focus on`
  String get focus_on {
    return Intl.message(
      'Focus on',
      name: 'focus_on',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get call_us {
    return Intl.message(
      'Call Us',
      name: 'call_us',
      desc: '',
      args: [],
    );
  }

  /// `Chat Us`
  String get chat_us {
    return Intl.message(
      'Chat Us',
      name: 'chat_us',
      desc: '',
      args: [],
    );
  }

  /// `Email Us`
  String get email_us {
    return Intl.message(
      'Email Us',
      name: 'email_us',
      desc: '',
      args: [],
    );
  }

  /// `Follow us`
  String get follow_us {
    return Intl.message(
      'Follow us',
      name: 'follow_us',
      desc: '',
      args: [],
    );
  }

  /// `Maximum loan period 91 days`
  String get home_day_hint {
    return Intl.message(
      'Maximum loan period 91 days',
      name: 'home_day_hint',
      desc: '',
      args: [],
    );
  }

  /// `Whether the salary is below 50,000`
  String get salary_text {
    return Intl.message(
      'Whether the salary is below 50,000',
      name: 'salary_text',
      desc: '',
      args: [],
    );
  }

  /// `Yes or No`
  String get salary_text_hint {
    return Intl.message(
      'Yes or No',
      name: 'salary_text_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm whether the receiving account number is correct`
  String get bk_dialog_hint1 {
    return Intl.message(
      'Please confirm whether the receiving account number is correct',
      name: 'bk_dialog_hint1',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Undertaking`
  String get undertaking {
    return Intl.message(
      'Undertaking',
      name: 'undertaking',
      desc: '',
      args: [],
    );
  }

  /// `I %s CNIC %s solemnly declare that to the best of my knowledge & belief the information is correct & complete.`
  String get undertaking_content {
    return Intl.message(
      'I %s CNIC %s solemnly declare that to the best of my knowledge & belief the information is correct & complete.',
      name: 'undertaking_content',
      desc: '',
      args: [],
    );
  }

  /// `If you fail to repay the loan, your name will be added to Ecib after that you won't be able to get any benefits from bank and credit institutions.`
  String get confirm_loan_hint {
    return Intl.message(
      'If you fail to repay the loan, your name will be added to Ecib after that you won\'t be able to get any benefits from bank and credit institutions.',
      name: 'confirm_loan_hint',
      desc: '',
      args: [],
    );
  }

  /// `Loan Detail`
  String get loan_detail {
    return Intl.message(
      'Loan Detail',
      name: 'loan_detail',
      desc: '',
      args: [],
    );
  }

  /// `Successful\nwithdrawal`
  String get successful_withdrawal {
    return Intl.message(
      'Successful\nwithdrawal',
      name: 'successful_withdrawal',
      desc: '',
      args: [],
    );
  }

  /// `Next loan\nget a raise`
  String get item_next_loan {
    return Intl.message(
      'Next loan\nget a raise',
      name: 'item_next_loan',
      desc: '',
      args: [],
    );
  }

  /// `Operation cost`
  String get operation_cost {
    return Intl.message(
      'Operation cost',
      name: 'operation_cost',
      desc: '',
      args: [],
    );
  }

  /// `Risk cost`
  String get risk_cost {
    return Intl.message(
      'Risk cost',
      name: 'risk_cost',
      desc: '',
      args: [],
    );
  }

  /// `Verification cost`
  String get verification_cost {
    return Intl.message(
      'Verification cost',
      name: 'verification_cost',
      desc: '',
      args: [],
    );
  }

  /// `Credit scoring`
  String get credit_scoring {
    return Intl.message(
      'Credit scoring',
      name: 'credit_scoring',
      desc: '',
      args: [],
    );
  }

  /// `I got it`
  String get i_got_it {
    return Intl.message(
      'I got it',
      name: 'i_got_it',
      desc: '',
      args: [],
    );
  }

  /// `<Privacy Policy>`
  String get privacy_policy {
    return Intl.message(
      '<Privacy Policy>',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Update receiving account`
  String get update_receiving_account {
    return Intl.message(
      'Update receiving account',
      name: 'update_receiving_account',
      desc: '',
      args: [],
    );
  }

  /// `Fast Repayment`
  String get fast_repayment {
    return Intl.message(
      'Fast Repayment',
      name: 'fast_repayment',
      desc: '',
      args: [],
    );
  }

  /// `Please carefully read the above agreement, agreed to check and enter the next step.`
  String get login_bottom_hint {
    return Intl.message(
      'Please carefully read the above agreement, agreed to check and enter the next step.',
      name: 'login_bottom_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please get OTP first.`
  String get login_code_hint {
    return Intl.message(
      'Please get OTP first.',
      name: 'login_code_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please tick the agreement first.`
  String get login_cb_hint {
    return Intl.message(
      'Please tick the agreement first.',
      name: 'login_cb_hint',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all information completely.`
  String get button_disable_hint {
    return Intl.message(
      'Please fill in all information completely.',
      name: 'button_disable_hint',
      desc: '',
      args: [],
    );
  }

  /// `Feedback\n`
  String get feedback {
    return Intl.message(
      'Feedback\n',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Customer service ticket`
  String get feedback_list_title {
    return Intl.message(
      'Customer service ticket',
      name: 'feedback_list_title',
      desc: '',
      args: [],
    );
  }

  /// `Replied`
  String get replied {
    return Intl.message(
      'Replied',
      name: 'replied',
      desc: '',
      args: [],
    );
  }

  /// `No reply`
  String get no_reply {
    return Intl.message(
      'No reply',
      name: 'no_reply',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter`
  String get please_enter {
    return Intl.message(
      'Please Enter',
      name: 'please_enter',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get return_text {
    return Intl.message(
      'Return',
      name: 'return_text',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit_text {
    return Intl.message(
      'Submit',
      name: 'submit_text',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully repaid!`
  String get pay_successfully {
    return Intl.message(
      'You have successfully repaid!',
      name: 'pay_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Please don't trust any customer service representatives or others who ask you to transfer money of repayment! Please transfer money according to the repayment guide in this APP. Currently, only the official Easypaisa and Jazzcash APPs are supported for repayment.`
  String get repayment_reminder {
    return Intl.message(
      'Please don\'t trust any customer service representatives or others who ask you to transfer money of repayment! Please transfer money according to the repayment guide in this APP. Currently, only the official Easypaisa and Jazzcash APPs are supported for repayment.',
      name: 'repayment_reminder',
      desc: '',
      args: [],
    );
  }

  /// `Max Credit Amount`
  String get max_credit_amount {
    return Intl.message(
      'Max Credit Amount',
      name: 'max_credit_amount',
      desc: '',
      args: [],
    );
  }

  /// `Your current maximum borrowing amount %s.`
  String get max_credit_amount_hint {
    return Intl.message(
      'Your current maximum borrowing amount %s.',
      name: 'max_credit_amount_hint',
      desc: '',
      args: [],
    );
  }

  /// `Late Fee`
  String get late_fee {
    return Intl.message(
      'Late Fee',
      name: 'late_fee',
      desc: '',
      args: [],
    );
  }

  /// `Deduction Fee`
  String get deduction_fee {
    return Intl.message(
      'Deduction Fee',
      name: 'deduction_fee',
      desc: '',
      args: [],
    );
  }

  /// `Please tick the agreement first`
  String get loan_agreement_hint {
    return Intl.message(
      'Please tick the agreement first',
      name: 'loan_agreement_hint',
      desc: '',
      args: [],
    );
  }

  /// `Loading failed, pull down refresh retry`
  String get product_query_fail {
    return Intl.message(
      'Loading failed, pull down refresh retry',
      name: 'product_query_fail',
      desc: '',
      args: [],
    );
  }

  /// `Online Service`
  String get dialog_online_service {
    return Intl.message(
      'Online Service',
      name: 'dialog_online_service',
      desc: '',
      args: [],
    );
  }

  /// `Customer Service`
  String get dialog_customer_service {
    return Intl.message(
      'Customer Service',
      name: 'dialog_customer_service',
      desc: '',
      args: [],
    );
  }

  /// `Cancel an order`
  String get dialog_cancel_an_order {
    return Intl.message(
      'Cancel an order',
      name: 'dialog_cancel_an_order',
      desc: '',
      args: [],
    );
  }

  /// `Cooling of period`
  String get cooling_of_period {
    return Intl.message(
      'Cooling of period',
      name: 'cooling_of_period',
      desc: '',
      args: [],
    );
  }

  /// `Detail of fees`
  String get detail_of_fees {
    return Intl.message(
      'Detail of fees',
      name: 'detail_of_fees',
      desc: '',
      args: [],
    );
  }

  /// `About cooling off period`
  String get about_period_title {
    return Intl.message(
      'About cooling off period',
      name: 'about_period_title',
      desc: '',
      args: [],
    );
  }

  /// `You will only be charged for the CIB & nadra fee incurred if you repay during the cooling off period.`
  String get about_period_content {
    return Intl.message(
      'You will only be charged for the CIB & nadra fee incurred if you repay during the cooling off period.',
      name: 'about_period_content',
      desc: '',
      args: [],
    );
  }

  /// `Do you have any outstanding debts with other loan companies`
  String get debt_title {
    return Intl.message(
      'Do you have any outstanding debts with other loan companies',
      name: 'debt_title',
      desc: '',
      args: [],
    );
  }

  /// `Amount owed to other companies`
  String get debt_amout {
    return Intl.message(
      'Amount owed to other companies',
      name: 'debt_amout',
      desc: '',
      args: [],
    );
  }

  /// `Permanent Address`
  String get permanent_address {
    return Intl.message(
      'Permanent Address',
      name: 'permanent_address',
      desc: '',
      args: [],
    );
  }

  /// `Officer designated`
  String get officer_designated {
    return Intl.message(
      'Officer designated',
      name: 'officer_designated',
      desc: '',
      args: [],
    );
  }

  /// `Name： Muhammad Hamza`
  String get officer_name {
    return Intl.message(
      'Name： Muhammad Hamza',
      name: 'officer_name',
      desc: '',
      args: [],
    );
  }

  /// `Phone：+92 320 2814058`
  String get officer_email {
    return Intl.message(
      'Phone：+92 320 2814058',
      name: 'officer_email',
      desc: '',
      args: [],
    );
  }

  /// `Email ：support@sarmayamf.com`
  String get officer_phone {
    return Intl.message(
      'Email ：support@sarmayamf.com',
      name: 'officer_phone',
      desc: '',
      args: [],
    );
  }

  /// `Address ：Plot # 14 street 22 g8/4`
  String get officer_address {
    return Intl.message(
      'Address ：Plot # 14 street 22 g8/4',
      name: 'officer_address',
      desc: '',
      args: [],
    );
  }

  /// `If you are overdue, a daily overdue fee of 2.5% of your loan amount will be charged.\nFor example, if you borrow PKR10,000, you will be charged PKR250 Late fee every day for overdue repayment. Please repay on time.`
  String get overdue_dialog_tips {
    return Intl.message(
      'If you are overdue, a daily overdue fee of 2.5% of your loan amount will be charged.\nFor example, if you borrow PKR10,000, you will be charged PKR250 Late fee every day for overdue repayment. Please repay on time.',
      name: 'overdue_dialog_tips',
      desc: '',
      args: [],
    );
  }

  /// `Date of Expriry`
  String get date_of_expiry {
    return Intl.message(
      'Date of Expriry',
      name: 'date_of_expiry',
      desc: '',
      args: [],
    );
  }

  /// `Repayment Term`
  String get repayment_term {
    return Intl.message(
      'Repayment Term',
      name: 'repayment_term',
      desc: '',
      args: [],
    );
  }

  /// `Dear %s, your current loan amount is %s, with a loan term of %s days and a maturity date of %s. The amount to be repaid upon maturity is %s`
  String get speak_text {
    return Intl.message(
      'Dear %s, your current loan amount is %s, with a loan term of %s days and a maturity date of %s. The amount to be repaid upon maturity is %s',
      name: 'speak_text',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enter_otp {
    return Intl.message(
      'Enter OTP',
      name: 'enter_otp',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ur'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
