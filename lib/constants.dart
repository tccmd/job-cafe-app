import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 컬러
const Color black = Color(0xff000000);
const Color white = Color(0xffFFFFFF);

const Color grayF6 = Color(0xffF6F6F7);
const Color grayEA = Color(0xffEAEAEA);
const Color grayC1 = Color(0xffC1C1C1);
const Color grayB5 = Color(0xffB5B5B6);
const Color grayA8 = Color(0xffA8A8A8);
const Color gray80 = Color(0xff808285);
const Color gray79 = Color(0xff797979);
const Color gray6F = Color(0xff6F6F6F);
const Color gray58 = Color(0xff585656);
const Color gray54 = Color(0xff545454);
const Color gray3D = Color(0xff3D3D3D);
const Color gray2E = Color(0xff2E2D2D);
const Color gray1C = Color(0xff1C1C1C);

const Color heart = Color(0xffFF4A55);
const Color error = Color(0xffFF3B30);
const Color primaryLight = Color(0xffFBD145);
// const Color primary = Color(0xffD3AE5A);
const Color profileBg = Color(0xffEDC948);

const Color primary = Color(0xff2FC6CB);
const Color primary2 = Color(0xff2FCBBE);
const Color primary3 = Color(0xff2F85CB);
const Color choco = Color(0xff3A2727);
const Color lip = Color(0xffCBAEBB);
const Color surfaceD9 = Color(0xffD9D9D9);
const Color shadowCE = Color(0xffCECECE);

// 패딩
EdgeInsets pd24all = EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h);
EdgeInsets pd24h20v = EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h);
EdgeInsets pd24h18v = EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h);
EdgeInsets pd24h16v = EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h);
EdgeInsets pd24h12v = EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h);
EdgeInsets pd24T = EdgeInsets.only(top: 24.h);
EdgeInsets pd24B = EdgeInsets.only(bottom: 24.h);
EdgeInsets pd24L = EdgeInsets.only(left: 24.w);
EdgeInsets pd24h = EdgeInsets.symmetric(horizontal: 24.w);
EdgeInsets pd24v = EdgeInsets.symmetric(vertical: 24.h);
EdgeInsets pd24202407 = EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 7.h);
EdgeInsets pd00122412 = EdgeInsets.fromLTRB(0, 12.h, 24.h, 12.h);
EdgeInsets pd24242400 = EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0);
EdgeInsets pd20h16v = EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h);
EdgeInsets pd20h12v = EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h);
EdgeInsets pd18h16v = EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h);
EdgeInsets pd18v = EdgeInsets.symmetric(vertical: 18.h);
EdgeInsets pd16L = EdgeInsets.only(left: 16.w);
EdgeInsets pd16h = EdgeInsets.symmetric(horizontal: 16.w);
EdgeInsets pd16v = EdgeInsets.symmetric(vertical: 16.h);
EdgeInsets pd16h12v = EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
EdgeInsets pd16h20v = EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h);
EdgeInsets pd12h8v = EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
EdgeInsets pd12v = EdgeInsets.symmetric(vertical: 12.h);
EdgeInsets pd20R = EdgeInsets.only(right: 20.w);
EdgeInsets pd20h10w = EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h);
EdgeInsets pd0 = const EdgeInsets.all(0);

// 텍스트 스타일
TextStyle startStyle = TextStyle(fontSize: 18.sp, height: 1);
TextStyle loginStyle =
TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1);
TextStyle appBarStyle =
TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, height: 1);
TextStyle cudiCafeDetailDescTit = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    height: 1);
TextStyle cudiCafeDetailDesc = TextStyle(
    fontSize: 13.sp, fontWeight: FontWeight.w400, color: gray58, height: 1.6);
TextStyle noticeContainerText =
TextStyle(color: gray80, fontSize: 12.sp, height: 1);
TextStyle s12 = TextStyle(fontSize: 12.sp, height: 1);
TextStyle s14 = TextStyle(fontSize: 14.sp, height: 1);
TextStyle s16 = TextStyle(fontSize: 16.sp, height: 1);
TextStyle w500 =
TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1);
TextStyle s12w500 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1,
    decoration: TextDecoration.underline);
TextStyle s12w600 =
TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, height: 1);
TextStyle s16w600 =
TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1);
TextStyle s16w500 =
TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 1);
TextStyle s16w700 =
TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1);
TextStyle s20 = TextStyle(fontSize: 20.sp, height: 1);
TextStyle s20w600 =
TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, height: 1);
TextStyle s24w700 =
TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700, height: 1);
TextStyle c79s12 = TextStyle(color: gray79, fontSize: 12.sp, height: 1);
TextStyle c85s12h16 = TextStyle(color: grayB5, fontSize: 12.sp, height: 1.6);
TextStyle h17 = TextStyle(fontSize: 14.sp, height: 1.7429);
TextStyle h19 = TextStyle(fontSize: 14.sp, height: 1.92);
TextStyle s12h19 = TextStyle(height: 1.92, fontSize: 12.sp);
TextStyle big =
TextStyle(fontWeight: FontWeight.w600, fontSize: 28.sp, height: 1.428);

// 사이즈
double homeIndicator = 34.h;
double dividerSize = 36.h;
double h54 = 54.h;
SizedBox sbh24 = SizedBox(height: 24.h);
SizedBox sbh20 = SizedBox(height: 20.h);
SizedBox sbh16 = SizedBox(height: 16.h);
SizedBox sbh12 = SizedBox(height: 12.h);
SizedBox sbh8 = SizedBox(height: 8.h);
SizedBox sbw20 = SizedBox(width: 20.w);
SizedBox sb = const SizedBox.shrink();

// 견본 문자열
const lorem = 'Lorem ipsum dolor sit amet consectetur. Dolor ut nisl risus turpis. Fusce quis dictum eget semper semper. Nec erat massa consequat ullamcorper nec. Augue diam interdum a at scelerisque mollis morbi. Ac id habitant hendrerit orci lectus ornare sit id. Volutpat tellus pharetra tempus dolor. Diam gravida turpis amet aliquam gravida egestas porta a varius. Elit amet eu lobortis pulvinar duis. Arcu condimentum consectetur duis euismod amet volutpat amet ut tortor. Nulla eget tellus nulla in tellus. Cras aliquet et in pretium cursus euismod interdum. Volutpat tincidunt mattis sagittis tristique interdum ac purus sollicitudin. Varius proin duis blandit at hac. Facilisi est ut erat pharetra et a. Eu leo iaculis porta massa sagittis fermentum. Ipsum porta mauris sem pharetra nec. Non consectetur odio';
const loremLong ='Lorem ipsum dolor sit amet consectetur. Dolor ut nisl risus turpis. Fusce quis dictum eget semper semper. Nec erat massa consequat ullamcorper nec. Augue diam interdum a at scelerisque mollis morbi. Ac id habitant hendrerit orci lectus ornare sit id. Volutpat tellus pharetra tempus dolor. Diam gravida turpis amet aliquam gravida egestas porta a varius. Elit amet eu lobortis pulvinar duis. Arcu condimentum consectetur duis euismod amet volutpat amet ut tortor. Nulla eget tellus nulla in tellus. Cras aliquet et in pretium cursus euismod interdum. Volutpat tincidunt mattis sagittis tristique interdum ac purus sollicitudin. Varius proin duis blandit at hac. Facilisi est ut erat pharetra et a. Eu leo iaculis porta massa sagittis fermentum. Ipsum porta mauris sem pharetra nec. Non consectetur odio habitant semper amet amet imperdiet neque erat. Dictum id at at sapien. Sit vitae sit tincidunt egestas. Amet arcu quis odio amet nulla. Varius in tempus dignissim ullamcorper. Lorem lectus in amet ut mauris. Turpis massa est magnis at eu commodo at a. Senectus gravida placerat scelerisque blandit elit congue sit morbi eget. Turpis leo lectus dictumst nunc metus. Convallis ut morbi in facilisi suspendisse. Pellentesque metus vitae aenean odio integer ut nisl. ';

