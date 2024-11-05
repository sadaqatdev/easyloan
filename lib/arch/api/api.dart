import 'package:sprintf/sprintf.dart';

import '../../utils/aes.dart';

class Api {
  static String latitude = "latitude";
  static String longitude = "longitude";

  static String getAppInfo() {
    return sprintf("/%s/%s", [anon, getAppInfoStr]);
  }

  static String getAppConfig() {
    return sprintf("/%s/%s", [anon, getAppConfigStr]);
  }

  static String region() {
    return sprintf("/%s/%s", [anon, regionStr]);
  }

  static String getAppImageList() {
    return sprintf("/%s/%s", [anon, getAppImageListStr]);
  }

  static String index() {
    return sprintf("/%s/%s", [anon, indexStr]);
  }

  static String genData() {
    return sprintf("/%s/%s", [anon, genDataStr]);
  }

  static String staticOverCustData() {
    return sprintf("/%s/%s", [anon, staticOverCustDataStr]);
  }

  static String getReborrowFlag() {
    return sprintf("/%s/%s", [cust, getReborrowFlagStr]);
  }

  static String vipProducts() {
    return sprintf("/%s/%s", [cust, vipProductsStr]);
  }

  static String uploadOperation() {
    return sprintf("/%s/%s", [anon, uploadOperationStr]);
  }

  static String getVerifCode() {
    return sprintf("/%s/%s", [login, getVerifCodeStr]);
  }

  static String loginForSms() {
    return sprintf("/%s/%s", [login, loginForSmsStr]);
  }

  static String getIdentificationResult() {
    return sprintf("/%s/%s", [cust, getIdentificationResultStr]);
  }

  static String identification() {
    return sprintf("/%s/%s", [cust, identificationStr]);
  }

  static String identificationV2() {
    return sprintf("/%s/%s", [cust, identificationV2Str]);
  }

  static String saveBasicCustInfo() {
    return sprintf("/%s/%s", [cust, saveBasicCustInfoStr]);
  }

  static String custInfoBasicQuery() {
    return sprintf("/%s/%s", [cust, custInfoBasicQueryStr]);
  }

  static String linkmanQuery() {
    return sprintf("/%s/%s", [cust, linkmanQueryStr]);
  }

  static String linkmanQueryV2() {
    return sprintf("/%s/%s", [cust, linkmanQueryV2Str]);
  }

  static String msgFeature() {
    return sprintf("/%s/%s", [feature, msgFeatureStr]);
  }

  static String msgFeatureV3() {
    return sprintf("/%s/%s", [featureV3, msgFeatureV3Str]);
  }

  static String saveLinkman() {
    return sprintf("/%s/%s", [cust, saveLinkmanStr]);
  }
  static String saveLinkmanInfo() {
    return sprintf("/%s/%s", [cust, saveLinkmanInfoStr]);
  }
  static String bankCardList() {
    return sprintf("/%s/%s", [cust, bankCardListStr]);
  }

  static String addBank() {
    return sprintf("/%s/%s", [cust, addBankStr]);
  }

  static String queryProduct() {
    return sprintf("/%s/%s", [product, queryProductStr]);
  }

  static String preAmount() {
    return sprintf("/%s/%s", [product, preAmountStr]);
  }

  static String preSubmitOrder() {
    return sprintf("/%s/%s", [order, preSubmitOrderStr]);
  }

  static String submitOrder() {
    return sprintf("/%s/%s", [order, submitOrderStr]);
  }

  static String repayDetail() {
    return sprintf("/%s/%s", [order, repayDetailStr]);
  }

  static String walletRepayUrl() {
    return sprintf("/%s/%s", [order, walletRepayUrlStr]);
  }

  static String checkRepayPoint() {
    return sprintf("/%s/%s", [order, checkRepayPointStr]);
  }

  static String saveRepayPoint() {
    return sprintf("/%s/%s", [order, saveRepayPointStr]);
  }

  static String repaymentInitiate() {
    return sprintf("/%s/%s", [order, repaymentInitiateStr]);
  }

  static String updateOrderPoint() {
    return sprintf("/%s/%s", [mul, updateOrderPointStr]);
  }

  static String indexForMulApp() {
    return sprintf("/%s/%s", [mul, indexForMulAppStr]);
  }

