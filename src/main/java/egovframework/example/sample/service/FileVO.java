package egovframework.example.sample.service;

public class FileVO {
	private int fileNo;
	private String fileName;
	private String uploadName;
	private Long fileSize;
	private int draftNo;
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getUploadName() {
		return uploadName;
	}
	public void setUploadName(String uploadName) {
		this.uploadName = uploadName;
	}
	public Long getFileSize() {
		return fileSize;
	}
	public void setFileSize(Long fileSize) {
		this.fileSize = fileSize;
	}
	public int getDraftNo() {
		return draftNo;
	}
	public void setDraftNo(int draftNo) {
		this.draftNo = draftNo;
	}
	
	@Override
	public String toString() {
		return "FileVO [fileNo=" + fileNo + ", fileName=" + fileName + ", uploadName=" + uploadName + ", fileSize="
				+ fileSize + ", draftNo=" + draftNo + "]";
	}
}
