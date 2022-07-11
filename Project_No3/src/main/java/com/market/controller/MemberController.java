package com.market.controller;

import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.market.model.MemberVO;
import com.market.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	//@Log4j 어노테이션 사용 안할 시
//	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	/* DB에 접근하여 필요한 비즈니스 로직을 수행하는 서비스 객체 DI */
	@Autowired
	private MemberService memberservice;
	
	/* 메일전송을 위해 필요로한 정보를 세팅하였던 "mailSender" Bean을 인젝션(의존성 주입) */
	@Autowired
	private JavaMailSender mailSender;
	
	/* 비밀번호 암호화를 위해 security-context.xml 에 설정한 bcryptPasswordEncoder 빈을 의존 주입 */
	@Autowired
    private BCryptPasswordEncoder pwEncoder;
	
	//회원가입 페이지 이동
	@RequestMapping(value = "join", method = RequestMethod.GET)   // 혹은 @GetMapping("/join")
	public void loginGET() {
		log.info("'회원가입' 페이지 진입");   //@Log4j 어노테이션 사용 안할 시 ==> logger.info("...");
	}
	
	//로그인 페이지 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public void joinGET() {
		log.info("'로그인' 페이지 진입");
	}
	
	//회원가입
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String joinPOST(MemberVO member) throws Exception{
		log.info("join 진입");
		
		/* member객체에서 비밀번호를 꺼낸 뒤, 비밀번호를 BCryptPasswordEncoder클래스의 encode() 메서드를 사용하여 인코딩
		 * 후 member객체에 다시 저장 한 뒤 회원정보 등록하는 방식으로 변경(추가) */
		// 회원가입 서비스 실행
		String rawPw = "";   // 인코딩 전 비밀번호
        String encodePw = "";   // 인코딩 후 비밀번호
        
        rawPw = member.getMemberPw();   // 비밀번호 데이터 획득
        encodePw = pwEncoder.encode(rawPw);   // 비밀번호 인코딩
        member.setMemberPw(encodePw);   // 인코딩된 비밀번호 member객체에 다시 저장
        
		memberservice.memberJoin(member);   //회원 가입 서비스 호출 (쿼리 실행)
		log.info("join Service 성공");
		
		//반환형식을 String으로 하여 return에 main페이지로 이동하도록 작성
		return "redirect:/main";
	}
	
	//회원가입 아이디 중복 검사
	//@ResponseBody 어노테이션 추가해주지 않는다면 join.jsp로 메서드의 결과가 반환되지 않습니다
	@RequestMapping(value = "/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPOST(String memberId) throws Exception{
		log.info("memberIdChk() 진입");   //join.jsp에서 작성한 ajax의 요청을 memberIdChkPOST메서드가 수신받는지 확인용
		
		int result = memberservice.idCheck(memberId);   //DB 회원 테이블에서 memberId 컬럼 중에 전달 받은 값이 존재하는지 유무
		log.info("결과값 = " + result);
		if(result != 0) {
			return "fail";	// 중복 아이디가 존재
		} else {
			return "success";	// 중복 아이디 x
		}
	}
	
	/* 이메일 인증 */
	//MimeMessage 객체를 직접 생성하여 메일을 발송하는 방법
	//MimeMessage 대신 SimpleMailMessage를 사용할 수도 있으며,
	//둘의 차이점은 MimeMessage의 경우 멀티파트 데이터를 처리 할 수 있고 SimpleMailMessage는 단순한 텍스트 데이터만 전송이 가능
	//View(회원가입페이지)로 온전히 데이터를 전송하기 위해선 @ResponseBody 어노테이션이 필요
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception{
        /* 뷰(View)로부터 넘어온 데이터 확인 */
        log.info("이메일 데이터 전송 확인");
        log.info("인증번호 : " + email);
        
        /* 인증번호(난수) 생성 (6자리) */
        Random random = new Random();
        int checkNum = random.nextInt(888889) + 111111;
        
        /* 이메일 보내기 */
        String setFrom = "vkdlxj3tp@naver.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 <strong>" + checkNum + "</strong> 입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");   // true : 멀티파트 메세지 허용 (이미지/업로드 전송을 위해)
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);   // true : html을 허용 (이미지/업로드 전송을 위해)
            mailSender.send(message);
        }catch(Exception e) {
            e.printStackTrace();
        }
        
		/* 인증번호 뷰(회원가입 페이지)로 전송하기 위해 
		 * ajax를 통한 요청으로 인해 뷰로 다시 반환할 때 데이터 타입은 String 타입만 가능하기 때문에 String 타입으로 변환 후 반환 */
        String num = Integer.toString(checkNum);
        return num;
    }
    
    /* 로그인 */
	/* MemberVo는 데이터를 전달받기 위해, HttpServletRequest는 로그인 성공 시 session에 회원 정보를 저장하기 위해,
	 * RedirectAttributes는 로그인 실패 시 리다이렉트 된 로그인 페이지에 실패를 의미하는 데이터를 전송하기 위해 */
    @RequestMapping(value="login.do", method=RequestMethod.POST)   //인터셉터 적용 대상을 정확히 타겟팅 하기 위해 url "login" -> "login.do"
    public String loginPOST(HttpServletRequest request, MemberVO member, RedirectAttributes rttr) throws Exception{
    	log.info("loginPOST 메서드 진입");
    	
		/* 전달 받은 ID를 통해 DB에서 가져온 암호화 된 비밀번호를 전달 받은 비밀번호와 비교하여 일치 여부 확인 로직 추가(변경) */
    	HttpSession session = request.getSession();   //로그인 상태 유지를 위해 로그인 정보를 담아 두기 위한 세션
    	String rawPw = "";   //전달 받은 비밀번호
        String encodePw = "";   //DB에서 가져온 암호화 된 비밀번호
        
    	MemberVO lvo = memberservice.memberLogin(member);   //전달 받은 id를 이용해 DB에서 해당 회원에 대한 데이터 가져오는 메서드 호출 
    	
		if(lvo != null) {   // 일치하는 아이디 존재 시
			rawPw = member.getMemberPw();   // 사용자가 제출한 비밀번호
            encodePw = lvo.getMemberPw();   // 데이터베이스에 저장한 인코딩된 비밀번호
            
			if(true == pwEncoder.matches(rawPw, encodePw)) {   //matches 메서드를 이용해 암호화 된 비밀번호와 전달받은 비밀번호 일치여부 판단
				lvo.setMemberPw("");   // 보안을 위해 DB에서 가져온 암호화 된 비밀번호 정보 지움
                session.setAttribute("member", lvo);   // session에 사용자의 정보 저장
                return "redirect:/main";   // 메인페이지 이동
			} else {   //비밀번호 불일치 (로그인 실패)
				rttr.addFlashAttribute("result", 0);   //리다이렉트 하는 페이지에 로그인 실패에 대한 데이터 전송 (실패 메시지 알림을 위해)
	        	return "redirect:/member/login";   //로그인 페이지로 리다이렉트
			}
        } else {   // 일치하는 아이디가 존재하지 않을 시 (로그인 실패)
        	rttr.addFlashAttribute("result", 0);   //리다이렉트 하는 페이지에 로그인 실패에 대한 데이터 전송 (실패 메시지 알림을 위해)
        	return "redirect:/member/login";   //로그인 페이지로 리다이렉트
        }
    	
//    	if(lvo == null) {   // 로그인 실패 (일치하지 않는 아이디 또는 비밀번호 입력 경우)
//            int result = 0;
//            rttr.addFlashAttribute("result", result);   //리다이렉트 하는 페이지에 로그인 실패에 대한 데이터 전송 (실패 메시지 알림을 위해)
//            return "redirect:/member/login";   //로그인 페이지로 리다이렉트
//        }
//        session.setAttribute("member", lvo);   // 로그인 성공 (일치하는 아이디, 비밀번호 경우)
//        return "redirect:/main";   //메인 페이지로 리다이렉트
    }
    
    /* 메인페이지 로그아웃 */
    @RequestMapping(value="logout.do", method=RequestMethod.GET)
    public String logoutMainGET(HttpServletRequest request) throws Exception{
    	log.info("logoutMainGET메서드 진입");
        
        HttpSession session = request.getSession();   //세션에 저장된 로그인 정보를 지워야하기 때문에 세션 가져오기
        session.invalidate();   //로그인 정보 외에 세션에 저장된 데이터가 없기 때문에 세션 전체를 무효로 하는 메서드 호출
        
        return "redirect:/main";   //메인 페이지로 리다이렉트
    }
    
    /* 비동기방식 로그아웃 메서드 */
    @RequestMapping(value="logout.do", method=RequestMethod.POST)
    @ResponseBody
    public void logoutPOST(HttpServletRequest request) throws Exception{
        log.info("비동기 로그아웃 메서드 진입");
        
        HttpSession session = request.getSession();
        session.invalidate();
    }

}