  static String indexForMulAppV2() {
    return sprintf("/%s/%s", [mul, indexForMulAppV2Str]);
  }

  static String orderListForMulApp() {
    return sprintf("/%s/%s", [mul, orderListForMulAppStr]);
  }

  static String copyCustInfo() {
    return sprintf("/%s/%s", [mul, copyCustInfoStr]);
  }

  static String getAppValueList() {
    return sprintf("/%s/%s", [anon, getAppValueListStr]);
  }

  //
  static String getCustLeavingMessageReply() {
    return "/incident/rewindPartDocument";
  }

  //
  static String getCustLeavingMessageByType() {
    return "/incident/hireUnknownCastle";
  }

  // b
  static String saveCustLeavingMessage() {
    return "/incident/armTerminalTechnology";
  }

  static String getAppSetting() {
    return "/impossibleStar/readDrumGetReply";
  }

  static String getSaveLinkmanInfoVerifCode() {
    return sprintf("/%s/%s", [login, getSaveLinkmanInfoVerifCodeStr]);
  }

  static String saveLinkmanInfoV2() {
    return sprintf("/%s/%s", [cust, saveLinkmanInfoV2Str]);
  }

  static String getSaveLinkmanInfoVerifCodeStr = "combinePopularPianoBookcase";
  static String saveLinkmanInfoV2Str = "lateHumorousThirst";
  static String saveLinkmanInfoStr = "driveHumorousPrinter";
  static String getAppValueListStr = "lastManyPetrol";
  static String getAppInfoStr = "broadcastFinalDish";
  static String getAppConfigStr = "postponeNativeSouthwest";
  static String regionStr = "explodeBetterAnybody";
  static String getAppImageListStr = "insureNeatFlag";
  static String indexStr = "performRoundaboutFeeling";
  static String genDataStr = "huntPopularFamily";
  static String staticOverCustDataStr = "believeTroublesomePrayer";
  static String getReborrowFlagStr = "takeModernNight";
  static String vipProductsStr = "graduateLiquidGreengrocer";
  static String uploadOperationStr = "cutSuitableBaseball";
  static String getVerifCodeStr = "combinePopularPiano";
  static String loginForSmsStr = "fillBrightSense";
  static String getIdentificationResultStr = "hireSleepyViolence";
  static String identificationStr = "equipCrowdedChat";
  static String saveBasicCustInfoStr = "misunderstandBasicEngine";
  static String custInfoBasicQueryStr = "rescueSeveralShore";
  static String linkmanQueryStr = "playConservativePassport";
  static String linkmanQueryV2Str = "starveForgetfulSilk";
  static String msgFeatureStr = "mindMinibusGoldfish";
  static String msgFeatureV3Str = "kissFederalJuice";
  static String saveLinkmanStr = "spotClearSpain";
  static String bankCardListStr = "devoteUndergroundHospital";
  static String addBankStr = "begLivingPainting";
  static String queryProductStr = "damageEagerGale";
  static String preAmountStr = "changeJapaneseTraveler";
  static String preSubmitOrderStr = "pickQuietCourse";
  static String submitOrderStr = "helpTallPro";
  static String repayDetailStr = "fastenThickMercy";
  static String walletRepayUrlStr = "glareSouthernHill";
  static String checkRepayPointStr = "boundUnfairChocolate";
  static String saveRepayPointStr = "slideLongGeometry";
  static String repaymentInitiateStr = "equipDullTitle";
  static String updateOrderPointStr = "raiseThankfulAthlete";
  static String indexForMulAppStr = "consistQuietItself";
  static String indexForMulAppV2Str = "shootFormerSystem";
  static String orderListForMulAppStr = "shaveHardSoul";
  static String copyCustInfoStr = "letLeadingFish";
  static String identificationV2Str = "equipCrowdedChatV2";

