package com.itbank.PLANWITH.model;

public class NaverBlogDTO {

	private String title;
	private String link;
	private String description;
	
	@Override
	public String toString() {
		return "title : " + title + ", link : " + link + ", description : " + description;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
}
