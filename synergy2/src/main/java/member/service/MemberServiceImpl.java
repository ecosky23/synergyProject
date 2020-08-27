package member.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import member.bean.MemberDTO;
import member.bean.TotalDTO;
import member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Override
	public MemberDTO login(String id, String pwd) {
		return memberDAO.login(id, pwd);
		
	}

	@Override
	public void join(Map<String, String> map) {
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
		map.put("auth", "ROLE_MEMBER");
		memberDAO.join(map);
		
	}

	@Override
	public void withdrawal(String username) {
		
		memberDAO.withdrawal(username);
		
	}

	@Override
	public MemberDTO getMyPage(Map<String, String> map) {
		
		return memberDAO.getMyPage(map);
	}

	@Override
	public void revise(Map<String, String> map) {
		
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
		
		memberDAO.revise(map);
		
	}

	@Override
	public void nicknameRevice(Map<String, String> map) {
		
		memberDAO.nicknameRevise(map);
		
	}

	@Override
	public List<MemberDTO> getMember() {
		
		return memberDAO.getMember();
	}

	@Override
	public void memberDelete(String username) {
		memberDAO.memberDelete(username);
		
	}

	@Override
	public List<MemberDTO> getBoardList() {
		
		return memberDAO.getBoardList();
	}

	@Override
	public List<MemberDTO> getSearchAdminBoard(Map<String,Object> map) {
		
		
		
		return memberDAO.getSearchAdminBoard(map);
	}

	@Override
	public int getTotalCount(Map<String,Object> map) {
		
		return memberDAO.getTotalCount(map);
	}

	@Override
	public List<TotalDTO> getTotalStats() {
		
		return memberDAO.getTotalStats();
	}


	
	

}
