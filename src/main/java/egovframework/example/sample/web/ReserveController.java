package egovframework.example.sample.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.example.cmmn.UploadExcel;
import egovframework.example.sample.service.DraftVO;
import egovframework.example.sample.service.EventVO;
import egovframework.example.sample.service.FileVO;
import egovframework.example.sample.service.GuestsVO;
import egovframework.example.sample.service.LineVO;
import egovframework.example.sample.service.ReserveService;
import egovframework.example.sample.service.ReserveVO;
import egovframework.example.sample.service.UserSearchVO;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ReserveController {
	private static final Logger LOGGER = Logger.getLogger(ReserveController.class);

	@Resource(name = "reserveService")
	private ReserveService reserveService;
	
	
	/********** 관리자 페이지 **********/
	
	// 관리자페이지 - 예약일정관리 캘린더
	@GetMapping("/adminCalendar.do")
	public String adminCalendarForm(Model model) throws Exception {
		List<EventVO> eventVOs = reserveService.selectEventList();
		model.addAttribute("eventList", eventVOs);
		
		return "reserve/adminCalendar";
	}
	
	// 관리자페이지 - 예약일정관리 데이터 전송
	@ResponseBody
	@GetMapping("/api/getReservations.do")
	public List<ReserveVO> getReservations(@RequestParam("year") int year, 
										   @RequestParam("month") int month,
										   @RequestParam("eventNo") int eventNo
										   ) throws Exception {
		String startDate = String.format("%04d-%02d-01", year, month + 1); // ex: 2024-02-01
	    String endDate = String.format("%04d-%02d-01", year, month + 2); // 다음 달의 1일 (현재 달의 마지막 날을 구하기 위함)
		List<ReserveVO> resVos = reserveService.selectReservations(startDate, endDate, eventNo);
		
		return resVos;
	}
	
	// 관리자페이지 - 이벤트 생성 페이지
	@GetMapping("/createEventForm.do")
	public String createEventForm() throws Exception {
		return "reserve/createEvent";
	}
	
	// 관리자페이지 - 이벤트 생성 기능
	@PostMapping("/createEvent.do")
	public String createEvent(EventVO eventVO) throws Exception {
		try {
			reserveService.createEvent(eventVO);
			return "redirect:/adminCalendar.do";			
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/error.do";
		}
	}
	
	// 관리자페이지 - 이벤트 삭제 기능
	@ResponseBody
	@GetMapping("/api/deleteEvent.do")
	public String deleteEvent(@RequestParam("eventNo") int eventNo) throws Exception {
		try {
			reserveService.deleteEvent(eventNo);
			return "success";
		} catch (Exception e) {
			e.printStackTrace();
			return "fail";
		}
		
	}
	
	// 관리자페이지 - 예약일정관리 현재 예약된 수
	@ResponseBody
	@GetMapping("/api/getReservedCount.do")
	public int getReservedCount(@RequestParam("resId") int resId) throws Exception {
		int guestCount = reserveService.selectGuestsDayCount(resId);
		
		return guestCount;
	}
	
	// 관리자페이지 - 예약 생성
	@GetMapping("/reservePost.do")
	public String postReserveForm(@RequestParam(value = "year", required = false) String year,
	                              @RequestParam(value = "month", required = false) String month,
	                              @RequestParam(value = "date", required = false) String date,
	                              @RequestParam(value = "title", required = false) String title,
	                              @RequestParam(value = "eventNo", required = true) int eventNo,
	                              @RequestParam(value = "eventTime", required = true) int eventTime,
	                              Model model
	                              ) throws Exception {
	    // 모델에 데이터 추가
	    model.addAttribute("year", year);
	    model.addAttribute("month", month);
	    model.addAttribute("date", date);
	    model.addAttribute("title", title);
	    model.addAttribute("eventNo", eventNo);
	    
	    if (eventTime == 0) {
		    model.addAttribute("eventTime", "30분");
	    } else if (eventTime == 1) {
		    model.addAttribute("eventTime", "1시간");
	    } else if (eventTime == 2) {
		    model.addAttribute("eventTime", "1시간 30분");
	    } else if (eventTime == 3) {
		    model.addAttribute("eventTime", "2시간");
	    } else if (eventTime == 4) {
		    model.addAttribute("eventTime", "2시간 30분");
	    } else if (eventTime == 5) {
		    model.addAttribute("eventTime", "3시간");
	    }
	    
	    return "reserve/reservePost";
	}

	// 관리자페이지 - 예약 저장(등록)
	@PostMapping("/reservePost.do")
	public String postReserve(@RequestParam(value = "resDate", required = false) String date,
				              @RequestParam(value = "resTitle", required = false) String title,
				              @RequestParam(value = "time", required = false) String time,
				              @RequestParam(value = "maxPeople", required = false) Integer maxCount,
				              @RequestParam(value = "eventNo", required = true) Integer eventNo,
				              HttpSession session
				              ) throws Exception {
		
		try {
			reserveService.insertReserve(date, time, title, maxCount, eventNo, session);
			return "redirect:/adminCalendar.do";
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	// 관리자페이지 - 전체 예약 저장(등록)
	@PostMapping("/reservePostAll.do")
	public String postReserveAll(@RequestParam(value = "resDate", required = false) String date,
					             @RequestParam(value = "resTitle", required = false) String title,
					             @RequestParam(value = "time", required = false) String time,
					             @RequestParam(value = "maxPeople", required = false) Integer maxCount,
					             @RequestParam(value = "eventNo", required = false) Integer eventNo
	            				 ) throws Exception {
		reserveService.insertReserveAll(date, time, title, maxCount, eventNo);
		
		return "redirect:/adminCalendar.do";
	}
	
	// 관리자페이지 - 예약정보 상세 및 변경 페이지
	@GetMapping("/reserveDetail.do")
	public String reserveDetailForm(@RequestParam("resId") int resId,
								    Model model,
								    HttpSession session
								    ) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		ReserveVO resVO = reserveService.selectReservationInfo(resId);
		List<ReserveVO> resRepresentVO = reserveService.selectRepresentUser(resId);
		int resCount = reserveService.selectGuestsDayCount(resId);
		
		DraftVO isApprover = reserveService.selectIsApprover(resId, loginUser.getUserId());
		
		model.addAttribute("resInfo", resVO);
		model.addAttribute("resRepreInfos", resRepresentVO);
		model.addAttribute("resCount", resCount);
		model.addAttribute("isApprover", isApprover);
		
		return "reserve/reserveDetail";
	}
	
	// 관리자페이지 - 예약 정보확인 팝업 데이터 전송
	@ResponseBody
	@GetMapping("/api/getUserInfos.do")
	public List<ReserveVO> getUserInfos(@RequestParam("groupId") int groupId
										) throws Exception {
		List<ReserveVO> userInfos = reserveService.selectReservedUserInfo(groupId);
		
		return userInfos;
	}
	
	// 관리자페이지 - 예약 삭제
	@GetMapping("/deleteReserve.do")
	public String deleteReservation(@RequestParam("resId") int resId) throws Exception {
		reserveService.deleteReserve(resId);
		
		return "redirect:/adminCalendar.do";
	}
	
	// 관리자페이지 - 예약한 그룹 삭제
	@GetMapping("/deleteGroup.do")
	public String deleteGroup(@RequestParam("groupId") int groupId,
							  @RequestParam("resId") int resId,
							  Model model
						      ) throws Exception {
		reserveService.deleteGroup(groupId);
		ReserveVO resVO = reserveService.selectReservationInfo(resId);
		List<ReserveVO> resRepresentVO = reserveService.selectRepresentUser(resId);
		
		model.addAttribute("resInfo", resVO);
		model.addAttribute("resRepreInfos", resRepresentVO);
		
		return "reserve/reserveDetail";
	}
	
	// 관리자페이지 - 예약 수정
	@ResponseBody
	@GetMapping("/api/updateReserveDetail.do")
	public Map<String, Object> updateReserveDetail(@RequestParam("resMax") int resMax,
												   @RequestParam("resId") int resId
												   ) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		try {			
			reserveService.updateReservation(resMax, resId);
			response.put("success", false);
            response.put("message", "수정되었습니다.");
			return response;
		} catch (Exception e) {
			e.printStackTrace();
			LOGGER.error("수정 오류: " + e.getMessage());
			response.put("success", false);
	        response.put("message", "예약 등록 중 오류가 발생했습니다: " + e.getMessage());
	        return response;
		}
	}
	
	// 관리자페이지 - 기안문 페이지
	@GetMapping("/reserveDraft.do")
	public String reserveDraftForm(@RequestParam("resId") int resId, 
								   Model model) throws Exception {
		ReserveVO resVO = reserveService.selectReservationInfo(resId);
		model.addAttribute("resInfo", resVO);
		
		return "reserve/reserveDraft";
	}
	
	// 관리자페이지 - 결재라인 페이지
	@GetMapping("/reserveApprover.do")
	public String reserveApproverForm(Model model,
									  HttpSession session
									  ) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		List<LineVO> lineList = reserveService.selectLineList(loginUser.getUserId());
		List<LineVO> memberList = reserveService.selectMemberList(loginUser.getUserId());
		model.addAttribute("lineList", lineList);
		model.addAttribute("memberList", memberList);
		
		return "reserve/reserveApprover";
	}
	
	// 결재라인 명단 리스트 페이징
	@ResponseBody
	@GetMapping("/api/userPaginating.do")
	public Map<String, Object> paginateUserList(@RequestParam("pageNo") String pageNo,
												@RequestParam("searchKeyword") String searchKeyword,
												@RequestParam(value = "deptCondition", defaultValue = "0") String deptCondition,
												@RequestParam(value = "levelCondition", defaultValue = "0") String levelCondition
												) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		UserSearchVO searchVO = new UserSearchVO();
		searchVO.setSearchKeyword(searchKeyword); // 검색어 설정
		searchVO.setLevelCondition(levelCondition); // 검색 조건: 직급
		searchVO.setDeptCondition(deptCondition); // 검색 조건: 부서
		searchVO.setPageIndex(Integer.parseInt(pageNo)); // 현재 페이지 번호 설정
	    searchVO.setPageUnit(10); // 한 페이지에 보여줄 게시글 수
	    searchVO.setPageSize(10); // 페이징 네비게이션에 표시될 페이지 수
		
	    // 페이징 처리용 객체 생성 및 설정
	    PaginationInfo paginationInfo = new PaginationInfo();
	    paginationInfo.setCurrentPageNo(searchVO.getPageIndex()); // 현재 페이지 번호 설정
	    paginationInfo.setRecordCountPerPage(searchVO.getPageUnit()); // 한 페이지에 표시할 게시글 수 설정
	    paginationInfo.setPageSize(searchVO.getPageSize()); // 페이지 네비게이션에 나타낼 페이지 수 설정
	    // PaginationInfo 객체에 대입 후 계산된 값들을 하단의 searchVO에 대입

	    // searchVO의 첫 번째와 마지막 인덱스 및 페이지당 레코드 수 설정
	    searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex()); // 현재 페이지의 첫 번째 게시글 인덱스(ex: 1페이지는 0, 2페이지는 10...) => 쿼리의 #{firstIndex}에 적용
	    searchVO.setLastIndex(paginationInfo.getLastRecordIndex()); // 현재 페이지의 마지막 레코드 인덱스(ex: 1페이지는 10, 2페이지는 20...)
	    searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage()); // 한 페이지에 표시할 게시글 수 설정 후 쿼리에 매개변수로 적용
	    paginationInfo.setTotalRecordCount(reserveService.selectEmployeeCount(searchVO)); // 전체 게시글 수
	    
	    List<UserVO> userList = reserveService.selectEmployeeList(searchVO);

	    response.put("userList", userList);
	    response.put("paginationInfo", paginationInfo); // 추가된 페이징 정보

	    return response;
	}
	
	// 결재 라인 저장(등록)
	@RequestMapping(value = "/api/saveLineMember.do", method = RequestMethod.POST)
	@ResponseBody
    public Map<String, Object> saveLineMember(@RequestBody Map<String, Object> saveObject, HttpSession session) {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        Map<String, Object> response = new HashMap<>();

	    try {
	        // String result = reserveService.insertReserveRequest(saveObject); // overMax, success, fail 값 중 하나 받아옴
	    	// 현재 시간(등록 일자) 생성
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String lineDate = now.format(formatter);
	        
	        reserveService.insertSaveLineMember(saveObject, loginUser, lineDate);
	        
	        response.put("success", true);
            response.put("message", "저장되었습니다.");
            response.put("lineDate", lineDate);
	    } catch (Exception e) { // 실패
	        e.printStackTrace();
	        LOGGER.error("등록 오류: " + e.getMessage());
	        response.put("success", false);
	        response.put("message", "저장에 실패했습니다: " + e.getMessage());
	    }
	    
	    return response;
    }
	
	// 결재 라인 수정
	@RequestMapping(value = "/api/updateLineMember.do", method = RequestMethod.POST)
	@ResponseBody
    public Map<String, Object> updateLineMember(@RequestBody Map<String, Object> saveObject, 
    											HttpSession session
    											) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
        
        Map<String, Object> response = new HashMap<>();

	    try {
	        // String result = reserveService.insertReserveRequest(saveObject); // overMax, success, fail 값 중 하나 받아옴
	    	// 현재 시간(등록 일자) 생성
	        LocalDateTime now = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String lineDate = now.format(formatter);
	        
	        reserveService.updateSaveLineMember(saveObject, loginUser, lineDate);
	        
	        response.put("success", true);
            response.put("message", "저장되었습니다.");
            response.put("lineDate", lineDate);
	    } catch (Exception e) { // 실패
	        e.printStackTrace();
	        LOGGER.error("등록 오류: " + e.getMessage());
	        response.put("success", false);
	        response.put("message", "저장에 실패했습니다: " + e.getMessage());
	    }
	    
	    return response;
    }	
	
	// 결재 라인 삭제
	@GetMapping("/api/deleteLineInfo.do")
	@ResponseBody
	public Map<String, Object> deleteLineMember(@RequestParam("lineNo") int lineNo) throws Exception {
		 Map<String, Object> response = new HashMap<>();
		 
		 try {
			 reserveService.deleteLineMember(lineNo);
		 } catch (Exception e) {
			e.printStackTrace();
	        LOGGER.error("등록 오류: " + e.getMessage());
	        response.put("success", false);
	        response.put("message", "삭제에 실패했습니다: " + e.getMessage());
		}
		 
		 return response;
		
	}
	
	// 결재 라인 선택
	@RequestMapping(value = "/reserveDraft.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> submitLineInfo(@RequestBody Map<String, Object> saveObject, 
											  HttpSession session
											  ) throws Exception {
		Map<String, Object> response = new HashMap<>();
		
		response.put("success", true);
		
		return response;
	}
	
	// 결재 신청
	@RequestMapping(value = "/requestApproval.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> requestApproval(@RequestParam("draftData") String draftData,
											   @RequestParam("lineData") String lineData,
											   @RequestPart(value = "fileList", required = false) List<MultipartFile> fileList,
											   HttpSession session
											   ) throws Exception {
		Map<String, Object> response = new HashMap<String, Object>();
		
		try {
			reserveService.insertDraftForm(draftData, lineData, fileList, session);
			response.put("success", true);
			return response;
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
			return response;
		}
	}
	
