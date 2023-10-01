class SearchModel {
  Uinfin? uinfin;
  Uinfin? name;
  Sex? sex;
  Sex? race;
  Sex? nationality;
  Uinfin? dob;
  Uinfin? email;
  Mobileno? mobileno;
  Regadd? regadd;
  Sex? housingtype;
  Sex? hdbtype;
  Sex? marital;
  Sex? edulevel;
  NoaBasic? noaBasic;
  Ownerprivate? ownerprivate;
  Cpfcontributions? cpfcontributions;
  Cpfbalances? cpfbalances;
  List<Null>? vehicles;
  Drivinglicence? drivinglicence;

  SearchModel(
      {this.uinfin,
        this.name,
        this.sex,
        this.race,
        this.nationality,
        this.dob,
        this.email,
        this.mobileno,
        this.regadd,
        this.housingtype,
        this.hdbtype,
        this.marital,
        this.edulevel,
        this.noaBasic,
        this.ownerprivate,
        this.cpfcontributions,
        this.cpfbalances,
        this.vehicles,
        this.drivinglicence});

  SearchModel.fromJson(Map<String, dynamic> json) {
    uinfin =
    json['uinfin'] != null ? new Uinfin.fromJson(json['uinfin']) : null;
    name = json['name'] != null ? new Uinfin.fromJson(json['name']) : null;
    sex = json['sex'] != null ? new Sex.fromJson(json['sex']) : null;
    race = json['race'] != null ? new Sex.fromJson(json['race']) : null;
    nationality = json['nationality'] != null
        ? new Sex.fromJson(json['nationality'])
        : null;
    dob = json['dob'] != null ? new Uinfin.fromJson(json['dob']) : null;
    email = json['email'] != null ? new Uinfin.fromJson(json['email']) : null;
    mobileno = json['mobileno'] != null
        ? new Mobileno.fromJson(json['mobileno'])
        : null;
    regadd =
    json['regadd'] != null ? new Regadd.fromJson(json['regadd']) : null;
    housingtype = json['housingtype'] != null
        ? new Sex.fromJson(json['housingtype'])
        : null;
    hdbtype =
    json['hdbtype'] != null ? new Sex.fromJson(json['hdbtype']) : null;
    marital =
    json['marital'] != null ? new Sex.fromJson(json['marital']) : null;
    edulevel =
    json['edulevel'] != null ? new Sex.fromJson(json['edulevel']) : null;
    noaBasic = json['noa-basic'] != null
        ? new NoaBasic.fromJson(json['noa-basic'])
        : null;
    ownerprivate = json['ownerprivate'] != null
        ? new Ownerprivate.fromJson(json['ownerprivate'])
        : null;
    cpfcontributions = json['cpfcontributions'] != null
        ? new Cpfcontributions.fromJson(json['cpfcontributions'])
        : null;
    cpfbalances = json['cpfbalances'] != null
        ? new Cpfbalances.fromJson(json['cpfbalances'])
        : null;
    /*if (json['vehicles'] != null) {
      vehicles = <Null>[];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Null.fromJson(v));
      });
    }*/
    drivinglicence = json['drivinglicence'] != null
        ? new Drivinglicence.fromJson(json['drivinglicence'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uinfin != null) {
      data['uinfin'] = this.uinfin!.toJson();
    }
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.sex != null) {
      data['sex'] = this.sex!.toJson();
    }
    if (this.race != null) {
      data['race'] = this.race!.toJson();
    }
    if (this.nationality != null) {
      data['nationality'] = this.nationality!.toJson();
    }
    if (this.dob != null) {
      data['dob'] = this.dob!.toJson();
    }
    if (this.email != null) {
      data['email'] = this.email!.toJson();
    }
    if (this.mobileno != null) {
      data['mobileno'] = this.mobileno!.toJson();
    }
    if (this.regadd != null) {
      data['regadd'] = this.regadd!.toJson();
    }
    if (this.housingtype != null) {
      data['housingtype'] = this.housingtype!.toJson();
    }
    if (this.hdbtype != null) {
      data['hdbtype'] = this.hdbtype!.toJson();
    }
    if (this.marital != null) {
      data['marital'] = this.marital!.toJson();
    }
    if (this.edulevel != null) {
      data['edulevel'] = this.edulevel!.toJson();
    }
    if (this.noaBasic != null) {
      data['noa-basic'] = this.noaBasic!.toJson();
    }
    if (this.ownerprivate != null) {
      data['ownerprivate'] = this.ownerprivate!.toJson();
    }
    if (this.cpfcontributions != null) {
      data['cpfcontributions'] = this.cpfcontributions!.toJson();
    }
    if (this.cpfbalances != null) {
      data['cpfbalances'] = this.cpfbalances!.toJson();
    }
    /*if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }*/
    if (this.drivinglicence != null) {
      data['drivinglicence'] = this.drivinglicence!.toJson();
    }
    return data;
  }
}