//서비스 이용약관
const serviceTerm = '''
서비스 이용약관 (상품, 서비스 등 이용 일반 회원용) 
제1조(목적) 
1. 본 약관은 민트초코(MintChoco)가 운영하는 온라인 쇼핑몰 'MINT'에서 제공하는 서비스(이하 '서비스'라 합니다)를 이용함에 있어 당사자의 권리 의무 및 책임사항을 규정하는 것을 목적으로 합니다. 
2. PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 본 약관을 준용합니다. 
제2조(정의) 
1. '회사'라 함은, '민트초코(MintChoco)'가 재화 또는 용역을 이용자에게 제공하기 위하여 컴퓨터 등 정 보통신설비를 이용하여 재화등을 거래할 수 있도록 설정한 가상의 영업장을 운영하는 사업자를 말하며, 아울러 'MINT'을 통해 제공되는 전자상거래 관련 서비스의 의미로도 사용합니다. 
2. '이용자'라 함은, '사이트'에 접속하여 본 약관에 따라 '회사'가 제공하는 서비스를 받는 회원 및 비회원을 말합니다. 
3. '회원'이라 함은 '회사'에 개인정보를 제공하고 회원으로 등록한 자로서, '회사'의 서비스를 계속하여 이용 할 수 있는 자를 말합니다. 
4. '비회원'이라 함은, 회원으로 등록하지 않고, '회사'가 제공하는 서비스를 이용하는 자를 말합니다. 
5. '상품'이라 함은 '사이트'를 통하여 제공되는 재화 또는 용역을 말합니다. 
6. '구매자'라 함은 '회사'가 제공하는 '상품'에 대한 구매서비스의 이용을 청약한 '회원' 및 '비회원'을 말합니 다. 
제3조(약관 외 준칙) 
본 약관에서 정하지 아니한 사항은 법령 또는 회사가 정한 서비스의 개별 약관, 운영정책 및 규칙(이하 '세부지침'이라 합니다)의 규정에 따릅니다. 또한 본 약관과 세부지침이 충돌할 경우에는 세부지침이 우 선합니다. 
제4조(약관의 명시 및 개정) 
1. '회사'는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지, 전화번호, 모사전송번호(FAX), 전자우편 주소, 사업자등록번호, 통신판매업신고번호 등을 이용자가 쉽게 알 수 있도록 '회사' 홈페이지의 초기 서비스화면에 게시합니다. 다만 본 약관의 내용은 이용자가 연결화면을 통하여 확인할 수 있도록 할 수 있 습니다. 
2. '회사'는 '이용자가 약관에 동의하기에 앞서 약관에 정해진 내용 중 청약철회, 배송책임, 환불조건 등과 같 은 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 통하여 '이용자'의 확인을 구합니다. 
3. '회사'는 '전자상거래 등에서의 소비자보호에 관한 법률', '약관의 규제에 관한 법률','전자거래기본법', '정 보통신망 이용촉진등에 관한 법률', '소비자보호법 등 관련법령(이하 '관계법령'이라 합니다)에 위배되지 않는 범위내에서 본 약관을 개정할 수 있습니다. 
4. '회사'가 본 약관을 개정하고자 할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 온라인 쇼핑몰의 초기화면에 그 적용일자 7일전부터 적용일자 전날까지 공지합니다. 다만, '이용자'에게 불리한 내용 으로 약관을 변경하는 경우 최소 30일 이상 유예기간을 두고 공지합니다. 
5. '회사'가 본 약관을 개정한 경우, 개정약관은 적용일자 이후 체결되는 계약에만 적용되며 적용일자 이전 체결된 계약에 대해서는 개정 전 약관이 적용됩니다. 다만, 이미 계약을 체결한 이용자가 개정약관의 내 용을 적용받고자 하는 뜻을 '회사'에 전달하고 '회사'가 여기에 동의한 경우 개정약관을 적용합니다. 
6. 본 약관에서 정하지 아니한 사항 및 본 약관의 해석에 관하여는 관계법령 및 건전한 상관례에 따릅니다. 
제5조(제공하는 서비스) 
'회사'는 다음의 서비스를 제공합니다. 
1. 재화 또는 용역에 대한 정보 제공 및 구매계약 체결 
2. "재화 등"에 대한 광고플랫폼 서비스 
3. 기타 '회사'가 정하는 업무 
제6조(서비스의 중단 등) 
1. '회사'가 제공하는 서비스는 연중무휴, 1일 24시간 제공을 원칙으로 합니다. 다만 '회사' 시스템의 유지· 보수를 위한 점검, 통신장비의 교체 등 특별한 사유가 있는 경우 서비스의 전부 또는 일부에 대하여 일시 적인 제공 중단이 발생할 수 있습니다. 
2. '회사'는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우, 전 기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 부득이한 사유가 발생한 경우 서 비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 
3. '쇼핑몰'은 재화 또는 용역이 품절되거나 상세 내용이 변경되는 경우 장차 체결되는 계약에 따라 제공할 재 화나 용역의 내용을 변경할 수 있습니다. 이 경우 변경된 재화 또는 용역의 내용 및 제공일자를 명시하여 즉시 공지합니다. 
4. '회사'가 서비스를 정지하거나 이용을 제한하는 경우 그 사유 및 기간, 복구 예정 일시 등을 지체 없이 '이용자'에게 알립니다. 
제7조(회원가입) 
1. '회사'가 정한 양식에 따라 '이용자'가 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다. 
2. '회사'는 전항에 따라 회원가입을 신청한 이용자 중 다음 각호의 사유가 없는 한 '회원'으로 등록합니다. 
  가. 가입신청자가 본 약관에 따라 회원자격을 상실한 적이 있는 경우. 다만, '회사'의 재가입 승낙을 얻은 경우에는 예외로 합니다. 
  나. 회원정보에 허위, 기재누락, 오기 등 불완전한 부분이 있는 경우 
  다. 기타 회원으로 등록하는 것이 '회사'의 운영에 현저한 지장을 초래하는 것으로 인정되는 경우 
3. 회원가입 시기는 '회사'의 가입승낙 안내가 '회원'에게 도달한 시점으로 합니다. 
제8조(회원탈퇴 및 자격상실 등) 
1. '회원'은 '회사'에 언제든지 탈퇴를 요청할 수 있으며, '회사'는 지체없이 회원탈퇴 요청을 처리합니다. 다만 이미 체결된 거래계약을 이행할 필요가 있는 경우에는 본약관이 계속 적용됩니다. 
2. '쇼핑몰'은 다음 각호의 사유가 발생한 경우 '회사'의 자격을 제한 또는 정지시킬 수 있습니다. 
  가. 회원가입 시 허위정보를 기재한 경우 
  나. 다른 이용자의 정상적인 이용을 방해하는 경우 
  다. 관계법령 또는 본 약관에서 금지하는 행위를 한 경우 
  라. 공서양속에 어긋나는 행위를 한 경우 
  마. 기타 회원으로 등록하는 것이 적절하지 않은 것으로 판단되는 경우 
3. '회사'의 서비스를 1년 동안 이용하지 않는 '회원'의 경우 휴면계정으로 전환하고 서비스 이용을 제한할 수 있습니다. 
4. 휴면계정 전환 시 계정 활성을 위해 필요한 아이디(ID), 비밀번호, 이름, 중복가입 방지를 위한 본인 인증 값(DI), 휴대전화 번호를 제외한 나머지 정보는 별도로 저장 및 관리됩니다. 다만, 관계법령에 의해 보존 할 필요가 있는 경우 '회사'는 정해진 기간 동안 회원정보를 보관합니다. 
제9조(회원에 대한 통지) 
1. '회사'는 '회원' 회원가입 시 기재한 전자우편, 이동전화번호, 주소 등을 이용하여 '회원'에게 통지할 수 있 습니다. 
2. '회사'가 불특정 다수 '회원'에게 통지하고자 하는 경우 1주일 이상 '사이트'의 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만 '회원'이 서비스를 이용함에 있어 중요한 사항에 대하여는 개별 통지합니다. 
제10조(구매신청) 
'이용자'는 온라인 쇼핑몰 상에서 다음 방법 또는 이와 유사한 방법에 따라 구매를 신청할 수 있으며, '회사'는 '이용자'를 위하여 다음 각호의 내용을 알기 쉽게 제공하여야 합니다. 
1. 재화 또는 용역의 검색 및 선택 
2. 성명, 주소, 연락처, 전자우편주소 등 구매자 정보 입력 
3. 약관내용, 청약철회가 제한되는 서비스, 배송료 등 비용부담과 관련된 내용에 대한 확인 및 동의 표시 
4. 재화 또는 용역 등에 대한 구매신청 및 확인 
5. 결제방법 선택 및 결제 
6. '회사'의 최종 확인 
제11조(계약의 성립) 
1. '회사'는 다음 각호의 사유가 있는 경우 본 약관의 '구매신청' 조항에 따른 구매신청을 승낙하지 않을 수 있습니다. 
  가. 신청 내용에 허위, 누락, 오기가 있는 경우 
  나. 회원자격이 제한 또는 정지된 고객이 구매를 신청한 경우 
  다. 재판매, 기타 부정한 방법이나 목적으로 구매를 신청하였음이 인정되는 경우 
  라. 기타 구매신청을 승낙하는 것이 회사의 기술상 현저한 지장을 초래하는 것으로 인정되는 경우 
2. '회사'의 승낙이 본 약관의 '수신확인통지' 형태로 이용자에게 도달한 시점에 계약이 성립한 것으로 봅니다. 
3. '회사'가 승낙의 의사표시를 하는 경우 이용자의 구매신청에 대한 확인 및 판매가능여부, 구매신청의 정정 및 취소 등에 관한 정보가 포함되어야 합니다. 
제12조(결제방법 및 일반회원의 이용 수수료) 
1. '회사'의 '사이트'에서 구매한 상품에 대한 대금은 다음 각호의 방법으로 결제할 수 있습니다. 
  가. 선불카드, 직불카드, 신용카드 등 각종 카드결제 
  나. '회사'가 지급한 결제 가능한 적립금에 의한 결제 
  다. MINTPAY 결제 
2. '회사'는 '구매자'가 결제수단에 대한 정당한 사용권한을 가지고 있는지 여부를 확인할 수 있으며, 이에 대한 확인이 완료될 때까지 거래 진행을 중지하거나, 확인이 불가능한 거래를 취소할 수 있습니다. 
3. '회사'의 정책 및 결제업체(이동통신사, 카드회사 등) 또는 결제대행업체(PG)의 기준에 따라 이용자 당월 누적 결제액 및 충전한도정당한 사용권한을 가지고 있는지 여부를 확인할 수 있으며, 이에 대한 확인이 완 료될 때까지 거래 진행을 중지하거나, 확인이 불가능한 거래를 취소할 수 있습니다. 
4. '회사'의 정책 및 결제업체(이동통신사, 카드회사 등) 또는 결제대행업체(PG)의 기준에 따라 '구매자' 당월 누적 결제액 및 충전한도가 제한될 수 있습니다. 
5. 대금의 지급 또는 결제를 위하여 입력한 정보에 대한 책임은 '구매자'가 전적으로 부담합니다. 
6. 일반회원은 회사의 서비스 이용대가로 수수료, 회원료 등 각 상품의 구매시 또는 별도로 회사가 정한 회사가 정한 요율이나 기준에 따라 서비스 이용료를 지급해야 합니다. 
제13조(적립금 및 할인쿠폰) 
1. '회사'는 '상품' 등을 구입하거나 구입한 '구매자'에게 경품, 사은품 등의 목적으로 적립금, 할인 쿠폰(이하 '적립금'이라 합니다)을 부여할 수 있으며, '적립금'의 부여 및 사용 등과 관련한 사항은 이 약관 또는 '회 사'의 개별 운영정책이 정한 바에 따릅니다. 
2. '적립금'은 '회사'의 '사이트'에서 '상품'을 구매할 때, 현금과 1:1비율로 사용할 수 있으나 '회사'가 사용을 허가하지 않은 일부 상품에는 사용할 수 없으며, 현금으로 교환할 수 없습니다. 
3. '적립금'의 소멸시효는 1년을 원칙으로 하되, '회사'가 사전에 기간을 정하여 지급하는 '적립금'은 사전에 고지된 기간으로 합니다. 
4. '적립금'(반품적립금은 제외)의 소멸시효가 완성된 이후에는, 월 단위로 소멸되며 '회사'는 '구매자'의 '적립 금' 소멸예정일이 포함된 달의 첫번째 날에 개인정보에 입력된 이메일 주소로 안내합니다. 다만, 회원정보 에 이메일이 입력되지 않은 경우 안내 이메일이 발송되지 않으며 이에 대한 불이익은 책임지지 않습니다. 
5. '적립금'의 소멸시효가 완성되면, 발급 정보 등 관련된 모든 데이터가 삭제되어 조회 및 복구가 불가능 합니다. 
6. '적립금'은 회원탈퇴시 소멸됩니다. 
7. '적립금'은 타인에게 양도할 수 없으며, 이를 통하여 부정한 방법으로 이득을 취하거나, 악의적인 상거래에 이용할 경우 '회사'는 해당 '적립금'의 지급을 중지 또는 회수 할 수 있습니다. 
제14조(수신확인통지, 구매신청 변경 및 취소) 
1. '회사'는 '구매자'가 구매신청을 한 경우 '구매자'에게 수신확인통지를 합니다. 
2. 수신확인통지를 받은 '구매자'는 의사표시의 불일치가 있는 경우 수신확인통지를 받은 후 즉시 구매신청 내용의 변경 또는 취소를 요청할 수 있고, '회사'는 배송 준비 전 '구매자'의 요청이 있는 경우 지체없이 그 요청에 따라 변경 또는 취소처리 하여야 합니다. 다만 이미 대금을 지불한 경우 본 약관의 '청약철회 등에서 정한 바에 따릅니다. 
제15조(재화 등의 공급) 
1. '회사'는 별도의 약정이 없는 이상, '구매자'가 청약을 한 날부터 7일 이내에 재화 등을 배송할 수 있도록 주문제작, 포장 등 기타 필요한 조치를 취합니다. 다만 '회사'가 이미 대금의 전부 또는 일부를 받은 경우에는 대금을 받은 날부터 3영업일 이내에 필요한 조치를 취합니다. 
2. 전항의 경우 '회사'는 '구매자'가 상품 등의 공급 절차 및 진행 상황을 확인할 수 있도록 적절한 조치를 취해야합니다. 
제16조(환급) 
'회사'는 '구매자'가 신청한 '상품'이 품절, 생산중단 등의 사유로 인도 또는 제공할 수 없게된 경우 지체없이 그 사유를 '구매자'에게 통지합니다. 이 때 '구매자'가 재화 등의 대금을 지불한 경우 대금을 받은날 부터 3영업일 이내에 환급하거나 이에 필요한 조치를 취합니다. 
제17조(청약철회) 
1. '회사'와 재화 등의 구매에 관한 계약을 체결한 '구매자'는 수신확인의 통지를 받은 날부터 7일 이내에 청약을 철회할 수 있습니다. 
2. 다음 각호의 사유에 해당하는 경우, 배송받은 재화의 반품 또는 교환이 제한됩니다. 
  가. '구매자'에게 책임있는 사유로 재화 등이 멸실 또는 훼손된 경우(다만, 재화를 확인하기 위하여 포장등을 훼손한 경우는 예외로 합니다) 
  나. '구매자'의 사용 또는 소비에 의하여 재화의 가치가 현저히 감소한 경우 
  다. 시간의 경과로 재판매가 곤란할 정도로 재화의 가치가 현저히 감소한 경우 
  라. 같은 성능을 지닌 재화등으로 복제가 가능한 경우 그 원본이 되는 재화의 포장을 훼손한 경우 
  마. '구매자'의 주문에 의하여 개별적으로 생산한 상품으로서 청약철회 및 교환의 제한에 대하여 사전에 고지한 경우 
3. '회사'가 전항의 청약철회 제한 사유를 '구매자'가 알기 쉽게 명시하거나, 시용상품을 제공하는 등의 조치를 취하지 않은 경우 '구매자'의 청약철회가 제한되지 않습니다. 
4. '구매자'는 본조의 규정에도 불구하고 재화등의 내용이 표시, 광고 내용과 다르거나 계약내용과 다르게 이 행된 때에는 당해 재화를 공급받은 날로부터 3월 이내, 그 사실을 안날 또는 알 수 있었던 날부터 30일 이 내에 청약철회 등을 할 수 있습니다. 
제18조(청약철회의 효과) 
1. '회사'는 '구매자'로부터 재화 등을 반환 받은 경우 3영업일 이내에 이미 지급받은 재화 등의 대금을 환급합 니다. 이때 '회사'가 '구매자'에게 재화등의 환급을 지연한 때에는 그 지연기간에 대하여 전자상거래법 시 행령 제21조의3 소정의 이율(연 15%)을 곱하여 산정한 지연이자를 지급합니다. 
2. '회사'는 위 재화를 환급함에 있어서 '구매자'가 신용카드 또는 전자화폐 등의 결제수단을 사용한 경우에는 지체없이 당해 결제수단을 제공한 사업자로 하여금 재화등의 대금 청구를 정지 또는 취소하도록 요청합 니다. 
3. 청약철회의 경우 공급받은 재화등의 반환에 필요한 비용은 '구매자'가 부담합니다. 다만, 재화등의 내용이 표시·광고내용과 다르거나 계약내용과 다르게 이행되어 청약철회를 하는 경우 재화 등의 반환에 필요한 비용은 '회사'가 부담합니다. 
4. '회사'는 청약철회시 배송비 등 제반 비용을 누가 부담하는지 구매자가 알기 쉽도록 명확하게 표시합니다. 
제19조(개인정보보호) 
1. '회사'는 '구매자의 정보수집시 다음의 필수사항 등 구매계약 이행에 필요한 최소한의 정보만을 수집합니다. 
  가. 성명 
  나. 주민등록번호 또는 외국인등록번호 
  다. 주소 
  라. 전화번호(또는 이동전화번호) 
  마. 아이디(ID) 
  바. 비밀번호 
  사. 전자우편(e-mail)주소 
2. '회사'가 개인정보보호법 상의 고유식별정보 및 민감정보를 수집하는 때에는 반드시 대상자의 동의를 받습니다. 
3. '회사'는 제공된 개인정보를 '구매자'의 동의 없이 목적외 이용, 또는 제3자 제공할 수 없으며 이에 대한 모든 책임은 '회사'가 부담합니다. 다만 다음의 경우에는 예외로 합니다. 
  가. 배송업무상 배송업체에게 배송에 필요한 최소한의 정보(성명, 주소, 전화번호)를 제공하는 경우 나. 통계작성, 학술연구 또는 시장조사를 위하여 필요한 경우로서 특정 개인을 식별할 수 없는 형태로 제공하는 경우 
  다. 재화등의 거래에 따른 대금정산을 위하여 필요한 경우 
  라. 도용방지를 위하여 본인 확인이 필요한 경우 
  마. 관계법령의 규정에 따른 경우 
4. 본 약관에 기재된 사항 이외의 개인정보보호에 관한 사항은 '회사'의 '개인정보처리방침'에 따릅니다. 
제20조('회사'의 의무) 
1. '회사'는 관계법령, 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 약관이 정하는 바에 따라 지속적 · 안정적으로 재화 및 용역을 제공하는데 최선을 다하여야 합니다. 
2. '회사'는 '이용자'가 안전하게 인터넷 서비스를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다. 
3. '회사'가 상품에 대하여 표시·광고의 공정화에 관한 법률' 제3조 소정의 부당한 표시·광고행위를 하여 '이용자'가 손해를 입은 때에는 이를 배상할 책임을 집니다. 
4. '회사'는 '이용자'의 수신동의 없이 영리목적으로 광고성 전자우편, 휴대전화 메시지, 전화, 우편 등을 발송하지 않습니다. 
제21조(이용자 및 회원의 의무) 
1. '이용자'는 회원가입 신청 시 사실에 근거하여 신청서를 작성해야 합니다. 허위, 또는 타인의 정보를 등록 한 경우 '회사'에 대하여 일체의 권리를 주장할 수 없으며, '회사'는 이로 인하여 발생한 손해에 대하여 책임 을 부담하지 않습니다. 
2. '이용자'는 본 약관에서 규정하는 사항과 기타 회사가 정한 제반 규정 및 공지사항을 준수하여야 합니다. 또한 '이용자'는 '회사'의 업무를 방해하는 행위 및 '회사'의 명예를 훼손하는 행위를 하여서는 안 됩니다. 
3. '이용자'는 주소, 연락처, 전자우편 주소 등 회원정보가 변경된 경우 즉시 이를 수정해야 합니다. 변경된 정보를 수정하지 않거나 수정을 게을리하여 발생하는 책임은 '이용자'가 부담합니다. 
4. '이용자'는 다음의 행위를 하여서는 안됩니다. 
  가. '회사'에 게시된 정보의 변경 
  나. '회사'가 정한 정보 외의 다른 정보의 송신 또는 게시 
  다. '회사' 및 제3자의 저작권 등 지식재산권에 대한 침해 
  라. '회사' 및 제3자의 명예를 훼손하거나 업무를 방해하는 행위 
  마. 외설 또는 폭력적인 메시지, 화상, 음성 기타 관계법령 및 공서양속에 반하는 정보를 '회사'의 '사이트'에 공개 또는 게시하는 행위 
5. '회원'은 부여된 아이디(ID)와 비밀번호를 직접 관리해야 합니다. 
6. '회원'이 자신의 아이디(ID) 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 '회사'에 통보하고 안내에 따라야 합니다. 
제22조(저작권의 귀속 및 이용) 
1. '쇼핑몰'이 제공하는 서비스 및 이와 관련된 모든 지식재산권은 '회사'에 귀속됩니다 
2. '이용자'는 '쇼핑몰'에게 지식재산권이 있는 정보를 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나, 제3자가 이용하게 하여서는 안됩니다. 
3. '이용자'가 서비스 내에 게시한 게시물, 이용후기 등 콘텐츠(이하 '콘텐츠)의 저작권은 해당 '콘텐츠'의 저작자에게 귀속됩니다. 
제23조(분쟁의 해결) 
부칙 
1. '회사'는 '이용자'가 제기하는 불만사항 및 의견을 지체없이 처리하기 위하여 노력합니다. 다만 신속한 처리가 곤란한 경우 '이용자'에게 그 사유와 처리일정을 즉시 통보해 드립니다. 
2. '회사'와 '이용자간 전자상거래에 관한 분쟁이 발생한 경우, '이용자'는 한국소비자원, 전자문서·전자거래 분쟁조정위원회 등 분쟁조정기관에 조정을 신청할 수 있습니다. 
3. '회사'와 '이용자간 발생한 분쟁에 관한 소송은 '회사' 소재지를 관할하는 법원을 제1심 관할법원으로 하며, 준거법은 대한민국의 법령을 적용합니다. 
제1조(시행일) 
본 약관은 2023.12.20부터 적용합니다.
''';

