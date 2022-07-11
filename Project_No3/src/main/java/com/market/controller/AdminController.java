package com.market.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.market.model.AuthorVO;
import com.market.model.BookVO;
import com.market.model.Criteria2;
import com.market.model.PageMakerDTO2;
import com.market.service.AdminService;
import com.market.service.AuthorService;

import lombok.extern.log4j.Log4j;

/* 제어 계층 => AuthorController.java 작성 - 뷰(View)로부터의 요청 처리하는 url 맵핑 메서드 작성 */
@Controller
@Log4j
@RequestMapping("/admin")
public class AdminController {
//	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
    private AuthorService authorService;   //작가 서비스
	
	@Autowired
	private AdminService adminService;   //상품 서비스
	
	/* 관리자 메인 페이지 이동 */
    @RequestMapping(value = "main", method = RequestMethod.GET)   // 혹은 @GetMapping("/main")
    public void adminMainGET() throws Exception{
        log.info("'관리자 페이지' 이동");
    }
    
    /* 상품 관리 페이지 접속 */
    @RequestMapping(value = "goodsManage", method = RequestMethod.GET)
    public void goodsManageGET() throws Exception{
        log.info("'상품 관리' 페이지 접속");
    }
    
    /* 상품 등록 페이지 접속 */
    @RequestMapping(value = "goodsEnroll", method = RequestMethod.GET)
    public void goodsEnrollGET() throws Exception{
        log.info("'상품 등록' 페이지 접속");
    }
    
    /* 작가 등록 페이지 접속 */
    @RequestMapping(value = "authorEnroll", method = RequestMethod.GET)
    public void authorEnrollGET() throws Exception{
        log.info("'작가 등록' 페이지 접속");
    }
    
    /* 작가 관리(목록) 페이지 접속 */
    @RequestMapping(value = "authorManage", method = RequestMethod.GET)
    public void authorManageGET(Criteria2 cri, Model model) throws Exception{
//    	log.info("'작가 관리(목록)' 페이지 접속");
        log.info("'작가 관리(목록)' 페이지 접속.........." + cri);
        
        /* 작가 목록 데이터 */
        List list = authorService.authorGetList(cri);   //DB에서 작가 테이블 목록 가져오기
//        model.addAttribute("list", list);   //view 페이지로 데이터 전송
		/* 검색 키워드에 맞는 행이 없을 경우 동작 */
        if(!list.isEmpty()) {
			model.addAttribute("list", list);   // 작가 존재 경우
		} else {
			model.addAttribute("listCheck", "empty");   // 작가 존재하지 않을 경우
		}
        
        /* 페이지 이동 인터페이스 데이터 */
        int total = authorService.authorGetTotal(cri);   //작가 총 수
        PageMakerDTO2 pageMaker = new PageMakerDTO2(cri, total);   //페이징 인터페이스 객체 생성
        model.addAttribute("pageMaker", pageMaker);   //view 페이지로 데이터 전송
        
//        model.addAttribute("pageMaker", new PageMakerDTO2(cri, authorService.authorGetTotal(cri)));   //이렇게 해도 됨
    }
    
	/* 작가 등록 ==> 전달 받은 작가 데이터를 DB에 등록 수행 */
    @RequestMapping(value="authorEnroll.do", method = RequestMethod.POST)   // 혹은 @PostMapping("/authorEnroll.do")
    public String authorEnrollPOST(AuthorVO author, RedirectAttributes rttr) throws Exception{
    	//BoardVO 객체는 뷰(View)가 전송하는 작가 관련 데이터를 받기 위해
    	/* RedirectAttributes 객체는 해당 메서드가 종료된 뒤 리다이렉트 방식으로 다른 페이지로 전송할 때 성공 메시지를 전송하기 위해 추가
    		(리다이렉트 방식으로 이동할 때 데이터 전송을 위해 사용되는 Model 객체라고 생각) */
    	log.info("authorEnroll :" +  author);   //메서드에 들어온 기록과 뷰(View)로부터 전달받은 데이터를 확인
    	
    	authorService.authorEnroll(author);      // 작가 등록 쿼리 수행
    	
		/* 경고창 메시지에 등록된 작가 이름을 표시하기 위해서 등록이 완료된 '작가 이름' 데이터를 전송
		 * 뷰(View)로 전송된 데이터가 일회성으로 사용되도록 addFlashAttriubte 메서드를 사용 */
    	rttr.addFlashAttribute("enroll_result", author.getAuthorName());   //작가등록이 성공적으로 완료되었음을 알리는 데이터를 전송해주는 코드
    	
    	return "redirect:/admin/authorManage";
    }
    
    /* 작가 상세 , 작가 수정 */
	/* 작가 수정 페이지도 동일하게 작가 한 명의 데이터 즉, book_author테이블의 하나의 행 데이터를 가져와야 함
	 * 이는 작가 상세 페이지(authorDetail.jsp)' 처리한 것과 동일
	 * 따라서 다시 일일이 Mapper, Service, Controller 메서드를 작성하지 않고 기존 '작가 상세 페이지'의 url 매핑 메서드인 authorGetInfoGET()을 활용 */
//	@GetMapping("/authorDetail")
    @GetMapping({"/authorDetail", "/authorModify"})
	public void authorGetInfoGET(int authorId, Criteria2 cri, Model model) throws Exception {
		log.info("authorDetail......." + authorId);
		
		/* 작가 관리 페이지 정보 */
		model.addAttribute("cri", cri);
		
		/* 선택 작가 정보 */
		model.addAttribute("authorInfo", authorService.authorGetDetail(authorId));
	}
    
    /* 작가 정보 수정 */
	@PostMapping("/authorModify")
	public String authorModifyPOST(AuthorVO author, RedirectAttributes rttr) throws Exception{
		log.info("authorModifyPOST......." + author);
		
		int result = authorService.authorModify(author);
		
		rttr.addFlashAttribute("modify_result", result);   //작가 수정 결과 알림 메시지를 위한 데이터 전송
		
		return "redirect:/admin/authorManage";   //수정 후 작가 목록(관리) 페이지로 이동
	}
	
	/* 상품 등록 */
	@PostMapping("/goodsEnroll")
	public String goodsEnrollPOST(BookVO book, RedirectAttributes rttr) {
		log.info("goodsEnrollPOST......" + book);
		
		adminService.bookEnroll(book);
		
		rttr.addFlashAttribute("enroll_result", book.getBookName());   //등록한 책 이름을 결과 알림 메시지 값으로 전송
		
		return "redirect:/admin/goodsManage";   //상품 목록(관리) 페이지로 이동
	}
	
	/* 작가 검색 팝업창 */
	/* 작가 관리(목록) 페이지에서 하였던 작가 리스트를 출력하고 검색 기능을 팝업창에서 구현할 것
	 * 기존의 authorManage.jsp에서 구현한 것을 거의 그대로 가져올 것 */
	@GetMapping("/authorPop")
	public void authorPopGET(Criteria2 cri, Model model) throws Exception{
		log.info("authorPopGET.......");
		
		cri.setAmount(5);   //팝업창 크기가 작기 때문에 좀 더 작은 단위로 작가 목록이 보이도록
		
		/* 게시물 출력 데이터 */
		List list = authorService.authorGetList(cri);   //작가 목록 가져오기
		
		if(!list.isEmpty()) {
			model.addAttribute("list",list);   // 작가 존재 경우
		} else {
			model.addAttribute("listCheck", "empty");   // 작가 존재하지 않을 경우
		}
		
		/* 페이지 이동 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageMakerDTO2(cri, authorService.authorGetTotal(cri)));
	}
	
}
