import 'package:injectable/injectable.dart';

class AppConfig {
  static String environment = Environment.dev;
  static String clientId = "";
  static String clientSecret = "";
  static String language = "vi";
  static String fontFamily = "Inter";
  static bool autoLogin = true;
  static String hotline = "18001260";
  static String colorPrimaryBtn = "#0D75D6";
  static String logoCustom = "";
  static double sizeLogo = 118;
  static String backgroundLogin = "";
  static String customerId = "";
  static double? borderRadiusBtn;
  static String colorSecondBtn = "#E0F0FF";
  static String packageDefault = "";
  static String customerPhone = "";
  static String customerEmail = "";
  static String password = "";

  //Bật cờ kiểm tra xem người dùng thực hiện ký số trên portal hay trực tiếp trên app? mặc định ký trên portal
  static bool isSignInApp = false;
  static bool isFlutter = false;

  static String supportHomepage = environment == Environment.dev
      ? "https://demorms.vnptit.vn/help/"
      : "https://smartca.vnpt.vn/help/";

  static String faqLink = "${supportHomepage}docs/faq/";

  static String updateHistoryLink = "${supportHomepage}docs/version-history/";

  static String featuresLink = "${supportHomepage}docs/features/install";

  static String notSecureDeviceLink =
      "${supportHomepage}docs/faq/index.html#4-thi%E1%BA%BFt-b%E1%BB%8B-kh%C3%B4ng-%C4%91%E1%BB%A7-an-to%C3%A0n-%C4%91%E1%BB%83-ch%E1%BA%A1y-%E1%BB%A9ng-d%E1%BB%A5ng-vnpt-smartca-ph%E1%BA%A3i-l%C3%A0m-th%E1%BA%BF-n%C3%A0o/";

  static String urlForgotPassword = environment == Environment.dev
      ? "https://rmidp.vnptit.vn/Account/ForgotPassword"
      : "https://ausca.vnpt.vn/Account/ForgotPassword";

  static String suggestedRefCodesUrl =
      environment == Environment.dev ? "https://10.168.3.36:44341" : "";

  static String? get package =>
      isFlutter == true ? "vnpt_smartca_module" : null;
}
