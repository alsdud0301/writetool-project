package ccomment;

public class Comment {
	private int freeID;

	private int commentID;
	private String userID;
	private String commentDate;
	private String commentText;
	private int cAvailable;
	private int number;
	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public int getFreeID() {
		return freeID;
	}
	public void setFreeID(int freeID) {
		this.freeID = freeID;
	}
	
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(String commentDate) {
		this.commentDate = commentDate;
	}
	public String getCommentText() {
		return commentText;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public int getcAvailable() {
		return cAvailable;
	}
	public void setcAvailable(int cAvailable) {
		this.cAvailable = cAvailable;
	}
	
}
