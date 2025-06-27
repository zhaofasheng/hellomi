class FetchSettingModel {
  FetchSettingModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  FetchSettingModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  FetchSettingModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      FetchSettingModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    Currency? currency,
    bool? isGooglePlayEnabled,
    bool? isStripeEnabled,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isRazorpayEnabled,
    String? razorPayId,
    String? razorSecretKey,
    bool? isFlutterwaveEnabled,
    String? flutterWaveId,
    String? privacyPolicyLink,
    String? termsOfUsePolicyLink,
    bool? isDummyData,
    int? loginBonus,
    int? privateCallRate,
    int? durationOfShorts,
    int? minCoinsToCashOut,
    int? minCoinsForPayout,
    int? pkEndTime,
    List<String>? videoBanned,
    List<String>? postBanned,
    String? sightengineUser,
    String? sightengineApiSecret,
    bool? shortsEffectEnabled,
    String? androidEffectLicenseKey,
    String? iosEffectLicenseKey,
    bool? watermarkEnabled,
    String? watermarkIcon,
    PrivateKey? privateKey,
    String? createdAt,
    String? updatedAt,
    List<String>? profilePhotoList,
    int? agencyMinPayout,
    List<Game>? game,
    String? agoraAppCertificate,
    String? agoraAppId,
  }) {
    _id = id;
    _currency = currency;
    _isGooglePlayEnabled = isGooglePlayEnabled;
    _isStripeEnabled = isStripeEnabled;
    _stripePublishableKey = stripePublishableKey;
    _stripeSecretKey = stripeSecretKey;
    _isRazorpayEnabled = isRazorpayEnabled;
    _razorPayId = razorPayId;
    _razorSecretKey = razorSecretKey;
    _isFlutterwaveEnabled = isFlutterwaveEnabled;
    _flutterWaveId = flutterWaveId;
    _privacyPolicyLink = privacyPolicyLink;
    _termsOfUsePolicyLink = termsOfUsePolicyLink;
    _isDummyData = isDummyData;
    _loginBonus = loginBonus;
    _privateCallRate = privateCallRate;
    _durationOfShorts = durationOfShorts;
    _minCoinsToCashOut = minCoinsToCashOut;
    _minCoinsForPayout = minCoinsForPayout;
    _pkEndTime = pkEndTime;
    _videoBanned = videoBanned;
    _postBanned = postBanned;
    _sightengineUser = sightengineUser;
    _sightengineApiSecret = sightengineApiSecret;
    _shortsEffectEnabled = shortsEffectEnabled;
    _androidEffectLicenseKey = androidEffectLicenseKey;
    _iosEffectLicenseKey = iosEffectLicenseKey;
    _watermarkEnabled = watermarkEnabled;
    _watermarkIcon = watermarkIcon;
    _privateKey = privateKey;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _profilePhotoList = profilePhotoList;
    _agencyMinPayout = agencyMinPayout;
    _game = game;
    _agoraAppCertificate = agoraAppCertificate;
    _agoraAppId = agoraAppId;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
    _isGooglePlayEnabled = json['isGooglePlayEnabled'];
    _isStripeEnabled = json['isStripeEnabled'];
    _stripePublishableKey = json['stripePublishableKey'];
    _stripeSecretKey = json['stripeSecretKey'];
    _isRazorpayEnabled = json['isRazorpayEnabled'];
    _razorPayId = json['razorPayId'];
    _razorSecretKey = json['razorSecretKey'];
    _isFlutterwaveEnabled = json['isFlutterwaveEnabled'];
    _flutterWaveId = json['flutterWaveId'];
    _privacyPolicyLink = json['privacyPolicyLink'];
    _termsOfUsePolicyLink = json['termsOfUsePolicyLink'];
    _isDummyData = json['isDummyData'];
    _loginBonus = json['loginBonus'];
    _privateCallRate = json['privateCallRate'];
    _durationOfShorts = json['durationOfShorts'];
    _minCoinsToCashOut = json['minCoinsToCashOut'];
    _minCoinsForPayout = json['minCoinsForPayout'];
    _pkEndTime = json['pkEndTime'];
    _videoBanned = json['videoBanned'] != null ? json['videoBanned'].cast<String>() : [];
    _postBanned = json['postBanned'] != null ? json['postBanned'].cast<String>() : [];
    _sightengineUser = json['sightengineUser'];
    _sightengineApiSecret = json['sightengineApiSecret'];
    _shortsEffectEnabled = json['shortsEffectEnabled'];
    _androidEffectLicenseKey = json['androidEffectLicenseKey'];
    _iosEffectLicenseKey = json['iosEffectLicenseKey'];
    _watermarkEnabled = json['watermarkEnabled'];
    _watermarkIcon = json['watermarkIcon'];
    _privateKey = json['privateKey'] != null ? PrivateKey.fromJson(json['privateKey']) : null;
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _profilePhotoList = json['profilePhotoList'] != null ? json['profilePhotoList'].cast<String>() : [];
    _agencyMinPayout = json['agencyMinPayout'];
    if (json['game'] != null) {
      _game = [];
      json['game'].forEach((v) {
        _game?.add(Game.fromJson(v));
      });
    }
    _agoraAppCertificate = json['agoraAppCertificate'];
    _agoraAppId = json['agoraAppId'];
  }
  String? _id;
  Currency? _currency;
  bool? _isGooglePlayEnabled;
  bool? _isStripeEnabled;
  String? _stripePublishableKey;
  String? _stripeSecretKey;
  bool? _isRazorpayEnabled;
  String? _razorPayId;
  String? _razorSecretKey;
  bool? _isFlutterwaveEnabled;
  String? _flutterWaveId;
  String? _privacyPolicyLink;
  String? _termsOfUsePolicyLink;
  bool? _isDummyData;
  int? _loginBonus;
  int? _privateCallRate;
  int? _durationOfShorts;
  int? _minCoinsToCashOut;
  int? _minCoinsForPayout;
  int? _pkEndTime;
  List<String>? _videoBanned;
  List<String>? _postBanned;
  String? _sightengineUser;
  String? _sightengineApiSecret;
  bool? _shortsEffectEnabled;
  String? _androidEffectLicenseKey;
  String? _iosEffectLicenseKey;
  bool? _watermarkEnabled;
  String? _watermarkIcon;
  PrivateKey? _privateKey;
  String? _createdAt;
  String? _updatedAt;
  List<String>? _profilePhotoList;
  int? _agencyMinPayout;
  List<Game>? _game;
  String? _agoraAppCertificate;
  String? _agoraAppId;
  Data copyWith({
    String? id,
    Currency? currency,
    bool? isGooglePlayEnabled,
    bool? isStripeEnabled,
    String? stripePublishableKey,
    String? stripeSecretKey,
    bool? isRazorpayEnabled,
    String? razorPayId,
    String? razorSecretKey,
    bool? isFlutterwaveEnabled,
    String? flutterWaveId,
    String? privacyPolicyLink,
    String? termsOfUsePolicyLink,
    bool? isDummyData,
    int? loginBonus,
    int? privateCallRate,
    int? durationOfShorts,
    int? minCoinsToCashOut,
    int? minCoinsForPayout,
    int? pkEndTime,
    List<String>? videoBanned,
    List<String>? postBanned,
    String? sightengineUser,
    String? sightengineApiSecret,
    bool? shortsEffectEnabled,
    String? androidEffectLicenseKey,
    String? iosEffectLicenseKey,
    bool? watermarkEnabled,
    String? watermarkIcon,
    PrivateKey? privateKey,
    String? createdAt,
    String? updatedAt,
    List<String>? profilePhotoList,
    int? agencyMinPayout,
    List<Game>? game,
    String? agoraAppCertificate,
    String? agoraAppId,
  }) =>
      Data(
        id: id ?? _id,
        currency: currency ?? _currency,
        isGooglePlayEnabled: isGooglePlayEnabled ?? _isGooglePlayEnabled,
        isStripeEnabled: isStripeEnabled ?? _isStripeEnabled,
        stripePublishableKey: stripePublishableKey ?? _stripePublishableKey,
        stripeSecretKey: stripeSecretKey ?? _stripeSecretKey,
        isRazorpayEnabled: isRazorpayEnabled ?? _isRazorpayEnabled,
        razorPayId: razorPayId ?? _razorPayId,
        razorSecretKey: razorSecretKey ?? _razorSecretKey,
        isFlutterwaveEnabled: isFlutterwaveEnabled ?? _isFlutterwaveEnabled,
        flutterWaveId: flutterWaveId ?? _flutterWaveId,
        privacyPolicyLink: privacyPolicyLink ?? _privacyPolicyLink,
        termsOfUsePolicyLink: termsOfUsePolicyLink ?? _termsOfUsePolicyLink,
        isDummyData: isDummyData ?? _isDummyData,
        loginBonus: loginBonus ?? _loginBonus,
        privateCallRate: privateCallRate ?? _privateCallRate,
        durationOfShorts: durationOfShorts ?? _durationOfShorts,
        minCoinsToCashOut: minCoinsToCashOut ?? _minCoinsToCashOut,
        minCoinsForPayout: minCoinsForPayout ?? _minCoinsForPayout,
        pkEndTime: pkEndTime ?? _pkEndTime,
        videoBanned: videoBanned ?? _videoBanned,
        postBanned: postBanned ?? _postBanned,
        sightengineUser: sightengineUser ?? _sightengineUser,
        sightengineApiSecret: sightengineApiSecret ?? _sightengineApiSecret,
        shortsEffectEnabled: shortsEffectEnabled ?? _shortsEffectEnabled,
        androidEffectLicenseKey: androidEffectLicenseKey ?? _androidEffectLicenseKey,
        iosEffectLicenseKey: iosEffectLicenseKey ?? _iosEffectLicenseKey,
        watermarkEnabled: watermarkEnabled ?? _watermarkEnabled,
        watermarkIcon: watermarkIcon ?? _watermarkIcon,
        privateKey: privateKey ?? _privateKey,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        profilePhotoList: profilePhotoList ?? _profilePhotoList,
        agencyMinPayout: agencyMinPayout ?? _agencyMinPayout,
        game: game ?? _game,
        agoraAppCertificate: agoraAppCertificate ?? _agoraAppCertificate,
        agoraAppId: agoraAppId ?? _agoraAppId,
      );
  String? get id => _id;
  Currency? get currency => _currency;
  bool? get isGooglePlayEnabled => _isGooglePlayEnabled;
  bool? get isStripeEnabled => _isStripeEnabled;
  String? get stripePublishableKey => _stripePublishableKey;
  String? get stripeSecretKey => _stripeSecretKey;
  bool? get isRazorpayEnabled => _isRazorpayEnabled;
  String? get razorPayId => _razorPayId;
  String? get razorSecretKey => _razorSecretKey;
  bool? get isFlutterwaveEnabled => _isFlutterwaveEnabled;
  String? get flutterWaveId => _flutterWaveId;
  String? get privacyPolicyLink => _privacyPolicyLink;
  String? get termsOfUsePolicyLink => _termsOfUsePolicyLink;
  bool? get isDummyData => _isDummyData;
  int? get loginBonus => _loginBonus;
  int? get privateCallRate => _privateCallRate;
  int? get durationOfShorts => _durationOfShorts;
  int? get minCoinsToCashOut => _minCoinsToCashOut;
  int? get minCoinsForPayout => _minCoinsForPayout;
  int? get pkEndTime => _pkEndTime;
  List<String>? get videoBanned => _videoBanned;
  List<String>? get postBanned => _postBanned;
  String? get sightengineUser => _sightengineUser;
  String? get sightengineApiSecret => _sightengineApiSecret;
  bool? get shortsEffectEnabled => _shortsEffectEnabled;
  String? get androidEffectLicenseKey => _androidEffectLicenseKey;
  String? get iosEffectLicenseKey => _iosEffectLicenseKey;
  bool? get watermarkEnabled => _watermarkEnabled;
  String? get watermarkIcon => _watermarkIcon;
  PrivateKey? get privateKey => _privateKey;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<String>? get profilePhotoList => _profilePhotoList;
  int? get agencyMinPayout => _agencyMinPayout;
  List<Game>? get game => _game;
  String? get agoraAppCertificate => _agoraAppCertificate;
  String? get agoraAppId => _agoraAppId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    map['isGooglePlayEnabled'] = _isGooglePlayEnabled;
    map['isStripeEnabled'] = _isStripeEnabled;
    map['stripePublishableKey'] = _stripePublishableKey;
    map['stripeSecretKey'] = _stripeSecretKey;
    map['isRazorpayEnabled'] = _isRazorpayEnabled;
    map['razorPayId'] = _razorPayId;
    map['razorSecretKey'] = _razorSecretKey;
    map['isFlutterwaveEnabled'] = _isFlutterwaveEnabled;
    map['flutterWaveId'] = _flutterWaveId;
    map['privacyPolicyLink'] = _privacyPolicyLink;
    map['termsOfUsePolicyLink'] = _termsOfUsePolicyLink;
    map['isDummyData'] = _isDummyData;
    map['loginBonus'] = _loginBonus;
    map['privateCallRate'] = _privateCallRate;
    map['durationOfShorts'] = _durationOfShorts;
    map['minCoinsToCashOut'] = _minCoinsToCashOut;
    map['minCoinsForPayout'] = _minCoinsForPayout;
    map['pkEndTime'] = _pkEndTime;
    map['videoBanned'] = _videoBanned;
    map['postBanned'] = _postBanned;
    map['sightengineUser'] = _sightengineUser;
    map['sightengineApiSecret'] = _sightengineApiSecret;
    map['shortsEffectEnabled'] = _shortsEffectEnabled;
    map['androidEffectLicenseKey'] = _androidEffectLicenseKey;
    map['iosEffectLicenseKey'] = _iosEffectLicenseKey;
    map['watermarkEnabled'] = _watermarkEnabled;
    map['watermarkIcon'] = _watermarkIcon;
    if (_privateKey != null) {
      map['privateKey'] = _privateKey?.toJson();
    }
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['profilePhotoList'] = _profilePhotoList;
    map['agencyMinPayout'] = _agencyMinPayout;
    if (_game != null) {
      map['game'] = _game?.map((v) => v.toJson()).toList();
    }
    map['agoraAppCertificate'] = _agoraAppCertificate;
    map['agoraAppId'] = _agoraAppId;
    return map;
  }
}

