package com.market.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.mapper.AttachMapper;
import com.market.model.AttachImageVO;
import com.market.model.BookVO;
import com.market.model.Criteria2;
import com.market.model.PageMakerDTO2;
import com.market.model.ReplyDTO;
import com.market.service.BookService;
import com.market.service.ReplyService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BookController {
	
	//@Log4j 어노테이션 사용 안할 시
//	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private AttachMapper attachMapper;   //이미지 데이터 가져오기 서비스
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ReplyService replyService;   //댓글 데이터 서비스
	
	/* 메인 페이지 이동 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)   // 혹은 @GetMapping("/main")
	public void mainPageGET(Model model) {
		log.info("'메인' 페이지 진입");   //@Log4j 어노테이션 사용 안할 시 ==> logger.info("...");
		model.addAttribute("cate1", bookService.getCateCode1());   //국내 제품 카테고리 리스트
		model.addAttribute("cate2", bookService.getCateCode2());   //국외 제품 카테고리 리스트
	}
	
	/* 상품 등록 업로드 이미지 출력
	 * 상품 등록 시 서버에 업로드 한 이미지 파일에 접근하기 위한 url 매핑 메서드 (현재 업로드 한 이미지를 미리보기 위해)
	 * AdminController에 접근하기 위해선 관리자 계정이 아닐 시 접근을 하지 못하도록 설정을 한 Interceptor 필터를 거쳐야 하기 때문에 접근을 하는데 제한
	 * 이미지는 로그인을 하든 안 하든 모든 곳에서 접근이 가능해야 하기 때문에 BookController.java 에 작성 */
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		//반환 타입은 바이너리 데이터인 이미지를 ResponseEntity 객체를 통해 뷰에 byte[] 데이터를 보내야 하기 대문에 ResponseEntity<byte[]>를 반환 타입
		//매개변수는 '파일 경로' + '파일 이름'을 전달받아야 하기 때문에 String 타입
		
		//기본 경로 문자열 데이터와 전달받은 '유동 경로' + '파일 이름'을 활용하여 File 객체를 생성
		File file = new File("c:\\upload\\" + fileName);
		
		//ResponseEntity에 Response의 header에 대한 설정을 추가해주기 위해 아래의 생성자를 사용
		/* ResponseEntity(T body, MultiValueMap<String,String> headers, HttpStatus status)
		 * 첫 번째 파라미터는 body에 첨부할 데이터를 추가
		 * 두 번째 파라미터의 경우 header의 설정이 부여된 객체를 추가
		 * MultiValueMap 클래스 타입이어야 한다고 명시되어 있는데 MultiValueMap 클래스를 상속한 HttpHeader 클래스를 사용
		 * 세 번째 클래스의 경우 전송하고자 하는 상태 코드와 관련된 코드를 추가 */
		//뷰로 반환할 ResponseEntity 객체의 주소를 저장할 참조 변수를 선언하고 null로 초기화
		ResponseEntity<byte[]> result = null;
		
		try {
			//ResponseEntity에 Response의 header와 관련된 설정의 객체를 추가해주기 위해서 HttpHeaders를 인스턴스화
			HttpHeaders header = new HttpHeaders();
			
			/* header의 'Content Type' 속성 값에 이미지 파일 MIME TYPE을 추가해주기 위해서 HttpHeader 클래스에 있는 add() 메서드를 사용
			 * 첫 번째 파라미터에는 Response header의 '속성명'을, 두 번째 파라미터에는 해당 '속성명'에 부여할 값(value)을 삽입 */
			//header의 'Content Type'에 대상 파일의 MIME TYPE을 부여
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			// 대상 이미지 파일, header 객체, 상태 코드를 인자 값으로 부여한 생성자를 통해 ResponseEntity 객체를 생성
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			/* FileCopyUtils 클래스는 파일과 stream 복사에 사용할 수 있는 메서드를 제공하는 클래스
			 * 해당 클래스 중 copyToByteArray() 메서드는 파라미터로 부여하는 File 객체 즉, 대상 파일을 복사하여 Byte 배열로 반환
			 * 두 번째 파라미터는 'Content-Type' 속성을 지정 해준 HttpHeader 객체(변수 header)를 인자로 부여
			 * 세 번째 파라미터는 성공 상태(status) 코드 200이 전송되도록 인자 값을 작성 */
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		//return에 생성한 ResponseEntity 객체(변수 result)를 작성
		return result;
	}
	
	/* 이미지 데이터 반환 - 반환해주는 데이터가 JSON형식이 되도록 지정해주기 위해 @GetMapping 어노테이션에 produces 속성 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int bookId){
		log.info("getAttachList.........." + bookId);
		
		//리턴 값으로  getAttachList(bookId) 메서드를 통해 반환받은 이미지 정보와 상태 코드가 OK 데이터를 담고 있는 ResponeEntity 객체
		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(bookId), HttpStatus.OK);
	}
	
	/* 상품 검색 */
	@GetMapping("search")
	public String searchGoodsGET(Criteria2 cri, Model model) {
		log.info("cri : " + cri);
		
		List<BookVO> list = bookService.getGoodsList(cri);
		
		log.info("pre list : " + list);
		if(!list.isEmpty()) {   //검색한 상품이 있을 경우
			model.addAttribute("list", list);
			log.info("list : " + list);
		} else {   //상품이 없을 경우
			model.addAttribute("listcheck", "empty");
			
			return "search";
		}
		
		model.addAttribute("pageMaker", new PageMakerDTO2(cri, bookService.goodsGetTotal(cri)));   //페이징 데이터
		
		String[] typeArr = cri.getType().split("");   //검색 타입 분할
		
		for(String s : typeArr) {
			if(s.equals("T") || s.equals("A")) {   //검색 타입이 책 이름 또는 작가인 경우
				model.addAttribute("filter_info", bookService.getCateInfoList(cri));   //카테고리 정보 리스트		
			}
		}
		
		return "search";
	}
	
	/* 상품 상세 정보 */
	/* @GetMapping 어노테이션의 Spring에서 사용자가 전송한 식별자 값을 변수로 인식하도록 하기 위해 템플릿 변수({bookId})를 작성
	 * URL로 전달받은 식별자 값을 인수로 전달받기 위해서 메서드의 파라미터에 bookId 변수를 선언해주고 파라미터 변수 앞에 @PathVarialbe 어노테이션을 추가
	 * 그리고 @PathVariable 어노테이션 파라미터로 앞서 @GetMapping에 작성한 템플릿 변수명을 추가
	 * 만약 클라이언트가 "/goodsDetail/15" URL 경로로 요청을 하면 작성한 URL 매핑 메서드(goodsDetailGET())가 매핑되어 호출되고
	 * @PathVarialbe 어노테이션을 통해 URL 경로에 작성된 식별자 값 "15"가 추출되어 파라미터 변수 'bookId'로 대입되어 값을 사용 가능 */
	@GetMapping("/goodsDetail/{bookId}")
	public String goodsDetailGET(@PathVariable("bookId")int bookId, Model model) {
		log.info("goodsDetailGET()..........");
		model.addAttribute("goodsInfo", bookService.getGoodsInfo(bookId));   //이미지 데이터가 담긴 상품 정보를 가져와 뷰로 전송
		return "/goodsDetail";
	}
	
	/* 리뷰 쓰기 */
	/* 리뷰 등록 페이지라서 리뷰 관련 요청이기는 하지만 ReplyController.java 는 전체가 http 바디(body)에 바로 데이터를
	 * 반환하도록 @RestController 어노테이션을 추가 해놓았기때문에 BookController에 팝업창 요청을 처리하는 메서드를 추가 */
	@GetMapping("/replyEnroll/{memberId}")
	public String replyEnrollWindowGET(@PathVariable("memberId")String memberId, int bookId, Model model) {
		log.info("replyEnrollWindowGET()..........");
		BookVO book = bookService.getBookIdName(bookId);   //상품 id를 이용해 상품 id와 상품 이름이 담긴 vo 객체 반환
		model.addAttribute("bookInfo", book);
		model.addAttribute("memberId", memberId);
		
		return "/replyEnroll";   //댓글 작성 팝업창 뷰
	}
	
	/* 리뷰 수정 팝업창 */
	@GetMapping("/replyUpdate")
	public String replyUpdateWindowGET(ReplyDTO dto, Model model) {   //뷰로부터 replyId, bookId, memberId를 전달받아 (ReplyDTO)
		log.info("replyUpdateWindowGET()..........");
		BookVO book = bookService.getBookIdName(dto.getBookId());   //수정하려는 상품의 id, 이름 (어떠한 상품(책)에 관한 수정인 지를 알 수 있도록)
		model.addAttribute("bookInfo", book);
		model.addAttribute("replyInfo", replyService.getUpdateReply(dto.getReplyId()));   //수정하려는 댓글 데이터
		model.addAttribute("memberId", dto.getMemberId());   //수정하는 회원의 id
		
		return "/replyUpdate";   //댓글 수정 팝업창 뷰
	}
	
}
