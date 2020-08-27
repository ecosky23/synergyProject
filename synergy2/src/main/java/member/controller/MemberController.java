package member.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import member.bean.MemberDTO;
import member.bean.TotalDTO;
import member.service.MemberService;
import net.sf.json.JSONArray;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private MemberDTO memberDTO;
	@Autowired
	private TotalDTO totalDTO;
	
	@RequestMapping(value="/all/loginForm",method= {RequestMethod.GET,RequestMethod.POST})
	public String loginForm() {
		return "/all/loginForm";
	}
	
	@RequestMapping(value="/all/signUpForm",method=RequestMethod.POST)
	public String signUpForm() {
		return "/all/signUpForm";
	}
	
	
	@RequestMapping(value="/member/welcome",method=RequestMethod.GET)
	public String welcome() {
		return "/member/welcome";
	}
	@ResponseBody
	@RequestMapping(value="/member/myPage",method=RequestMethod.POST)
	public ModelAndView myPage(@RequestParam String username, HttpServletRequest request, HttpSession session){
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		//System.out.println(username);
		
		memberDTO = memberService.getMyPage(map);
		//System.out.println(memberDTO.getUsername());
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberDTO", memberDTO);
		mav.setViewName("/member/myPage");
		
		return mav;
	}
	
	
	@RequestMapping(value="/admin/admin_index",method=RequestMethod.GET)
	public String admin_index() {
		return "/admin/admin_index";
	}
	
	@RequestMapping(value="/all/joinForm",method=RequestMethod.GET)
	public String joinForm() {
		return "/all/joinForm";
	}
	
	@RequestMapping(value="/all/join",method=RequestMethod.POST)
	public String join(@RequestParam Map<String, String> map) {
		
		memberService.join(map);
		return "redirect:/all/loginForm";
	}
	
	
	  @RequestMapping(value="/member/withdrawal",method=RequestMethod.POST) 
	  public String withdrawal(@RequestParam String username) {
	  
	  memberService.withdrawal(username);
	  
	  return "redirect:/all/loginForm"; 
	  }
	  
	  @RequestMapping(value="/member/revise",method=RequestMethod.POST) 
	  public String revise(@RequestParam String username, String password, String nickname) {
		  
	  System.out.println(username);
	  System.out.println(password);
	  System.out.println(nickname);
	  
		
	  
		 if(password == null || password == ""){ 
			 System.out.println(username);
			 System.out.println(password);
			 System.out.println(nickname);
			 
			 Map<String, String> map = new HashMap<String, String>();
		 	 map.put("username", username);
		 	 map.put("nickname", nickname);
		 	 
		 	 memberService.nicknameRevice(map);
		 	 
		 	 return "/member/welcome"; 
		 	 
		 }else{
	  
			  Map<String, String> map = new HashMap<String, String>();
			  map.put("username", username);
			  map.put("password", password);
			  map.put("nickname", nickname);
			  
			  memberService.revise(map);
			  
			  return "/member/welcome"; 
		 }
	  
	 
	  }
	  
		/*
		 * @RequestMapping(value="/admin/adminBoard2",method=RequestMethod.GET) public
		 * String adminBoard2() { return "/admin/adminBoard2"; }
		 */
	  
	  /*
		  @ResponseBody
		  @RequestMapping(value="/all/adminBoard",method=RequestMethod.GET) 
		  public ModelAndView adminBoard() {
		  
		  List<MemberDTO> list = memberService.getMember();
		  
		  ModelAndView mav = new ModelAndView(); 
		  mav.addObject("list", list);
		  
		  mav.setViewName("/all/adminBoard"); 
		  return mav;
		  
		  }
		*/
	  
	  @RequestMapping(value="/all/getAdminBoard",method=RequestMethod.GET) 
	  public String getAdminBoard(@RequestParam(value="searchOption", defaultValue = "null", required=false) String searchOption,
			  @RequestParam(value="keyword", defaultValue = "null", required=false) String keyword,
			  @RequestParam(value="nowpage", defaultValue = "0") int nowpage, Model model) {
		  
		  
		  int row =7;
		  
		  int startpoint = nowpage * row;

		  Map<String, Object> map = new HashMap<String, Object>();
		  map.put(searchOption, "%" + keyword + "%");
		  map.put("startpoint", startpoint);
		  map.put("row", row);
		 
		  List<MemberDTO> list = memberService.getSearchAdminBoard(map); 
		  
		  int totalList = memberService.getTotalCount(map);
		  
		  int totalpage  = totalList / row -1;
		  
		  if((totalList % row) > 0) totalpage++;
		  
		  
		  model.addAttribute("nowpage", nowpage); 
		  model.addAttribute("totalpage", totalpage); 
		  model.addAttribute("list", list);
		  
		  model.addAttribute("keyword", keyword);
		  model.addAttribute("searchOption", searchOption);
		  

		  return "/all/adminBoard";
		  
	  }
	  
	  @RequestMapping(value="/all/adminBoard",method=RequestMethod.GET) 
	  public String adminBoard() {
		  
		  
		  return "/all/adminBoard";
		  
	  }
	  
	  @RequestMapping(value="/all/adminStats",method=RequestMethod.GET) 
	  public String adminStats() {
		  
		  
			/*
			 * List<TotalDTO> list = memberService.getTotalStats();
			 * 
			 * System.out.println(list);
			 * 
			 * 
			 * 
			 * model.addAttribute("list", list);
			 */
		  
		  return "/all/adminStats";
		  
	  }
	  
	  @ResponseBody
	  @RequestMapping(value="/all/getAdminStats",method=RequestMethod.POST) 
	  public JSONArray getAdminStats() {
		  
		  
		List<TotalDTO> list =  memberService.getTotalStats();
		  
		
		JSONArray json = new JSONArray();
		json.addAll(list);
		
		return json;
		  
	  }
	  
	  
	  
	  
	    
	  
	  
	 
	  @RequestMapping(value="/all/memberDelete",method=RequestMethod.POST)
	  public String memberDelete(@RequestParam String username) {
			
		  System.out.println(username);
		  
			memberService.memberDelete(username);
			
			
			return "redirect:/all/adminBoard";
	  }
	
}

