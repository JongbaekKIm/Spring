package org.conan.service;

import java.util.List;

import org.conan.domain.BoardAttachVO;
import org.conan.domain.BoardVO;
import org.conan.domain.Criteria;
import org.conan.mapper.BoardAttachMapper;
import org.conan.mapper.BoardMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	/* @Setter(onMethod_=@Autowired) == @AllArgsConstructor */
	private BoardMapper mapper;
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {
		/*
		 * log.info("register...." + board.getBno()); mapper.insert(board);
		 */
		log.info("register...." + board.getBno());
		mapper.insertSelectKey(board);
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			log.info("123123123123123");
			return;
		}
		board.getAttachList().forEach(attach -> {
			log.info("123123");
			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get...." + bno);
		return mapper.read(bno);
	}
	
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		attachMapper.deleteAll(board.getBno());
		boolean modifyResult = mapper.update(board)==1;
		if(modifyResult && board.getAttachList()!=null && board.getAttachList().size()>0) {
			board.getAttachList().forEach(attach->{
				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(long bno) {
		log.info("remove...." + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList....................?");
		return mapper.getList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		log.info("getList with criteria : " + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
	
	@Transactional
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		log.info("get Attach list by bno"+bno);
		return attachMapper.findByBno(bno);
		// TODO Auto-generated method stub
	}
	


}
