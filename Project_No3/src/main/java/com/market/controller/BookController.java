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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.market.mapper.AttachMapper;
import com.market.model.AttachImageVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BookController {
	
	//@Log4j 어노테이션 사용 안할 시
//	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private AttachMapper attachMapper;   //이미지 데이터 가져오기 서비스
	
	/* 메인 페이지 이동 */
	@RequestMapping(value = "/main", method = RequestMethod.GET)   // 혹은 @GetMapping("/main")
	public void mainPageGET() {
		log.info("'메인' 페이지 진입");   //@Log4j 어노테이션 사용 안할 시 ==> logger.info("...");
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
	
}
