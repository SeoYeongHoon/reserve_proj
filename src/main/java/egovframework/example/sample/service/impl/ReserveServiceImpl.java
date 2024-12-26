package egovframework.example.sample.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.example.sample.service.DraftVO;
import egovframework.example.sample.service.EventVO;
import egovframework.example.sample.service.FileVO;
import egovframework.example.sample.service.GuestsVO;
import egovframework.example.sample.service.LineVO;
import egovframework.example.sample.service.ReserveService;
import egovframework.example.sample.service.ReserveVO;
import egovframework.example.sample.service.UserSearchVO;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

import org.json.JSONArray;
import org.json.JSONObject;

@Service("reserveService")
public class ReserveServiceImpl extends EgovAbstractServiceImpl implements ReserveService {
	
	private static final Logger LOGGER = Logger.getLogger(ReserveServiceImpl.class);

	@Resource(name = "reserveMapper")
	private ReserveMapper reserveMapper;

	// 예약 출력(관리자)
	@Override
	public List<ReserveVO> selectReservations(String year, String month, int eventNo) throws Exception {
		return reserveMapper.selectReservations(year, month, eventNo);
	}
	
	// 예약 생성(관리자)
	@Override
	public void insertReserve(String date, String time, String title, Integer maxCount, Integer eventNo, HttpSession session) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		ReserveVO resVO = new ReserveVO();
		resVO.setResTitle(title);
		resVO.setResDate(date);
		resVO.setResTime(time);
		resVO.setResMax(maxCount);
		resVO.setEventNo(eventNo);
		
		// 등록할 때, 정해진 이벤트 시간보다 더 일찍 등록은 불가
		int eventTime = reserveMapper.selectEventTimeByEventNo(eventNo);
		/*
		 * 0: 30분
		 * 1: 1시간
		 * 2: 1시간 30분
		 * 3: 2시간
		 * 4: 2시간 30분
		 * 5: 3시간
		*/
//		while (eventTime < 6) {
//			switch (eventTime) {
//			case 1: {
//				
//			}
//		}
		
