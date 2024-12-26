package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

public interface ReserveService {
	// 예약 출력(관리자)
	List<ReserveVO> selectReservations(String year, String month, int eventNo) throws Exception;

	// 예약 생성(관리자)
	void insertReserve(String date, String time, String title, Integer maxCount, Integer eventNo, HttpSession session) throws Exception;

	// 예약 전체 생성(관리자)
	void insertReserveAll(String date, String time, String title, Integer maxCount, Integer eventNo) throws Exception;

	// 예약 조회(관리자)
	ReserveVO selectReservationInfo(int resId) throws Exception;
	
	// 각 날에 있는 최대 예약 수(관리자)
	int selectReservationCount(int resId) throws Exception;
	
	// 각 예약 당 대표자 수(관리자)
	int selectReservedCount(int resId) throws Exception;
	// 각 예약 당 일행 수(관리자)
	int selectGuestsDayCount(int resId) throws Exception;
	
	// 예약한 대표 인원 조회(관리자)
	List<ReserveVO> selectRepresentUser(int resId) throws Exception;
	
	// 대표자 제외 예약 인원 조회(관리자)
	List<ReserveVO> selectReservedUserInfo(int groupId) throws Exception;

	// 예약한 그룹 삭제(관리자)
	void deleteGroup(int groupId) throws Exception;
	
	// 예약 저장(예약자)
	// void insertRepresenter(String repUserInfo, List<String> guestList) throws Exception;

	// 예약 저장(예약자)
	String insertReserveRequest(Map<String, Object> requestData) throws Exception;
	
	// 예약 확인 리스트(예약자)
	List<ReserveVO> selectReservedSchedules(String userId) throws Exception;
	
	// 예약 항목 당 예약자 수
	int selectReservedGuestsCount(int groupId) throws Exception;
	
	// 예약 리스트의 예약정보
	List<GuestsVO> selectReservedGuests(int groupId) throws Exception;
	
	// 예약한 대표자의 groupId값 가져오기
	int selectGroupIdByUserId(int resId, String userId) throws Exception;

	// 엑셀 양식 다운로드
	void downloadFiles(HttpServletResponse res, String fileName);
	
	// 이미 예약한 날짜에 입장했을 때 처리를 위한 개수
	int selectIsReserved(@Param("userId") String userId, @Param("resId") int resId) throws Exception;

	// 예약 취소
	void cancelReservation(int resId, int groupId) throws Exception;

	// 예약 수정(관리자)
	void updateReservation(int resMax, int resId);
	
	// 결재라인 명단 리스트
	List<UserVO> selectEmployeeList(UserSearchVO searchVO) throws Exception;
	
	// 결재라인 명단 수
	int selectEmployeeCount(UserSearchVO searchVO) throws Exception;

	// 결재라인 저장
	void insertSaveLineMember(Map<String, Object> saveObject, UserVO loginUser, String lineDate) throws Exception;
	// 결재라인 수정
	void updateSaveLineMember(Map<String, Object> saveObject, UserVO loginUser, String lineDate) throws Exception;
	
	// 결재라인 출력
	List<LineVO> selectLineList(String userId) throws Exception;
	// 결재라인 멤버 출력
	List<LineVO> selectMemberList(String userId) throws Exception;

	// 결재라인 삭제
	void deleteLineMember(int lineNo) throws Exception;

	// 결재라인 요청
	void insertDraftData(Map<String, Object> draftInfo, HttpSession session) throws Exception;
	
	// 예약 마감 상태 업데이트
	void updateReservationStatus(@Param("resId") int resId, @Param("isRequested") int isRequested);

	// 예약 삭제(관리자)
	void deleteReserve(int resId) throws Exception;

	// 결재 확인 리스트
	List<DraftVO> selectApprovalList(String userId) throws Exception;

	// 결재자인지 확인
	DraftVO selectIsApprover(int resId, String userId) throws Exception;

	// 파일 테스트
	void insertDraftForm(String draftData, String lineData, List<MultipartFile> fileList, HttpSession session) throws Exception;
	
	// 결재할 기안문 상세조회
	DraftVO selectDraftDetails(String userId) throws Exception;
	
	// 기안문 파일조회
	List<FileVO> selectDraftFile(int draftNo) throws Exception;

	// 기안문 파일 다운로드
	void fileDownload(HttpServletResponse res, int fileNo) throws Exception;

	// 이벤트 생성
	void createEvent(EventVO eventVO) throws Exception;
	// 이벤트 리스트 조회
	List<EventVO> selectEventList() throws Exception;
	// 이벤트 삭제
	void deleteEvent(int eventNo) throws Exception;
}
