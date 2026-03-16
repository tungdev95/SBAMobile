// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:vnpt_smartca_module/views/controller/policy_data_controller.dart';
import '../../i18n/generated_locales/l10n.dart';
import '../../widgets/dialog/common_dialog.dart';
import '../../widgets/widget.dart';

class PrivacyPolicy extends StatefulWidget {
  final String? fromScreen;
  final Function()? callback;
  PrivacyPolicy({super.key, this.fromScreen, this.callback});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final controller = Get.put(PolicyDataController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.fromScreen != "registerAccount") {
      controller.getPolicy();
    }
    //đẩy view xuống vị trí chỉ định
    // Future.delayed(Duration(milliseconds: 950), () {
    //   final box = globalKey.currentContext?.findRenderObject();
    //   Offset position = (box as RenderBox).localToGlobal(Offset.zero);
    //   try {
    //     controller.scrollController.jumpTo(position.dy -
    //         AppBar().preferredSize.height -
    //         MediaQuery.of(context).viewPadding.vertical -
    //         80);
    //   } catch (e) {
    //     print(e);
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: "Chính sách bảo vệ dữ liệu cá nhân",
      loadingWidget: const BaseLoading<PolicyDataController>(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Container();
        } else {
          return Container(
              color: const Color(0xFFF4F6FB),
              child: SingleChildScrollView(
                controller: controller.scrollController,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "VĂN BẢN LẤY CHẤP THUẬN CỦA KHÁCH HÀNG ĐỐI VỚI CHÍNH SÁCH BẢO VỆ THÔNG TIN KHÁCH HÀNG CỦA TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Bằng việc đánh dấu vào các ô chấp thuận trong bảng dưới đây, Khách hàng xác nhận chấp thuận cho TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM (sau đây gọi tắt là “VNPT”) xử lý Thông tin Khách hàng cho các mục đích/phạm vi sử dụng như sau:",
                          textAlign: TextAlign.justify,
                          style: TextStyle(),
                        ),
                        SizedBox(height: 10),
                        ItemPolicyCheckBox(
                          content1: '',
                          content2: '',
                        ),
                        SizedBox(height: 20),
                        Text(
                          "(Chi tiết CHÍNH SÁCH BẢO VỆ THÔNG TIN KHÁCH HÀNG CỦA TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM được cung cấp cho Khách hàng văn bản dưới đây và được niêm yết theo quy định pháp luật)",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 60),
                        Text(
                          "CHÍNH SÁCH BẢO VỆ THÔNG TIN KHÁCH HÀNG CỦA TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Html(
                      data: """<pre>
Căn cứ
-  <i>Luật bảo vệ quyền lợi người tiêu dùng số 19/2023/QH15 do Quốc hội ban hành ngày 20/06/2023;</i>
-  <i>Luật Viễn thông số 24/2023/QH15 do Quốc hội ban hành ngày 24/1c văn b1/2023 và cáản hướng dẫn thi hành;</i>
-  <i>Nghị định 163/2024/NĐ-CP do Chính phủ ban hành ngày 24/12/2024 quy định chi tiết một số điều và biện pháp thi hành Luật viễn thông;</i>
-  <i>Nghị định 55/2024/NĐ-CP do Chính phủ ban hành ngày 16/05/2024 quy định chi tiết một số điều của Luật bảo vệ quyền lợi người tiêu dùng;</i>
-  <i>Nghị định 13/2023/NĐ-CP do Chính phủ ban hành ngày 17/04/2023 về bảo vệ dữ liệu cá nhân;</i>
-  <i>Nghị định 06/2016/NĐ-CP do Chính phủ ban hành ngày 18/01/2016 quy định quản lý, cung cấp và sử dụng dịch vụ phát thanh, truyền hình sửa đổi bổ sung bởi Nghị định 71/2022/NĐ-CP;</i>
-  <i>Quyết định số 07/2024/QĐ-TTg do Thủ tướng Chính phủ ban hành ngày 20/06/2024 ban hành Danh mục sản phẩm, hàng hóa, dịch vụ phải đăng ký hợp đồng theo mẫu, điều kiện giao dịch chung.</i>
Chính sách bảo vệ thông tin khách hàng của TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM (sau đây gọi tắt là <b>“Chính sách”</b>) nhằm mục đích thông báo với Khách hàng về các Thông tin Khách hàng do TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM <b>(“VNPT”)</b> xử lý, mục đích xử lý, cách thức xử lý, thời gian lưu trữ, quyền, nghĩa vụ của Khách hàng đối với Thông tin Khách hàng theo quy định của pháp luật Việt Nam về bảo vệ Thông tin Khách hàng. Chính sách này đồng thời đưa ra các khuyến nghị để giúp Khách hàng nâng cao nhận thức về bảo vệ Thông tin Khách hàng.
Chính sách này là Điều kiện giao dịch chung được áp dụng cho toàn bộ hoạt động cung cấp Sản phẩm, dịch vụ của VNPT và áp dụng trên toàn bộ các nền tảng có tương tác với Khách hàng cá nhân trên môi trường số.
VNPT có trách nhiệm cung cấp đầy đủ Chính sách này cho khách hàng trước khi ký hợp đồng hoặc giao dịch và lấy chấp thuận của Khách hàng đối với Chính sách này trước khi thực hiện hoạt động xử lý Thông tin Khách hàng theo quy định của pháp luật. Bằng việc tích vào ô "Chấp thuận" trên các website (trang mạng)/ứng dụng cung cấp dịch vụ của VNPT có đăng tải công khai Chính sách này; hoặc bằng việc ký kết hợp đồng với VNPT có dẫn chiếu và đính kèm Chính sách này; Khách hàng xác nhận rằng đã đọc kỹ, hiểu rõ và chấp thuận toàn bộ nội dung Chính sách này.
</pre>""",
                      style: {
                        "pre": Style(
                          fontSize: FontSize(14),
                          fontFamily: "Roboto",
                          textAlign: TextAlign.justify,
                        ),
                      },
                    ),
                    ItemPolicy(
                        title: 'Điều 1. Giải thích từ ngữ và các từ viết tắt',
                        content: """<pre>
Trong phạm vi Chính sách này, các thuật ngữ dưới đây được hiểu và giải thích như sau: 
<b>1.1.</b> <b>VNPT</b> là Tập Đoàn Bưu Chính Viễn Thông Việt Nam và các đơn vị trực thuộc Tập Đoàn Bưu Chính Viễn Thông Việt Nam. 
<b>1.2.</b> <b>Công ty con của VNPT</b> là các doanh nghiệp do VNPT sở hữu 100% vốn điều lệ. Công ty con của VNPT bao gồm TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM (VNPT) và Tổng công ty Truyền thông (VNPT Media).
<b>1.3.</b> <b>Khách hàng</b> là: 
 - Cá nhân hoặc người đại diện hợp pháp của cá nhân sử dụng và/hoặc quan tâm tới các Sản phẩm, dịch vụ của VNPT; 
 - Cá nhân hoặc người đại diện hợp pháp của cá nhân đã truy cập và/hoặc đăng ký tài khoản tại các website/ứng dụng cung cấp dịch vụ của VNPT. 
<b>1.4.</b> <b>Sản phẩm, dịch vụ của VNPT</b> là: 
 - Dịch vụ viễn thông di động mặt đất (dịch vụ thoại, dịch vụ nhắn tin, dịch vụ truy nhập Internet);
 - Dịch vụ viễn thông cố định mặt đất (dịch vụ thoại, dịch vụ truy nhập Internet);
 - Dịch vụ truyền hình trả tiền;
 - Các sản phẩm, dịch vụ khác do VNPT cung cấp cho Khách hàng theo quy định của pháp luật.
<b>1.5.</b> <b>Thông tin Khách hàng</b> bao gồm (i) Dữ liệu cá nhân của Khách hàng theo quy định của pháp luật về bảo vệ dữ liệu cá nhân và (ii) Thông tin về quá trình mua, sử dụng sản phẩm, hàng hóa, dịch vụ của Khách hàng và thông tin khác liên quan đến giao dịch giữa Khách hàng và VNPT.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 2. Xử lý Thông tin Khách hàng',
                        content: """<pre>
<b>1.</b> VNPT có trách nhiệm thông báo Chính sách này cho Khách hàng và lấy chấp thuận của Khách hàng trước khi tiến hành xử lý Thông tin Khách hàng trong những trường hợp dưới đây: 
 <b>a)</b> Khi Khách hàng hoặc người đại diện hợp pháp của Khách hàng liên hệ với VNPT để yêu cầu tư vấn Sản phẩm, dịch vụ của VNPT hoặc bày tỏ sự quan tâm tới các Sản phẩm, dịch vụ của VNPT; 
 <b>b)</b> Khi Khách hàng dùng thử, ký kết hợp đồng, đăng ký, sử dụng Sản phẩm, dịch vụ của VNPT;
 <b>c)</b> Khi Khách hàng truy cập và/hoặc đăng ký tài khoản tại các website/ứng dụng cung cấp dịch vụ của VNPT;
 <b>d)</b> Khi Khách hàng đồng thuận cung cấp Thông tin Khách hàng cho VNPT qua các nguồn công khai như: website/ứng dụng cung cấp dịch vụ; cuộc họp, sự kiện, hội thảo, hội nghị, các mạng xã hội, hay chương trình đối thoại, thảo luận do VNPT tổ chức, tài trợ hoặc tham dự và/hoặc từ các tệp lưu trữ (cookies) ghi nhận được trên website/ứng dụng cung cấp dịch vụ của VNPT;
 <b>e)</b> Khi khách hàng của một tổ chức, doanh nghiệp cho phép tổ chức, doanh nghiệp đó chia sẻ Thông tin Khách hàng của khách hàng với VNPT;
 <b>g)</b> Là khách hàng của một tổ chức, doanh nghiệp được VNPT thực hiện góp vốn, mua cổ phần; hoặc là khách hàng của một tổ chức, doanh nghiệp có hoạt động hợp tác cung cấp sản phẩm, dịch vụ với VNPT.
 <b>h)</b> Khi có yêu cầu của các cơ quan nhà nước có thẩm quyền. 
 <b>i)</b> Khi VNPT tiến hành các công việc theo mục đích xử lý Thông tin Khách hàng được quy định tại Điều 3 Chính sách này. 
 <b>j)</b> Các trường hợp khác theo quy định của pháp luật.
