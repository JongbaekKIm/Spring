package org.conan.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.conan.domain.BoardVO;

public interface BoardMapper {
	/* @Select("select * from tbl_board where BNO>0") */
public List<BoardVO> getList();
}
