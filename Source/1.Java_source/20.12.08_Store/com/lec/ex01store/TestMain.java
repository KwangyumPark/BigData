package com.lec.ex01store;

public class TestMain 
{
	
	public static void main(String[] args) // new HeadQuarterStore("== ���� ==")
	{
		HeadQuarterStore[] store = 
			{
				new StoreNum1("== ���ð� 1ȣ�� =="),
				new StoreNum2("== ���а� 2ȣ�� =="),
				new StoreNum3("== ���ǰ� 3ȣ�� ==")
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