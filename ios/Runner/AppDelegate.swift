import UIKit
import Flutter
import GoogleMaps
import AppCenter
import AppCenterDistribute
import AppCenterAnalytics
import AppCenterCrashes



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    //Khai báo biến
    var vnptSmartCASDK: VNPTSmartCASDK?
    var partnerId: String = "VNPTSmartCAPartner-79a7413b-c5cf-4c61-93d-9eccefef7b6c"
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      GMSServices.provideAPIKey("AIzaSyB5CMAVB0CRD8NEOfZrzrI6V39Jwu_ZK94")
    //   AppCenter.start(withAppSecret: "496254aa-74cf-4faa-a335-51fa445262ad", services: [Distribute.self, Analytics.self, Crashes.self])
      GeneratedPluginRegistrant.register(with: self)
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let digitalSignChannel = FlutterMethodChannel(name: "com.sacombank.cmv/digitalSign",
                                                binaryMessenger: controller.binaryMessenger)

      self.vnptSmartCASDK = VNPTSmartCASDK(
          viewController:  controller,
          partnerId: partnerId,
          environment: VNPTSmartCASDK.ENVIRONMENT.PRODUCTION,
          lang: VNPTSmartCASDK.LANG.VI,
          isFlutterApp: true
      )
      
      digitalSignChannel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          // This method is invoked on the UI thread.
          if (call.method == "initSmartCa") {
              result(true)
          } else if (call.method == "getAuthentication") {
              self.getAuthentication(result: result)
          } else if (call.method == "getMainInfo") {
              self.getMainInfo(result: result)
          } else if (call.method == "startSign") {
              self.getWaitingTransaction(call: call, result: result)
          } else if (call.method == "destroySDK") {
              self.destroySDK()
              result(true)
          } else {
              result(FlutterMethodNotImplemented)
          }
      })
      
      GeneratedPluginRegistrant.register(with: self.vnptSmartCASDK?.flutterEngine as! FlutterPluginRegistry);
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    

    @objc func getAuthentication(result: @escaping FlutterResult) {
        // SDK tự động xử lý các trường hợp về token: Hết hạn, chưa kích hoạt...
        self.vnptSmartCASDK?.getAuthentication(callback: { smartCaResult in
            if smartCaResult.status == SmartCAResultCode.SUCCESS_CODE {
//                print(authResult.data)
//                result(authResult.data)
                result(smartCaResult.toJson())
            } else {
                result(nil)
            }
        });
    }
    
    func getMainInfo(result: @escaping FlutterResult) {
            self.vnptSmartCASDK?.getMainInfo(callback: { smartCaResult in
                result(smartCaResult.toJson())
            })
        }

     @objc func getWaitingTransaction(call: FlutterMethodCall, result: @escaping FlutterResult) {
         guard let args = call.arguments as? [String : Any] else {return}
         let transId = args["transId"] as! String
         self.vnptSmartCASDK?.getWaitingTransaction(tranId: transId, callback: { smartCaResult in
             result(smartCaResult.toJson())
         })
     }

    @objc func destroySDK() {
        self.vnptSmartCASDK?.destroySDK()
    }
    
}
