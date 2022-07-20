package com.market.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.market.mapper.AdminMapper;
import com.market.model.AttachImageVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class TaskTests {

	@Autowired
	private AdminMapper mapper;
	
	/* 디렉토리(directory)에 저장된 이미지 파일의 path 객체를 생성하기 위해 필요로한 폴더 경로 문자열(언제자 날짜)을 얻는 메서드 */
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");   //날짜 형식
		
		Calendar cal = Calendar.getInstance();   //캘린더
		
		cal.add(Calendar.DATE, -1);   //오늘 날짜 - 1일 값을 캘린더에 추가
		
		String str = sdf.format(cal.getTime());   //캘린더에 추가한 날짜를 지정한 날짜 형식의 문자열로 적용
		
		return str.replace("-", File.separator);   //날짜 문자열의 "-" 값들을 모두 각 운영체제에 맞는 경로 구분자로 변경
	}
	
	@Test
	public void taskTests() {
		List<AttachImageVO> fileList = mapper.checkFileList();   //DB에 존재하는 이미지 정보 리스트를 가져오기
		
		//확인용 출력문
		System.out.println("fileList : ");
		fileList.forEach( list -> System.out.println(list));
		System.out.println("========================================");
		
		List<Path> checkFilePath = new ArrayList<Path>();   //DB에 저장된 리스트와 디렉토리에 저장된 리스트 비교를 위해 자료형을 같게 Path 객체로 변환
		
		/* fileList에 forEach 메서드를 호출하여 각요소의 AttachImageVO의 필드 값을 통해 Path 객체를 생성 해준 뒤 checkFilePath 요소로 추가 */
		fileList.forEach(vo -> {   //Paths 클래스의 정적(static) 메서드 get() 은 path 객체를 반환
			Path path = Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		//확인용 출력문
		System.out.println("checkFilePath : ");
		checkFilePath.forEach(list -> System.out.println(list));
		System.out.println("========================================");
		
		/* 원본 이미지와 같이 저장된 썸네일 이미지도 선별하기 위해 */
		fileList.forEach(vo -> {
			Path path = Paths.get("C:\\upload", vo.getUploadPath(),"s_" +  vo.getUuid() + "_" + vo.getFileName());
			checkFilePath.add(path);
		});
		
		//확인용 출력문
		System.out.println("checkFilePath(썸네일 이미지 정보 추가 후) : ");
		checkFilePath.forEach(list -> System.out.println(list));
		System.out.println("========================================");
		
		//체크할 대상의 이미지 파일이 저장된 디렉토리를 File 객체로 생성 후 tagetDir 변수에 대입
		File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
		
		//listFiles() 메서드를 호출하여 반환받은 File 배열 객체 주소를 targetFile 변수에 대입
		File[] targetFile = targetDir.listFiles();   // listFiles() : 해당 디렉토리에 저장되어 있는 파일들을 File 객체로 생성하여 가지는 배열을 반환
		
		//targetFile의 배열에 디렉토리에 저장되어 있는 파일의 정보들이 요소로 있는지 확인하기 위해 console 출력
		System.out.println("targetFile : ");
		for(File file : targetFile) {
			System.out.println(file);
		}
		System.out.println("========================================");
		
		//File을 요소로 가지는 List 타입인 removeFileList 변수 선언, 디렉토리 파일 리스트 targeFile 배열을 List 타입으로 변환 후 대입
		List<File> removeFileList = new ArrayList<File>(Arrays.asList(targetFile));   //Arrays.asList(배열) : 배열 객체를 리스트 객체로 변경
		
		//확인용 출력문
		System.out.println("removeFileList(필터 전) : ");		
		removeFileList.forEach(file -> {
			System.out.println(file);
		});		
		System.out.println("========================================");		
		
		//이중 for문을 통해서 removeFileList에 checkFilePath(DB 이미지 리스트)에 존재하지 않는 이미지 File 객체만 남기고 나머지 File객체 요소가 제거
		for(File file : targetFile){   //즉, removeFileList 객체에는 제거 해야하는 파일 Path 객체만 남겨 놓는다
			checkFilePath.forEach(checkFile ->{
				if(file.toPath().equals(checkFile))   //체크 대상 폴더의 파일(file.toPath())과 체크 데이터(DB 이미지 정보)가 같으면 true
					removeFileList.remove(file);	//제거 파일 리스트에서 DB에 이미지 정보가 있는 파일 Path 객체를 제거한다
			});
		}
		
		//확인용 출력문
		System.out.println("removeFileList(필터 후) : ");
		removeFileList.forEach(file -> {
			System.out.println(file);
		});
		System.out.println("========================================");
		
		/* 삭제되어야 할 File 객체를 얻었기 때문에 File클래스의 delete() 메서드를 호출하여 해당 파일 삭제 */
		for(File file : removeFileList) {
			System.out.println("삭제 : " + file);
			file.delete();
		}
	}
	
}
