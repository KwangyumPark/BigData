package com.lec.customer_list;

/*
 * 20.12.18 고객 정보를 입력받아 가입한 정보를 콘솔(ArrayList)과 customer.txt파일에 출력
 */

public class Customer {
	
	private String name,phone,birth,address;
	
	public Customer() { }

	public Customer(String name, String phone, String birth, String address) {
		
		this.name = name;
		this.phone = phone;
		this.birth = birth;
		this.address = address;
		
	}// main

	@Override
	public String toString() {
		
		return name +"\t"+ phone + "\t"+ birth + "생\t"+ address + "\r\n";
	
	}// String
	
	
}// class
