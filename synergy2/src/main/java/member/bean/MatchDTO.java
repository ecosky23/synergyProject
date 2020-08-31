package member.bean;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class MatchDTO {
	
	private String username;
	private int mycareer;
	private Double x;
	private Double y;
	private Double range;
	private String time1;
	private String time2;
	private String time3;
	private String topic1;
	private String topic2;
	private String topic3;
	private int career;
	private int people;
	private Date created;
	private boolean visited;
	//people 규칙
	//0 : 무관
	//3 : 3명
	//4 : 4~6명
	//7 : 7~9명
	//10 : 10명 이상

	
//	@Override
//	public String toString() {
//		return visited + " " +username+" "+mycareer+" "+x+" "+y+" "+range+" "+time1+" "+time2+" "+time3+" "+topic1+" "+topic2+" "+topic3+" "+career+" "+people + " " + created;
//	}
}
