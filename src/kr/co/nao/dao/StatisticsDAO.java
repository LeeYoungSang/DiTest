package kr.co.nao.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.sun.corba.se.spi.orbutil.fsm.GuardBase;

public class StatisticsDAO extends CommonDAO {

	public ArrayList<Map<String, Object>> getStatisticsList(String id) {
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		String sql = 
			"		select * from tb_schedule "
			+ "	where		isDel = 'N' "
			+ "	and				id = ? ";
//			+ "	order by schedule_date desc, schedule_start_time desc "
//			+ "	limit			?, 10 ";
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			con = ds.getConnection();
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				Map<String, Object> ad = new HashMap<String, Object>();
//				ad.put("num", 							rs.getInt("num"));
//				ad.put("schedule_date", 			rs.getDate("schedule_date"));
//				ad.put("schedule_start_time",	rs.getInt("schedule_start_time"));
//				ad.put("machine_num", 			rs.getString("machine_num"));
//				ad.put("contents_num", 			rs.getInt("contents_num"));
				
				list.add(ad);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return list;
	}
	
	/**
	 * 일일 통계 리스트 
	 * 
	 * @author	이영상
	 * @since		2020.08.19
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.19			이영상				최초생성
	 */
	
	public ArrayList<Map<String, Object>> getStatisticsDayList(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		StringBuffer sb = new StringBuffer();
		
		Map<String, Object> param = paramList.get(0);

		System.out.println("param pn:"+param.get("pn"));
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param type:"+param.get("type"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		int pn = Integer.parseInt(String.valueOf(param.get("pn")));
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String type = (String) param.get("type");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		/*
			param.put("pn", pageNum);					//페이지번호
			param.put("id", (String)member.get("id"));  //Login ID
			param.put("division", (String)member.get("division"));  //division
			param.put("preDate", preDate);				//검색 시작일자
			param.put("selADT", selADT );				//광고주
			param.put("type", type );					//광고주 select태그
			param.put("selAdKind", selAdKind );			//광고종류
			param.put("selMc", selMc );					//머신
		*/
		
		sb.append("SELECT															\n");
		sb.append("				A.ST_CONT_NUM										\n");
		sb.append("			   ,A.ST_MAC_NUM										\n");
		sb.append("			   ,A.ST_MONTH											\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY			\n");
		sb.append("			   ,A.ST_HOUR											\n");
		sb.append("			   ,A.ST_NUM_OF_ADS										\n");
		sb.append("			   ,A.ST_SP_YN											\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_DAY LIKE  	'%"+preDate+"%'							\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null ) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
			System.out.println("getStatisticsDayList: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("CONT_NUM", 					rs.getInt("ST_CONT_NUM"));
				ad.put("MAC_NUM", 					rs.getString("ST_MAC_NUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("HOUR", 						rs.getString("ST_HOUR"));
				ad.put("ADS_CNT", 					rs.getInt("ST_NUM_OF_ADS"));
				ad.put("SP_YN", 					rs.getString("ST_SP_YN"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				
				list.add(ad);	
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return list;
	}

	
	/**	현재사용안함
	 * 일일 통계 그래프  ajax data
	 * 
	 * @author	이영상
	 * @since		2020.08.19
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.19			이영상				최초생성
	 */

/*
	public String getStatisticsDayListJson2(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		String returnResult = "";
		int cnt = 0;

		Map<String, Object> param = paramList.get(0);

		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT															\n");
		sb.append("				A.ST_CONT_NUM										\n");
		sb.append("			   ,A.ST_MAC_NUM										\n");
		sb.append("			   ,A.ST_MONTH											\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY			\n");
		sb.append("			   ,A.ST_HOUR											\n");
		sb.append("			   ,A.ST_NUM_OF_ADS										\n");
		sb.append("			   ,A.ST_SP_YN											\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("			   ,(SELECT COUNT(*)									\n");
		sb.append("			       FROM tb_statistics AA							\n");
		sb.append("			   		   ,tb_contents   BB							\n");
		sb.append("			   		   ,tb_machine    CC							\n");
		sb.append("			   	  WHERE												\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num			\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("			   	  	AND AA.ST_CONT_NUM = A.ST_CONT_NUM				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = A.ST_MAC_NUM				\n");
		sb.append("			   	  	AND AA.ST_DAY 	   = A.ST_DAY					\n");
		sb.append("			     ) AS ROW_CNT										\n");
		sb.append("			   ,(SELECT COUNT(*)									\n");
		sb.append("			       FROM tb_statistics AA							\n");
		sb.append("			   		   ,tb_contents   BB							\n");
		sb.append("			   		   ,tb_machine    CC							\n");
		sb.append("			   	  WHERE												\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num			\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("  				AND AA.ST_DAY LIKE  '%"+preDate+"%'				\n");
		sb.append("			     ) AS TT_CNT										\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_DAY LIKE  	'%"+preDate+"%'							\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT)) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			JSONObject result = new JSONObject();
			JSONArray bodyArray = new JSONArray();
			
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
			System.out.println("getStatisticsDayListJson: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("CONT_NUM", 					rs.getInt("ST_CONT_NUM"));
				ad.put("MAC_NUM", 					rs.getString("ST_MAC_NUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("HOUR", 						rs.getString("ST_HOUR"));
				ad.put("ADS_CNT", 					rs.getInt("ST_NUM_OF_ADS"));
				ad.put("SP_YN", 					rs.getString("ST_SP_YN"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				ad.put("ROW_CNT", 					rs.getInt("ROW_CNT"));
				ad.put("TT_CNT", 					rs.getInt("TT_CNT"));
				
				list.add(ad);	
				
				++cnt;
				
				//list 가 있을때만 적용
				if(list !=null && list.size()>0) 
				{	
					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					// 1. list.Size()와 배열로 묶을 데이터행의 갯수(ROW_CNT)가 같아질 때, 현재 ArrayList 내 데이터 를 JSON형태 (key: dayList) 로 변환 후 JsonArray에 세팅한다. //
					// 2. JsonArray에 세팅할 때마다 ArrayList를 초기화 해준다.																			  //
					// 3. cnt( 전체 반복 횟수) 와  DB내 조회한 쿼리 의 레코드 수(TT_CNT)가 같을 때 JSONArray 에 쌓아온 데이터를 JSON형태로 크게 묶는다  						  //
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					if(list.size() == rs.getInt("ROW_CNT")) 
					{
						JSONObject json2 = new JSONObject();
						
						//같은 메모리를 바라보지않기위해 clone 생성
						ArrayList<Map<String, Object>> arr = (ArrayList<Map<String, Object>>)list.clone();
						json2.put("dayList", arr);
						
						System.out.println("dayList:"+list.get(0).get("CONT_NUM"));
						System.out.println("daytList2:"+json2.toString()  );
						
						bodyArray.add(json2);
						
						String bodyChk = bodyArray.toJSONString();
						System.out.println("bodyChk:"+bodyArray);
						
						if(cnt == rs.getInt("TT_CNT") ) 
						{
							result.put("body", bodyArray);
							System.out.println("result:"+result.toJSONString());
							returnResult = result.toJSONString();
						}
						//list 초기화
						list.clear();
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return returnResult;
	}
*/
	
	/**
	 * 일일 통계 그래프  ajax data
	 * 
	 * @author	이영상
	 * @since		2020.08.19
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.19			이영상				최초생성
	 */
	
	public JSONObject getStatisticsDayListJson(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		JSONObject jsonObject = new JSONObject();
		
		String returnResult = "";
		int cnt = 0;

		Map<String, Object> param = paramList.get(0);

		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT															\n");
		sb.append("				A.ST_CONT_NUM										\n");
		sb.append("			   ,A.ST_MAC_NUM										\n");
		sb.append("			   ,A.ST_MONTH											\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY			\n");
		sb.append("			   ,A.ST_HOUR											\n");
		sb.append("			   ,A.ST_NUM_OF_ADS										\n");
		sb.append("			   ,A.ST_SP_YN											\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("			   ,(SELECT COUNT(*)									\n");
		sb.append("			       FROM tb_statistics AA							\n");
		sb.append("			   		   ,tb_contents   BB							\n");
		sb.append("			   		   ,tb_machine    CC							\n");
		sb.append("			   	  WHERE												\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num			\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("			   	  	AND AA.ST_CONT_NUM = A.ST_CONT_NUM				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = A.ST_MAC_NUM				\n");
		sb.append("			   	  	AND AA.ST_DAY 	   = A.ST_DAY					\n");
		if(!"".equals(selADT) && selADT !=null  ) 
		{
			sb.append("			   	  	AND BB.advertiser_num  = B.advertiser_num		\n");
		}
		sb.append("			     ) AS ROW_CNT										\n");
		sb.append("			   ,(SELECT COUNT(*)									\n");
		sb.append("			       FROM tb_statistics AA							\n");
		sb.append("			   		   ,tb_contents   BB							\n");
		sb.append("			   		   ,tb_machine    CC							\n");
		sb.append("			   	  WHERE												\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num			\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num				\n");
		sb.append("			   	  	AND AA.ST_DAY 	   = A.ST_DAY					\n");
		if(!"".equals(selADT) && selADT !=null  ) 
		{
			sb.append("			   	  	AND BB.advertiser_num  = B.advertiser_num		\n");
		}
		sb.append("			     ) AS TT_CNT										\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_DAY LIKE  	'%"+preDate+"%'							\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null  ) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		//if(!"".equals(selAdKind) || selAdKind != null)
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		//if(!"".equals(selMc)  || selMc != null )
		if(!"".equals(selMc) )
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			JSONObject result = new JSONObject();
			JSONArray bodyArray = new JSONArray();
			
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
			System.out.println("getStatisticsDayListJson: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("CONT_NUM", 					rs.getInt("ST_CONT_NUM"));
				ad.put("MAC_NUM", 					rs.getString("ST_MAC_NUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("HOUR", 						rs.getString("ST_HOUR"));
				ad.put("ADS_CNT", 					rs.getInt("ST_NUM_OF_ADS"));
				ad.put("SP_YN", 					rs.getString("ST_SP_YN"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				ad.put("ROW_CNT", 					rs.getInt("ROW_CNT"));
				ad.put("TT_CNT", 					rs.getInt("TT_CNT"));
				
				list.add(ad);	
				
				++cnt;
				
				//list 가 있을때만 적용
				if(list !=null && list.size()>0) 
				{	
					//System.out.println("listSize():"+list.size());
					
					/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					// 1. list.Size()와 배열로 묶을 데이터행의 갯수(ROW_CNT)가 같아질 때, 현재 ArrayList 내 데이터 를 JSON형태 (key: dayList) 로 변환 후 JsonArray에 세팅한다. //
					// 2. JsonArray에 세팅할 때마다 ArrayList를 초기화 해준다.																			  //
					// 3. cnt( 전체 반복 횟수) 와  DB내 조회한 쿼리 의 레코드 수(TT_CNT)가 같을 때 JSONArray 에 쌓아온 데이터를 JSON형태로 크게 묶는다  						  //
					////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
					if(list.size() == rs.getInt("ROW_CNT")) 
					{
						JSONObject json2 = new JSONObject();
						
						//같은 메모리를 바라보지않기위해 clone 생성
						ArrayList<Map<String, Object>> arr = (ArrayList<Map<String, Object>>)list.clone();
						json2.put("dayList", arr);
						
						System.out.println("dayList:"+list.get(0).get("CONT_NUM"));
						System.out.println("daytList2:"+json2.toString()  );
						
						bodyArray.add(json2);
						
						String bodyChk = bodyArray.toJSONString();
						System.out.println("bodyChk:"+bodyArray);
						
						if(cnt == rs.getInt("TT_CNT") ) 
						{
							result.put("body", bodyArray);
							System.out.println("result:"+result.toJSONString());
							returnResult = result.toJSONString();
							
							JSONParser jsonParser = new JSONParser();
							jsonObject = (JSONObject)jsonParser.parse(returnResult);
						}
						//list 초기화
						list.clear();
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return jsonObject;
	}
	
	/**
	 * Json parsing
	 * 
	 * @author	이영상
	 * @since		2020.08.19
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.19			이영상				최초생성
	 */
	public int jsonInsert() 
	{
		int result = 0;
		
		StringBuffer sb = new StringBuffer();
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		/*//마카노차야 데이터
		String jsonData = "{\"RSP_WORD\":\"RSP DAILY STATISTICS LIST\",\"BODY\":"
				+"[{\"MAC_NUM\":\"2020-01-13-002\",\"CONT_NUM\":\"1\","
				+"\"RSP STT LIST\":"
					 +"[{\"HOUR\":\"00\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"  
					 +"{\"HOUR\":\"01\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"02\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"03\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"04\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"05\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"06\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"07\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"08\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"09\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"10\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"11\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"12\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"13\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"5\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"14\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"15\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"16\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"17\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"18\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"5\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"19\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"20\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"21\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"22\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"23\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"}]"
//					 +"{\"HOUR\":\"24\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"}]"
				+"}"
		*/		
			//emart 데이터
		String jsonData = "{\"RSP_WORD\":\"RSP DAILY STATISTICS LIST\",\"BODY\":"
				+"[{\"MAC_NUM\":\"2020-01-22-001\",\"CONT_NUM\":\"31\","
				+"\"RSP STT LIST\":"
					 +"[{\"HOUR\":\"00\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"5\",\"SP_YN\":\"N\"},"  
					 +"{\"HOUR\":\"01\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"7\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"02\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"03\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"04\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"05\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"06\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"4\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"07\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"11\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"08\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"18\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"09\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"17\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"10\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"15\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"11\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"12\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"2\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"13\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"1\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"14\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"12\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"15\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"13\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"16\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"17\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"18\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"19\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"19\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"20\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"19\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"21\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"3\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"22\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"1\",\"SP_YN\":\"N\"},"
					 +"{\"HOUR\":\"23\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"1\",\"SP_YN\":\"N\"}]"
//					 +"{\"HOUR\":\"24\",\"DAY\":\"2020-08-19\",\"MONTH\":\"08\",\"NUM_OF_ADS\":\"0\",\"SP_YN\":\"N\"}]"
				+"}"		
				
			+ "]}";
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject;
		
		
		try 
		{
			
			con = ds.getConnection();
//			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
			
			jsonObject = (JSONObject)jsonParser.parse(jsonData);
			//System.out.println(jsonObject);
			
			String rspWord = (String)jsonObject.get("RSP_WORD");
			JSONArray bodyArray = (JSONArray)jsonObject.get("BODY");
			//System.out.println("rspWord:"+rspWord);
			//System.out.println("bodyArray:"+bodyArray);
			
			List<String> jsonDataList = new ArrayList<String>(); 
			
			System.out.println("bodySize:"+bodyArray.size());
			
			
			for(int i=0; i< bodyArray.size(); i++) 
			{
				JSONObject jsList = (JSONObject)bodyArray.get(i);
				
				String macNum  = (String)jsList.get("MAC_NUM");
				String contNum = (String)jsList.get("CONT_NUM");
				
				System.out.println("{macNum:"+macNum +" "+i+"번째");
				System.out.println("contNum:"+contNum+" " +i+"번째}");

				JSONArray timeList = (JSONArray)jsList.get("RSP STT LIST");
				
				System.out.println("timeListSize:"+timeList.size());
				
				for(int a =0; a< timeList.size(); a++)  
				{
					JSONObject timeListVal = (JSONObject)timeList.get(a);
					String hour   = (String)timeListVal.get("HOUR");
					String day    = (String)timeListVal.get("DAY");
					String month  = (String)timeListVal.get("MONTH");
					String adsNum = (String)timeListVal.get("NUM_OF_ADS");
					String spYn   = (String)timeListVal.get("SP_YN");
					
					System.out.println("{");
					System.out.println("hour:"+hour+" "+i+"번째"+" "+a+"열");
					System.out.println("day:"+day+" "+i+"번째"+" "+a+"열");
					System.out.println("month:"+month+" "+i+"번째"+" "+a+"열");
					System.out.println("adsNum:"+adsNum+" "+i+"번째"+" "+a+"열");
					System.out.println("spYn:"+spYn+" "+i+"번째"+" "+a+"열");
					System.out.println("}");
				
					sb.append("INSERT INTO tb_statistics						\n");
					sb.append("(												\n");
					sb.append("					ST_NUM							\n");
					sb.append("				   ,ST_CONT_NUM						\n");
					sb.append("				   ,ST_MAC_NUM						\n");
					sb.append("				   ,ST_MONTH						\n");
					sb.append("				   ,ST_DAY							\n");
					sb.append("				   ,ST_HOUR							\n");
					sb.append("				   ,ST_NUM_OF_ADS					\n");
					sb.append("				   ,ST_SP_YN						\n");
					sb.append(")												\n");
					sb.append("	VALUES											\n");
					sb.append("(												\n");
					sb.append("		(SELECT  									\n");
					sb.append("			 	IFNULL(MAX(ST_NUM),0)+1 			\n");
					sb.append("		 FROM tb_statistics	A)						\n");
					sb.append("				   ,?								\n");
					sb.append("				   ,?								\n");
					sb.append("				   ,?								\n");
					sb.append("				   ,DATE_FORMAT(?,'%Y%m%d')			\n");
					sb.append("				   ,?								\n");
					sb.append("				   ,?								\n");
					sb.append("				   ,?								\n");
					sb.append(")												\n");
					
					stmt = con.prepareStatement(sb.toString());
					stmt.setString(1, contNum);		//컨텐츠번호
					stmt.setString(2, macNum);		//머신번호
					stmt.setString(3, month);		//월
					stmt.setString(4, day);
					stmt.setString(5, hour);
					stmt.setString(6, adsNum);
					stmt.setString(7, spYn);
					
					result += stmt.executeUpdate();
					
					stmt.clearParameters();
					sb.setLength(0);
				}
			}
			
			System.out.println("Update 성공횟수:"+result);
			
		} 
		catch(Exception e) 
		{
			e.printStackTrace();
		
		} 
		finally 
		{
			close(stmt);
			close(con);
		}
		
		return result;
	}
	
	
	/**
	 * 통계 메뉴 광고주 select 태그목록
	 * 
	 * @author	이영상
	 * @since		2020.08.24
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.24			이영상				최초생성
	 */
	
	public ArrayList<Map<String, Object>> getSelectADTList(String id) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT															\n");
		sb.append("		  		advertiser_num										\n");
		sb.append("			   ,advertiser_name										\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_advertiser 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  member_id	= 	 ?											\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			stmt.setString(1, id);
			System.out.println("getSelectADTList: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADT_NUM", 					rs.getInt("advertiser_num"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				
				list.add(ad);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	/**
	 * 월별 통계 리스트
	 * 
	 * @author	이영상
	 * @since		2020.08.24
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.24			이영상				최초생성
	 */
	public ArrayList<Map<String, Object>> getStatisticsMonthList(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		StringBuffer sb = new StringBuffer();
		
		Map<String, Object> param = paramList.get(0);
		
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDateM:"+param.get("preDateM"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDateM = (String) param.get("preDateM");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		preDateM = preDateM.substring(5,7);
		
		sb.append("SELECT															\n");
		sb.append("				SUM(A.ST_NUM_OF_ADS) AS ADS_SUM						\n");
		sb.append("			   ,CONCAT(A.ST_MONTH,'월')AS ST_MONTH					\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_MONTH   ='"+preDateM+"'								\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null ) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		sb.append("  GROUP BY ST_MONTH,ST_CONT_NUM, ST_MAC_NUM						\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
			System.out.println("getStatisticsMonthList: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADS_SUM", 					rs.getInt("ADS_SUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				
				list.add(ad);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	
	/**
	 * 월별 통계 그래프  ajax data
	 * 
	 * @author	이영상
	 * @since		2020.08.27
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.19			이영상				최초생성
	 */
	
	public ArrayList<Map<String, Object>> getStatisticsMonthListJson(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		JSONObject jsonObject = new JSONObject();
		
		String returnResult = "";
		
		StringBuffer sb = new StringBuffer();
		
		Map<String, Object> param = paramList.get(0);
		
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDateM:"+param.get("preDateM"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDateM = (String) param.get("preDateM");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		preDateM = preDateM.substring(5,7);
		
		sb.append("SELECT																\n");
		sb.append("				SUM(A.ST_NUM_OF_ADS) AS ADS_SUM							\n");
		sb.append("			   ,A.ST_MONTH												\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY				\n");
		sb.append("			   ,B.contents_title										\n");
		sb.append("			   ,D.advertiser_name										\n");
		sb.append("			   ,F.id													\n");
		sb.append("			   ,(SELECT COUNT( DISTINCT( AA.ST_CONT_NUM ) )				\n");
		sb.append("			       FROM tb_statistics AA								\n");
		sb.append("			   		   ,tb_contents   BB								\n");
		sb.append("			   		   ,tb_machine    CC								\n");
		sb.append("			   	  WHERE													\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num					\n");
		sb.append("			   	  	AND AA.ST_MONTH     ='"+preDateM+"'					\n");
		if(!"".equals(selADT) && selADT !=null) 
		{
				sb.append("  AND  BB.advertiser_num  ="+selADT+"						\n");
		}
		sb.append("			     ) AS COL_CNT											\n");
		sb.append("			   ,(SELECT GROUP_CONCAT(DISTINCT(DD.advertiser_name),'@@') \n");
		sb.append("			       FROM tb_statistics AA								\n");
		sb.append("			   		   ,tb_contents   BB								\n");
		sb.append("			   		   ,tb_machine    CC								\n");
		sb.append("			   		   ,tb_advertiser DD								\n");
		sb.append("			   	  WHERE													\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num				\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num					\n");
		sb.append("			   	  	AND BB.advertiser_num = DD.advertiser_num			\n");
		sb.append("			   	  	AND AA.ST_MONTH     ='"+preDateM+"'					\n");
		if(!"".equals(selADT) && selADT !=null) 
		{
				sb.append("  AND  BB.advertiser_num  ="+selADT+"						\n");
		}
		sb.append("			     ) AS COL_NM											\n");
		sb.append("  FROM																\n");
		sb.append("  	  tb_statistics A 												\n");
		sb.append("  	 ,tb_contents 	B 												\n");
		sb.append("  	 ,tb_machine 	C 												\n");
		sb.append("  	 ,tb_advertiser D												\n");
		sb.append("  	 ,tb_member     F 												\n");
		sb.append( "WHERE 																\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num								\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num									\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num							\n");
		sb.append("  AND  B.member_id = F.id											\n");
		sb.append("  AND  C.partner = F.id												\n");
		sb.append("  AND  A.ST_MONTH   ='"+preDateM+"'									\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		sb.append("  GROUP BY ST_DAY,ST_CONT_NUM, ST_MAC_NUM							\n");
		sb.append("  ORDER BY A.ST_DAY ASC , D.advertiser_name ASC						\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			System.out.println("getStatisticsMonthListJson: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADS_SUM", 					rs.getInt("ADS_SUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				ad.put("COL_CNT", 					rs.getInt("COL_CNT"));
				ad.put("COL_NM", 					rs.getString("COL_NM"));
				
				list.add(ad);	
			}
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return list;
	}
	
	/**
	 * 기간별 일자 리스트
	 * 
	 * @author	이영상
	 * @since		2020.08.24
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.24			이영상				최초생성
	 */
	public ArrayList<Map<String, Object>> getStatisticsPeriodDList(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> param = paramList.get(0);

		System.out.println("param pn:"+param.get("pn"));
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param postDate:"+param.get("postDate"));
		System.out.println("param type:"+param.get("type"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		int pn = Integer.parseInt(String.valueOf(param.get("pn")));
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String postDate = (String) param.get("postDate");
		String type = (String) param.get("type");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		StringBuffer sb = new StringBuffer();
		
		/*
		sb.append("SELECT																		  \n");
		sb.append("				A.ST_CONT_NUM													  \n");
		sb.append("			   ,A.ST_MAC_NUM													  \n");
		sb.append("			   ,A.ST_MONTH														  \n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY						  \n");
		sb.append("			   ,A.ST_HOUR														  \n");
		sb.append("			   ,A.ST_NUM_OF_ADS													  \n");
		sb.append("			   ,A.ST_SP_YN														  \n");
		sb.append("			   ,B.contents_title												  \n");
		sb.append("			   ,D.advertiser_name												  \n");
		sb.append("			   ,F.id															  \n");
		sb.append("  FROM																		  \n");
		sb.append("  	  tb_statistics A 														  \n");
		sb.append("  	 ,tb_contents 	B 														  \n");
		sb.append("  	 ,tb_machine 	C 														  \n");
		sb.append("  	 ,tb_advertiser D														  \n");
		sb.append("  	 ,tb_member     F 														  \n");
		sb.append( "WHERE 																		  \n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num										  \n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num											  \n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num									  \n");
		sb.append("  AND  B.member_id = F.id													  \n");
		sb.append("  AND  C.partner = F.id														  \n");
		sb.append("  AND  B.member_id = ?														  \n");
		*/
		sb.append("SELECT															\n");
		sb.append("				SUM(A.ST_NUM_OF_ADS) AS ADS_SUM						\n");
		sb.append("			   ,CONCAT(A.ST_MONTH,'월')AS ST_MONTH					\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_DAY BETWEEN IFNULL( '"+preDate+"' ,'1900-01-01') AND IFNULL ( '"+postDate+"' ,'9999-12-31') \n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT)) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
//			stmt.setString(1, id);
//			stmt.setString(2, 시작일자);
//			stmt.setString(3, 종료일자);
			
			
			System.out.println("getStatisticsPeriodDList: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADS_SUM", 					rs.getInt("ADS_SUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				
				list.add(ad);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	
	/**
	 * 기간별 월별리스트( 기간별 조회 시 기간 조회가 한달 이상 일 시 적용)
	 * 
	 * @author	이영상
	 * @since		2020.08.31
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.31			이영상				최초생성
	 */
	public ArrayList<Map<String, Object>> getStatisticsPeriodMList(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		Map<String, Object> param = paramList.get(0);

		System.out.println("param pn:"+param.get("pn"));
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param postDate:"+param.get("postDate"));
		System.out.println("param type:"+param.get("type"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		int pn = Integer.parseInt(String.valueOf(param.get("pn")));
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String postDate = (String) param.get("postDate");
		String type = (String) param.get("type");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		StringBuffer sb = new StringBuffer();
		
		sb.append("SELECT															\n");
		sb.append("				SUM(A.ST_NUM_OF_ADS) AS ADS_SUM						\n");
		sb.append("			   ,CONCAT(A.ST_MONTH,'월')AS ST_MONTH					\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY			\n");
		sb.append("			   ,B.contents_title									\n");
		sb.append("			   ,D.advertiser_name									\n");
		sb.append("			   ,F.id												\n");
		sb.append("  FROM															\n");
		sb.append("  	  tb_statistics A 											\n");
		sb.append("  	 ,tb_contents 	B 											\n");
		sb.append("  	 ,tb_machine 	C 											\n");
		sb.append("  	 ,tb_advertiser D											\n");
		sb.append("  	 ,tb_member     F 											\n");
		sb.append( "WHERE 															\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num							\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num								\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num						\n");
		sb.append("  AND  B.member_id = F.id										\n");
		sb.append("  AND  C.partner = F.id											\n");
		sb.append("  AND  A.ST_DAY BETWEEN IFNULL( '"+preDate+"' ,'1900-01-01') AND IFNULL ( '"+postDate+"' ,'9999-12-31') \n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null ) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		sb.append("  GROUP BY CONCAT(A.ST_MONTH,'월'),ST_CONT_NUM					\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			System.out.println("getStatisticsMonthList: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADS_SUM", 					rs.getInt("ADS_SUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				
				list.add(ad);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		return list;
	}
	
	/**
	 * 기간별 통계 그래프  ajax data
	 * 
	 * @author	이영상
	 * @since		2020.08.31
	 * @version	1.0
	 * 
	 * <pre>
	 * << 개정이력 >>
	 * ------------------------------------------------------
	 * 수정일				수정자				수정내용
	 * ------------------------------------------------------
	 * 08.31			이영상				최초생성
	 */
	
	public ArrayList<Map<String, Object>> getStatisticsPeriodMListJson(ArrayList<Map<String, Object>> paramList) 
	{
		ArrayList<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		JSONObject jsonObject = new JSONObject();
		
		String returnResult = "";
		
		StringBuffer sb = new StringBuffer();
		
		Map<String, Object> param = paramList.get(0);
		
		System.out.println("param id:"+param.get("id"));
		System.out.println("param division:"+param.get("division"));
		System.out.println("param preDate:"+param.get("preDate"));
		System.out.println("param postDate:"+param.get("postDate"));
		System.out.println("param selADT:"+param.get("selADT"));
		System.out.println("param selAdKind:"+param.get("selAdKind"));
		System.out.println("param selMc:"+param.get("selMc"));
		
		String id = (String) param.get("id");
		String division = (String) param.get("division");
		String preDate = (String) param.get("preDate");
		String postDate = (String) param.get("postDate");
		String selADT = (String) param.get("selADT");
		String selAdKind = (String) param.get("selAdKind");
		String selMc = (String)param.get("selMc");
		
		sb.append("SELECT																														\n");
		sb.append("				SUM(A.ST_NUM_OF_ADS) AS ADS_SUM																					\n");
		sb.append("			   ,A.ST_MONTH																										\n");
		sb.append("			   ,DATE_FORMAT(A.ST_DAY, '%Y-%m-%d') AS ST_DAY																		\n");
		sb.append("			   ,B.contents_title																								\n");
		sb.append("			   ,D.advertiser_name																								\n");
		sb.append("			   ,F.id																											\n");
		sb.append("			   ,(SELECT COUNT( DISTINCT( AA.ST_CONT_NUM ) )																		\n");
		sb.append("			       FROM tb_statistics AA																						\n");	
		sb.append("			   		   ,tb_contents   BB																						\n");
		sb.append("			   		   ,tb_machine    CC																						\n");
		sb.append("			   	  WHERE																											\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num																		\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num																			\n");
		sb.append("			   	  	AND AA.ST_DAY    BETWEEN IFNULL('"+preDate+"','1900-01-01') AND IFNULL ('"+postDate+"','9999-12-31')		\n");
		if(!"".equals(selADT) && selADT !=null) 
		{
			sb.append("  AND  BB.advertiser_num  ="+selADT+"																					\n");
		}
		sb.append("			     ) AS COL_CNT																									\n");
		sb.append("			   ,(SELECT GROUP_CONCAT(DISTINCT(DD.advertiser_name),'@@') 														\n");
		sb.append("			       FROM tb_statistics AA																						\n");
		sb.append("			   		   ,tb_contents   BB																						\n");
		sb.append("			   		   ,tb_machine    CC																						\n");
		sb.append("			   		   ,tb_advertiser DD																						\n");
		sb.append("			   	  WHERE																											\n");
		sb.append("			   	 	    AA.ST_CONT_NUM = BB.contents_num																		\n");
		sb.append("			   	  	AND AA.ST_MAC_NUM  = CC.machine_num																			\n");
		sb.append("			   	  	AND BB.advertiser_num = DD.advertiser_num																	\n");
		sb.append("			   	  	AND AA.ST_DAY     BETWEEN IFNULL('"+preDate+"','1900-01-01') AND IFNULL ('"+postDate+"','9999-12-31')		\n");
		if(!"".equals(selADT) && selADT !=null) 
		{
			sb.append("  AND  BB.advertiser_num  ="+selADT+"																					\n");
		}
		sb.append("			     ) AS COL_NM																									\n");
		sb.append("  FROM																														\n");
		sb.append("  	  tb_statistics A 																										\n");
		sb.append("  	 ,tb_contents 	B 																										\n");
		sb.append("  	 ,tb_machine 	C 																										\n");
		sb.append("  	 ,tb_advertiser D																										\n");
		sb.append("  	 ,tb_member     F 																										\n");
		sb.append( "WHERE 																														\n");
		sb.append("  	  A.ST_CONT_NUM = B.contents_num																						\n");
		sb.append("  AND  A.ST_MAC_NUM  = C.machine_num																							\n");
		sb.append("  AND  B.advertiser_num = D.advertiser_num																					\n");
		sb.append("  AND  B.member_id = F.id																									\n");
		sb.append("  AND  C.partner = F.id																										\n");
		sb.append("  AND  A.ST_DAY BETWEEN IFNULL( '"+preDate+"' ,'1900-01-01') AND IFNULL ( '"+postDate+"' ,'9999-12-31') 						\n");
		
		if("01".equals(division))
		{
			sb.append("  AND  B.member_id = 	'"+id+"'							\n");
		}
		
		if(!"".equals(selADT) && selADT !=null) 
		{
			sb.append("  AND  B.advertiser_num  ="+selADT+"							\n");
		}
		
		if(!"".equals(selAdKind))
		{
			sb.append("  AND  A.ST_CONT_NUM  	="+selAdKind+"						\n");
		}
		
		if(!"".equals(selMc))
		{
			sb.append("  AND  A.ST_MAC_NUM  	="+selMc+"							\n");
		}
		
		sb.append("  GROUP BY ST_DAY,ST_CONT_NUM, ST_MAC_NUM							\n");
		sb.append("  ORDER BY A.ST_DAY ASC , D.advertiser_name ASC						\n");
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try 
		{
			
			con = ds.getConnection();
			stmt = con.prepareStatement(sb.toString());
			System.out.println("getStatisticsPeriodMListJson: \n"+sb.toString());
			
			rs = stmt.executeQuery();
			
			while(rs.next()) 
			{
				Map<String, Object> ad = new HashMap<String, Object>();
				ad.put("ADS_SUM", 					rs.getInt("ADS_SUM"));
				ad.put("MONTH",						rs.getInt("ST_MONTH"));
				ad.put("DAY", 						rs.getString("ST_DAY"));
				ad.put("C_TITLE", 					rs.getString("contents_title"));
				ad.put("ADT_NM", 					rs.getString("advertiser_name"));
				ad.put("ID", 						rs.getString("id"));
				ad.put("COL_CNT", 					rs.getInt("COL_CNT"));
				ad.put("COL_NM", 					rs.getString("COL_NM"));
				
				list.add(ad);	
			}
		} catch(Exception e) {
			e.printStackTrace();
		
		} finally {
			close(rs);
			close(stmt);
			close(con);
		}
		
		return list;
	}
	
	
	
}