// 개인정보 처리방침
String personalInfo = '''
개인정보처리방침
제1조(목적)
민트초코 (MintChoco)(이하 '회사라고 함')는 회사가 제공하고자 하는 서비스(이하 '회사 서비스')를 이용하는 개인(이하 '이용자' 또는 '개인')의 정보(이하 '개인정보')를 보호하기 위해, 개인정보보호법, 정보통신망 이용촉진및 정보보호 등에 관한 법류(이하 '정보통신망법') 등 관련 법령을 준수하고, 서비스 이용자의 개인정보 보호 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 갱니정보처리방침(이하 '본 방침')을 수립합니다.
제2조(개인정보 처리의 원칙)
개인정보 관련 법령 및 본 방침에 따라 회사는 이용자의 개인정보를 수집할 수 있으며 수집된 개인정보는 개인의 동의가 있는 경우에 한해 제3자에게 제공될 수 있습니다. 단, 법령의 규정 등에 의해 적법하게 강제되는 경우 회사는 수집한 이용자의 개인정보를 사전에 개인의 동의 없이 제3자에게 제공할 수도 있습니다.
제3조(본 방침의 공개)
1. 회사는 이용자가 언제든지 쉽게 본 방침을 확인할 수 있도록 회사 홈페이지 첫화면 또는 첫화면과의 연결회면을 통해 본 방침을 공개하고 있습니다.
2. 회사는 제1항에 따라 본 방침을 공개하는 경우 글자 크기, 색상 등을 활용하여 이용자가 본 방침을 쉽게 확인할 수 있도록 합니다.
제4조(본 방침의 변경)
1. 본 방침은 개인정보 관련 법령, 지침, 고시 또는 정부나 회사 서비스의 정책이나 내용의 변경에 따라 개정될 수 있습니다.
2. 회산느 제1항에 따라 본방침을 개정하는 경우 다음 각 호 하나 이상의 방법으로 공지합니다.
  가. 회사가 운영하는 인터넷 홈페이지의 첫 화면의 공지사항란 또는 별도의 창을 통하여 공지하는 방법
  나. 서면·모사전송·전자우편 또는 이와 비슷한 방법으로 이용자에게 공지하는 방법
3. 회산느 제2항의 공지는 본 방침 개정의 시행일로부터 최소 7일 이전에 공지합니다. 다만, 이용자 권리의 중요한 변경이 있을 경우에는 최소 30일전에 공지합니다.
제5조(회원 가입을 위한 정보)
회사는 이용자의 회사 서비스에 대한 회원가입을 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 이메일 주소, 비밀번호, 이름, 닉네임, 생년월일 및 휴대폰 번호
제6조(본인 인증을 위한 정보)
회사는 이용자의 본인인증을 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 휴대폰 번호, 이메일 주소, 이름, 생년월일, 성별, 이동통신사 및 내/외국인 여부
제7조(결제 서비스를 위한 정보)
회사는 이용자에게 회사의 결제 서비스 제공을 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 카드번호, 유효기간, 은행명 및 계좌번호
제8조(현금 영수증 발행을 위한 정보)
회사는 이용자의 현금영수증을 발행하기 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 현금영수증 발행 대상자 이름, 현금영수증 발행 대상자 생년월일, 형금영수증 발행 대상자 주소, 휴대폰 번호 및 현금영수증 카드번호
제9조(회사 서비스 제공을 위한 정보)
회사는 이용자에게 회사의 서비스를 제공하기 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 아이디, 이메일 주소, 이름, 생년월일 및 연락처
제10조(서비스 이용 및 부정 이용 확인을 위한 정보)
회사는 이용자의 서비스 이용에 따른 통계·분석 및 부정이용의 확인·분석을 위하여 다음과 같은 정보를 수집합니다. (부정이용이란 회원탈퇴 후 재가입, 상품구매 후 구매취소 등을 반복적으로 행하는 등 회사가 제곡하는 할인쿠폰, 이벤트 혜택 등의 경제상 이익을 불·편법행위 등을 말합니다.)
1. 필수 수집 정보: 서비스 이용기록 및 기기정보
제11조(개인정보 수집 방법)
회사는 다음과 같은 방법으로 이용자의 개인정보를 수집합니다.
1. 이용자가 회사의 홈페이지에 자신의 개인정보를 입력하는 방식
2. 어플리케이션 등 회사가 제공하는 홈페이지 외의 서비스를 통해 이용자가 자신의 개인정보를 입력하는 방식
3. 이용자가 회사가 발송한 이메일을 수신받아 개인정보를 입력하는 방식
4. 이용자가 고객센터의 상담, 게시판에서의 활동 등 회사의 서비스를 이용하는 과정에서 이용자가 입력하는 방식
제12조(개인정보의 이용)
회사는 개인정보를 다음 각 호의 경우에 이용합니다.
1. 공지사항의 전달 등 회사운영에 필요한 경우
2. 이용문의에 대한 회신, 불만의 처리 등 이용자에 대한 서비스 개선을 위한 경우
3. 회사의 서비슬르 제공하기 위한 경우
4. 법령 및 회사 약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운영에 지장을 주는 행위에 대한 방지 및 제재를 위한 경우
5. 신규 서비스 개발을 위한 경우
6. 이벤트 및 행사 안내 등 마케팅을 위한 경우
7. 인구통계학적 분석, 서비스 방문 및 이용기록의 분석을 위한 경우
8. 개인정보 및 관심에 기반한 이용자간 관계의 형성을 위한 경우
제13조(개인정보의 보유 및 이용기간)
1. 회사는 이용자의 개인정보에 대해 개인정보의 수집·이용 목적 달성을 위한 기간 동안 개인정보를 보유 및 이용합니다.
2. 전항에도 불구하고 회사는 내부 방침에 의해 서비스 부정이용기록은 부정 가입 및 이용 방지를 위하여 회원 탈퇴 시점으로부터 최대 1년간 보관합니다.
제14조(법령에 따른 개인정보의 보유 및 이용기간)
회사는 관게법령에 따라 다음과 같이 개인정보를 보유 및 이용합니다.
1. 전자상거래 등에서의 소비자보호에 관한 법률에 따른 보유정보 및 보유기간
  가. 계약 또는 청약철회 등에 관한 기록 : 5년
  나. 대금결제 및 재화 등의 공급에 관한 기록 : 5년
  다. 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
  라. 표시·광고에 관한 기록 : 6개월
2. 통신비밀보호법에 따른 보유정보 및 보유기간
  가. 웹사이트 로그 기록 자료 : 3개월
3. 전자금융거래법에 따른 보유정보 및 보유기간
  가. 전자금융거래에 관한 기록 : 5년
4. 위치정보의 보호 및 이용 등에 관한 법률
  가. 개인위치정보에 관한 기록 : 6개월
제15조(개인정보의 파기원칙)
회사는 원칙적으로 이용자의 개인정보 처리 목적의 달성, 보유·이용기간의 경과 등 개인정보가 필요하지 않을 경우에는 해당 정보를 지체 없이 파기합니다. 
제16조(개인정보파기절차)
1. 이용자가 회원가입 등을 위해 입력한 정보는 개인정보 처리 목적이 달성된 후 별도의 DB로 옮겨져(종이의 경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정부보호 사유에 따라(보유 및 이용기간 참조) 일정 기간 저장된 후 파기 되어집니다.
2. 회사는 파기 사유가 발생한 개인정보를 개인정보보호 책임자의 승인절차를 거쳐 파기합니다.
제17조(개인정보파기방법)
회사는 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제하며, 종이로 출력된 개인정보는 분쇄기로 분쇄하거나 소각 등을 통하여 파기합니다.
제18조(광고성 정보의 전송 조치)
1. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 이용자의 명시적인 사건동의를 받습니다. 다만, 다음 각호 어느 하나에 해당하는 경우에는 사전 동의를 받지 않습니다.
  가. 회사가 재화 등의 거래관계를 통하여 수신자로부터 직접 연락처를 수집한 경우, 거래가 종료된 날로부터 6개월 이내에 회사가 처리하고 수신자와 거래한 것과 동종의 재화 등에 대한 영리목적의 광고성 정보를 전송하려는 경우
  나.  「방문판매 등에 관한 법률」 에 따른 전화권유판매자가 육성으로 수신자에게 개인정보의 수집출처를 고지하고 전화권유를 하는 경우
2. 회사는 전항에도 불구하고 수신자가 수신거부의사를 표시하거나 사전 도으이를 철회한 경우에는 영리목적의 광고성 정보를 전송하지 않으며 수신거부 및 수신동의 철회에 대한 처리 결과를 알립니다.
3. 회사는 오후 9시부터 그다음날 오전 8시까지의 시간에 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우에는 제1항에도 불구하고 그 수신자로부터 별도의 사전 동의를 받습니다.
4. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 다음의 사항 등을 광고성 정보에 구체적으로 밝힙니다.
  가. 회사명 및 연락처
  나. 수신 거부 또는 수신 동의의 철회 의사표시에 관한 사항의 표시
5. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 다음 각 호의 어느 하나에 해당하는 조치를 하지 않습니다.
  가. 광고성 정보 수신자의 수신거부 또는 수신동의의 철회를 회피·방해하는 조치
  나. 숫자·부호 또는 문자를 조합하여 전화번호·전자우편주소 등 수신자의 연락처를 자동으로 만들어 내는 조치
  다. 영리목적의 광고성 정보를 전송할 목적으로 전화번호 또는 전자우편주소를 자동으로 등록하는 조치
  라. 광고성 정보 전송자의 신원이나 광고 전송 출처를 감추기 위한 각종 조치
  마. 영리목적의 광고성 정보를 전송할 목적으로 수신자를 기망하여 회신을 유도하는 각종 조치
제19조(아동의 개인정보보호)
1. 회사는 만 14 미만 아동의 개인정보 보호를 위하여 만 14 이상의 이용자에 한하여 회원가입을 허용합니다.
2. 제1항에도 불구하고 회사는 이용자가 만 14세 미만의 아동일 경우에는, 그 아동의 법정대리인으로부터 그아동의 개인정보 수집, 이용, 제공 등의 동의를 그 아동의 법정대리인으로부터 받습니다.
3. 제2항의 경우 회사는 그 법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(ID), 휴대폰 번호 등을 추가로 수집합니다.
제20조(개인정보 조회 미 수집동의 철회)
1. 이용자 및 법정 대리인은 언제든지 등록되어 있는 자신의 개인정보를 조회하거나 수정할 수 있으며 개인정보수집 동의 철회를 요청할 수 있습니다.
2. 이용자 및 법정 대리인은 자신의 가입정보 수집등에 대한 동의 철회하기 위해서는 개인정보보호책임자 또는 담당자에게 서면, 전화 또는 전자우편주소로 연락하시면 회사는 지체 없이 조치하겠습니다.
제21조(개인정보 정보변경 등)
1. 이용자는 회사에게 전조의 방법을 통해 개인정보의 요류에 대한 정정을 요청할 수 있습니다.
2. 회사는 전항의 경우에 개인정보의 정정을 완료하기 전까지 개인정보를 이용 또는 제공하지 않으며 잘못된 개인정보를 제3자에게 이미 제공한 경우에는 정정 처리결과를 제3자에게 지체 없이 통지하여 정정이 이루어지도록 하겠습니다.
제22조(이용자의 의무)
1. 이용자는 자신의 개인정보를 최신의 상태로 유지해야 하며, 이용자의 부정확한 정보 입력으로 발생하는 문제의 책임은 이용자 자신에게 있습니다.
2. 타인의 개인정보를 도용한 회원가입의 경우 이용자 자격을 상실하거나 관련 개인정보보호 법령에 의해 처벌받을 수 있습니다.
3. 이용자는 전자우편주소, 비밀번호 등에 대한 보안을 유지할 책임이 있으며 제3자에게 이를 양도하거나 대여할 수 없습니다.
제23조(개인정보 유출 등에 대한 조치)
회사는 개인정보의 분실·도난·유출(이하 "유출 등"이라 한다) 사실을 안 때에는 지체 없이 다음 각 호의 모든 사항을 해당 이용자에게 알리고 방송통신위원회 또는 한국인터넷진흥원에 신고합니다.
1. 유출 등이 된 개인정보 항목
2. 유출 등이 발생한 시점
3. 이용자가 취할 수 있는 조치
4. 정보통신서비스 제공자 등의 대응 조치
5. 이용자가 상담 등을 접수할 수 있는 부서 및 연락처
제24조(개인정보 유출 등에 대한 조치의 에외)
회사는 전조에도 불구하고 이용자의 연락처를 알 수 없는 등 정당한 사유가 있는 경우에는 회사의 홈페이지에 30일 이상 게시하는 방법으로 전조의 통지를 갈음하는 조치를 취할 수 있습니다.
제25조(국외 이전 개인정보의 보호)
1. 회사는 이용자의 개인정보에 관하여 개인정보보호법 등 관계 법규를 위반한느 사항을 내용으로 하는 국제계약을 체결하지 않습니다.
2. 회사는 이용자의 개인정보를 국외에 제공(제회되는 경우를 포함)`처리위탁`보관(이하 "이전"이라 함)하려면 이용자의 동의를 받습니다. 다만, 본조 제3항 각 호의 사항 모두를 개인정보보호법 등 관계 법규에 따라 공개하거나 전자우편 등 대통령령으로 정하는 방법에 따라 이용자에게 알린 경우에는 개인정보 처리위탁`보관에 따른 동의절차를 거치지 아니할 수 있습니다.
3. 회사는 본조 제2항 본문에 따른 동의를 받으려면 미리 다음 각 호의 사항 모두를 이용자에게 고지합니다.
  가. 이전되는 개인정보 항목
  나. 개인정보가 이전되는 국가, 이전일시 및 이전방법
  다. 개인정보를 이전받는 자의 성명(법인인 경우 그 명칭 및 정보관리 책임자의 연락처를 말한다)
  라. 개인정보를 이전받는 자의 개인정보 이용목적 및 보유 ` 이용 기간
4. 회사는 본조 제2항 본문에 따른 동의를 받아 개인정보를 국외로 이전하는 경우 개인정보보호법 대통령령 등 관계법규에서 정하는 바에 따라 보호조치를 합니다.
제26조(개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항)
1. 회사는 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용 정보를 저장하고 수시로 불러오는 개인정보 자동 수집장치(이하'쿠키')를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 웹브라우저(PC 및 모바일을 포함)에게 보내는 소량의 정보이며 이용자의 저장공간에 저장되기도 합니다.
2. 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 이용자는 웹브라우저에서 옵션을 설정함으로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부 할 수도 있습니다.
3. 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 회사의 일부 서비스는 이용에 어려움이 있을 수 있습니다.
제27조(쿠키 설치 허용 지정 방법)
웹브라우저 옵션 설정을 통해 쿠키 허용, 쿠키 차단 등의 설정을 할 수 있습니다.
1. Edge: 웹브라우저 우측 상단의 설정 메뉴 > 쿠키 및 사이트 권한 > 쿠키 및 사이트 데이터 관리 및 삭제
2. Chrome: 웹브라우저 우측 상단의 설정 메뉴 > 개인정보 및 보안 > 쿠키 및 기타 사이트 데이터
3. Whale: 웹브라우저 우측 상단의 설정 메뉴 > 개인정보 보호 > 쿠키 및 기타 사이트 데이터
제28조(회사의 개인정보 보호 책임자 지정)
1. 회사는 이용자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서 및 개인정보 보호 책임자를 지정하고 있습니다.
  가. 개인정보 보호 책임자
    1) 성명: 
    2) 직책: 
    3) 전화번호: 
    4) 이메일: 
제29조(권인침해에 대한 구제방법)
1. 정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인 정보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상담에 대하여는 아래의 기관에 문의하시기 바랍니다.
  가. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
  나. 개인정보침해신고센터 : (국번없이) 188 (privacy.kisa.or.kr)
  다. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
  라. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)
2. 회사는 정보주체의 개인정보자기결정권을 보장하고, 개인정보침해로 인한 상담 및 피해 구제를 위해 노력하고 있으며, 신고나 상담이 필요한 경우 제1항의 담당부서로 연락주시기 바랍니다.
3. 개인정보 보호법 제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지 등)의 규정에 의한 요구에 대하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.
  가. 중앙행정심판위원회 : (국번없이) 110 (www.simpan.go.kr)
부칙
제1조 본 방침은 2023.12.20부터 시행됩니다.
''';

