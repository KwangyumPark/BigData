package com.lec.ex01store;

public class TestMain 
{
	
	public static void main(String[] args) // new HeadQuarterStore("== 본사 ==")
	{
		HeadQuarterStore[] store = 
			{
				new StoreNum1("== 주택가 1호점 =="),
				new StoreNum2("== 대학가 2호점 =="),
				new StoreNum3("== 증권가 3호점 ==")
			};
		
		for(HeadQuarterStore s : store) 
		{
			System.out.println(s.getName());
			s.kimchi();
			s.bude();
			s.bibib();
			s.sunde();
			s.gonggibab();
		}

	}
	
}