  static String linkmanValue = "endFestivalEmpireGlobe";
  static String appInstanceId = "highClockLameCowboy";
  static String emails = "italianBankGreekEntrance";
  static String whatsapps = "aggressiveHungryKitchenFright";
  static String mobiles = "southernAwardEarlySoccerExcellentLung";
  static String anon = "impossibleStar";
  static String cust = "carefulArrangement";
  static String login = "dirt";
  static String feature = "technicalExhibition";
  static String featureV3 = "fancySecretary";
  static String product = "tablet";
  static String order = "tiredHen";
  static String mul = "goldfish";
  static String appssid = "happyLivelyPetrolEuropeanReply";
  static String userId = "furnishedPatientBeautifulGram";
  static String language = "grandNetworkSuchSeriousAccount";
  static String ip = "smellyTheSausageTroop";
  static String deviceId = "juicyFlyLessMyselfInterestingFan";
  static String imei = "deadFlashBakery";
  static String versionName = "swiftFruitFullMyself";
  static String channel = "mountainousDetectiveTeamworkBadSpoonful";
  static String imageType = "flatActionEndlessComfortableSilk";
  static String versionCode = "aboveSexTeapotIsland";
  static String pageIndex = "nationalBacteriumTranslationIndependentChapter";
  static String pageSize = "americanRatExactPepperPoliteShanghai";
  static String systemMode = "severalPrinterFierceMentalSalt";
  static String orderId = "australianShoppingTin";
  static String googleMobileNo = "longHospitalDirtyBookshopUncertainField";
  static String googleGaid = "averageCoupleUncertainBoss";
  static String googleUserAgent = "cubicStadium";
  static String apiName = "constantTokyoSecretArabLength";
  static String client_id = "dullGlueUnmarriedUsefulLaw";
  static String currentUserId = "greatFireplaceDullSoft";
  static String token = "deadRoofVastEmpire";
  static String device_id = "clearSpainCloudDifference";
  static String v_flag = "modernTrainerNonFloor";
  static String mulFlag = "violentRequirementJuicyPint";
  static String code = "personalProperHallPark";
  static String msg = "majorFlagJustCrossFountain";
  static String data = "ancientLicenseForgetfulTiger";
  static String frontImage = "technicalBreadLeather";
  static String backImage = "plainCourtyardPublicToothacheBanana";
  static String appName = "rectangleSelfRainbowTomato";
  static String logoUrl = "mexicanTermCartoonBlueHusband";
  static String appVersion = "tiresomeActivityAustralianCollar";
  static String appDownUrl = "literaryGarbageLongStupidPool";
  static String forceUpdateFlag = "mobileFollowingPork";
  static String promptMsg = "unmarriedHillsideRoundPineapple";
  static String showUrl = "braveReservationFrontPro";
  static String appMobile = "seniorSpokenShabbyFireplace";
  static String appPackageName = "dailyAshamedMerryNose";
  static String key = "festivalNextFilmUnusualPoster";
  static String type = "followingDictionarySpiritualBaggage";
  static String value = "mobileFistLowJuly";
  static String regionParentId = "holyMonumentPlainTailorTrip";
  static String regionlevel = "crazyMicroscopeBridgeSausage";
  static String regionId = "chemicalManagerBank";
  static String regionName = "hardworkingSuccessfulPleasureScholar";
  static String regionLevel = "undividedEffortAnxiousSalesgirlStory";
  static String zipCode = "necessaryPageGreatGeneration";
  static String url = "probableDollarCourtyard";
  static String ext1 = "metalNeedle";
  static String ext2 = "dearFormerPrescription";
  static String ext3 = "dizzyPopcornExtraordinaryPersonalPostcard";
  static String reborrowFlag = "forgetfulMeal";
  static String easyPayFlag = "familiarForgetfulAloneCoffee";
  static String jazzCashFlag = "crazyGuiltyPerTastySize";
  static String overdueStatus =
      "unsuccessfulManagerPoliteSurfaceInterestingCentimetre";
  static String creditAmount = "standardPartyTiresomeStrengthRoot";
  static String firstLoanReject = "fairCordlessHorse";
  static String orderNo = "stillLocustBasicHongLittleMid";
  static String intAmount = "spiritualSteakFrontGranny";
  static String duration = "hardworkingNearGentlemanTelegram";
  static String desc = "hillyAmericanCoolDifference";
  static String loanStatus = "civilLazyBirth";
  static String approveStatus = "funnySureMinibusSun";
  static String approvalStatusDesc = "racialSilverTomb";
  static String repayAmt = "fastPartnerRareLemonade";
  static String iva = "suddenJewel";
  static String repayFlag = "absentVacationPancakeAncientZoo";
  static String applyDate = "simpleDictationSquareMaid";
  static String repaymentDate = "arcticCab";
  static String lateFee = "medicalTopicSeptemberFriendlyTram";
  static String deductionFee = "rectangleHonestStrait";
  static String overdueDays = "cottonSomethingExpensiveSheetCoal";
  static String extendFlag = "japaneseInitialSafeJustice";
  static String loanFinish = "rareThemselvesCarelessManner";
  static String firstLoanFinish = "cottonExtraPaddleAggressiveHardship";
  static String easyPayNumber = "northernBorderLastStudent";
  static String easyCompanyName = "activeHistoryShabbyBookmarkConvenientPurse";
  static String mprepayflag = "valuableConstructionTentRichEquality";
  static String yesLoanCount = "anotherAbilityLivelyLatter";
  static String perLoanAmount = "italianCowboy";
  static String loanRate = "aliveAfraidRelative";
  static String curRepayCount = "passiveFrequentGiraffe";
  static String totalRepayCount = "loudGentleVisitorPolitician";
  static String curRepayRate = "irishStewardLetter";
  static String name = "farBoyCordlessBrick";
  static String custList = "suchLiveCarHunger";
  static String custName = "impossibleMostDishMess";
  static String idNo = "familiarPassageThemTheme";
  static String vipProductImageUrl = "southernSuitableDistance";
  static String vipProductList = "lovelyJusticeNumberRudeBelgium";
  static String downUrl = "popularEmpireTortoiseUnfortunateLab";
  static String optType = "triangleYesterdayThoroughNetwork";
  static String gpsInfo = "majorBikeBirthplace";
  static String lbs = "hungryBlow";
  static String equipmentBrand = "tallDiskNewspaperNationality";
  static String equipmentType = "sorryAccidentToothVillager";
  static String gaid = "musicalMistFlatGlobe";
  static String uuid = "contraryBlankChiefPasser";
  static String os_version = "electricalLowCanada";
  static String user_agent = "violentChipsSorryEquipment";
  static String mobile_language = "lemonPrideBathroom";
  static String phoneNo = "endlessKnifeLovelySpace";
  static String smsCode = "valuableFestivalDrierCough";
  static String newCustFlag = "darkStewardProvince";
  static String fullName = "favouriteQualitySpace";
  static String fatherName = "cleverDormitoryDowntownConversation";
  static String cardFrontFlag = "formerDizzyFilm";
  static String cardFrontUrl = "violentTastelessSkilledHive";
  static String cardBackFlag = "followingBootDigestSpellingAmusement";
  static String cardBackUrl = "strongSeparationIce";
  static String faceVerified = "americanHillsideLeftoverPhotographer";
  static String faceSimilarity = "physicalSubtractionAfricanIncorrectDrug";
  static String afaceUrl = "looseFarStocking";
  static String custInfoWorkFlag = "localChineseIncorrectAirport";
  static String custInfoBaseFlag = "eastSonAfraidRiddle";
  static String basicFlag = "blueHydrogenAtlanticCounter";
  static String bankCardFlag = "tiresomeFreeIndeedMatter";
  static String bankCardDesc = "triangleRadioFrontBridge";
  static String bankCardImagFlag = "difficultEmergency";
  static String bankCardImagUrl = "contraryHungerFridayPineapple";
  static String relationFlag = "unablePunishmentPracticalEagerSale";
  static String sfPayResult = "luckyGrainComfort";
  static String sex = "privateAlarmMinorityThirst";
  static String sexDesc = "mercifulNeitherTechnologyBookcase";
  static String birthDay = "tinyBrickCubicThread";
  static String maritalStatus = "youngBeltLadyHillside";
  static String maritalStatusDesc = "coldNearCoolBookstore";
  static String education = "primaryVcdJourneyBritain";
  static String educationDesc = "suchTonightLamb";
  static String homeAddress = "smellySignatureDriving";
  static String email = "loudDecisionFreshBlouse";
  static String validDate = "lateBirdDanger";
  static String residentialTown = "loudHumanSee";
  static String residentialCity = "brokenSmellFalseFuelArm";
  static String residentialDistrict = "foolishGreengrocerUnableSpade";
  static String residentialState = "suchChineseGold";
  static String residentialCityCode = "drunkBridegroomArcticVinegar";
  static String residentialStateCode = "flatStringUnrestKing";
  static String workType = "splendidSurroundingNetworkDustyJoy";
  static String workTypeDesc = "splendidAshamedGrammar";
  static String incomeLevel = "electronicHealthCoolMemory";
  static String incomeLevelDesc = "backStrongSoldierEnemy";
  static String companyName = "primarySteadyHiveDetective";
  static String companyPhone = "healthyMountainImmediateCabbageIndia";
  static String payPeriod = "nearSense";
  static String positionDesc = "russianCaptainLoudStream";
  static String companyAddress = "fondSmellyCertificateRuler";
  static String companyResidentialCity = "inlandNovelistEnemySignal";
  static String companyResidentialDistrict = "stupidSoulHusbandSoftArt";
  static String companyResidentialTown = "freezingNailLatePrayer";
  static String companyResidentialState = "impossibleChairSlimTable";
  static String loanPurpose = "rightBeautyGreetingGuiltyPassage";
  static String loanPurposeDesc = "hardworkingSmoothPlainStadium";
  static String monthlyIncomeScope = "privateRopeInitialChangeableEdition";
  static String monthlyIncomeScopeDesc = "dizzyTokyoBroadIncidentAbovePlayer";
  static String phoneNumber = "giftedFacialTranslationPreciousLawyer";
  static String relationship = "fondPardonDeadSignCrop";
  static String relationshipName = "smokeSureZero";
  static String phoneNumberSec = "aggressiveFamily";
  static String nameSec = "merryBookcaseMerryMoreFarmer";
  static String relationshipSec = "englishSilenceBeautifulValleyFestivalBathtub";
  static String relationshipSecName = "busyMiddayAggressiveMerryVacation";
  static String fullAddress = "luckyCrossNovelist";
  static String permanentAddress = "artCropBritainThirst";
  static String position = "heavyChainLatestDifficulty";
  static String bankName = "rudeUnableSayingCrossPosition";
  static String bankNameDesc = "expensiveCuriousPrimaryVariety";
  static String bankAccountNumber = "saltyFact";
  static String payType = "possibleHairHopelessGet";
  static String payTypeDesc = "theseYoungPower";
  static String branchCode = "convenientBoxPreciousStraightAntique";
  static String orderFaildAddFlag = "deepBarberKidMadam";
  static String bankCardUrl = "cleverPoliticsSoutheast";
  static String productId = "somePoliticalStrength";
  static String productName = "nobleElectricAstronaut";
  static String prodetailList = "localRagConstruction";
  static String detailId = "racialSnowTheoreticalRoomPan";
  static String rate = "endlessGrandTripResearch";
  static String maxCreditAmount = "sadSliceMadUndergroundPrison";
  static String minCreditAmount = "europeanFullPrayer";
  static String incrAmount = "nonGoodnessExtraordinaryDifferenceSureLift";
  static String applyAmount = "interestingHeavenVocabularyEveryList";
  static String preAmountField = "tightPrintingSingerDarkNorthwest";
  static String disbursalAmount = "strangeSonSmallSeed";
  static String serviceFee = "excellentCamelGladRoomBoundMemorial";
  static String serviceFeeNew = "honestThreadCertificateTrack";
  static String processingFee = "eastFightCompressedPrize";
  static String productConfigId = "tensePieceBothDepth";
  static String repaymentBank = "russianLoudQuarter";
  static String repaymentBankNo = "magicPatternNoisyCompressedBase";
  static String payOrderId = "physicalTroublesomeActualEnvelope";
  static String payAmount = "shortRefreshments";
  static String mobile = "broadCultureCarpet";
  static String orderStatus = "dizzyPacificHeadline";
  static String contractList = "gayHolyTyre";
  static String epochFlag = "americanSugarInterestingBeefBicycle";
  static String interest = "instantBothPedestrian";
  static String extendDuration = "probableStandardNervousThe";
  static String extendDate = "dirtySunlightInvitationDampPronunciation";
  static String afterExtendOrderAmt = "italianRainyActiveCarbon";
  static String repayPoint = "guiltyThemselvesSecondPintDullSecret";
  static String createTime = "suitablePopularAlivePer";
  static String payOutId = "punctualPassiveSteward";
  static String curUserId = "everydayEnemyHotThinking";
  static String endDate = "localGermanLungConvenientCup";
  static String startDate = "easyYouthUnpleasantHandwritingRoughZipper";
  static String settleDate = "saltyGymThisSaltMouthful";
  static String appSsid = "uglyImpressionArcticParkingPlayer";
  static String viewStatus = "classicalGasSmellyRice";
  static String repayDate = "strictSheepSomeone";
  static String ogAppssid = "boundUnknownSpaceship";
  static String newUserId = "communistAddressRedBeginning";
  static String serverTime = "sillySeniorArrivalUnpleasantPhysics";
  static String salaryLimit = "politeBackSkirt";
  static String salaryLimitDesc = "happyDisabledBottom";
  static String jazzCashPayOutId = "tinThinkingEnemy";
  static String testCustFlag = "swissThe";
  static String totalAmount = "blueTinNervousThe";
  static String amount = "everyListBlueTermThe";
  static String overdueRate = "anotherArcticCab";
  static String foreignDebts = "luckyBackSkirt";
  static String foreignDebtsDesc = "spaceBackGold";
  static String foreignDebtsAmount = "politeBritain";
  static String newContractList = "newContractList";
  static String expiryDate = "expiryCourtyard";
  static String linkmanResponse = "lonelyFreshFirewoodSimpleSkirt";

