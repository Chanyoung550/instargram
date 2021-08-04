package org.zerock.instardto;

import lombok.Data;

@Data
public class CommentVO {
	private int cno;
	private int pno;
	private String comment_user;
	private String comment_content;
	private String comment_date;
}
