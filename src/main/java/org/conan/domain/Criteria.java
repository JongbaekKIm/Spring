package org.conan.domain;

import lombok.Data;
import lombok.ToString;
@Data
@ToString
public class Criteria {

	private int pageNum;// 페이지 번호
	private int amount;// 한 페이지에 출력되는 데이터 수

	private String type;
	private String keyword;

	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public void setPageNum(int pageNum) {
		if (pageNum <= 0) {
			this.pageNum = 1;
			return;
		}
		this.pageNum = pageNum;
	}

	public int getPageNum() {
		return this.pageNum;
	}

	public int getAmount() {
		return this.amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getPageStart() {
		return (this.pageNum - 1) * this.amount;
	}

	// 검색조건을 배열로 처리
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
}
