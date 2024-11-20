package com.itbank.PLANWITH.model;

public class NaverImageDTO {

	private String title;
	private String link;
	private String thumbnail;
	private String sizeheight;
	private String sizewidth;
	
	@Override
	public String toString() {
		return "title : "  + title + ", link : " + link + ", thumbnail : " + thumbnail + ", sizeheight : " + sizeheight + ", sizewidth : " + sizewidth;
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
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getSizeheight() {
		return sizeheight;
	}
	public void setSizeheight(String sizeheight) {
		this.sizeheight = sizeheight;
	}
	public String getSizewidth() {
		return sizewidth;
	}
	public void setSizewidth(String sizewidth) {
		this.sizewidth = sizewidth;
	}
}
