package com.rivetlogic.csvtemplatemailer.util;

import java.io.Serializable;

public class FileColumn implements Serializable {
	private static final long serialVersionUID = 4528814658816537739L;
	
	private int id;
	private String name;
	private Boolean use;
	private Boolean isEmail;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Boolean getUse() {
		return use;
	}
	
	public void setUse(Boolean use) {
		this.use = use;
	}
	
	public Boolean getIsEmail() {
		return isEmail;
	}
	
	public void setIsEmail(Boolean isEmail) {
		this.isEmail = isEmail;
	}
}
