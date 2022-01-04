package org.conan.service;

import java.util.List;

import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.domain.ReplyPageDTO;

public interface BoardService {
	public void register(BoardVO board);

	public BoardVO get(Long bno);

	public boolean modify(BoardVO board);

	public boolean remove(long bno);

	public List<BoardVO> getList();

	public List<BoardVO> getList(Criteria cri);

	public List<BoardVO> getListWithPaging(Criteria cri);

	public int getTotal(Criteria cri);

}