class Game {
  Game({
    String? name,
    String? image,
    String? link,
    int? minWinPercent,
    int? maxWinPercent,
    bool? isActive,
    String? id,
  }) {
    _name = name;
    _image = image;
    _link = link;
    _minWinPercent = minWinPercent;
    _maxWinPercent = maxWinPercent;
    _isActive = isActive;
    _id = id;
  }

  Game.fromJson(dynamic json) {
    _name = json['name'];
    _image = json['image'];
    _link = json['link'];
    _minWinPercent = json['minWinPercent'];
    _maxWinPercent = json['maxWinPercent'];
    _isActive = json['isActive'];
    _id = json['_id'];
  }
  String? _name;
  String? _image;
  String? _link;
  int? _minWinPercent;
  int? _maxWinPercent;
  bool? _isActive;
  String? _id;
  Game copyWith({
    String? name,
    String? image,
    String? link,
    int? minWinPercent,
    int? maxWinPercent,
    bool? isActive,
    String? id,
  }) =>
      Game(
        name: name ?? _name,
        image: image ?? _image,
        link: link ?? _link,
        minWinPercent: minWinPercent ?? _minWinPercent,
        maxWinPercent: maxWinPercent ?? _maxWinPercent,
        isActive: isActive ?? _isActive,
        id: id ?? _id,
      );
  String? get name => _name;
  String? get image => _image;
  String? get link => _link;
  int? get minWinPercent => _minWinPercent;
  int? get maxWinPercent => _maxWinPercent;
  bool? get isActive => _isActive;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['image'] = _image;
    map['link'] = _link;
    map['minWinPercent'] = _minWinPercent;
    map['maxWinPercent'] = _maxWinPercent;
    map['isActive'] = _isActive;
    map['_id'] = _id;
    return map;
  }
}