<b>2.</b> Dữ liệu cá nhân của Khách hàng được VNPT tiến hành xử lý (sau đây gọi tắt là <b>“Dữ liệu cá nhân”</b>) bao gồm:
 <b>2.1.</b> Dữ liệu cá nhân cơ bản
  <b>a)</b> Họ, chữ đệm và tên khai sinh, tên gọi khác (nếu có);
  <b>b)</b> Ngày, tháng, năm sinh; ngày, tháng, năm chết hoặc mất tích;
  <b>c)</b> Giới tính;
  <b>d)</b> Nơi sinh, nơi đăng ký khai sinh, nơi thường trú, nơi tạm trú, nơi ở hiện tại, quê quán, địa chỉ liên hệ;
  <b>e)</b> Quốc tịch;
  <b>g)</b> Hình ảnh của cá nhân;
  <b>h)</b> Số điện thoại, số chứng minh nhân dân, số định danh cá nhân, số hộ chiếu, số giấy phép lái xe, số biển số xe, số mã số thuế cá nhân, số bảo hiểm xã hội, số thẻ bảo hiểm y tế;
  <b>i)</b> Tình trạng hôn nhân;
  <b>k)</b> Thông tin về mối quan hệ gia đình (cha mẹ, con cái);
  <b>l)</b> Thông tin về tài khoản số của cá nhân; dữ liệu cá nhân phản ánh hoạt động, lịch sử hoạt động trên không gian mạng;
  <b>m)</b> Các thông tin khác gắn liền với một con người cụ thể hoặc giúp xác định một con người cụ thể.
 <b>2.2.</b> Dữ liệu cá nhân nhạy cảm 
  <b>a)</b> Dữ liệu cá nhân của tổ chức tín dụng, chi nhánh ngân hàng nước ngoài, tổ chức cung ứng dịch vụ trung gian thanh toán, các tổ chức được phép khác, gồm: thông tin định danh Khách hàng theo quy định của pháp luật, thông tin về tài khoản, thông tin về tiền gửi, thông tin về tài sản gửi, thông tin về giao dịch, thông tin về tổ chức, cá nhân là bên bảo đảm tại tổ chức tín dụng, chi nhánh ngân hàng, tổ chức cung ứng dịch vụ trung gian thanh toán;
  <b>b)</b> Dữ liệu về vị trí của cá nhân được xác định qua dịch vụ định vị;
  <b>c)</b> Dữ liệu cá nhân khác được pháp luật quy định là đặc thù và cần có biện pháp bảo mật cần thiết.
 <b>2.3.</b> VNPT sẽ thông báo cho Khách hàng các Thông tin Khách hàng bắt buộc phải cung cấp <b>(“Thông tin Khách hàng bắt buộc cung cấp”)</b> và các Thông tin Khách hàng được lựa chọn đồng ý hoặc không đồng ý cung cấp <b>(“Thông tin Khách hàng tùy chọn cung cấp”)</b > tại thời điểm Khách hàng liên hệ, trao đổi hoặc đăng ký, ký kết hợp đồng với VNPT. Trong đó, Thông tin Khách hàng bắt buộc phải cung cấp được hiểu là các Thông tin Khách hàng mà VNPT cần phải thu thập từ Khách hàng theo quy định của pháp luật hoặc các Thông tin Khách hàng mà VNPT bắt buộc phải sử dụng để triển khai cung cấp một phần hoặc toàn bộ Sản phẩm, dịch vụ của VNPT theo yêu cầu của Khách hàng. Thông tin Khách hàng tùy chọn cung cấp được hiểu là các Thông tin Khách hàng mà VNPT thu thập để nâng cao trải nghiệm khách hàng, dự đoán hành vi tiêu dùng hoặc nghiên cứu thị trường dịch vụ viễn thông, việc không cung cấp Thông tin Khách hàng tùy chọn cung cấp không làm ảnh hưởng tới việc cung cấp Sản phẩm, dịch vụ của VNPT theo yêu cầu của Khách hàng. 
