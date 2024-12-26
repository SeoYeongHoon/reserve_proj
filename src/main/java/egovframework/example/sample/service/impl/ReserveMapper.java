package egovframework.example.sample.service.impl;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import egovframework.example.sample.service.DraftVO;
import egovframework.example.sample.service.EventVO;
import egovframework.example.sample.service.FileVO;
import egovframework.example.sample.service.GuestsVO;
import egovframework.example.sample.service.LineVO;
import egovframework.example.sample.service.ReserveVO;
import egovframework.example.sample.service.UserSearchVO;
import egovframework.example.sample.service.UserVO;
import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("reserveMapper")
public interface ReserveMapper {
	// 예약 출력(관리자)
	List<ReserveVO> selectReservations(@Param("startDate") String startDate, @Param("endDate") String endDate, @Param("eventNo") int eventNo) throws Exception;

	// 예약 생성(관리자)
	void insertReserve(ReserveVO resVO) throws Exception;

	// 예약 전체 생성(관리자)
	void insertReserveAll(@Param("reservations") List<ReserveVO> reservations) throws Exception;

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
	
	// 예약 인원 조회(관리자)
	List<ReserveVO> selectReservedUserInfo(int resId) throws Exception;

	// 예약한 그룹 삭제(관리자)
	void deleteGroup(int groupId) throws Exception;
	
	// 예약 대표자 저장(예약자)
	void insertRepresenter(ReserveVO reserveVO) throws Exception;
	
	// 예약 일행 저장(예약자)
	void insertGuests(GuestsVO guestsVO) throws Exception;
	
	// 예약 확인 리스트(예약자)
	List<ReserveVO> selectReservedSchedules(String userId) throws Exception;
	
	// 예약 항목 당 예약자 수
	int selectReservedGuestsCount(int groupId) throws Exception;
	
	// 예약 리스트의 예약정보
	List<GuestsVO> selectReservedGuests(int groupId) throws Exception;
	
	// 예약한 대표자의 groupId값 가져오기
	int selectGroupIdByUserId(@Param("resId") int resId, @Param("userId") String userId) throws Exception;
	
	// 이미 예약한 날짜에 입장했을 때 처리를 위한 개수
	int selectIsReserved(@Param("userId") String userId, @Param("resId") int resId) throws Exception;
	
	// 예약 취소(예약자)
	void cancelReservation(int resId) throws Exception;
	void deleteGuests(int groupId) throws Exception;

	// 예약 수정(관리자)
	void updateReservation(@Param("resMax") int resMax, @Param("resId") int resId);
	
	// 결재라인 명단 리스트
	List<UserVO> selectEmployeeList(UserSearchVO searchVO) throws Exception;
	
	// 결재라인 명단 수
	int selectEmployeeCount(UserSearchVO searchVO) throws Exception;

	// 결재라인 저장
	void insertLineInfo(LineVO lineVO) throws Exception;
	// 결재자 저장
	void insertLineMemberInfo(LineVO approveVO) throws Exception;
	// 결재라인 출력
	List<LineVO> selectLineList(String userId) throws Exception;
	// 결재라인 멤버 출력
	List<LineVO> selectMemberList(String userId) throws Exception;

	// 결재라인 수정
	void updateLineInfo(LineVO lineVO) throws Exception;

	void deleteLineInfo(int parseInt) throws Exception;
	
	// 결재 라인 정보 삭제
	void deleteLineMember(int parseInt) throws Exception;

	// 결재라인 요청(글 저장)
	void insertDraft(DraftVO draftVO);

	// 결재 라인 요청(저장)
	void insertDraftRequests(DraftVO requestedDraft);

	// 예약 마감 상태 업데이트
	void updateReservationStatus(@Param("resId") int resId, @Param("isRequested") int isRequested);
	
	// 예약 삭제(관리자)
	void deleteReserve(int resId) throws Exception;
	void deleteGroupByResId(int resId) throws Exception;
	void deleteGuestsByResId(int resId) throws Exception;
	
	// 결재 확인 리스트
	List<DraftVO> selectApprovalList(String userId) throws Exception;
	
	// 결재자인지 확인
	DraftVO selectIsApprover(@Param("resId") int resId, @Param("userId") String userId) throws Exception;

	// 파일 업로드
	void insertFiles(FileVO fileVO) throws Exception;
	
	// 결재할 기안문 상세조회
	DraftVO selectDraftDetails(String userId) throws Exception;
	
	// 기안문 파일조회
	List<FileVO> selectDraftFile(int draftNo) throws Exception;

	// 기안문 파일 다운로드 위한 파일이름(encoding) 조회
	String findUploadNameByFileNo(int fileNo) throws Exception;
	// 기안문 파일 다운로드 위한 파일이름 조회
	String findFileNameByFileNo(int fileNo) throws Exception;

	// 이벤트 생성
	void createEvent(EventVO eventVO) throws Exception;
	// 이벤트 리스트 조회
	List<EventVO> selectEventList() throws Exception;
	// 이벤트 삭제
	void deleteEvent(int eventNo) throws Exception;

	// 이벤트 시간 조회
	int selectEventTimeByEventNo(Integer eventNo) throws Exception;
}