class Uinfin {
  String? lastupdated;
  String? source;
  String? classification;
  String? value;

  Uinfin({this.lastupdated, this.source, this.classification, this.value});

  Uinfin.fromJson(Map<String, dynamic> json) {
    lastupdated = json['lastupdated'];
    source = json['source'];
    classification = json['classification'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    data['classification'] = this.classification;
    data['value'] = this.value;
    return data;
  }
}

class Sex {
  String? lastupdated;
  String? code;
  String? source;
  String? classification;
  String? desc;

  Sex(
      {this.lastupdated,
        this.code,
        this.source,
        this.classification,
        this.desc});

  Sex.fromJson(Map<String, dynamic> json) {
    lastupdated = json['lastupdated'];
    code = json['code'];
    source = json['source'];
    classification = json['classification'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastupdated'] = this.lastupdated;
    data['code'] = this.code;
    data['source'] = this.source;
    data['classification'] = this.classification;
    data['desc'] = this.desc;
    return data;
  }
}

class Mobileno {
  String? lastupdated;
  String? source;
  String? classification;
  Areacode? areacode;
  Areacode? prefix;
  Areacode? nbr;

  Mobileno(
      {this.lastupdated,
        this.source,
        this.classification,
        this.areacode,
        this.prefix,
        this.nbr});

  Mobileno.fromJson(Map<String, dynamic> json) {
    lastupdated = json['lastupdated'];
    source = json['source'];
    classification = json['classification'];
    areacode = json['areacode'] != null
        ? new Areacode.fromJson(json['areacode'])
        : null;
    prefix =
    json['prefix'] != null ? new Areacode.fromJson(json['prefix']) : null;
    nbr = json['nbr'] != null ? new Areacode.fromJson(json['nbr']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    data['classification'] = this.classification;
    if (this.areacode != null) {
      data['areacode'] = this.areacode!.toJson();
    }
    if (this.prefix != null) {
      data['prefix'] = this.prefix!.toJson();
    }
    if (this.nbr != null) {
      data['nbr'] = this.nbr!.toJson();
    }
    return data;
  }
}

class Areacode {
  String? value;

  Areacode({this.value});

  Areacode.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Regadd {
  Country? country;
  Areacode? unit;
  Areacode? street;
  String? lastupdated;
  Areacode? block;
  String? source;
  Areacode? postal;
  String? classification;
  Areacode? floor;
  String? type;
  Areacode? building;

  Regadd(
      {this.country,
        this.unit,
        this.street,
        this.lastupdated,
        this.block,
        this.source,
        this.postal,
        this.classification,
        this.floor,
        this.type,
        this.building});

  Regadd.fromJson(Map<String, dynamic> json) {
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    unit = json['unit'] != null ? new Areacode.fromJson(json['unit']) : null;
    street =
    json['street'] != null ? new Areacode.fromJson(json['street']) : null;
    lastupdated = json['lastupdated'];
    block = json['block'] != null ? new Areacode.fromJson(json['block']) : null;
    source = json['source'];
    postal =
    json['postal'] != null ? new Areacode.fromJson(json['postal']) : null;
    classification = json['classification'];
    floor = json['floor'] != null ? new Areacode.fromJson(json['floor']) : null;
    type = json['type'];
    building = json['building'] != null
        ? new Areacode.fromJson(json['building'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.street != null) {
      data['street'] = this.street!.toJson();
    }
    data['lastupdated'] = this.lastupdated;
    if (this.block != null) {
      data['block'] = this.block!.toJson();
    }
    data['source'] = this.source;
    if (this.postal != null) {
      data['postal'] = this.postal!.toJson();
    }
    data['classification'] = this.classification;
    if (this.floor != null) {
      data['floor'] = this.floor!.toJson();
    }
    data['type'] = this.type;
    if (this.building != null) {
      data['building'] = this.building!.toJson();
    }
    return data;
  }
}

class Country {
  String? code;
  String? desc;

  Country({this.code, this.desc});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['desc'] = this.desc;
    return data;
  }
}

class NoaBasic {
  Areacode? yearofassessment;
  String? lastupdated;
  Amount? amount;
  String? source;
  String? classification;