  static String androidValue() {
    return AesUtil.decrypt("69960e63dff2dc348b8263b85b355e84");
  }

  static String payTypeValue() {
    return AesUtil.decrypt("d5e8a7c4ac795b559b7d5d21a403641d");
  }

  static String bankNameListValue() {
    return AesUtil.decrypt("0bedec09c06805ce6b982cbf95226bbe");
  }

  static String sexValue() {
    return AesUtil.decrypt("23795ffb516f7eaf1d00bec7ff7b3118");
  }

  static String educationValue() {
    return AesUtil.decrypt("211b2d6c57feed6e81235b41a034504f");
  }

  static String maritalStatusValue() {
    return AesUtil.decrypt("48063b4e3f2886c9328d6d6a1bd97daf");
  }

  static String loanPurposeValue() {
    return AesUtil.decrypt("fe562e3622b250e690088fae530e6b7b");
  }

  static String relationshipValue() {
    return AesUtil.decrypt("5bcac9b7eae22af0c9b4d199f9dbed73");
  }

  static String secRelationshipValue() {
    return AesUtil.decrypt("3a3fa46b7ad6faa6238658b4e94cf87f");
  }

  static String positionValue() {
    return AesUtil.decrypt("9f2b18f156b7375224a87e2de6dfa47a");
  }

