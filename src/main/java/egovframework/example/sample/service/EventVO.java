package egovframework.example.sample.service;

public class EventVO {
	private int eventNo;
	private String eventTitle;
	private Integer eventTime;
	
	public int getEventNo() {
		return eventNo;
	}
	public void setEventNo(int eventNo) {
		this.eventNo = eventNo;
	}
	public String getEventTitle() {
		return eventTitle;
	}
	public void setEventTitle(String eventTitle) {
		this.eventTitle = eventTitle;
	}
	public Integer getEventTime() {
		return eventTime;
	}
	public void setEventTime(Integer eventTime) {
		this.eventTime = eventTime;
	}
	
	@Override
	public String toString() {
		return "EventVO [eventNo=" + eventNo + ", eventTitle=" + eventTitle + ", eventTime=" + eventTime + "]";
	}
}
