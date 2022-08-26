package com.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.market.model.BoardVO;
import com.market.model.Criteria;
import com.market.model.PageMakerDTO;
import com.market.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller   /* 해당 클래스를 스프링의 빈으로 인식하도록 */
@RequestMapping("/board/*")   /* '/board/'로 시작하는 모든 요청 처리를 BoardController.java 가 하도록 지정 */
/* @Log4j을 이용한 log 사용 시 아래 어노테이션 활성화 (logger 선언 필요 없음) */
@Log4j
public class BoardController {
	/* log 사용을 위한 logger 선언 */
//	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	/* DB 테이블에 데이터를 삽입 쿼리를 실행하기 위해 BoardService.java 인터페이스를 의존성 주입 */
	@Autowired
    private BoardService bservice;
	
	/* 게시글 목록 페이지(list.jsp)로 이동 할 수 있는 맵핑 메서드 */
//	@GetMapping("/list")   // => @RequestMapping(value="list", method=RequestMethod.GET) => 동일한 역할
//    public void boardListGET(Model model) {   //뷰(View -> 여기선 list.jsp)에 데이터를 전송하기 위해 Model 파라미터를 추가
//        log.info("게시글 목록 페이지 진입");
//        //addAttribute 메소드를 호출하여 "list"라는 속성명에 BoardService 클래스의 getList() 메소드를 반환 값(게시글 목록 데이터)을 속성 값으로 저장
//        model.addAttribute("list", bservice.getList());   //SQL로 가져온 게시글 목록 리스트를 모델 객체에 담는다
//    }
    
    /* url 매핑 시 매핑 메서드의 매개변수에 별도의 객체가 매개변수로 적용되어 있을 때
    	해당 객체와 맞는 VO 객체가 작성되어 있다면
    	자동으로 해당 VO 객체의 기본 생성자로 객체 생성이 되어 매핑 메서드의 매개변수로 활용할 수 있다 */
	/* 즉, 아래와 같이 "Criteria cri" 라는 매개변수가 적용된 매핑 매서드의 경우 해당 객체의 변수 이름과 같은 input 요소를 받아
		미리 작성한 Criteria.java 클래스의 기본 생성자를 이용해 자동으로 객체 생성하여 매개변수로 활용된다 */
	
	/* 게시글 목록(페이징 적용) 페이지(list.jsp)로 이동 할 수 있는 맵핑 메서드 */
	@GetMapping("/list")
    public void boardListGET(Model model, Criteria cri) {
		log.info("게시글 목록(페이징 적용) => " + cri.getPageNum() + "번 페이지 진입");
//        log.info("boardListGET");
        model.addAttribute("list", bservice.getListPaging(cri));   //조회할 게시글의 범위를 지정하여 조회
        int total = bservice.getTotal(cri);   //게시글 총 개수 조회 (cri에 검색 keyword 포함 시 해당 값이 포함된 게시글 개수만 조회)
        PageMakerDTO pageMake = new PageMakerDTO(cri, total);   //화면에 보여질 페이징의 계산 객체
        model.addAttribute("pageMaker", pageMake);
    }
	
	/* 게시글 등록 페이지(enroll.jsp)로 이동 할 수 있는 맵핑 메서드 */
    @GetMapping("/enroll")   // => @RequestMapping(value="enroll", method=RequestMethod.GET) => 동일한 역할
    public void boardEnrollGET() {
        log.info("게시글 '등록' 페이지 진입");
    }
    
    /* 게시글 조회 페이지(get.jsp)로 이동 할 수 있는 맵핑 메서드 */
    @GetMapping("/get")			//조회할 게시글을 특정하기 위해 int 파라미터 추가 ,뷰(View -> get.jsp)에 데이터를 전송하기 위해 Model 파라미터를 추가
    public void boardGetPageGET(int bno, Model model, Criteria cri) {
    	log.info(bno + "번 게시글 '조회' 페이지 진입");
        model.addAttribute("pageInfo", bservice.getPage(bno));   //SQL로 가져온 해당 게시글 객체를 모델 객체에 담는다
        model.addAttribute("cri", cri);   //목록(list.jsp) 페이지에서 받아온 현재 페이징 정보를 모델에 담아 조회 페이지로 전송
    }
    