class PrivateKey {
  PrivateKey({
    String? type,
    String? projectId,
    String? privateKeyId,
    String? privateKey,
    String? clientEmail,
    String? clientId,
    String? authUri,
    String? tokenUri,
    String? authProviderX509CertUrl,
    String? clientX509CertUrl,
    String? universeDomain,
  }) {
    _type = type;
    _projectId = projectId;
    _privateKeyId = privateKeyId;
    _privateKey = privateKey;
    _clientEmail = clientEmail;
    _clientId = clientId;
    _authUri = authUri;
    _tokenUri = tokenUri;
    _authProviderX509CertUrl = authProviderX509CertUrl;
    _clientX509CertUrl = clientX509CertUrl;
    _universeDomain = universeDomain;
  }

  PrivateKey.fromJson(dynamic json) {
    _type = json['type'];
    _projectId = json['project_id'];
    _privateKeyId = json['private_key_id'];
    _privateKey = json['private_key'];
    _clientEmail = json['client_email'];
    _clientId = json['client_id'];
    _authUri = json['auth_uri'];
    _tokenUri = json['token_uri'];
    _authProviderX509CertUrl = json['auth_provider_x509_cert_url'];
    _clientX509CertUrl = json['client_x509_cert_url'];
    _universeDomain = json['universe_domain'];
  }
  String? _type;
  String? _projectId;
  String? _privateKeyId;
  String? _privateKey;
  String? _clientEmail;
  String? _clientId;
  String? _authUri;
  String? _tokenUri;
  String? _authProviderX509CertUrl;
  String? _clientX509CertUrl;
  String? _universeDomain;
  PrivateKey copyWith({
    String? type,
    String? projectId,
    String? privateKeyId,
    String? privateKey,
    String? clientEmail,
    String? clientId,
    String? authUri,
    String? tokenUri,
    String? authProviderX509CertUrl,
    String? clientX509CertUrl,
    String? universeDomain,
  }) =>
      PrivateKey(
        type: type ?? _type,
        projectId: projectId ?? _projectId,
        privateKeyId: privateKeyId ?? _privateKeyId,
        privateKey: privateKey ?? _privateKey,
        clientEmail: clientEmail ?? _clientEmail,
        clientId: clientId ?? _clientId,
        authUri: authUri ?? _authUri,
        tokenUri: tokenUri ?? _tokenUri,
        authProviderX509CertUrl: authProviderX509CertUrl ?? _authProviderX509CertUrl,
        clientX509CertUrl: clientX509CertUrl ?? _clientX509CertUrl,
        universeDomain: universeDomain ?? _universeDomain,
      );
  String? get type => _type;
  String? get projectId => _projectId;
  String? get privateKeyId => _privateKeyId;
  String? get privateKey => _privateKey;
  String? get clientEmail => _clientEmail;
  String? get clientId => _clientId;
  String? get authUri => _authUri;
  String? get tokenUri => _tokenUri;
  String? get authProviderX509CertUrl => _authProviderX509CertUrl;
  String? get clientX509CertUrl => _clientX509CertUrl;
  String? get universeDomain => _universeDomain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['project_id'] = _projectId;
    map['private_key_id'] = _privateKeyId;
    map['private_key'] = _privateKey;
    map['client_email'] = _clientEmail;
    map['client_id'] = _clientId;
    map['auth_uri'] = _authUri;
    map['token_uri'] = _tokenUri;
    map['auth_provider_x509_cert_url'] = _authProviderX509CertUrl;
    map['client_x509_cert_url'] = _clientX509CertUrl;
    map['universe_domain'] = _universeDomain;
    return map;
  }
}