		reserveMapper.insertReserve(resVO);
	}

	// 예약 전체 생성
	@Override
	public void insertReserveAll(String date, String time, String title, Integer maxCount, Integer eventNo) throws Exception {
	    if (date != null && date.endsWith("-")) {
	        date += "01"; // 기본적으로 1일로 설정
	    }

	    LocalDate inputDate = LocalDate.parse(date);
	    LocalDate startOfMonth = LocalDate.of(inputDate.getYear(), inputDate.getMonthValue(), 1);
	    LocalDate endOfMonth = startOfMonth.with(TemporalAdjusters.lastDayOfMonth());

	    for (LocalDate currentDate = startOfMonth; !currentDate.isAfter(endOfMonth); currentDate = currentDate.plusDays(1)) {
	        // 일요일 제외
	        if (currentDate.getDayOfWeek() == DayOfWeek.SUNDAY) {
	            continue;
	        }

	        // 예약 정보 생성
	        ReserveVO reserve = new ReserveVO();
	        reserve.setResTitle(title);
	        reserve.setResDate(currentDate.toString());
	        reserve.setResTime(time);
	        reserve.setResMax(maxCount);
	        reserve.setEventNo(eventNo);

	        // 개별 삽입 호출
	        reserveMapper.insertReserve(reserve);
	    }
	}


	// 예약 조회(관리자)
	@Override
	public ReserveVO selectReservationInfo(int resId) throws Exception {
		return reserveMapper.selectReservationInfo(resId);
	}

	// 각 날에 있는 최대 예약 수(관리자)
	@Override
	public int selectReservationCount(int resId) throws Exception {
		return reserveMapper.selectReservationCount(resId);
	}

	// 각 날에 현재 예약 수(관리자)
	@Override
	public int selectReservedCount(int resId) throws Exception {
		return reserveMapper.selectReservedCount(resId);
	}
	@Override
	public int selectGuestsDayCount(int resId) throws Exception {
		return reserveMapper.selectGuestsDayCount(resId);
	}

	// 예약 인원 조회(관리자)
	@Override
	public List<ReserveVO> selectRepresentUser(int resId) throws Exception {
		return reserveMapper.selectRepresentUser(resId);
	}

	// 대표자 제외 예약 인원 조회(관리자)
	@Override
	public List<ReserveVO> selectReservedUserInfo(int groupId) throws Exception {
		return reserveMapper.selectReservedUserInfo(groupId);
	}

	// 예약한 그룹 삭제(관리자)
	@Override
	public void deleteGroup(int groupId) throws Exception {
		try {
			reserveMapper.deleteGroup(groupId);
			reserveMapper.deleteGuests(groupId);
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("삭제 오류: " + e.getMessage());
		}
	}

	// 예약 대표자 저장(예약자)	
	@Override
	public String insertReserveRequest(Map<String, Object> requestData) throws Exception {
		try {
	        // JSON 데이터를 추출
	        ObjectMapper mapper = new ObjectMapper();
	        String repUserInfoJson = mapper.writeValueAsString(requestData.get("repUserInfo"));
	        List<String> guestListJson = (List<String>) requestData.get("guestInfo");

	        // JSON 문자열 -> 객체 변환
	        ReserveVO reservedData = mapper.readValue(repUserInfoJson, ReserveVO.class);
	        LOGGER.info("대표자 정보: " + reservedData);
	        LOGGER.info("일행 정보: " + guestListJson);
	        

		    
		    int guestCount = reserveMapper.selectGuestsDayCount(reservedData.getResId()); // 예약자 수
		    ReserveVO resVO = reserveMapper.selectReservationInfo(reservedData.getResId()); // 예약 정보
		    int enableCount = (resVO.getResMax() - guestCount); // 예약 가능한 수
		    
		    // 예약 신청한 수가 예약 가능한 수보다 클 시 컨트롤러로 return
		    if (guestListJson.size() > enableCount) {
		    	return "overMax";
		    }
		    	        
	        ReserveVO reserveVO = new ReserveVO();
	        reserveVO.setUserId(reservedData.getUserId());
	        reserveVO.setResId(reservedData.getResId());
	        reserveVO.setUserName(reservedData.getUserName());
	        
	        reserveMapper.insertRepresenter(reserveVO);
	        
	        for (int i = 0; i < guestListJson.size(); i++) {
	        	GuestsVO guestData = mapper.convertValue(guestListJson.get(i), GuestsVO.class);
	        	
	        	GuestsVO guestsVO = new GuestsVO();
	        	guestsVO.setResId(reservedData.getResId());
	        	guestsVO.setGuestName(guestData.getGuestName());
	        	guestsVO.setGuestGender(guestData.getGuestGender());
	        	guestsVO.setGroupId(reserveVO.getGroupId());
	        	guestsVO.setIsDisabled(guestData.getIsDisabled());
	        	guestsVO.setIsForeigner(guestData.getIsForeigner());
	        	guestsVO.setGuestSido(guestData.getGuestSido());
	        	guestsVO.setGuestGugun(guestData.getGuestGugun());
	        	
	        	reserveMapper.insertGuests(guestsVO);
	        }
	        
	        return "success";
	    } catch (Exception e) {
	        LOGGER.error("insertSchedule 오류: ", e);
	        return "fail";
	    }
	}

	// 예약 확인 리스트
	@Override
	public List<ReserveVO> selectReservedSchedules(String userId) throws Exception {
		return reserveMapper.selectReservedSchedules(userId);
	}

	// 예약 항목 당 예약자 수
	@Override
	public int selectReservedGuestsCount(int groupId) throws Exception {
		return reserveMapper.selectReservedGuestsCount(groupId);
	}

	// 예약 리스트의 예약정보(일행 확인 등)
	@Override
	public List<GuestsVO> selectReservedGuests(int groupId) throws Exception {
		return reserveMapper.selectReservedGuests(groupId);
	}
	
	// 예약한 대표자의 groupId값 가져오기
	@Override
	public int selectGroupIdByUserId(int resId, String userId) throws Exception {
		return reserveMapper.selectGroupIdByUserId(resId, userId);
	}

	// 엑셀 양식 다운로드
	@Override
	public void downloadFiles(HttpServletResponse res, String fileName) {
        // 다운로드할 파일을 가져올 경로
        String downPathFrom = "D:\\download\\" + fileName;
        File file = new File(downPathFrom);

        // 파일이 존재하지 않을 경우 처리
        if (!file.exists()) {
            return; // 파일이 없으면 종료
        }

        // 파일을 읽기 위한 FileInputStream 생성
        FileInputStream fis = null; // 파일 읽기 스트림 선언
        OutputStream os = null;    // 클라이언트로 전송하기 위한 출력 스트림 선언
        
        try {
        	// 파일 이름 인코딩 및 헤더 설정
        	// MIME 타입 설정(브라우저가 응답 데이터를 어떻게 처리해야 할지 알려주는 정보)
            String encodedFileName = URLEncoder.encode(file.getName(), "UTF-8").replace("+", "%20");
            res.setContentType("application/octet-stream"); // 알 수 없는 형식은 다운로드 처리(바이너리 파일로 간주 후 다운로드 처리)
            res.setHeader("Content-Disposition", "attachment; filename=\"" + encodedFileName + "\"");
            res.setHeader("Content-Length", String.valueOf(file.length()));
        	
        	fis = new FileInputStream(downPathFrom); // 파일 읽기 스트림 생성
        	os = res.getOutputStream(); // HTTP 응답 출력 스트림 생성
        	 
        	// 파일 데이터 클라이언트로 전송
            byte[] buffer = new byte[4096]; // 파일을 읽을 때 한 번에 전부 읽지 않고, 4KB씩 작은 단위로 나누어 처리
            int bytesRead; // 실제로 읽은 바이트 수 저장
            while ((bytesRead = fis.read(buffer)) != -1) { // 파일을 끝까지 읽음
            	// fis.read(buffer): 파일 데이터를 4KB씩 읽음
            	// -1이 반환될 때까지 파일을 읽어서 bytesRead에 저장
            	// 즉, 4096바이트씩 읽다가 읽을 수 없는 데이터(0)가 나오면 -1을 반환 => 루프 종료
            	
                os.write(buffer, 0, bytesRead);
                // 읽은 데이터(buffer)를 0번째 인덱스부터 bytesRead만큼 클라이언트로 전송.
            }

            os.flush(); // 스트림에 남아 있는 데이터 강제로 클라이언트로 전송
            // 네트워크 전송 시 데이터가 모두 보내졌는지 보장하기 위해 호출.
        	
        } catch (Exception e) {
        	// 파일 읽기/쓰기 중 에러 발생 시 500 상태 반환
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		} finally { // 예외에 상관없이 항상 실행(스트림 사용했으면 반드시 닫기)
            // 스트림 닫기
            if (fis != null) {
                try {
                    fis.close(); // 파일 입력 스트림 닫기
                } catch (IOException e) {
                    LOGGER.error("파일 입력 스트림 닫기 오류: " + e.getMessage());
                }
            }
            if (os != null) {
                try {
                    os.close(); // 출력 스트림 닫기
                } catch (IOException e) {
                    LOGGER.error("출력 스트림 닫기 오류: " + e.getMessage());
                }
            }
        }
	}

	// 이미 예약한 날짜에 입장했을 때 처리를 위한 개수
	@Override
	public int selectIsReserved(String userId, int resId) throws Exception {
		return reserveMapper.selectIsReserved(userId, resId);
	}

	// 예약 취소(예약자)
	@Override
	public void cancelReservation(int resId, int groupId) throws Exception {
		try {
			reserveMapper.cancelReservation(resId);
			reserveMapper.deleteGuests(groupId);
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("삭제 오류: " + e.getMessage());
		}
	}

	// 예약 수정(관리자)
	@Override
	public void updateReservation(int resMax, int resId) {
		reserveMapper.updateReservation(resMax, resId);
	}

	// 결재라인 명단 리스트
	@Override
	public List<UserVO> selectEmployeeList(UserSearchVO searchVO) throws Exception {
		return reserveMapper.selectEmployeeList(searchVO);
	}
	
	// 결재라인 명단 수
	@Override
	public int selectEmployeeCount(UserSearchVO searchVO) throws Exception {
		return reserveMapper.selectEmployeeCount(searchVO);
	}

	// 결재라인 저장
	@Override
	public void insertSaveLineMember(Map<String, Object> saveObject, UserVO loginUser, String lineDate) throws Exception {
		
		try {
	        // JSON 데이터를 추출
	        ObjectMapper mapper = new ObjectMapper();
	        
	        // lineTitle 추출
	        String lineTitle = (String) saveObject.get("lineTitle");
	        LOGGER.info("결재 라인 제목: " + lineTitle);
	        
	        // draft_line 테이블(결재 라인 저장 테이블)에 저장
	        LineVO lineVO = new LineVO();
	        lineVO.setLineTitle(lineTitle);
	        lineVO.setUserId(loginUser.getUserId());
	        lineVO.setLineDate(lineDate);
	        reserveMapper.insertLineInfo(lineVO);
	        
	        // approveLine 추출
	        List<Map<String, String>> approveLine = (List<Map<String, String>>) saveObject.get("approveLine");
	        if (approveLine != null && !approveLine.isEmpty()) {
	            for (Map<String, String> user : approveLine) {
	                String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName); // 이름(직급)
	                approveVO.setUserId(userId); // 결재자 아이디
	                approveVO.setMemberType(0); // 0: 결재자, 1: 협조자, 2: 참조자
	                approveVO.setLineNo(lineVO.getLineNo());
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("결재자가 없습니다.");
	        }

	        // coopLine 추출
	        List<Map<String, String>> coopLine = (List<Map<String, String>>) saveObject.get("coopLine");
	        if (coopLine != null && !coopLine.isEmpty()) {
	            for (Map<String, String> user : coopLine) {
	            	String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName);
	                approveVO.setUserId(userId);
	                approveVO.setMemberType(1);
	                approveVO.setLineNo(lineVO.getLineNo());
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("협조자가 없습니다.");
	        }

	        // referLine 추출
	        List<Map<String, String>> referLine = (List<Map<String, String>>) saveObject.get("referLine");
	        if (referLine != null && !referLine.isEmpty()) {
	            for (Map<String, String> user : referLine) {
	            	String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName);
	                approveVO.setUserId(userId);
	                approveVO.setMemberType(2);
	                approveVO.setLineNo(lineVO.getLineNo());
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("참조자가 없습니다.");
	        }
	    } catch (Exception e) {
	        LOGGER.error("insertSchedule 오류: ", e);
	    }
	}
	

	// 결재라인 수정
	@Override
	public void updateSaveLineMember(Map<String, Object> saveObject, UserVO loginUser, String lineDate) throws Exception {
		try {
	        // JSON 데이터를 추출
	        ObjectMapper mapper = new ObjectMapper();
	        
	        // lineTitle 추출
	        String lineTitle = (String) saveObject.get("lineTitle");
	        String lineNo = (String) saveObject.get("lineNo");
	        LOGGER.info("결재 라인 제목: " + lineTitle);
	        
	        // draft_line 테이블(결재 라인 저장 테이블)에 저장
	        LineVO lineVO = new LineVO();
	        lineVO.setLineNo(Integer.parseInt(lineNo));
	        lineVO.setLineTitle(lineTitle);
	        lineVO.setUserId(loginUser.getUserId());
	        lineVO.setLineDate(lineDate);
	        reserveMapper.updateLineInfo(lineVO);
	        reserveMapper.deleteLineMember(Integer.parseInt(lineNo));
	        
	        // approveLine 추출
	        List<Map<String, String>> approveLine = (List<Map<String, String>>) saveObject.get("approveLine");
	        if (approveLine != null && !approveLine.isEmpty()) {
	            for (Map<String, String> user : approveLine) {
	                String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 정보 - ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName); // 이름(직급)
	                approveVO.setUserId(userId); // 결재자 아이디
	                approveVO.setMemberType(0); // 0: 결재자, 1: 협조자, 2: 참조자
	                approveVO.setLineNo(Integer.parseInt(lineNo)); // 
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("결재자가 없습니다.");
	        }

	        // coopLine 추출
	        List<Map<String, String>> coopLine = (List<Map<String, String>>) saveObject.get("coopLine");
	        if (coopLine != null && !coopLine.isEmpty()) {
	            for (Map<String, String> user : coopLine) {
	            	String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 정보 - ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName);
	                approveVO.setUserId(userId);
	                approveVO.setMemberType(1);
	                approveVO.setLineNo(lineVO.getLineNo());
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("협조자가 없습니다.");
	        }

	        // referLine 추출
	        List<Map<String, String>> referLine = (List<Map<String, String>>) saveObject.get("referLine");
	        if (referLine != null && !referLine.isEmpty()) {
	            for (Map<String, String> user : referLine) {
	            	String userId = user.get("userId"); // 결재자 아이디
	                String userDept = user.get("userDept"); // 결재자 부서
	                String userName = user.get("userName"); // 결재자 이름
	                LOGGER.info("결재자 정보 - ID: " + userId + ", 부서: " + userDept + ", 이름: " + userName);
	                
	                LineVO approveVO = new LineVO();
	                approveVO.setMemberInfo(userName);
	                approveVO.setUserId(userId);
	                approveVO.setMemberType(2);
	                approveVO.setLineNo(lineVO.getLineNo());
	                
	                reserveMapper.insertLineMemberInfo(approveVO);
	            }
	        } else {
	            LOGGER.info("참조자가 없습니다.");
	        }
	    } catch (Exception e) {
	        LOGGER.error("insertSchedule 오류: ", e);
	    }
		
	}
	
	// 결재라인 출력
	@Override
	public List<LineVO> selectLineList(String userId) throws Exception {
		return reserveMapper.selectLineList(userId);
	}
	// 결재라인 멤버 출력
	@Override
	public List<LineVO> selectMemberList(String userId) throws Exception {
		return reserveMapper.selectMemberList(userId);
	}

	// 결재라인 삭제
	@Override
	public void deleteLineMember(int lineNo) throws Exception {
		reserveMapper.deleteLineInfo(lineNo);
		reserveMapper.deleteLineMember(lineNo);
	}

	// 결재라인 요청
	@Override
	public void insertDraftData(Map<String, Object> draftInfo, HttpSession session) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		try {	        
	        String draftTitle = (String) draftInfo.get("draftTitle");
	        String draftContent = (String) draftInfo.get("draftContent");
	        String resId = (String) draftInfo.get("resId");
	        
	        DraftVO draftVO = new DraftVO();
	        draftVO.setDraftTitle(draftTitle);
	        draftVO.setDraftContent(draftContent);
	        draftVO.setUserId(loginUser.getUserId());
	        draftVO.setResId(Integer.parseInt(resId));
	        reserveMapper.insertDraft(draftVO);
	        
	     	// approveLine 추출
	        List<String> approveLine = (List<String>) draftInfo.get("approveList");
	        // coopLine 추출
	        List<String> coopLine = (List<String>) draftInfo.get("coopList");
	        // referLine 추출
	        List<String> referLine = (List<String>) draftInfo.get("referList");
	        
	        DraftVO requestedDraft = new DraftVO();
	        for (int i = 0; i < approveLine.size(); i++) {
	        	requestedDraft.setUserId(approveLine.get(i));
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(0);
	        	requestedDraft.setResId(Integer.parseInt(resId));
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }
	        for (int i = 0; i < coopLine.size(); i++) {
	        	requestedDraft.setUserId(coopLine.get(i));
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(1);
	        	requestedDraft.setResId(Integer.parseInt(resId));
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }
	        for (int i = 0; i < referLine.size(); i++) {
	        	requestedDraft.setUserId(referLine.get(i));
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(2);
	        	requestedDraft.setResId(Integer.parseInt(resId));
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }

	        reserveMapper.updateReservationStatus(Integer.parseInt(resId), 1);
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("오류: ", e);
		}
	}
	
	// 예약 삭제(관리자)
	@Override
	public void deleteReserve(int resId) throws Exception {
		reserveMapper.deleteReserve(resId);
		reserveMapper.deleteGroupByResId(resId);
		reserveMapper.deleteGuestsByResId(resId);
	}

	// 결재 확인 리스트
	@Override
	public List<DraftVO> selectApprovalList(String userId) throws Exception {
		return reserveMapper.selectApprovalList(userId);
	}
	
	// 결재자인지 확인
	@Override
	public DraftVO selectIsApprover(int resId, String userId) throws Exception {
		return reserveMapper.selectIsApprover(resId, userId);
	}

	@Override
	public void updateReservationStatus(int resId, int isRequested) {
		reserveMapper.updateReservationStatus(resId, isRequested);
	}

	// 파일 테스트
	@Override
	public void insertDraftForm(String draftData, String lineData, List<MultipartFile> fileList, HttpSession session) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			
			DraftVO draftInfo = objectMapper.readValue(draftData, DraftVO.class);
			
			System.err.println("본문 정보: " + draftInfo.toString());
			
			DraftVO draftVO = new DraftVO();
	        draftVO.setUserId(loginUser.getUserId());
			draftVO.setDraftTitle(draftInfo.getDraftTitle());
			draftVO.setDraftContent(draftInfo.getDraftContent());
			draftVO.setResId(draftInfo.getResId());
			
			reserveMapper.insertDraft(draftVO);
			
			JSONObject jsonObject = new JSONObject(lineData);
			JSONArray approveList = jsonObject.getJSONArray("approveList");
	        JSONArray coopList = jsonObject.getJSONArray("coopList");
	        JSONArray referList = jsonObject.getJSONArray("referList");

	        DraftVO requestedDraft = new DraftVO();
	        
	        // 결재자 
	        for (int i = 0; i < approveList.length(); i++) {
	        	requestedDraft.setUserId(approveList.get(i).toString());
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(0);
	        	requestedDraft.setResId(draftInfo.getResId());
	        	
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }
	        
	        // 협조자
	        for (int i = 0; i < coopList.length(); i++) {
	        	requestedDraft.setUserId(coopList.get(i).toString());
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(1);
	        	requestedDraft.setResId(draftInfo.getResId());
	        	
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }
	        
	        // 참조자
	        for (int i = 0; i < referList.length(); i++) {
	        	requestedDraft.setUserId(referList.get(i).toString());
	        	requestedDraft.setDraftNo(draftVO.getDraftNo());
	        	requestedDraft.setDraftType(2);
	        	requestedDraft.setResId(draftInfo.getResId());
	        	
	        	reserveMapper.insertDraftRequests(requestedDraft);
	        }
			
	        for (int i = 0; i < fileList.size(); i++) {
	        	String originName = fileList.get(i).getOriginalFilename(); // 파일 이름 원본
	        	String exName = FilenameUtils.getExtension(originName); // 파일 확장자
                UUID uuid = UUID.randomUUID(); // 랜덤값
                LocalTime now = LocalTime.now(); // 현재시간
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH-mm-ss"); // 시분초로 포맷하는 메소드
                String formattedTime = now.format(formatter); // 현재시간을 포맷
                String uploadName = uuid + formattedTime + "." + exName; // 랜덤값 + 포맷한 현재시간 + 확장자로 유일한 이름으로 파일이름 설정
                Long fileSize = fileList.get(i).getSize();

                FileVO fileVO = new FileVO();
                fileVO.setDraftNo(draftVO.getDraftNo());
                fileVO.setFileName(originName);
                fileVO.setUploadName(uploadName);
                fileVO.setFileSize(fileSize);
                
                reserveMapper.insertFiles(fileVO);
                
                // 업로드 경로 설정
                String uploadPath = "D:\\upload\\" + uploadName; 
                fileList.get(i).transferTo(new File(uploadPath));
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 결재할 기안문 상세조회
	@Override
	public DraftVO selectDraftDetails(String userId) throws Exception {
		return reserveMapper.selectDraftDetails(userId);
	}
	// 기안문 파일조회
	@Override
	public List<FileVO> selectDraftFile(int draftNo) throws Exception {
		return reserveMapper.selectDraftFile(draftNo);
	}
	// 기안문 파일 다운로드
	@Override
	public void fileDownload(HttpServletResponse res, int fileNo) throws Exception {
		String uploadName = reserveMapper.findUploadNameByFileNo(fileNo);
		String fileName = reserveMapper.findFileNameByFileNo(fileNo);
		
		// 다운로드할 파일을 가져올 경로
        String downPathFrom = "D:\\upload\\" + uploadName;
        File file = new File(downPathFrom);

        // 파일이 존재하지 않을 경우 처리
        if (!file.exists()) {
            return; // 파일이 없으면 종료
        }

        // 파일을 읽기 위한 FileInputStream 생성
        FileInputStream fis = null; // 파일 읽기 스트림 선언
        OutputStream os = null;    // 클라이언트로 전송하기 위한 출력 스트림 선언
        
        try {
        	// 파일 이름 인코딩 및 헤더 설정
        	// MIME 타입 설정(브라우저가 응답 데이터를 어떻게 처리해야 할지 알려주는 정보)
            // String encodedFileName = URLEncoder.encode(file.getName(), "UTF-8").replace("+", "%20");
            res.setContentType("application/octet-stream"); // 알 수 없는 형식은 다운로드 처리(바이너리 파일로 간주 후 다운로드 처리)
            res.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
            // res.setHeader("Content-Length", String.valueOf(file.length()));
        	
        	fis = new FileInputStream(downPathFrom); // 파일 읽기 스트림 생성
        	os = res.getOutputStream(); // HTTP 응답 출력 스트림 생성
        	
        	// 파일 데이터 클라이언트로 전송
            byte[] buffer = new byte[4096]; // 파일을 읽을 때 한 번에 전부 읽지 않고, 4KB씩 작은 단위로 나누어 처리
            int bytesRead; // 실제로 읽은 바이트 수 저장
            while ((bytesRead = fis.read(buffer)) != -1) { // 파일을 끝까지 읽음
            	// fis.read(buffer): 파일 데이터를 4KB씩 읽음
            	// -1이 반환될 때까지 파일을 읽어서 bytesRead에 저장
            	// 즉, 4096바이트씩 읽다가 읽을 수 없는 데이터(0)가 나오면 -1을 반환 => 루프 종료
            	
                os.write(buffer, 0, bytesRead);
                // 읽은 데이터(buffer)를 0번째 인덱스부터 bytesRead만큼 클라이언트로 전송.
            }

            os.flush(); // 스트림에 남아 있는 데이터 강제로 클라이언트로 전송
            // 네트워크 전송 시 데이터가 모두 보내졌는지 보장하기 위해 호출.
        	
        } catch (Exception e) {
        	// 파일 읽기/쓰기 중 에러 발생 시 500 상태 반환
            res.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		} finally { // 예외에 상관없이 항상 실행(스트림 사용했으면 반드시 닫기)
            // 스트림 닫기
            if (fis != null) {
                try {
                    fis.close(); // 파일 입력 스트림 닫기
                } catch (IOException e) {
                    LOGGER.error("파일 입력 스트림 닫기 오류: " + e.getMessage());
                }
            }
            if (os != null) {
                try {
                    os.close(); // 출력 스트림 닫기
                } catch (IOException e) {
                    LOGGER.error("출력 스트림 닫기 오류: " + e.getMessage());
                }
            }
        }
	}

	// 이벤트 생성
	@Override
	public void createEvent(EventVO eventVO) throws Exception {
		try {
			reserveMapper.createEvent(eventVO);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	// 이벤트 리스트 조회
	@Override
	public List<EventVO> selectEventList() throws Exception {
		return reserveMapper.selectEventList();
	}
	// 이벤트 삭제
	@Override
	public void deleteEvent(int eventNo) throws Exception {
		reserveMapper.deleteEvent(eventNo);
	}
	
}
