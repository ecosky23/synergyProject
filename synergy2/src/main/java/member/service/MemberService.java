package member.service;



import java.util.List;
import java.util.Map;

import member.bean.MatchDTO;
import member.bean.MemberDTO;
import member.bean.ProgrammingDTO;
import member.bean.TotalDTO;

public interface MemberService {

	public MemberDTO login(String id, String pwd);

	public void join(Map<String, String> map);

	public void withdrawal(String username);

	public MemberDTO getMyPage(Map<String, String> map);

	public void revise(Map<String, String> map);

	public void nicknameRevice(Map<String, String> map);

	public List<MemberDTO> getMember();

	public void memberDelete(String username);

	public List<MemberDTO> getBoardList();

	public List<MemberDTO> getSearchAdminBoard(Map<String, Object> map);

	public int getTotalCount(Map<String, Object> map);

	public List<TotalDTO> getTotalStats();

	public List<ProgrammingDTO> getProgrammingStats();

	public List<MatchDTO> getListFromMatch();

	

	

	

	
}