Nếu các Thông tin Khách hàng bắt buộc cung cấp không được cung cấp theo yêu cầu của VNPT, Khách hàng sẽ không thể sử dụng Sản phẩm, dịch vụ của VNPT. Trong trường hợp này, VNPT có thể từ chối cung cấp sản phẩm, dịch vụ cho Khách hàng mà không phải chịu bất kì một khoản bồi thường và/hoặc phạt vi phạm nào (trừ trường hợp do lỗi của VNPT hoặc pháp luật có quy định khác).
 <b>2.4.</b> VNPT có thể tự mình hoặc ủy quyền, thuê bên thứ ba thực hiện xử lý Thông tin Khách hàng với điều kiện là việc xử lý Thông tin Khách hàng phải bảo đảm an toàn, an ninh Thông tin Khách hàng theo quy định của pháp luật. Trường hợp VNPT ủy quyền hoặc thuê bên thứ ba thực hiện việc xử lý Thông tin Khách hàng thì phải được sự đồng ý của Khách hàng. Việc ủy quyền hoặc thuê bên thứ ba phải được thực hiện bằng văn bản, trong đó quy định rõ phạm vi, trách nhiệm của mỗi bên trong việc bảo vệ Thông tin Khách hàng theo quy định của pháp luật. Trường hợp Khách hàng thực hiện giao dịch thông qua bên thứ ba thì bên thứ ba có trách nhiệm bảo vệ Thông tin Khách hàng theo quy định của pháp luật. 
</pre>
"""),
                    ItemPolicy(
                        title: 'Điều 3. Mục đích xử lý Thông tin Khách hàng',
                        content: """<pre>