class Currency {
  Currency({
    String? name,
    String? symbol,
    String? countryCode,
    String? currencyCode,
    bool? isDefault,
  }) {
    _name = name;
    _symbol = symbol;
    _countryCode = countryCode;
    _currencyCode = currencyCode;
    _isDefault = isDefault;
  }

  Currency.fromJson(dynamic json) {
    _name = json['name'];
    _symbol = json['symbol'];
    _countryCode = json['countryCode'];
    _currencyCode = json['currencyCode'];
    _isDefault = json['isDefault'];
  }
  String? _name;
  String? _symbol;
  String? _countryCode;
  String? _currencyCode;
  bool? _isDefault;
  Currency copyWith({
    String? name,
    String? symbol,
    String? countryCode,
    String? currencyCode,
    bool? isDefault,
  }) =>
      Currency(
        name: name ?? _name,
        symbol: symbol ?? _symbol,
        countryCode: countryCode ?? _countryCode,
        currencyCode: currencyCode ?? _currencyCode,
        isDefault: isDefault ?? _isDefault,
      );
  String? get name => _name;
  String? get symbol => _symbol;
  String? get countryCode => _countryCode;
  String? get currencyCode => _currencyCode;
  bool? get isDefault => _isDefault;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['symbol'] = _symbol;
    map['countryCode'] = _countryCode;
    map['currencyCode'] = _currencyCode;
    map['isDefault'] = _isDefault;
    return map;
  }
}
