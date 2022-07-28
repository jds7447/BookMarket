package com.market.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.market.model.AttachImageVO;
import com.market.model.AuthorVO;
import com.market.model.BookVO;
import com.market.model.Criteria2;
import com.market.model.OrderDTO;
import com.market.model.PageMakerDTO2;
import com.market.service.AdminService;
import com.market.service.AuthorService;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnails;

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
    
    /* 상품 관리(목록) 페이지 접속 */
    @RequestMapping(value = "goodsManage", method = RequestMethod.GET)
    public void goodsManageGET(Criteria2 cri, Model model) throws Exception{
        log.info("'상품 관리(목록)' 페이지 접속");
        
        /* 상품 리스트 데이터 */
		List list = adminService.goodsGetList(cri);
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
		} else {
			model.addAttribute("listCheck", "empty");
			return;
		}
		
		/* 페이지 인터페이스 데이터 */
		model.addAttribute("pageMaker", new PageMakerDTO2(cri, adminService.goodsGetTotal(cri)));
    }
    
    /* 상품 등록 페이지 접속 */
    @RequestMapping(value = "goodsEnroll", method = RequestMethod.GET)
    public void goodsEnrollGET(Model model) throws Exception{
        log.info("'상품 등록' 페이지 접속");
        
		/* 사용할 Jackson-databind의 메서드는 static 메서드가 아니기 때문에 바로 사용할 수 없고 ObjectMapper클래스를 인스턴스화 하여 사용해야 합니다
		 * 따라서 ObjectMapper 타입의 'mapper'변수를 선언한 후 ObjectMapper 객체로 초기화 */
        ObjectMapper objm = new ObjectMapper();
        
		/* 카테고리 리스트 데이터를 'goodsEnroll.jsp'에 전달해주어야 하기 때문에 해당 url 매핑 메서드에 카테고리 리스트 데이터를
		 * 반환하는 Service 메서드를 호출하여 List타입의 변수 'list'에 저장 */
        List list = adminService.cateList();
        
		/* writeValueAsString() 메서드는 Java 객체를 String타입의 JSON형식 데이터로 변환해줌 */
        String cateList = objm.writeValueAsString(list);
        
		/* 뷰(view)로 데이터 전달을 위해 매개변수에 Model 부여 후 addAttribute() 로 "cateList" 속성에 String 타입 'cateList' 변수의 값 저장 */
        model.addAttribute("cateList", cateList);
        
		/* 변환 데이터 확인 */
//        log.info("변경 전.........." + list);
//        log.info("변경 후.........." + cateList);
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
	
	/* 외래 키 조건으로 인해 작가 테이블을 참조(reference) 하고 있는 상품 테이블
	 * 참조되지 않고 있는 행을 지운다면 문제가 없지만 만약 참조되고 있는 행을 지우려고 시도를 한다면 '무결성 제약 조건을 위반' 한다는 경고와 함께
	 * SQLIntegrityConstraintViolationException 예외가 발생
	 * 따라서 try catch 문을 사용하여 참조되지 않는 행을 지울땐 삭제를 수행하고 '작가 목록' 페이지로 1을 전성하도록 하고,
	 * 예외가 발생한 상황에는 '작가 목록' 페이지로 2를 전송하도록 작성  */
	/* 작가 정보 삭제 */
	@PostMapping("/authorDelete")
	public String authorDeletePOST(int authorId, RedirectAttributes rttr) {
		log.info("authorDeletePOST..........");
		
		int result = 0;
		
		try {
			result = authorService.authorDelete(authorId);
		} catch (Exception e) {
			e.printStackTrace();
			result = 2;
			rttr.addFlashAttribute("delete_result", result);
			
			return "redirect:/admin/authorManage";
		}
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/admin/authorManage";
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
	
	/* 이미지 첨부 파일 업로드 */
	/* 이미지 파일 이름이 한글인 경우 업로드는 정상적으로 수행을 하겠지만 뷰로 반환되는 이미지 정보의 파일 이름(fileName) 데이터가 깨져 있을 수가 있음
	 * 이를 위해서 RequestMapping 어노테이션에 produce 속성을 추가하여 전송되는 JSON데이터가 UTF8인코딩이 된 채로 전송되도록 속성값을 부여
	 * RequestMapping 어노테이션의 produces 속성은 서버에서 뷰로 전송되는 Response의 Content-type을 제어 할 수 있는 속성 */
//	@PostMapping("/uploadAjaxAction")
//	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	/* 스프링 부트 2.2.*부터 MediaType 중에 (UTF8)인코딩이 들어간 상수가 deprecation (비활성 또는 사용 중지)
	 * 5.2 버전 부터 Chrome 같은 메이저 브라우저들이 해당 parameter 없이도 올바르게 잘 interpret 하기 때문에 필요 없다 */
	@PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
//	public void uploadAjaxActionPOST(MultipartFile uploadFile) {   //첨부파일 데이터를 전달받기 위해 MultipartFile 매개변수로
					/* MultiparFile에 대해 간략히 설명을 하면 뷰(View)에서 전송한 multipart 타입의 파일을 다룰 수 있도록 해주는 인터페이스
					 * 해당 인터페이스의 메서드들은 파일의 이름 반환, 파일의 사이즈 반환, 파일을 특정 경로에 저장 등을 수행 */
	/* 업로드를 수행하는 url 매핑 메서드를 여러 개의 파일 업로드도 처리를 할 수 있도록 변경
	 * 여러개의 파일을 처리할 수 있도록 변경하더라도 한 개의 데이터만 전달받았을 경우에도 업로드 처리에는 영향이 없습 */
//	public void uploadAjaxActionPOST(MultipartFile[] uploadFile) {
	/* 반환형을 void에서 ResponseEntity로 변경
	 * 반환 타입이 ResponseEntity 객체이고 Http의 Body에 추가될 데이터는 List <AttachImageVO>라는 의미 */
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		log.info("uploadAjaxActionPOST..........");
//		log.info("파일 이름 : " + uploadFile.getOriginalFilename());
//		log.info("파일 타입 : " + uploadFile.getContentType());
//		log.info("파일 크기 : " + uploadFile.getSize());
		/* MultiparFile 배열 타입의 uploadFile의 모든 요소의 데이터 정보를 출력 */
		for(MultipartFile multipartFile : uploadFile) {   //기본 for문: for(int i = 0; i < uploadFile.length; i++) {
			log.info("-----------------------------------------------");
			log.info("파일 이름 : " + multipartFile.getOriginalFilename());
			log.info("파일 타입 : " + multipartFile.getContentType());
			log.info("파일 크기 : " + multipartFile.getSize());			
		}
		
		/* 이미지 파일 체크 - 전달 받은 파일이 이미지 파일인지 체크
		 * nio 패키지 Files 클래스의 probeContentType() 메서드를 호출하여 반환받은 MIME TYPE 속성을 활용
		 * image가 아닌 경우 업로드에 관한 코드가 실행이 되지 않고 상태 코드 400을 뷰에 반환 */
		for(MultipartFile multipartFile: uploadFile) {
			File checkfile = new File(multipartFile.getOriginalFilename());   //전달받은 파일(uploadfile)을 File 객체로
			String type = null;   //MIME TYPE을 저장할 String 타입의 type 변수
			
			try {
				type = Files.probeContentType(checkfile.toPath());   //반환하는 MIME TYPE 데이터를 type 변수에 대입
				//파라미터로는 Path 객체를 전달받아야 하는데, 이를 위해 File 클래스의 toPath() 메서드를 사용
				log.info("MIME TYPE : " + type);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			//전달받은 파일이 어떠한 MIME TYPE을 가졌는지에 대한 데이터를 image인지 아닌지 체크
			if(!type.startsWith("image")) {   //이미지가 아니라면
				//전달 해줄 파일의 정보는 없지만 반환 타입이 ResponseEntity<List<AttachImageVO>>이기 때문에 첨부해줄 값이 null인 List<AttachImageVO>
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);   //상태 코드 400인 ResponseEntity 객체를 인스턴스화 하여 이를 반환
			}
		}
		
		/* 업로드 하는 날짜에 맞게 폴더가 생성되고, 생성된 폴더에 업로드 파일을 저장되도록 할 것
		 * 예를 들어 '2021년 05월 10일' 날짜의 경우 c/upload 경로에 '2021/05/10' 경로의 폴더가 생성되도록 */
		String uploadFolder = "C:\\upload";   //파일을 저장할 기본적 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   //폴더 이름 날짜 형식
		Date date = new Date();   //오늘 날짜 데이터 가져오기
		String str = sdf.format(date);   //오늘 날짜 데이터를 지정한 날짜 형식을 적용한 문자열로
		String datePath = str.replace("-", File.separator);   //날짜 문자열의 "-" 값을 현 운영체제에 맞는 경로 구분자(File.separator)로 변경
		
		/*File 타입의 uploadpath 변수를 선언하여 우리가 만들고자 하는 "c:\\upload\\yyyy\\MM\\dd' 경로의 디렉터리를 대상으로 하는 File 객체로 초기화
		 * 객체화해주는 코드에 첫 번째 인자로 부모 경로인 uploadFoler 변수를 두 번째 인자로 자식 경로인 datePath 변수를 부여 */
		File uploadPath = new File(uploadFolder, datePath);
		/* 폴더를 생성을 수행하기 위해서 File 클래스의 mkdir() 혹은 mkdirs()를 사용
		 * 두 메서드는 폴더를 생성한다는 것을 동일 하지만 한 개의 폴더를 생성할 수 있느냐 여러 개의 폴더를 생성할 수 있느냐의 차이
		 * 우리는 여러개의 폴더를 생성해야 하기 때문에 mkdirs() 메서드를 사용 */
		if(uploadPath.exists() == false) {   //폴더 중복 생성 방지 (대상 파일 혹은 디렉터리가 존재하는지 유무를 반환하는 exists() 메서드, 없으면 false)
			uploadPath.mkdirs();
		}
		
		/* 이미저 정보 담는 객체 */
		List<AttachImageVO> list = new ArrayList();
		
		for(MultipartFile multipartFile : uploadFile) {   //기본 for문: for(int i = 0; i < uploadFile.length; i++) {
			/* 이미저 정보 객체 */
			AttachImageVO vo = new AttachImageVO();
			
			/* 파일 이름 */
			String uploadFileName = multipartFile.getOriginalFilename();   //파일 이름의 경우 뷰로부터 전달받은 파일 이름을 그대로 사용
			vo.setFileName(uploadFileName);   //이미지 객체에 원본 파일명 저장
			vo.setUploadPath(datePath);   //이미지 객체에 자식(유동) 폴더 경로 저장 (기본 경로: C:\\upload) (유동 경로: \\yyyy\\MM\\dd)
			
			/* uuid 적용 파일 이름 */
			String uuid = UUID.randomUUID().toString();   //UUID를 저장할 String 타입의 변수 uuid를 선언하고 UUID로 초기화
			uploadFileName = uuid + "_" + uploadFileName;   //기존 파일 이름인 uploadFileName 변수를 "UUID_파일 이름" 형식이 되도록 변경
			vo.setUuid(uuid);   //이미지 객체에 uuid 저장
			
			/* 파일 저장 위치, 파일 이름을 매개변수로 사용한 File 객체 */
			File saveFile = new File(uploadPath, uploadFileName);
			
			/* 파일 저장 */
			try {
				multipartFile.transferTo(saveFile);   //전달 받은 파일을 설정한 경로, 이름으로 저장
				
				/* 썸네일 방법 1 - ImageIO 사용 *//*
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);   //썸네일 이미지 File 객체로 초기화 (경로, 이름)
				
				BufferedImage bo_image = ImageIO.read(saveFile);   //원본 이미지 파일을 BufferedImage 타입으로 변경
				double ratio = 3;   //원본 이미지를 축소할 비율
				int width = (int) (bo_image.getWidth() / ratio);   //원본 이미지 넓이 지정한 비율값으로
				int height = (int) (bo_image.getHeight() / ratio);   //원본 이미지 높이 지정한 비율값으로
//				BufferedImage bt_image = new BufferedImage(300, 500, BufferedImage.TYPE_3BYTE_BGR);   //썸네일 이미지 BuffedImage 객체 생성
					//일종의 크기를 지정하여 흰색 도화지를 만드는 것 ('넓이', '높이', '생성될 이미지의 타입')
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);   //비율 적용 도화지
								
				Graphics2D graphic = bt_image.createGraphics();   //Graphic2D 객체 생성 (만든 도화지에 그림을 그릴 수 있도록 하는 과정)
				
//				graphic.drawImage(bo_image, 0, 0, 300, 500, null);   //좌상단(0,0)부터 썸네일 이미지 그리기 (도화지에 이미지를 그리는 과정)
				//그려놓고자 하는 이미지, 시작 x y 좌표, 넓이 높이, ImageObserver (일반적인 경우 null을 전달)
				graphic.drawImage(bo_image, 0, 0, width, height, null);   //비율 적용 이미지
					
				ImageIO.write(bt_image, "jpg", thumbnailFile);   //제작한 썸네일 이미지 파일로 저장
				//파일로 저장할 이미지, 확장자, 저장될 경로와 이름으로 생성한 File 객체
				*//* 썸네일 방법 1 끝 */
				
				/* 썸네일 방법 2 - thumbnailaotor 라이브러리 사용 */
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	   //썸네일 이미지 File 객체로 초기화 (경로, 이름)
				
				BufferedImage bo_image = ImageIO.read(saveFile);   //원본 이미지 파일을 BufferedImage 타입으로 변경

				double ratio = 3;   //원본 이미지를 축소할 비율
				int width = (int) (bo_image.getWidth() / ratio);   //원본 이미지 넓이 지정한 비율값으로
				int height = (int) (bo_image.getHeight() / ratio);   //원본 이미지 높이 지정한 비율값으로	
				
				Thumbnails.of(saveFile)   //해당 이미지 파일로 썸네일 생성
						        .size(width, height)   //썸네일 가로, 세로 크기 지정
						        .toFile(thumbnailFile);   //썸네일 이미지를 파일로 저장
				/* 썸네일 방법 2 끝 */
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			list.add(vo);   //파일의 데이터가 담긴 이미지 객체를 이미지 객체 리스트에 저장
		}
		
		/* ResponseEntity 참조 변수를 선언하고 생성자로 초기화
		 * Http의 바디에 추가될 데이터는 List <AttachImageVO>이고 상태 코드가 OK(200)인 ReseponseEntity 객체가 생성 */
		ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
		return result;   //작성한 ResponseEntity를 뷰로 반환
	}
	
	/* 업로드 된 첨부 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		log.info("deleteFile........" + fileName);
		
		File file = null;
		
		try {
			/* 썸네일 파일 삭제 */
			/* 파일 업로드 메서드에서 뷰 페이지로 보낸 파일 경로를 뷰 페이지에서 경로 문제로 인해 encodeURIComponent() 메서드를 통해 UTF-8로 인코딩 후 사용
			 * 인코딩된 경로를 파일 삭제 메서드로 그대로 보내오기 때문에 File 클래스에 사용시 다시 경로 문제가 발생할 수 있음
			 * 따라서 다시 디코딩 하는 작업이 필요 */
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));   //썸네일 파일 경로
			file.delete();   //전달 받은 경로의 파일 삭제 (썸네일 파일 삭제)
			
			/* 원본 파일 삭제 */
			/* File 클래스의 getAbsolutePath() 메서드 : 대상 File 객체의 경로를 문자열(String) 타입의 데이터로 반환 */
			/* replace() 메서드 : 첫 번째 인자로 부여한 문자열 데이터를 찾아서, 두 번째 인자로 부여한 문자열 데이터로 치환 */
			String originFileName = file.getAbsolutePath().replace("s_", "");   //원본 파일명
			log.info("originFileName : " + originFileName);
			file = new File(originFileName);   //원본 파일 경로			
			file.delete();   //원본 파일 삭제
		} catch(Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);   //이미지 삭제 실패 알림을 뷰로 반환
		}
		/* 성공 상태 코드와 함께 성공과 관련된 문자열을 뷰로 전송 */
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	/* 상품 조회 페이지 */
	//상품 수정 페이지로 이동할 수 있는 URL 매핑 메서드는 '상품 조회 페이지 이동 메서드(goodsDetail)'와 완전히 동일