<b>3.1.</b> VNPT được phép tiến hành xử lý Thông tin Khách hàng trong các trường hợp sau <b>(“Mục đích bắt buộc”)</b>: 
 <b>a)</b> Cung cấp sản phẩm, dịch vụ của VNPT theo yêu cầu của Khách hàng và chỉ trong phạm vi thông tin mà Khách hàng đã đồng ý <i>(Theo Điểm b Khoản 3 Điều 18 Luật bảo vệ quyền lợi người tiêu dùng 2023)</i>, bao gồm:
  - Xác minh tính chính xác, đầy đủ của các thông tin được Khách hàng cung cấp theo quy định của pháp luật; xác định hoặc xác thực danh tính của Khách hàng và thực hiện quy trình xác thực Khách hàng; Xử lý việc đăng ký sử dụng Sản phẩm, dịch vụ của VNPT;
  - Thẩm định hồ sơ và khả năng đủ điều kiện của Khách hàng đối với việc sử dụng Sản phẩm, dịch vụ của VNPT. VNPT có thể sử dụng các phương pháp chấm điểm, gán ngưỡng cước nóng, kiểm tra lịch sử Khách hàng sử dụng Sản phẩm, dịch vụ của VNPT để đánh giá và quản trị rủi ro tín dụng, đảm bảo khả năng thanh toán đối với các nghĩa vụ thanh toán và các nghĩa vụ khác có liên quan trong suốt quá trình cung cấp Sản phẩm, dịch vụ của VNPT cho Khách hàng;
  - Thực hiện các quyền của Khách hàng liên quan đến Thông tin Khách hàng theo quy định pháp luật, thỏa thuận giữa Khách hàng và VNPT.
  - Thông báo tới Khách hàng thông tin về kế hoạch tác động mạng lưới liên quan đến Sản phẩm, dịch vụ của VNPT.
  - Quản lý tài khoản Khách hàng và các chương trình Khách hàng thân thiết;
  - Tiếp nhận giải quyết các yêu cầu, khiếu nại, khiếu kiện của Khách hàng; gửi các thông báo cho Khách hàng nhằm khảo sát sự hài lòng của Khách hàng đối với chất lượng sản phẩm, dịch vụ, quy trình giải quyết yêu cầu, khiếu nại, khiếu kiện do VNPT thực hiện;
  - Liên hệ với Khách hàng nhằm tư vấn, trao đổi thông tin, giải quyết yêu cầu, khiếu nại, giao các hóa đơn, các sao kê, các báo cáo hoặc các tài liệu khác liên quan tới Sản phẩm, dịch vụ của VNPT thông qua các kênh khác nhau (ví dụ: email, chat) và để trả lời yêu cầu của Khách hàng. Liên hệ với Khách hàng (hoặc các bên do Khách hàng chỉ định hoặc yêu cầu) để thông báo cho Khách hàng về thông tin liên quan đến việc sử dụng Sản phẩm, dịch vụ của VNPT.
  - Đánh giá hiệu quả sản xuất kinh doanh của các đơn vị; vận hành hệ thống quản trị nội bộ, hệ thống đánh giá hiệu quả công việc và các hệ thống giám sát hoạt động sản xuất kinh doanh;
  - Lập hồ sơ phục vụ công tác mời thầu hoặc tham dự thầu hoặc; Lập báo cáo, thống kê, phân tích dữ liệu nội bộ để nghiên cứu, xây dựng, phát triển, quản lý, đo lường, cung cấp và cải tiến Sản phẩm, hàng hóa, dịch vụ cũng như điều hành hoạt động kinh doanh của VNPT;
  - Đánh giá khả năng mua, sử dụng sản phẩm, hàng hóa, dịch vụ của VNPT thông qua điểm xếp hạng viễn thông của Khách hàng nhằm hỗ trợ tốt nhất trong việc cung cấp các sản phẩm, hàng hóa, dịch vụ cho Khách hàng;
  - Cung cấp thông tin mà Khách hàng yêu cầu hoặc nhận định rằng Khách hàng có thể thấy hữu ích, bao gồm thông tin về các Sản phẩm, dịch vụ của VNPT theo quy định pháp luật;
  - Cải tiến công nghệ, giao diện website/ứng dụng cung cấp dịch vụ đảm bảo tối ưu hóa trải nghiệm của Khách hàng.
 <b>b)</b> Thực hiện các nghĩa vụ theo quy định của pháp luật <i>(Theo Điểm c Khoản 3 Điều 18 Luật bảo vệ quyền lợi người tiêu dùng 2023)</i>, bao gồm:
  - Lập các loại báo cáo theo quy định của pháp luật về viễn thông, truyền hình hoặc theo yêu cầu bằng văn bản của cơ quan quản lý nhà nước có thẩm quyền;
  - Trong trường hợp khẩn cấp, cần xử lý ngay Thông tin Khách hàng có liên quan để bảo vệ tính mạng, sức khỏe của chủ thể dữ liệu hoặc người khác với điều kiện là việc xử lý thông tin này phải phù hợp với quy định của pháp luật;
  - Việc công khai Thông tin Khách hàng theo quy định của luật; tuân thủ các nghĩa vụ của doanh nghiệp cung cấp dịch vụ viễn thông, truyền hình theo quy định của pháp luật;
  - Việc xử lý dữ liệu của cơ quan nhà nước có thẩm quyền trong trường hợp tình trạng khẩn cấp về quốc phòng, an ninh quốc gia, trật tự an toàn xã hội, thảm họa lớn, dịch bệnh nguy hiểm; khi có nguy cơ đe dọa an ninh, quốc phòng nhưng chưa đến mức ban bố tình trạng khẩn cấp; phòng, chống bạo loạn, khủng bố, phòng, chống tội phạm và vi phạm pháp luật theo quy định của luật;
  - Để thực hiện nghĩa vụ theo hợp đồng của chủ thể dữ liệu với cơ quan, tổ chức, cá nhân có liên quan theo quy định của pháp luật;
  - Phục vụ hoạt động của cơ quan nhà nước đã được quy định theo pháp luật chuyên ngành.
<b>3.2.</b> Trừ trường hợp quy định tại Điều 3.1, VNPT phải thực hiện thông báo và lấy chấp thuận của Khách hàng trước khi xử lý Thông tin Khách hàng của Khách hàng đối với các mục đích được liệt kê dưới đây (sau đây gọi tắt là <b>“Mục đích tùy chọn”</b>). Thông tin Khách hàng thu thập, cập nhật, bổ sung phải phù hợp và giới hạn trong phạm vi, mục đích cần xử lý theo quy định tại Chính sách này.
 <b>a)</b> Mục đích kinh doanh các dịch vụ phân tích dữ liệu, dịch vụ xác thực, dịch vụ định danh, dịch vụ quảng cáo, dịch vụ tiếp thị, nghiên cứu thị trường, thăm dò dư luận, môi giới. Đối với dịch vụ tiếp thị, phương thức, hình thức, tần suất giới thiệu sản phẩm thực hiện theo quy định của pháp luật về bảo vệ dữ liệu cá nhân.
 <b>b)</b> Tổ chức chương trình quảng cáo, giới thiệu sản phẩm, hàng hóa, dịch vụ và thực hiện các hoạt động xúc tiến thương mại đối với sản phẩm, hàng hóa, dịch vụ do Bên A cung cấp cho Bên B, bao gồm các hoạt động sử dụng Thông tin Khách hàng để quảng cáo, tiếp thị với Khách hàng về các chương trình khuyến mại, nghiên cứu, khảo sát, tin tức, thông tin cập nhật, các sự kiện, cuộc thi có thưởng, trao các phần thưởng có liên quan, các quảng cáo và nội dung có liên quan về Sản phẩm, dịch vụ của VNPT. Trường hợp Khách hàng không muốn tiếp tục nhận email, tin nhắn và/hoặc bản tin định kỳ với mục đích quảng cáo, tiếp thị của VNPT với tần suất tùy thuộc vào Chính sách của VNPT theo từng thời kỳ và phù hợp với quy định pháp luật, Khách hàng có thể từ chối theo cách thức đã được VNPT hướng dẫn trên các kênh, phương tiện như tin nhắn, cuộc gọi, dấu tích trên website/ứng dụng cung cấp dịch vụ hoặc liên hệ với tổng đài chăm sóc Khách hàng của VNPT;
<b>3.3.</b> VNPT không thực hiện hoạt động mua bán Thông tin Khách hàng dưới bất kỳ hình thức nào.
</pre>
"""),
                    ItemPolicy(
                        title: 'Điều 4. Cách thức xử lý Thông tin Khách hàng',
                        content: """<pre>
VNPT áp dụng một hoặc nhiều hoạt động tác động tới Thông tin Khách hàng như: thu thập, ghi, phân tích, xác nhận, lưu trữ, chỉnh sửa, công khai, kết hợp, truy cập, truy xuất, thu hồi, mã hóa, giải mã, sao chép, chia sẻ, truyền đưa, cung cấp, chuyển giao, xóa, hủy Thông tin Khách hàng hoặc các hành động khác có liên quan phù hợp với quy định của pháp luật.
</pre>"""),
                    ItemPolicy(
                        title:
                            'Điều 5. Thời gian bắt đầu, thời gian kết thúc xử lý dữ liệu',
                        content: """<pre>