  static String workTypeValue() {
    return AesUtil.decrypt("569a606e0390abb09f2e90cba04d4ceb");
  }

  static String monthlyIncomValue() {
    return AesUtil.decrypt("68a1101ce704fc000d2637f86f9a8128");
  }

  static String newrealtermValue() {
    return AesUtil.decrypt("3b60e36a81c0b0d82bcb1f5b44cecd06");
  }

  static String enValue() {
    return AesUtil.decrypt("1809857589375ed1befa20591da80699");
  }

  static String httpAgentValue() {
    return AesUtil.decrypt("83ed212fcd04934410743424fca546e8");
  }

  static String mPSuccessValue() {
    return AesUtil.decrypt("6e993c4cb00f68b2ddaf0522bcb01317");
  }

  static String salaryLimitValue() {
    return AesUtil.decrypt("e562956ab0eb10f3ef067be64e4cb296");
  }

  static String bankMobileOpenSwitchValue() {
    return AesUtil.decrypt("786fa4536d20deaaa77335bf7c8f43ccc012576bc69ed65eb20d071f4da6e0d7");
  }

  static String foreignDebtsValue() {
    return AesUtil.decrypt("9703d6c70368dedd302205a57c1ad7f7");
  }

  static String newWorkTypeValue() {
    return AesUtil.decrypt("c23d667770e5732fc44494a9158c17dc");
  }

  static String newRelationshipValue() {
    return AesUtil.decrypt("01dcf713f3c6f65da274f60158da8682");
  }




}
