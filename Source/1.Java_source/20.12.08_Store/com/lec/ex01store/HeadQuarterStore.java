package com.lec.ex01store;

/*
 * 12.08 �������� 1.
 * �߻� Ŭ������ �̿��Ͽ� 3���� ���� ���� �޴��� ������ ���� ������ �� �ֵ��� ���α׷��� �ۼ�.
 */

public abstract class HeadQuarterStore 
{
	
	private String name;
	
	public HeadQuarterStore(String name) 
	{
		this.name = name;
	}
	
	public abstract void kimchi() ; // �߻�(abstract) �޼ҵ�
	
	public abstract void bude();
	
	public abstract void bibib();
	
	public abstract void sunde();
	
	public abstract void gonggibab();
	
	public String getName() 
	{
		return name;
	}

}