<b>1.</b> Thời gian bắt đầu xử lý dữ liệu: Kể từ thời điểm phát sinh các Mục Đích quy định tại Điều 3 Chính sách này.
<b>2.</b> Thời gian kết thúc xử lý dữ liệu: VNPT chấm dứt việc xử lý Thông tin Khách hàng khi đã hoàn thành Mục Đích quy định tại Chính sách này, trừ trường hợp pháp luật có quy định khác hoặc Khách hàng rút lại sự đồng ý việc xử lý Thông tin Khách hàng hoặc khi cơ quan nhà nước có thẩm quyền yêu cầu bằng văn bản.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 6. Phạm vi sử dụng Thông tin Khách hàng',
                        content: """<pre>
<b>6.1.</b> VNPT được phép chia sẻ Thông tin Khách hàng của Khách hàng cho các tổ chức, cá nhân dưới đây để thực hiện các Mục Đích quy định tại Chính sách <b>(“Phạm vi sử dụng bắt buộc”)</b>, cụ thể:
 <b>1.</b> Chia sẻ thông tin với Công ty con của VNPT, công ty liên kết của VNPT, công ty liên kết của Công ty con của VNPT <i>(Theo Nghị định 25/2016/NĐ-CP)</i>;
 <b>2.</b> Chia sẻ thông tin với Bên thứ ba cung cấp dịch vụ cho VNPT hoặc các đối tác trong các hợp đồng hợp tác kinh doanh nhằm phát triển sản phẩm, dịch vụ của VNPT và hai bên đã có thỏa thuận bằng văn bản về việc bên thứ ba có trách nhiệm bảo vệ Thông tin Khách hàng <i>(Theo Điểm a Khoản 4 Điều 18 Luật bảo vệ quyền lợi người tiêu dùng 2023)</i>, cụ thể: VNPT sử dụng và/hoặc hợp tác với các công ty và cá nhân khác để thực hiện một số công việc và chương trình như chương trình quảng cáo, khuyến mại dành cho Khách hàng, nghiên cứu thị trường, phân tích và phát triển sản phẩm, tư vấn chiến lược, cung cấp dịch vụ thu cước. Các Bên thứ ba cung cấp dịch vụ và/hoặc các đối tác này có quyền truy cập, thu thập, sử dụng và xử lý Thông tin Khách hàng của Khách hàng trong phạm vi Khách hàng đã đồng ý và VNPT cho phép để thực hiện các chức năng của họ và phải tuân thủ quy định của pháp luật về bảo vệ Thông tin Khách hàng với tư cách là Bên Xử lý Dữ Liệu, có văn bản/thỏa thuận về xử lý Thông tin Khách hàng xác định rõ phạm vi, mục đích, loại Thông tin Khách hàng được chia sẻ, các quyền nghĩa vụ của các bên và trách nhiệm của Bên Xử lý Thông tin Khách hàng đối với việc bảo vệ Thông tin Khách hàng.
 <b>3.</b> Chia sẻ thông tin với các doanh nghiệp viễn thông có thỏa thuận bằng văn bản với Bên B về việc trao đổi, cung cấp thông tin thuê bao viễn thông, thông tin về việc sử dụng dịch vụ viễn thông của người sử dụng dịch vụ để phục vụ cho việc tính giá, lập hóa đơn <i>(Theo quy định tại Điểm b Khoản 4 Điều 6 Luật Viễn thông 2023)</i>;
 <b>4.</b> Cung cấp thông tin thuê bao viễn thông có hành vi trốn tránh thực hiện nghĩa vụ thanh toán tiền sử dụng dịch vụ viễn thông theo quy định của Bộ trưởng Bộ Thông tin và Truyền thông <i>(Theo quy định tại Điểm c Khoản 4 Điều 6 Luật Viễn thông 2023)</i>;
 <b>5.</b> Khi có yêu cầu của cơ quan nhà nước có thẩm quyền, theo quy định của pháp luật <i>(Theo quy định tại Điểm d Khoản 4 Điều 6 Luật Viễn thông 2023)</i>.
<b>6.2.</b> Ngoài các đối tượng quy định tại Điều 6.1 Chính sách này, việc chia sẻ Thông tin Khách hàng cho bất kì bên thứ ba nào khác phải được sự chấp thuận của Khách hàng <b>(“Phạm vi sử dụng tùy chọn”)</b>.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 7. Quyền của Khách hàng', content: """<pre>
<b>1.</b> Quyền được biết và Quyền đồng ý
Khách hàng có quyền được biết về hoạt động xử lý Thông tin Khách hàng của mình, trừ trường hợp pháp luật có quy định khác. Khách hàng có quyền đồng ý hoặc không đồng ý với các điều khoản và điều kiện của Chính sách này theo cách thức đã được VNPT hướng dẫn trên các kênh, phương tiện như tin nhắn SMS, cuộc gọi, dấu tích trên website/ứng dụng cung cấp dịch vụ hoặc liên hệ với tổng đài chăm sóc khách hàng của VNPT phù hợp với quy định của pháp luật. VNPT chỉ thực hiện xử lý Thông tin Khách hàng khi đã có chấp thuận của Khách hàng. 
<b>2.</b> Quyền truy cập và yêu cầu cung cấp Thông tin Khách hàng 
Khách hàng có quyền truy cập vào các ứng dụng cung cấp dịch vụ/website của VNPT và/hoặc liên hệ trực tiếp với VNPT để xem, chỉnh sửa, trích xuất các Thông tin Khách hàng của Khách hàng, trừ trường hợp pháp luật có quy định khác. 
Trường hợp Khách hàng không thể tự truy cập để xem, chỉnh sửa, trích xuất hoặc gặp khó khăn trong việc truy cập để xem, chỉnh sửa hoặc trích xuất các Thông tin Khách hàng, Khách hàng vui lòng liên hệ với VNPT để được hỗ trợ.
<b>3.</b> Quyền chỉnh sửa
Khách hàng có quyền chỉnh sửa các Thông tin Khách hàng của mình với điều kiện việc chỉnh sửa này không vi phạm các quy định của pháp luật. Trường hợp Khách hàng không thể tự chỉnh sửa hoặc gặp khó khăn trong việc chỉnh sửa các Thông tin Khách hàng, Khách hàng có thể liên hệ với VNPT để được hỗ trợ.
<b>4.</b> Quyền phản đối, hạn chế, rút lại sự đồng ý xử lý dữ liệu
 <b>a)</b> Khách hàng có quyền phản đối, yêu cầu hạn chế xử lý Thông tin Khách hàng hoặc rút lại sự đồng ý xử lý Thông tin Khách hàng. Tuy nhiên, việc phản đối, hạn chế hoặc rút lại sự đồng ý xử lý Thông tin Khách hàng bắt buộc cung cấp tại Điều 2 hoặc phản đối, hạn chế hoặc rút lại sự đồng ý xử lý Thông tin Khách hàng phục vụ các Mục đích bắt buộc tại Điều 3 hoặc phản đối, hạn chế hoặc rút lại sự đồng ý đối với Phạm vi sử dụng bắt buộc tại Điều 6 sẽ dẫn tới việc VNPT không thể cung cấp Sản phẩm, dịch vụ cho Khách hàng, điều này đồng nghĩa với việc VNPT có thể đơn phương chấm dứt hợp đồng mà không cần phải bồi thường cho Khách hàng do các điều kiện để thực hiện hợp đồng đã thay đổi (trừ trường hợp do lỗi của VNPT). 
 <b>b)</b> Trường hợp Khách hàng muốn phản đối, hạn chế, rút lại sự đồng ý xử lý Thông tin Khách hàng phục vụ các Mục đích tùy chọn quy định tại Điều 3 Chính sách này hoặc phản đối, hạn chế, rút lại sự đồng ý xử lý Thông tin Khách hàng tùy chọn cung cấp hoặc hoặc phản đối, hạn chế, rút lại sự đồng ý xử lý đối với Phạm vi sử dụng tùy chọn, Khách hàng thực hiện theo hướng dẫn của VNPT tại thời điểm VNPT thu thập Thông tin Khách hàng hoặc liên hệ với VNPT theo các thông tin được cung cấp tại Chính sách này. Nếu Khách hàng không muốn nhận thông báo từ ứng dụng cung cấp dịch vụ của VNPT, vui lòng điều chỉnh cài đặt thông báo trong ứng dụng cung cấp dịch vụ hoặc thiết bị của mình. 
