package egovframework.example.cmmn;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.GuestsVO;

public class UploadExcel {
	public static Map<String, GuestsVO> uploadExcel(MultipartFile file) throws IOException {

	    // id를 key로 하고 Guest 객체를 value로 저장
	    Map<String, GuestsVO> guestMap = new HashMap<>();

	    // Maven 라이브러리 XSSFWorkbook 선언
	    XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());

	    // 엑셀 파일의 0번째 시트
	    XSSFSheet sheet = workbook.getSheetAt(0);

	    // DataFormatter 선언 (셀의 값을 String으로 변환)
	    DataFormatter formatter = new DataFormatter();

	    // 첫 번째 행이 헤더라면, i를 1부터 시작해서 데이터만 읽습니다.
	    for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
	        XSSFRow row = sheet.getRow(i);

	        // null 체크: 빈 행인 경우 건너뛰기
	        if (row == null) continue;

	        // 0번째 열부터 셀 값 읽기
	        String id = formatter.formatCellValue(row.getCell(0));
	        String guestName = formatter.formatCellValue(row.getCell(1));
	        String guestGender = formatter.formatCellValue(row.getCell(2));
	        String guestType = formatter.formatCellValue(row.getCell(3));
	        String guestSido = formatter.formatCellValue(row.getCell(4));
	        String guestGugun = formatter.formatCellValue(row.getCell(5));
	        String isDisabled = formatter.formatCellValue(row.getCell(6));
	        String isForeigner = formatter.formatCellValue(row.getCell(7));
	        
	        // 값이 하나라도 비어있으면 건너뛰기
	        if (guestName == null || guestName.trim().isEmpty()) continue;
	        
	        // id가 비어있으면 건너뛰기
	        if (id == null || id.trim().isEmpty()) continue;

	        // Guest 객체 생성
	        GuestsVO guestsVO = new GuestsVO();
	        guestsVO.setGuestName(guestName);
	        guestsVO.setGuestGender(Integer.parseInt(guestGender));
	        guestsVO.setGuestType(Integer.parseInt(guestType));
	        guestsVO.setGuestSido(guestSido);
	        guestsVO.setGuestGugun(guestGugun);
	        guestsVO.setIsDisabled(Integer.parseInt(isDisabled));
	        guestsVO.setIsForeigner(Integer.parseInt(isForeigner));
	        
	        // id를 key로 Guest 객체를 value로 저장
	        guestMap.put(id, guestsVO);
	    }

	    // 자원 해제
	    workbook.close();

	    return guestMap;
	}

}
