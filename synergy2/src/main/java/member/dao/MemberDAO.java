package member.dao;

import java.util.List;
import java.util.Map;


import member.bean.MemberDTO;
import member.bean.ProgrammingDTO;
import member.bean.TotalDTO;

public interface MemberDAO {
	

	public abstract MemberDTO login(String id, String pwd);

	public abstract void join(Map<String, String> map);

	public abstract void withdrawal(String username);

	public abstract MemberDTO getMyPage(Map<String, String> map);

	public abstract void revise(Map<String, String> map);

	public abstract void nicknameRevise(Map<String, String> map);

	public abstract List<MemberDTO> getMember();

	public abstract void memberDelete(String username);

	public abstract List<MemberDTO> getBoardList();

	public abstract List<MemberDTO> getSearchAdminBoard(Map<String, Object> map);

	public abstract int getTotalCount(Map<String,Object> map);

	public abstract List<TotalDTO> getTotalStats();

	public abstract List<ProgrammingDTO> getProgrammingStats();


}