<b>5.</b> Quyền xóa Thông tin Khách hàng 
Khách hàng có quyền yêu cầu VNPT thực hiện xóa Thông tin Khách hàng của Khách hàng với điều kiện là yêu cầu của Khách hàng phải phù hợp với quy định của pháp luật. Tuy nhiên, yêu cầu xóa Thông tin Khách hàng bắt buộc cung cấp theo quy định pháp luật sẽ dẫn tới việc VNPT không thể cung cấp Sản phẩm, dịch vụ cho Khách hàng, điều này đồng nghĩa với việc VNPT có thể đơn phương chấm dứt hợp đồng mà không cần phải bồi thường cho Khách hàng do các điều kiện để thực hiện hợp đồng đã thay đổi (trừ trường hợp do lỗi của VNPT hoặc pháp luật có quy định khác). 
<b>6.</b> Quyền khiếu nại, tố cáo, khởi kiện 
Khách hàng có quyền khiếu nại, tố cáo hoặc khởi kiện theo quy định của pháp luật.
<b>7.</b> Quyền yêu cầu bồi thường thiệt hại
Khách hàng có quyền yêu cầu bồi thường thiệt hại theo quy định của pháp luật khi xảy ra vi phạm quy định về bảo vệ Thông tin Khách hàng của mình, trừ trường hợp các bên có thỏa thuận khác hoặc luật có quy định khác.
<b>8.</b> Quyền tự bảo vệ 
Khách hàng có quyền tự bảo vệ theo quy định của Bộ luật Dân sự, luật khác có liên quan và Nghị định 13/2023/NĐ-CP về bảo vệ Thông tin Khách hàng (và các bản sửa đổi kèm theo), hoặc yêu cầu cơ quan, tổ chức có thẩm quyền thực hiện các phương thức bảo vệ quyền dân sự theo quy định tại Điều 11 Bộ luật Dân sự.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 8. Nghĩa vụ của Khách hàng',
                        content: """<pre>
Khách hàng có trách nhiệm bảo vệ Thông tin Khách hàng của mình như sau: 
 <b>1.</b> Chủ động thực hiện các biện pháp bảo vệ, quản lý và sử dụng an toàn tài khoản, thiết bị công nghệ cá nhân (bao gồm các thiết bị như điện thoại thông minh, máy tính, máy tính bảng, laptop) bằng cách đăng xuất tài khoản sau khi sử dụng, đặt một mật khẩu mạnh<sup>1</sup> và giữ bí mật thông tin đăng nhập cũng như mật khẩu của mình. Các biện pháp bảo vệ và quản lý sử dụng an toàn tài khoản, thiết bị di động nói trên giúp ngăn chặn việc truy cập trái phép vào tài khoản của Khách hàng. VNPT được loại trừ trách nhiệm với các thiệt hại của Khách hàng trong trường hợp Khách hàng bị lộ/mất, bị đánh cắp mật khẩu, dẫn tới việc bị truy cập trái phép vào tài khoản, hoặc bất kỳ hoạt động nào trên tài khoản của Khách hàng sử dụng trên thiết bị di động bị mất, thất lạc dẫn đến người không có thẩm quyền tự ý sử dụng dịch vụ, hoặc hệ thống của VNPT bị xâm phạm bất hợp pháp bởi bên thứ ba mặc dù VNPT đã thực hiện đầy đủ các biện pháp để bảo vệ hệ thống (trừ trường hợp do lỗi của VNPT);
 <sup>(1)</sup> Mật khẩu mạnh phải đảm bảo các yếu tố sau:
  •   Sử dụng tối thiểu 8 ký tự, và tối đa 15 ký tự.
  •   Bao gồm số, chữ thường, chữ in hoa và ký tự đặc biệt.
  •   Duy nhất, không dùng chung cho các tài khoản khác.
  •   Không được mang ý nghĩa đi kèm (số điện thoại, ngày sinh, tên địa danh...).
  •   Không sử dụng tên riêng.
  •   Không sử dụng các con số nổi tiếng, ví dụ: 113, 115, 12345678...
  •	  Không sử dụng các thông tin trong mật khẩu cho câu hỏi bí mật (câu hỏi bí mật là phương pháp giúp người dùng đặt lại mật khẩu khi quên).
 <b>2.</b> Khi đã chấp thuận toàn bộ điều khoản và điều kiện của của Chính sách này, Khách hàng có trách nhiệm cung cấp Thông tin Khách hàng đầy đủ, chính xác theo yêu cầu của VNPT và có trách nhiệm thông báo cho VNPT ngay khi phát hiện hành vi vi phạm quy định về bảo vệ Thông tin Khách hàng;
 <b>3.</b> Khách hàng có trách nhiệm tôn trọng Thông tin Khách hàng của chủ thể khác và thực hiện quy định của pháp luật về bảo vệ Thông tin Khách hàng, tham gia phòng, chống các hành vi vi phạm quy định về bảo vệ Thông tin Khách hàng.
</pre>"""),
                    ItemPolicy(
                        title:
                            'Điều 9. Lưu trữ Thông tin Khách hàng/Phạm vi sử dụng Thông tin Khách hàng',
                        content: """<pre>
<b>1.</b> Địa điểm lưu trữ Thông tin Khách hàng: Trong phạm vi pháp luật cho phép, VNPT có thể lưu trữ Thông tin Khách hàng của Khách hàng tại Việt Nam và ở nước ngoài, kể cả trên giải pháp lưu trữ điện toán đám mây. VNPT áp dụng các tiêu chuẩn về bảo mật dữ liệu phù hợp với quy định pháp luật hiện hành. Việc chuyển Thông tin Khách hàng ra nước ngoài phải phù hợp với quy định tại Điều 25 Nghị định 13/2023/NĐ-CP (và các bản sửa đổi kèm theo) và các quy định của pháp luật. 
<b>2.</b> Thời gian lưu trữ Thông tin Khách hàng: Trừ trường hợp pháp luật có quy định khác, VNPT chỉ thực hiện lưu trữ Thông tin Khách hàng của Khách hàng để hoàn thành các Mục Đích bắt buộc (và các Mục đích tùy chọn trong trường hợp được Khách hàng đồng ý) quy định tại Chính sách này.  
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 10. Nghĩa vụ của VNPT', content: """<pre>
<b>1.</b> Thông tin Khách hàng của Khách hàng được cam kết bảo mật theo quy định của pháp luật, Chính sách bảo vệ Thông tin Khách hàng của VNPT. VNPT phải có các biện pháp bảo vệ Thông tin Khách hàng theo quy định của pháp luật, trong đó các biện pháp ngăn chặn các hành vi sau đây:
 <b>a)</b> Đánh cắp hoặc tiếp cận thông tin trái phép;
 <b>b)</b> Sử dụng thông tin trái phép;
 <b>c)</b> Chỉnh sửa, cập nhật, hủy bỏ thông tin trái phép.