//	@GetMapping("/goodsDetail")
	@GetMapping({"/goodsDetail", "/goodsModify"})
	public void goodsGetInfoGET(int bookId, Criteria2 cri, Model model) throws JsonProcessingException {
		log.info("goodsGetInfo()........." + bookId);
		
		/* 지금 현재의 카테고리 출력에 사용할 수 있는 데이터는 사용자가 최종적으로 선택하였던 DB에 등록되어 잇는 소분류의 코드만 있습니다
		 * 문제는 해당 데이터만으로는 대분류, 중분류 항목까지 출력시킬 수는 없습니다
		 * 중분류, 대분류를 출력시키기 위해선 카테고리 항목이 무엇이 담겨있는지 알 수 있는 카테고리 항목 전체 데이터가 필요로 합니다
		 * 따라서 '상품 등록(goodsEnroll.jsp)'에 사용하였던 카테고리 항목에 관한 전체 데이터를 '상품 조회(goodsDetail.jsp)'페이지 가져와서
		 * JSON 데이터로 변환한 카테고리 분류에 따라 객체로 분류해둔 코드를 활용할 것 */
		ObjectMapper mapper = new ObjectMapper();
		/* ObjectMapper는 기본 POJO(Plain Old Java Objects) 또는 범용 JSON 트리 모델(JsonNode) 간에
		 * JSON을 읽고 쓰는 기능과 변환을 수행하기 위한 관련 기능을 제공합니다
		 * 다른 스타일의 JSON 콘텐츠와 함께 작동하고 다형성 및 개체 ID와 같은 고급 개체 개념을 지원합니다
		 * ObjectMapper는 또한 고급 ObjectReader 및 ObjectWriter 클래스를 위한 팩토리 역할 */
		
		/* 상품 카테고리 리스트 데이터 */
		model.addAttribute("cateList", mapper.writeValueAsString(adminService.cateList()));
		/* writeValueAsString - Java 값을 문자열로 직렬화하는 데 사용할 수 있는 메소드 */
		/* writeValueAsString() 메서드는 Java 객체를 String타입의 JSON형식 데이터로 변환해줌 */
		
		/* 목록 페이지 조건 정보 */
		model.addAttribute("cri", cri);
		
		/* 조회 페이지 정보 */
		model.addAttribute("goodsInfo", adminService.goodsGetDetail(bookId));
	}
	
	/* 상품 정보 수정 */
	@PostMapping("/goodsModify")
	public String goodsModifyPOST(BookVO vo, RedirectAttributes rttr) {
		log.info("goodsModifyPOST.........." + vo);
		
		int result = adminService.goodsModify(vo);
		
		rttr.addFlashAttribute("modify_result", result);
		
		return "redirect:/admin/goodsManage";		
	}
	
	/* 상품 정보 삭제 */
	@PostMapping("/goodsDelete")
	public String goodsDeletePOST(int bookId, RedirectAttributes rttr) {
		log.info("goodsDeletePOST..........");
		
		List<AttachImageVO> fileList = adminService.getAttachInfo(bookId);   //DB에서 해당 상품의 이미지 정보 획득
		
		if(fileList != null) {   //이미지 정보가 존재 한다면
			List<Path> pathList = new ArrayList();
			
			fileList.forEach(vo ->{   //반복문을 이용해 이미지 정보 리스트에서 이미지 정보들을 각각 Path 객체로 변환하여 pathList에 저장
				// 원본 이미지
				Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
				pathList.add(path);
				
				// 섬네일 이미지
				path = Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid()+"_" + vo.getFileName());
				pathList.add(path);
			});
			
			pathList.forEach(path ->{   //반복문을 이용해 pathList에 담인 이미지 정보 객체들을 활용해 해당 이미지 파일들을 실제로 삭제
				path.toFile().delete();
			});
		}
		
		int result = adminService.goodsDelete(bookId);
		
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/admin/goodsManage";
	}
	
	/* 주문 현황 페이지 */
	@GetMapping("/orderList")
	public String orderListGET(Criteria2 cri, Model model) {
		List<OrderDTO> list = adminService.getOrderList(cri);   //주문 목록
		
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			model.addAttribute("pageMaker", new PageMakerDTO2(cri, adminService.getOrderTotal(cri)));
		} else {
			model.addAttribute("listCheck", "empty");
		}
		
		return "/admin/orderList";
	}
	
}