  NoaBasic(
      {this.yearofassessment,
        this.lastupdated,
        this.amount,
        this.source,
        this.classification});

  NoaBasic.fromJson(Map<String, dynamic> json) {
    yearofassessment = json['yearofassessment'] != null
        ? new Areacode.fromJson(json['yearofassessment'])
        : null;
    lastupdated = json['lastupdated'];
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    source = json['source'];
    classification = json['classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.yearofassessment != null) {
      data['yearofassessment'] = this.yearofassessment!.toJson();
    }
    data['lastupdated'] = this.lastupdated;
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    data['source'] = this.source;
    data['classification'] = this.classification;
    return data;
  }
}

class Amount {
  num? value;

  Amount({this.value});

  Amount.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Ownerprivate {
  String? lastupdated;
  String? source;
  String? classification;
 // bool? value;

  Ownerprivate(
      {this.lastupdated, this.source, this.classification,});

  Ownerprivate.fromJson(Map<String, dynamic> json) {
    lastupdated = json['lastupdated'];
    source = json['source'];
    classification = json['classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    data['classification'] = this.classification;
    return data;
  }
}

class Cpfcontributions {
  String? lastupdated;
  String? source;
  List<History>? history;
  String? classification;

  Cpfcontributions(
      {this.lastupdated, this.source, this.history, this.classification});

  Cpfcontributions.fromJson(Map<String, dynamic> json) {
    lastupdated = json['lastupdated'];
    source = json['source'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
    classification = json['classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    data['classification'] = this.classification;
    return data;
  }
}

class History {
  Areacode? date;
  Areacode? employer;
  Amount? amount;
  Areacode? month;

  History({this.date, this.employer, this.amount, this.month});

  History.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Areacode.fromJson(json['date']) : null;
    employer = json['employer'] != null
        ? new Areacode.fromJson(json['employer'])
        : null;
    amount =
    json['amount'] != null ? new Amount.fromJson(json['amount']) : null;
    month = json['month'] != null ? new Areacode.fromJson(json['month']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date!.toJson();
    }
    if (this.employer != null) {
      data['employer'] = this.employer!.toJson();
    }
    if (this.amount != null) {
      data['amount'] = this.amount!.toJson();
    }
    if (this.month != null) {
      data['month'] = this.month!.toJson();
    }
    return data;
  }
}

class Cpfbalances {
  Amount? oa;
  Amount? ma;
  String? lastupdated;
  String? source;
  String? classification;
  Amount? sa;
  Amount? ra;

  Cpfbalances(
      {this.oa,
        this.ma,
        this.lastupdated,
        this.source,
        this.classification,
        this.sa,
        this.ra});

  Cpfbalances.fromJson(Map<String, dynamic> json) {
    oa = json['oa'] != null ? new Amount.fromJson(json['oa']) : null;
    ma = json['ma'] != null ? new Amount.fromJson(json['ma']) : null;
    lastupdated = json['lastupdated'];
    source = json['source'];
    classification = json['classification'];
    sa = json['sa'] != null ? new Amount.fromJson(json['sa']) : null;
    ra = json['ra'] != null ? new Amount.fromJson(json['ra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oa != null) {
      data['oa'] = this.oa!.toJson();
    }
    if (this.ma != null) {
      data['ma'] = this.ma!.toJson();
    }
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    data['classification'] = this.classification;
    if (this.sa != null) {
      data['sa'] = this.sa!.toJson();
    }
    if (this.ra != null) {
      data['ra'] = this.ra!.toJson();
    }
    return data;
  }
}

class Drivinglicence {
  Country? comstatus;
  String? lastupdated;
  String? source;
  String? classification;
  Totaldemeritpoints? totaldemeritpoints;
  Suspension? suspension;
  Suspension? disqualification;
  Suspension? revocation;
  Pdl? pdl;
  Pdl? qdl;
  Areacode? photocardserialno;

  Drivinglicence(
      {this.comstatus,
        this.lastupdated,
        this.source,
        this.classification,
        this.totaldemeritpoints,
        this.suspension,
        this.disqualification,
        this.revocation,
        this.pdl,
        this.qdl,
        this.photocardserialno});

  Drivinglicence.fromJson(Map<String, dynamic> json) {
    comstatus = json['comstatus'] != null
        ? new Country.fromJson(json['comstatus'])
        : null;
    lastupdated = json['lastupdated'];
    source = json['source'];
    classification = json['classification'];
    totaldemeritpoints = json['totaldemeritpoints'] != null
        ? new Totaldemeritpoints.fromJson(json['totaldemeritpoints'])
        : null;
    suspension = json['suspension'] != null
        ? new Suspension.fromJson(json['suspension'])
        : null;
    disqualification = json['disqualification'] != null
        ? new Suspension.fromJson(json['disqualification'])
        : null;
    revocation = json['revocation'] != null
        ? new Suspension.fromJson(json['revocation'])
        : null;
    pdl = json['pdl'] != null ? new Pdl.fromJson(json['pdl']) : null;
    qdl = json['qdl'] != null ? new Pdl.fromJson(json['qdl']) : null;
    photocardserialno = json['photocardserialno'] != null
        ? new Areacode.fromJson(json['photocardserialno'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comstatus != null) {
      data['comstatus'] = this.comstatus!.toJson();
    }
    data['lastupdated'] = this.lastupdated;
    data['source'] = this.source;
    data['classification'] = this.classification;
    if (this.totaldemeritpoints != null) {
      data['totaldemeritpoints'] = this.totaldemeritpoints!.toJson();
    }
    if (this.suspension != null) {
      data['suspension'] = this.suspension!.toJson();
    }
    if (this.disqualification != null) {
      data['disqualification'] = this.disqualification!.toJson();
    }
    if (this.revocation != null) {
      data['revocation'] = this.revocation!.toJson();
    }
    if (this.pdl != null) {
      data['pdl'] = this.pdl!.toJson();
    }
    if (this.qdl != null) {
      data['qdl'] = this.qdl!.toJson();
    }
    if (this.photocardserialno != null) {
      data['photocardserialno'] = this.photocardserialno!.toJson();
    }
    return data;
  }
}

class Totaldemeritpoints {
  num? value;

  Totaldemeritpoints({this.value});

  Totaldemeritpoints.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}

class Suspension {
  Areacode? startdate;
  Areacode? enddate;

  Suspension({this.startdate, this.enddate});

  Suspension.fromJson(Map<String, dynamic> json) {
    startdate = json['startdate'] != null
        ? new Areacode.fromJson(json['startdate'])
        : null;
    enddate =
    json['enddate'] != null ? new Areacode.fromJson(json['enddate']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startdate != null) {
      data['startdate'] = this.startdate!.toJson();
    }
    if (this.enddate != null) {
      data['enddate'] = this.enddate!.toJson();
    }
    return data;
  }
}

class Pdl {
  Country? validity;
  Areacode? expirydate;
  List<Null>? classes;

  Pdl({this.validity, this.expirydate, this.classes});

  Pdl.fromJson(Map<String, dynamic> json) {
    validity = json['validity'] != null
        ? new Country.fromJson(json['validity'])
        : null;
    expirydate = json['expirydate'] != null
        ? new Areacode.fromJson(json['expirydate'])
        : null;
    /*if (json['classes'] != null) {
      classes = <Null>[];
      json['classes'].forEach((v) {
        classes!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.validity != null) {
      data['validity'] = this.validity!.toJson();
    }
    if (this.expirydate != null) {
      data['expirydate'] = this.expirydate!.toJson();
    }
    /*if (this.classes != null) {
      data['classes'] = this.classes!.map((v) => v.toJson()).toList();
    }*/
    return data;
  }
}
