package com.rivetlogic.csvtemplatemailer.util;

import java.util.ArrayList;
import java.util.List;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;

public class Utils {
	public static String formatColumnName(String columnName) {
		columnName = columnName.toLowerCase();
		columnName = columnName.replace(" ", "_");
		
		return "${" + columnName + "}";
	}
	
	public static String generateHtmlTable(List<FileColumn> columns) {
		String tableStart = "<table border=\"1\" cellpadding=\"1\" cellspacing=\"1\" style=\"width:500px;\">"+
								"<tbody>"+
									"<tr>";
		String columnsName = "";
		for (FileColumn fileColumn : columns) {
			columnsName += "<td>"+ fileColumn.getName() +"</td>";
		}
		
		String rowChange = "</tr><tr>";
		
		String columnsData = "";
		for (FileColumn fileColumn : columns) {
			columnsData += "<td>"+ formatColumnName(fileColumn.getName()) +"</td>";
		}
		
		String tableEnd = "</tr></tbody></table>";
		
		return tableStart + columnsName + rowChange + columnsData + tableEnd;
	}
	
	public static String removeEscapeChars(String arg) {
		arg = arg.replace("\n", "");
		arg = arg.replace("\t", "");
		arg = arg.replace("&nbsp;", " ");
		
		return arg;
	}
	
	public static boolean checkboxValueConvert(String value) {
		if (value.equals("on")) {
			return true;
		}
		
		return false;
	}
	
	public static List<FileColumn> deserializeColumns(String data) {
		List<FileColumn> result = new ArrayList<>();
		JSONArray params;
		
		try {
			params = JSONFactoryUtil.createJSONArray(data);
			
			for (int i = 0; i < params.length(); i++) {
				JSONObject val = params.getJSONObject(i);
				FileColumn col =(FileColumn) JSONFactoryUtil.looseDeserialize(val.toString(), FileColumn.class);

				result.add(col);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