    /* 게시글 수정 페이지(modify.jsp)로 이동 할 수 있는 맵핑 메서드 (게시글 조회 페이지에서 수정 페이지로 이동 시) */
    @GetMapping("/modify")
    public void boardModifyGET(int bno, Model model, Criteria cri) {
    	log.info(bno + "번 게시글 '수정' 페이지 진입");
        model.addAttribute("pageInfo", bservice.getPage(bno));   //SQL로 가져온 해당 게시글 객체를 view 페이지(modify.jsp)로 넘긴다
        model.addAttribute("cri", cri);   //조회(get.jsp) 페이지에서 받아온 현재 페이징 정보를 모델에 담아 수정 페이지로 전송
    }
    
    /* 게시글 등록 */
    /* view 페이지(enroll.jsp)에서 입력되어 전달 받은 데이터를 DB에 적용 후 적용 결과 메시지를 게시글 목록 페이지로 이동하며 넘긴다 */
    /* 뷰가 전송하는 Post 방식의 데이터를 전송받음, BoradVO클래스를 파라미터로 작성 */
    @PostMapping("/enroll")						//redirect로 페이지 이동 시 완료 경고창 호출 키워드 전달을 위해 RedirectAttributes 파라미터 추가
    public String boardEnrollPOST(BoardVO board, RedirectAttributes rttr) {
        log.info(board.getBno() + "번 게시글 '등록' ==> BoardVO : " + board);
        bservice.enroll(board);   //enroll 페이지에서 입력되어 전달 받은 데이터를 DB에 저장하는 serviece 메서드 호출
	    /* addFlashAttribute()을 사용한 이유는 일회성으로만 데이터를 전달하기 위함,
	    	'게시판 목록' 페이지에서 자바스크립트를 통해 서버로부터 전달받은 데이터가 있을 경우 경고창을 뜨도록 로직을 구성할 것인데,
	    	전달받은 데이터가 계속 잔존할 경우 경고창이 계속 뜰 수 있기 때문 */
        rttr.addFlashAttribute("result", "enrol success");   //게시글 등록 완료를 표시하기 위해 경고창 호출을 위한 값을 속성(key, value)에 담아 전달
        return "redirect:/board/list";   //DB에 데이터 입력 완료 후 게시판 목록 페이지로 이동하는 리다이렉트 구문 반환
    }
    
    /* 게시글 수정 */
    /* view 페이지(modify.jsp)에서 수정되어 전달 받은 데이터를 DB에 적용 후 적용 결과 메시지를 게시글 목록 페이지로 이동하며 넘긴다 */
    @PostMapping("/modify")
    public String boardModifyPOST(BoardVO board, RedirectAttributes rttr) {
    	log.info(board.getBno() + "번 게시글 '수정' ==> BoardVO : " + board);
        bservice.modify(board);   //전달 받은 데이터를 이용해 DB에서 해당 데이터의 bno 값에 해당하는 게시글 update
        rttr.addFlashAttribute("result", "modify success");   //게시글 수정 완료 표시를 위해 경고창 호출을 위한 값을(key, value) 담아 리다이렉트
        return "redirect:/board/list";   //DB에 데이터 수정 완료 후 위에 설정한 데이터와 함께 게시판 목록 페이지로 이동하는 리다이렉트 구문 반환
    }
    
    /* 게시글 삭제 */
    /* view 페이지(modify.jsp)에서 삭제 버튼 클릭 시 아래의 매핑 메서드가 요청되어 게시글 삭제 서비스를 호출 후 결과 메시지를 목록 페이지로 이동하며 넘긴다 */
	/* 삭제 쿼리를 실행하기 위해선 게시판 번호(bno)에 대한 정보가 필요로 하기 때문에 int형 변수를 파라미터로 부여하였고,
	 * 수정 기능 실행 후 리다이렉트 방식으로 리스트 페이지 이동시 데이터를 같이 전송하기 위해서 RedirctAttributes 객체를 파라미터로 부여 */
    @PostMapping("/delete")
    public String boardDeletePOST(int bno, RedirectAttributes rttr) {
    	log.info(bno + "번 게시글 '삭제'");
        bservice.delete(bno);
        rttr.addFlashAttribute("result", "delete success");   //게시글 삭제 완료 표시를 위해 경고창 호출을 위한 값을(key, value) 담아 리다이렉트
        return "redirect:/board/list";   //DB에 데이터 삭제 완료 후 위에 설정한 데이터와 함께 게시판 목록 페이지로 이동하는 리다이렉트 구문 반환
    }
}