//	@RequestMapping(value = "/requestApproval.do", method = RequestMethod.POST)
//	@ResponseBody
//	public Map<String, Object> requestApproval(// @RequestParam("draftInfo") String draftInfo,
//											   // @RequestParam("lineList") List<String> lineList,
//											   // @RequestPart(value = "file", required = false) List<MultipartFile> files,
//											   HttpSession session,
//											   @RequestBody Map<String, Object> draftInfo
//											   ) throws Exception {
//		Map<String, Object> response = new HashMap<String, Object>();
//		
//		try {
//			// reserveService.insertDraftInfo(draftInfo, lineList, files, session);
//			reserveService.insertDraftData(draftInfo, session);
//			response.put("success", "success");
//			return response;
//		} catch (Exception e) {
//			e.printStackTrace();
//	        LOGGER.error("요청 오류: " + e.getMessage());
// 			response.put("fail", "fail");
// 			response.put("message", e.getMessage());
// 			return response;
//		}
//	}
	
	// 결재 확인 페이지
	@GetMapping("/approvalCheck.do")
	public String approvalCheckForm(HttpSession session, Model model) throws Exception {

		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		List<DraftVO> draftVO = reserveService.selectApprovalList(loginUser.getUserId());
		
		model.addAttribute("draftInfos", draftVO);
		
		return "reserve/approvalCheck";
	}

	// 결재 기안문 상세 정보
	@RequestMapping(value = "/api/showDraftDetail.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> showDraftDetails(@RequestParam("userId") String userId) throws Exception {
		Map<String, Object> draftMap = new HashMap<>();
		
		DraftVO draftVO = reserveService.selectDraftDetails(userId);
		draftMap.put("draftTitle", draftVO.getDraftTitle());
		draftMap.put("draftContent", draftVO.getDraftContent());
		draftMap.put("userId", draftVO.getUserId());
		draftMap.put("userName", draftVO.getUserName());
		
		List<FileVO> files = reserveService.selectDraftFile(draftVO.getDraftNo());
		draftMap.put("files", files);
		
		return draftMap;
	}
	
	// 결재하기
	@GetMapping("/approveDraft.do")
	public String approveDraft(@RequestParam("resId") int resId) throws Exception {
		
		reserveService.updateReservationStatus(resId, 2);
		
		return "redirect:/approvalCheck.do";
	}
	
	// 첨부파일 다운로드
	@GetMapping("/api/downloadFile.do")
	public void downloadFile(HttpServletResponse res,
							 @RequestParam("fileNo") int fileNo
							 ) throws Exception {
		reserveService.fileDownload(res, fileNo);
	}
	
	
	
	/********** 유저 페이지 **********/
	
	// 메인페이지 (예약 캘린더)
	@GetMapping("/userCalendar.do")
	public String userCalendarForm() throws Exception {
		
		return "reserve/userCalendar";
	}
	
	// 예약 정보 입력 페이지
	@GetMapping("/requestReserve.do")
	public String requestForm(@RequestParam("resId") int resId,
							  HttpSession session,
		    				  Model model
		    				  ) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		
		int isReserved = reserveService.selectIsReserved(loginUser.getUserId(), resId);
		if (isReserved > 0) {
			model.addAttribute("isReserved", "isReserved");
		}
		
		int guestCount = reserveService.selectGuestsDayCount(resId); // 예약자 수
		ReserveVO resVO = reserveService.selectReservationInfo(resId); // 예약 정보
		
		// 최대 인원수와 현재 예약된 인원들 수가 같아지면 예약 불가
		if (guestCount >= resVO.getResMax()) {
			model.addAttribute("resInfo", resVO);
			model.addAttribute("maxReserve", "maxReserve");
			return "reserve/requestReserve";
		} else {
			model.addAttribute("resInfo", resVO);
			return "reserve/requestReserve";
		}		
	}
	
	// 예약 저장 기능
	@RequestMapping(value = "/saveSchedule.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertSchedule(@RequestBody Map<String, Object> requestData) throws Exception {
	    Map<String, Object> response = new HashMap<>();

	    try {
	        String result = reserveService.insertReserveRequest(requestData); // overMax, success, fail 값 중 하나 받아옴
	        
	        if (result.equals("overMax")) { // 인원 초과 시
	            response.put("success", false);
	            response.put("message", "예약 가능한 인원을 초과했습니다.");
	        } else { // 등록 성공
	            response.put("success", true);
	            response.put("message", "예약이 정상적으로 등록되었습니다.");
	        }
	    } catch (Exception e) { // 실패
	        e.printStackTrace();
	        LOGGER.error("등록 오류: " + e.getMessage());
	        response.put("success", false);
	        response.put("message", "예약 등록 중 오류가 발생했습니다: " + e.getMessage());
	    }

	    return response;
	}

	// 예약 정보 확인 페이지
	@GetMapping("/reserveList.do")
	public String reserveListForm(HttpSession session, Model model) throws Exception {
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		List<ReserveVO> reserveVOs = reserveService.selectReservedSchedules(loginUser.getUserId());
		
		model.addAttribute("reservedInfos", reserveVOs);
		
		return "reserve/reserveList";
	}
	
	// 엑셀 양식 다운로드
	@GetMapping("/fileDownload.do")
	public void fileDownload(HttpServletResponse res,
				 			 @RequestParam("fileName") String fileName
							 ) throws Exception {
		
	    reserveService.downloadFiles(res, fileName);
	}
	
	// 엑셀 업로드
	@RequestMapping(value = "/api/uploadFile.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> uploadFile(@RequestParam(value = "file", required = false) MultipartFile file) throws Exception {
	    Map<String, GuestsVO> guestInfo = UploadExcel.uploadExcel(file);

	    // 상태 코드와 데이터를 반환
	    Map<String, Object> result = new HashMap<>();
	    result.put("status", "success");
	    result.put("data", guestInfo);

	    return result;
	}

	// 예약 취소(삭제)
	@GetMapping("/cancelReservation.do")
	public String cancelReservation(@RequestParam("resId") int resId,
									@RequestParam("groupId") int groupId,
									HttpSession session,
									Model model
									) throws Exception {
		
		reserveService.cancelReservation(resId, groupId);
		
		UserVO loginUser = (UserVO) session.getAttribute("loginUser");
		List<ReserveVO> reserveVOs = reserveService.selectReservedSchedules(loginUser.getUserId());
		
		model.addAttribute("reservedInfos", reserveVOs);
		
		return "reserve/reserveList";
	}
}