<b>2.</b> VNPT áp dụng những biện pháp vật lý, điện tử và quản lý để bảo vệ Thông tin Khách hàng, bao gồm: 
 <b>a)</b> Các máy chủ trang thông tin điện tử chính thức của VNPT và các hệ thống thông tin chứa Thông tin Khách hàng của VNPT đều được bảo vệ bởi các biện pháp, công nghệ bảo mật như tường lửa, mã hóa, chống xâm nhập trái phép; ban hành các biện pháp kiểm soát về con người, xây dựng quy trình kiểm tra, đánh giá, rà soát để phòng tránh các hành vi vi phạm quy định về bảo vệ Thông tin Khách hàng.
 <b>b)</b> VNPT sẽ thực hiện tất cả các biện pháp cần thiết để đảm bảo rằng Thông tin Khách hàng của Khách hàng được xử lý đúng với Mục Đích đã thông báo và được Khách hàng đồng ý. VNPT sẽ luôn tuân thủ những yêu cầu của pháp luật liên quan đến việc xử lý Thông tin Khách hàng.
<b>3.</b> Thực hiện các yêu cầu của Khách hàng liên quan đến Thông tin Khách hàng của Khách hàng với điều kiện các yêu cầu của Khách hàng phải phù hợp với quy định của pháp luật.
<b>4.</b> Trong trường hợp hệ thống thông tin bị tấn công làm phát sinh nguy cơ mất an toàn, an ninh Thông tin Khách hàng, VNPT hoặc bên lưu trữ thông tin liên quan phải thông báo cho cơ quan quản lý nhà nước có thẩm quyền trong thời hạn theo quy định của pháp luật và thực hiện các biện pháp cần thiết để bảo đảm an toàn, an ninh Thông tin Khách hàng theo quy định của pháp luật về an ninh mạng, an toàn thông tin mạng, giao dịch điện tử và quy định khác của pháp luật có liên quan.
<b>5.</b> Các nghĩa vụ khác theo quy định của pháp luật và của Chính sách này.
</pre>"""),
                    ItemPolicy(
                        title:
                            'Điều 11. Hậu quả, thiệt hại không mong muốn có khả năng xảy ra',
                        content: """<pre>
<b>1.</b> VNPT sử dụng nhiều biện pháp, công nghệ bảo mật thông tin khác nhau nhằm bảo vệ Thông tin Khách hàng của Khách hàng không bị sử dụng hoặc chia sẻ ngoài ý muốn trong quá trình xử lý Thông tin Khách hàng (bao gồm cả dữ liệu sinh trắc học của Khách hàng). VNPT cam kết sẽ bảo mật một cách tối đa Thông tin Khách hàng. Một số hậu quả, thiệt hại, rủi ro không mong muốn có thể xảy ra bao gồm: 
 <b>a)</b> Lỗi phần cứng, phần mềm trong quá trình xử lý Thông tin Khách hàng gây ảnh hưởng không mong muốn (lỗi, hỏng, mất) Thông tin Khách hàng của Khách hàng; 
 <b>b)</b> Lỗ hổng bảo mật nằm ngoài khả năng kiểm soát của VNPT, hệ thống bị hacker tấn công gây lộ lọt Thông tin Khách hàng của Khách hàng; 
 <b>c)</b> Khách hàng tự làm lộ lọt Thông tin Khách hàng của Khách hàng do: bất cẩn hoặc bị lừa đảo; truy cập các website/tải các ứng dụng cung cấp dịch vụ có chứa phần mềm độc hại; tự ý chia sẻ thông tin với người khác.
