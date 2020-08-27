package member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


import member.bean.MemberDTO;
import member.bean.TotalDTO;
@Repository
@Transactional
public class MemberDAOMybatis implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	

	@Override
	public MemberDTO login(String id, String pwd) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pwd", pwd);
		
		return sqlSession.selectOne("memberSQL.login", map);
	}


	@Override
	public void join(Map<String, String> map) {
		sqlSession.insert("memberSQL.join", map);
		
	}


	@Override
	public void withdrawal(String username) {
		sqlSession.delete("memberSQL.withdrawal", username);
		
	}


	@Override
	public MemberDTO getMyPage(Map<String, String> map) {
		
		return sqlSession.selectOne("memberSQL.getMyPage", map);
	}


	@Override
	public void revise(Map<String, String> map) {

		sqlSession.update("memberSQL.revise", map);
		
		
	}


	@Override
	public void nicknameRevise(Map<String, String> map) {
		
		sqlSession.update("memberSQL.nicknameRevise", map);
		
	}


	@Override
	public List<MemberDTO> getMember() {
		
		return sqlSession.selectList("memberSQL.getMember");
	}


	@Override
	public void memberDelete(String username) {
		
		sqlSession.delete("memberSQL.memberDelete", username);
		
	}


	@Override
	public List<MemberDTO> getBoardList() {
		
		return sqlSession.selectList("memberSQL.getBoardList");
	}


	@Override
	public List<MemberDTO> getSearchAdminBoard(Map<String, Object> map) {
		
		return sqlSession.selectList("memberSQL.getSearchAdminBoard", map);
	}


	@Override
	public int getTotalCount(Map<String,Object> map) {
		
		return sqlSession.selectOne("memberSQL.getTotalCount", map);
	}


	@Override
	public List<TotalDTO> getTotalStats() {
		
		return sqlSession.selectList("memberSQL.getTotalStats");
	}




	

}