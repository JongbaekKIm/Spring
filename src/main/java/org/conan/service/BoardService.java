package org.conan.service;

import java.util.List;

import org.conan.domain.BoardVO;

public interface BoardService {
	public void register(BoardVO board);

	public BoardVO get(Long bno);

	public boolean modify(BoardVO board);

	public boolean remove(long bno);

	public List<BoardVO> getList();

}