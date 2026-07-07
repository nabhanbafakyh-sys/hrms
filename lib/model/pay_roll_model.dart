class PayrollModel {
  final int? id;
  final int employee;

  final int month;
  final int year;

  final String basicSalary;
  final String allowances;
  final String hra;
  final String pf;
  final String esi;
  final String tds;
  final String lossOfPay;
  final String bonuses;
  final String incentives;
  final String arrears;
  final String finalSettlement;

  final String? grossSalary;
  final String? deductions;
  final String? netSalary;
  final String? generatedAt;

  PayrollModel({
    this.id,
    required this.employee,
    required this.month,
    required this.year,
    required this.basicSalary,
    this.allowances = "0",
    this.hra = "0",
    this.pf = "0",
    this.esi = "0",
    this.tds = "0",
    this.lossOfPay = "0",
    this.bonuses = "0",
    this.incentives = "0",
    this.arrears = "0",
    this.finalSettlement = "0",
    this.grossSalary,
    this.deductions,
    this.netSalary,
    this.generatedAt,
  });

  factory PayrollModel.fromJson(Map<String, dynamic> json) {
    return PayrollModel(
      id: json["id"],
      employee: json["employee"],
      month: json["month"],
      year: json["year"],
      basicSalary: json["basic_salary"],
      allowances: json["allowances"] ?? "0",
      hra: json["hra"] ?? "0",
      pf: json["pf"] ?? "0",
      esi: json["esi"] ?? "0",
      tds: json["tds"] ?? "0",
      lossOfPay: json["loss_of_pay"] ?? "0",
      bonuses: json["bonuses"] ?? "0",
      incentives: json["incentives"] ?? "0",
      arrears: json["arrears"] ?? "0",
      finalSettlement: json["final_settlement"] ?? "0",
      grossSalary: json["gross_salary"],
      deductions: json["deductions"],
      netSalary: json["net_salary"],
      generatedAt: json["generated_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "employee": employee,
      "month": month,
      "year": year,
      "basic_salary": basicSalary,
      "allowances": allowances,
      "hra": hra,
      "pf": pf,
      "esi": esi,
      "tds": tds,
      "loss_of_pay": lossOfPay,
      "bonuses": bonuses,
      "incentives": incentives,
      "arrears": arrears,
      "final_settlement": finalSettlement,
    };
  }
}