/*
 * @RequestMapping(value="/member/logout",method=RequestMethod.GET) public
 * String logout(HttpSession session) { session.invalidate();
 * 
 * return "/member/loginForm"; }
 */
/*
 * @ResponseBody
 * 
 * @RequestMapping(value="/member/login",method=RequestMethod.POST) public
 * String login(@RequestParam String id, @RequestParam String pwd, HttpSession
 * session) {
 * 
 * MemberDTO memberDTO = memberService.login(id, pwd); String result = "";
 * 
 * if(memberDTO != null) { result = "success"; session.setAttribute("memId",
 * memberDTO.getId());
 * 
 * }else { result = "fail"; }
 * 
 * return result; }
 */

/*
	  @RequestMapping(value="/all/getSearchAdminBoard",method=RequestMethod.GET) 
	  public String getSearchAdminBoard(@RequestParam(value="nowpage", defaultValue = "0") int nowpage, Model model, 
			  							String username, String nickname) {
		  
		  int row =3;
		  
		  List<MemberDTO> list = new ArrayList<>(); 
		  
		  Map<String, String> map = new HashMap<String, String>();
		  map.put("username", username);
		  map.put("nickname", nickname);
		  List<MemberDTO> temp = memberService.getSearchAdminBoard(map); 
		  
		  int totalpage = temp.size() / 3; if((list.size() % 3) > 0) totalpage++; 
		   
		  for(int i = nowpage * row; i < (nowpage * row) + row; i++) { 
			  list.add(temp.get(i)); 
		  }
		  
		  model.addAttribute("nowpage", nowpage); 
		  model.addAttribute("totalpage", totalpage); 
		  model.addAttribute("list", list);

		  return "/all/adminBoard";
		  
	  }
	  
 */