//개인정보 수집
String personalConsent = '''
개인정보처리동의서 
민트초코(MintChoco)(이하 '회사'라고 합니다)는 개인정보보호법 등 관련 법령상의 개인정보보호 규정을 준수하며 귀하의 개인정보보호에 최선을 다하고 있습니다. 회사는 개인정보보호법에 근거하여 다음과 같은 내용으로 개인정보를 수집 및 처리하고자 합니다. 
다음의 내용을 자세히 읽어보시고 모든 내용을 이해하신 후에 동의 여부를 결정해주시기 바랍니다. 
제1조(개인정보 수집 및 이용 목적) 
- 
이용자가 제공한 모든 정보는 다음의 목적을 위해 활용하며, 목적 이외의 용도로는 사용되지 않습니다. 
마케팅 및 프로모션 활용(광고성. 맞춤형 광고 포함) / (이벤트 정보 제공) 
제2조(개인정보 수집 및 이용 항목) 
- 
회사는 개인정보 수집 목적을 위하여 다음과 같은 정보를 수집합니다. 
회원가입 시 수집한 항목, 서비스 이용시 수집한 항목, 서비스 이용기록 
제3조(개인정보 보유 및 이용 기간) 
1. 수집한 개인정보는 수집•이용 동의일로부터 회원탈퇴 또는 동의 철회 시까지 보관 및 이용합니다. 
2. 개인정보 보유기간의 경과, 처리목적의 달성 등 개인정보가 불필요하게 되었을 때에는 지체없이 해당 개 인정보를 파기합니다. 
제4조(동의 거부 관리) 
귀하는 본 안내에 따른 개인정보 수집·이용에 대하여 동의를 거부하실 수 있으며, 이에 따른 불이익은 없습니다. 
본인은 위의 동의서 내용을 충분히 숙지하였으며, 위와 같이 개인정보를 수집·이용하는데 동의합니다. 
개인정보 수집 및 이용에 동의함 동의하지 않음 □ 
2023년 12월 19일 
''';