<b>2.</b> VNPT khuyến cáo Khách hàng thực hiện nghiêm ngặt các trách nhiệm bảo vệ Thông tin Khách hàng theo quy định tại Điều 8 Chính sách này và theo quy định của pháp luật. 
<b>3.</b> Trong trường hợp xảy ra lỗi phần cứng, phần mềm trong quá trình xử lý Thông tin Khách hàng theo quy định tại Điểm a Khoản 1 Điều này, VNPT có trách nhiệm bồi thường thiệt hại cho Khách hàng theo quy định tại Hợp đồng và theo quy định pháp luật.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 12. Quảng cáo trên internet và bên thứ ba',
                        content: """<pre>
Các website/ứng dụng cung cấp dịch vụ của VNPT có thể bao gồm quảng cáo của bên thứ ba và liên kết tới các website/ứng dụng cung cấp dịch vụ khác. Các đối tác quảng cáo bên thứ ba có thể thu thập thông tin về Khách hàng khi Khách hàng tương tác với nội dung, quảng cáo hoặc dịch vụ của họ. Mọi quyền truy cập và sử dụng các liên kết hoặc trang website của bên thứ ba không bị điều chỉnh bởi Chính sách này, mà thay vào đó được điều chỉnh bởi chính sách quyền riêng tư của các bên thứ ba đó.
</pre>"""),
                    ItemPolicy(title: 'Điều 13. Luật áp dụng', content: """<pre>
Chính sách này được soạn thảo và điều chỉnh bởi pháp luật Việt Nam.
</pre>"""),
                    ItemPolicy(
                        title: 'Điều 14. Thông tin liên lạc', content: """<pre>
Trường hợp Khách hàng có bất kỳ câu hỏi nào về Chính sách này hoặc muốn thực hiện các quyền của Khách hàng liên quan tới Thông tin Khách hàng, vui lòng liên hệ với VNPT theo các phương thức và thông tin dưới đây: 
 <b>1.</b> Liên hệ tới tổng đài theo thông tin tại các website/ứng dụng cung cấp dịch vụ chính thức của VNPT tại từng thời điểm.
 <b>2.</b> Liên hệ trực tiếp tại các điểm giao dịch của VNPT trên phạm vi toàn quốc. 
 <b>3.</b> Các cách thức liên hệ khác như Livechat (phần mềm trò chuyện trực tuyến), liên hệ qua fanpage (trang thông tin điện tử) chính thức của VNPT, email chăm sóc Khách hàng được cung cấp cho Khách hàng tại mọi thời điểm.
</pre>"""),
                    Padding(padding: EdgeInsets.only(bottom: 70)),
                  ],
                ),
              ));
        }
      }),
      bottomSheet: Container(
        height: 70,
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 6,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppButtonWidget(
                    label: AppLocalizations.current.close,
                    labelColor: const Color(0xff0D75D6),
                    backgroundColor: const Color(0xffE0F0FF),
                    doublePadding: 15,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: AppButtonWidget(
                    label: (widget.fromScreen == "registerAccount" ||
                            widget.fromScreen == "buyCertificate")
                        ? AppLocalizations.current.Continue
                        : AppLocalizations.current.save,
                    doublePadding: 15,
                    onTap: () async {
                      await controller
                          .updatePolicy(controller.checkPolicyList.value);

                      if (widget.callback != null) {
                        if (widget.fromScreen == "registerAccount") {
                          await widget.callback!();
                        } else {
                          widget.callback!();
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemPolicy extends StatelessWidget {
  final String title;
  final String content;
  ItemPolicy({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 0),
      childrenPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Html(
          data: "$content",
          style: {
            "pre": Style(
              fontSize: FontSize(14),
              fontFamily: "Roboto",
              textAlign: TextAlign.justify,
              wordSpacing: 1.0,
            ),
          },
        ),
      ],
    );
  }
}

class ItemPolicyCheckBox extends StatefulWidget {
  final String content1;
  final String content2;
  const ItemPolicyCheckBox(
      {super.key, required this.content1, required this.content2});

  @override
  State<ItemPolicyCheckBox> createState() => _ItemPolicyCheckBoxState();
}

class _ItemPolicyCheckBoxState extends State<ItemPolicyCheckBox> {
  final globalKey = GlobalKey();

  final String uid = "";
  final controller = Get.find<PolicyDataController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Table(
        border: TableBorder.all(color: Colors.black, width: 1),
        columnWidths: {
          0: FlexColumnWidth(5),
          1: FlexColumnWidth(1),
        },
        children: thirdPolicy.subPolicy.map(buildPolicyUserCheck).toList(),
      ),
    );
  }

  TableRow buildPolicyUserCheck(Policy policy) {
    return TableRow(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                child: policy.index == 0
                    ? RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black, fontSize: 13), // Style chung
                          children: [
                            TextSpan(
                              text:
                                  "Mục đích/Phạm vi sử dụng Thông tin Khách hàng",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold), // Phần in đậm
                            ),
                            TextSpan(
                              text:
                                  " (Quy định chi tiết tại Điều 3 và Điều 6 Chính sách bảo vệ thông tin khách hàng của TẬP ĐOÀN BƯU CHÍNH VIỄN THÔNG VIỆT NAM)",
                            ),
                          ],
                        ),
                      )
                    : Text(
                        policy.title,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: policy.index != null
                              ? FontWeight.normal
                              : FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
        if (policy.index == 0)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: BaseText(
              "Chấp thuận của Khách hàng",
              textAlign: TextAlign.center,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        if (policy.index != null && (policy.index ?? 0) > 0)
          Checkbox(
            value: controller.checkPolicyList.value[policy.index! - 1],
            onChanged: (newValue) {
              if (policy.required) {
                //show thong baos
                showNotifyModal(
                    "Mục đích xử lý dữ liệu cá nhân này là bắt buộc để VNPT cung cấp dịch vụ VNPT SmartCA cho khách hàng",
                    title: "Lưu ý!");
              } else {
                controller.checkPolicyList[policy.index! - 1] =
                    newValue ?? false;
              }
            },
          )
      ],
    );
  }
}