// 위치 기반 서비스
const positionService = '''
위치기반서비스 이용약관 
제1조(목적) 
본 약관은 회원(올라운더(All ROUNDER)의 서비스 약관에 동의한 자를 말하며 이하 '회원'이라고 합니다)이 올라운더(All ROUNDER)(이하 '회사'라고 합니다)가 제공하는 웹페이지 및 'MINT' (회사가 개발 운영하는 모바일 애플리케이션을 말합니다 이하 '모바일앱'이라고 합니다)의 서비스를 이용함에 있어 회원과 회사의 권리 및 의무, 기타 제반 사항을 정하는 것을 목적으로 합니다. 
제2조(가입자격) 
서비스에 가입할 수 있는 회원은 위치기반서비스를 이용할 수 있는 이동전화 단말기의 소유자 본인이어야 합니다. 
제3조(서비스 가입) 
회사는 다음 각 호에 해당하는 가입신청을 승낙하지 않을 수 있습니다. 
1. 실명이 아니거나 타인의 명의를 사용하는 등 허위로 신청하는 경우 
2. 고객 등록 사항을 누락하거나 오기하여 신청하는 경우 
3. 공공질서 또는 미풍양속을 저해하거나 저해할 목적을 가지고 신청하는 경우 
4. 기타 회사가 정한 이용신청 요건이 충족되지 않았을 경우 
제4조(서비스 해지) 
회원은 회사가 정한 절차를 통해 서비스 해지를 신청할 수 있습니다. 
제5조(이용약관의 효력 및 변경) 
1. 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 회사가 정한 소정의 절차에 따라 회원으로 등록함으로써 효력이 발생합니다. 
2. 서비스를 신청한 고객 또는 개인위치정보주체가 온라인에서 본 약관을 모두 읽고 "동의하기" 버튼을 클릭하였을 경우 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 봅니다.
3. 본 약관에 대하여 동의하지 않은 경우, 회사가 개인위치정보를 기반으로 제공하는 각종 혜택 및 편의제공에 일부 제한이 발생할 수 있습니다. 
4. 회사는 필요한 경우 '위치 정보의 보호 및 이용 등에 관한 법률, '콘텐츠산업 진흥법', '전자상거래 등에서의 소비자보호에 관한 법률', '소비자기본법', '약관의 규제에 관한 법률 등 관계법령(이하 '관계법령'이라 합니 다)의 범위 내에서 본 약관을 개정할 수 있습니다. 
5. 회사가 약관을 개정할 경우 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 현행약 관과 함께 그 적용일자 10일 전부터 적용일 이후 상당한 기간 동안 회사의 웹페이지 및 모바일앱을 통해 공지합니다. 다만, 개정약관의 내용이 회원에게 새로운 의무를 부과하거나 권리를 제한하는 내용인 경우 그 적용일자 30일 전부터 상당한 기간 동안 이를 회사의 웹페이지 및 모바일앱을 통해 공지하고, 회원에게 전자적형태로 약관의 개정사실을 발송하여 고지합니다. 
제6조(약관 외 준칙) 
본 약관은 신의성실의 원칙에 따라 공정하게 적용하며, 본 약관에 명시되지 아니한 사항에 대하여는 관계법령 및 건전한 거래관행에 따릅니다. 
제7조(서비스의 내용) 
회사가 제공하는 서비스는 아래와 같습니다. 
1. 위치기반 컨텐츠 분류를 위한 지오태깅(GeoTagging) 
2. 회사 및 제휴사의 상품 및 서비스 정보 제공 
3. 회사 및 제휴사의 마케팅 서비스 제공 
4. 회사 및 제휴사의 프로모션 혜택 알림 제공 
5. 길 안내 등 생활편의 서비스 제공 
제8조(서비스 이용요금) 
1. 회사의 서비스는 무료제공을 원칙으로 합니다. 다만, 회원이 별도로 유료서비스를 이용하고자 할 경우 해당 서비스 화면에 명시된 요금을 지불하여야 사용할 수 있습니다. 
2. 회사는 유료서비스 이용요금을 회사와 계약한 전자지불업체에서 정한 방법에 의하거나 회사가 정한 청구서에 합산하여 청구할 수 있습니다. 
3. 유료서비스 이용을 위하여 결제된 대금에 대한 취소 및 환불은 관계법령과 회사의 운영정책에 따릅니다. 
4. 무선 서비스 이용시 발생하는 데이터 통신료는 별도이며, 이 때 부과되는 데이터 통신료는 회원이 가입한 각 이동통신사의 정책에 따릅니다. 
5. 멀티미디어 메시지 서비스(MMS) 등으로 게시물을 등록할 경우 발생하는 요금은 각 이동통신사의 요금 정책에 따라 회원이 부담합니다. 
제9조(서비스내용 변경 통지 등) 
1. 회사가 서비스 내용을 변경하거나 종료하는 경우 회사는 회원이 등록한 전자우편 주소로 이메일을 발송하여 서비스 내용의 변경 사항 또는 종료를 사전 일주일 전에 통지합니다. 
2. 전항의 경우 불특정 다수의 회원을 상대로 통지하는 때에는 회사의 웹페이지 등을 통해 공지함으로써 회원들에게 통지할 수 있습니다. 
제10조(서비스이용의 제한 및 중지) 
1. 회사는 아래 각 호에 해당하는 사유가 발생한 경우에는 회원의 서비스 이용을 제한하거나 중지시킬 수 있습니다. 
  가. 회원이 회사의 서비스 운영을 고의 또는 과실로 방해하는 경우 
  나. 서비스용 설비 점검, 보수 또는 공사로 인하여 부득이한 경우 
  다. 전기통신사업법에 규정된 기간통신사업자가 서비스를 중지했을 경우 
  라. 국가비상사태, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 서비스 이용에 지장이 있는 때 
  마. 기타 중대한 사유로 회사가 서비스 제공을 지속하는 것이 곤란한 경우 
2. 회사가 전항에 따라 서비스의 이용을 제한하거나 중지한 때에는 해당사실을 인터넷 등에 공지하거나 고 객에게 통지합니다. 다만 회사가 통제할 수 없는 사유로 인하여 서비스를 중단하게 되는 경우 이를 사후에 통지할 수 있습니다. 
제11조(개인위치정보의 이용 또는 제공) 
1. 회사가 개인위치정보를 이용하여 서비스를 제공하고자 하는 경우에는 본 약관에 대한 개인위치정보주체의 동의를 얻어야 합니다. 
2. 회사는 회원이 제공한 개인위치정보를 해당 회원의 동의 없이 서비스 제공 이외의 목적으로 이용하지 않습니다. 다만, 고객이 미리 요청한 경우 해당 내용을 고객이 지정한 통신단말장치(휴대전화 등)나 이메일 주소로 통보할 수 있습니다. 
3. 회사는 타사업자 또는 이용 고객과의 요금정산 및 민원처리 등을 위해 회원의 위치정보 이용·제공사실 확인자료를 자동 기록·보존하며, 해당 자료는 3년 보관합니다. 
4. 회사가 개인위치정보를 회원이 지정하는 제3자에게 제공하는 경우, 위치정보를 수집한 당해 통신 단말장 치로매회 회원에게 제공받는 자, 제공일시, 제공목적을 즉시 통보합니다. 다만 다음 각호의 경우에는 회원이 미리 지정한 통신단말장치 또는 전자우편주소로 통보합니다. 
  가. 개인위치정보를 수집한 통신단말장치가 문자, 음성 또는 영상 수신기능을 갖추지 아니한 경우 나. 회원이 다른 방법을 요청한 경우 
제12조(개인위치정보의 보유기간 및 이용기간) 
1. 회사가 회원의 개인위치정보를 이용하였다면 회사는 위치정보의 보호 및 이용 등에 관한 법률 제16조 제2 
항의 규정에 따라 기록·보존해야 하는 위치정보이용 제공사실 확인자료 이외의 해당 개인위치정보를 같 은 법 제23조에 따라 고객이 동의한 목적범위 내에서 이용하고 고객 응대를 위하여 3sus간 보유하며, 이 기간이 지나면 즉시 파기합니다. 
2. 전항에도 불구하고 관계법령 등에서 개인위치정보를 보존할 의무 및 필요성이 있는 경우에는 그에 따라 보존합니다. 
제13조(개인위치정보 주체의 권리) 
1. 회원은 회사에 대하여 언제든지 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다. 이 경우 회사는 수집한 개인위치정보 및 위치 정보 이용, 제공사실 확인자료를 파기합니다. 
2. 회원은 회사에 대하여 언제든지 개인위치정보의 수집, 이용 또는 제공의 일시적인 중지를 요구할 수 있습 니다. 
3. 회원은 회사에 대하여 아래 각 호의 자료에 대한 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있 는 경우에는 그 정정을 요구할 수 있습니다. 이 경우 회사는 정당한 사유 없이 회원의 요구를 거절할 수 없 습니다. 
  가. 본인에 대한 위치정보 이용, 제공사실 확인자료 
  나. 본인의 위치정보가 제3자에게 제공된 이유 및 내용 
4. 회원은 회사가 정한 절차에 따라 제1항 내지 제3항의 권리를 행사할 수 있습니다. 
제14조(법정대리인의 권리) 
1. 회사는 14세 미만 회원에 대해서는 당해 회원과 회원의 법정대리인으로부터 모두 동의를 받은 경우에만 개인위치정보를 이용한 서비스를 제공합니다. 이 경우 법정대리인은 본 약관에 의한 회원의 권리를 모두 가지며 회사는 법정대리인을 회원으로 봅니다. 
2. 회사는 14세 미만 회원의 개인위치정보 및 위치정보 이용, 제공사실에 관한 확인자료를 본 약관에 명시 또 는 고지한 범위를 넘어 이용하거나 제3자에게 제공하고자 하는 경우 당해 회원과 회원의 법정대리인에게 모두 동의를 받아야합니다. 다만 다음 각호의 경우는 제외합니다. 
  가. 개인위치정보 및 위치기반서비스 제공에 따른 요금정산을 위하여 위치정보 이용, 제공사실 확인자료가 필요한 경우 
  나. 통계작성, 학술연구 또는 시장조사를 위하여 특정 개인을 알아볼 수 없는 형태로 가공하여 제공하는 경우 
  다. 기타 관계법령에 특별한 규정이 있는 경우 
제15조(위치정보관리책임자의 지정) 
1. 회사는 위치정보를 적절히 관리, 보호하고 개인위치정보주체의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를 위치정보의 관리책임자로 지정하고 운영합니다. 
2. 회사의 위치정보관리책임자는 위치기반서비스의 제공에 관한 제반 사항을 담당 · 관리하는 부서의 CEO으로서, 구체적인 사항은 본 약관의 부칙에 따릅니다. 
제16조(손해배상) 
1. 회사가 위치정보의 보호 및 이용 등에 관한 법률 제15조 내지 제26조의 규정을 위반한 행위를 하여 회원에게 손해가 발생한 경우 회원은 회사에 대하여 손해배상 청구를 할 수 있습니다. 
2. 회원이 고의 또는 과실로 본 약관의 규정을 위반하여 회사에 손해가 발생한 경우 회원은 회사에 발생한 모든 손해를 배상해야 합니다. 
제17조(면책) 
1. 회사는 다음 각 호의 사유로 서비스를 제공할 수 없는 경우 이로 인하여 회원에게 발생한 손해에 대한 책임을 부담하지 않습니다. 
  가. 천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우 
  나. 제3자의 고의적인 서비스 방해가 있는 경우 
  다. 회원의 귀책사유로 서비스 이용에 장애가 있는 경우 
  라. 기타 회사의 고의 또는 과실이 없는 사유에 해당하는 경우 
2. 회사는 서비스 및 서비스에 게재된 정보, 자료, 사실의 신뢰도 및 정확성 등에 대한 보증을 하지 않으며 이로 인하여 회원에게 발생한 손해에 대하여 책임을 부담하지 않습니다. 
3. 회사는 회원이 서비스를 이용하며 기대하는 수익을 상실한 것에 대한 책임과, 그 밖의 서비스를 통하여 얻은 자료로 인하여 회원에게 발생한 손해에 대한 책임을 부담하지 않습니다. 
제18조(분쟁의 조정) 
1. 회사는 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 '위치정보의 보호 및 이용 등에 관한 법률' 제28조의 규정에 따라 방송통신위원회에 재정을 신청할 수 있습니다. 
2. 회사 또는 고객은 위치정보와 관련된 분쟁에 대해 당사자간 협의가 이루어지지 아니하거나 협의를 할 수 없는 경우에는 '개인정보보호법' 제43조의 규정에 따라 개인정보분쟁조정위원회에 조정을 신청할 수 있습니다. 
3. 제1항 내지 제2항에도 불구하고 당사자간 분쟁이 원만하게 해결되지 않아 법원에 의한 분쟁해결 절차를 따를 경우에는 부산지방법원을 전속적인 제1심 관할법원으로 정합니다. 
제19조(회사의 연락처) 
회사의 상호 및 주소 등은 다음과 같습니다. 
부칙 
1. 법인명 : 올라운더(All ROUNDER) 
2. 대표이사: 정창훈 
3. 소재지 : 부산 연제구 쌍미천로 89 (연산동) 2F 
4. 연락처 : 0518523355 
제1조(시행일) 
본 약관은 2023.12.20부터 시행합니다. 
제2조(위치정보관리책임자) 
위치정보관리책임자는 2023.01.02를 기준으로 다음과 같이 지정합니다. 
1. 소속 : 올라운더 
2. 성명 : 정창훈 
3. 직위: CEO 
4. 전화 : 0518523355 
''';


// 문자열
const nullDataText = '데이터를 받아오지 못했습니다.';