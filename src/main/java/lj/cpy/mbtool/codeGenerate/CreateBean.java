package lj.cpy.mbtool.codeGenerate;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.velocity.VelocityContext;

public class CreateBean {
	private static String url;
	private static String username;
	private static String password;
	private static String rt = "\r\t";
	private String SQLTables = "show tables";

	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void setDbInfo(String url, String username, String password) {
		this.url = url;
		this.username = username;
		this.password = password;
	}

	public Connection getConnection() throws SQLException {
		return DriverManager.getConnection(url, username, password);
	}

	public List<String> getTables() throws SQLException {
		Connection con = getConnection();
		PreparedStatement ps = con.prepareStatement(this.SQLTables);
		ResultSet rs = ps.executeQuery();
		List list = new ArrayList();
		while (rs.next()) {
			String tableName = rs.getString(1);
			list.add(tableName);
		}
		rs.close();
		ps.close();
		con.close();
		return list;
	}

	/**
	 * 表名转类名，表名格式为t_table_name，或tableName
	 * @param tableName
	 * @return
	 */
	public String getTableNameToClassName(String tableName) {
		String[] split = tableName.split("_");
		if (split.length > 1) {
			StringBuffer sb = new StringBuffer();
			for (int i = 1; i < split.length; i++) {
				String tempTableName = split[i].substring(0, 1).toUpperCase() + split[i].substring(1, split[i].length());
				sb.append(tempTableName);
			}
			return sb.toString();
		}
		return split[0].substring(0, 1).toUpperCase() + split[0].substring(1, split[0].length());
	}
	
	/**
	 * 列名转驼峰类型，列明格式为col_name，或name
	 * @param columnName
	 * @return
	 */
	public String getHumpName(String columnName) {
		String[] split = columnName.split("_");
		if (split.length > 1) {
			StringBuffer sb = new StringBuffer(split[0]);
			for (int i = 1; i < split.length; i++) {
				String tempName = split[i].substring(0, 1).toUpperCase() + split[i].substring(1, split[i].length());
				sb.append(tempName);
			}
			return sb.toString();
		}
		return columnName;
	}
	
	/**
	 * 列名转驼峰类型，首字母大写，列明格式为col_name，或name
	 * @param columnName
	 * @return
	 */
	public String getUpperHumpName(String columnName) {
		String[] split = columnName.split("_");
		if (split.length > 1) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < split.length; i++) {
				String tempName = split[i].substring(0, 1).toUpperCase() + split[i].substring(1, split[i].length());
				sb.append(tempName);
			}
			return sb.toString();
		}
		return columnName.substring(0, 1).toUpperCase() + columnName.substring(1, columnName.length());
	}
	
	/**
	 * 初始化mapper参数
	 * @param context
	 * @param tableName
	 */
	public void initTableInfo(VelocityContext context, String tableName) {
		List<ColumnData> columnDatas = new ArrayList<ColumnData>();
		String SQLColumns = "select column_name, data_type, column_comment, numeric_precision, numeric_scale, character_maximum_length, is_nullable, column_key from information_schema.columns where table_name =  '" + tableName + "' " + "and table_schema =  '" + CodeResource.DATABASE_NAME + "'";

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			ps = con.prepareStatement(SQLColumns);
			rs = ps.executeQuery();
			while (rs.next()) {
				ColumnData columnData = new ColumnData();
				columnData.setColumnName(rs.getString(1));
				columnData.setColumnType(rs.getString(2));
				columnData.setColumnComment(rs.getString(3));
				columnData.setPrecision(rs.getString(4));
				columnData.setScale(rs.getString(5));
				columnData.setCharmaxLength(rs.getString(6));
				columnData.setNullable(getNullAble(rs.getString(7)));
				columnData.setColumnKey(rs.getString(8));
				columnData.setPropertyName(getHumpName(rs.getString(1)));
				columnData.setUpperPropertyName(getUpperHumpName(rs.getString(1)));
				transDataType(columnData, rs.getString(2), rs.getString(4), rs.getString(5));
				columnDatas.add(columnData);
			}
			context.put("columnDatas", columnDatas);
			
			// MapperXml
			// 主键生成方式
			String primaryKeyType = String.valueOf(context.get("keyType"));// 01:UUID 02:自增
			StringBuffer sql_columns = new StringBuffer();// 列名
			StringBuffer sql_condition = new StringBuffer();// 查询条件
			StringBuffer sql_update_set = new StringBuffer();// 更新
			StringBuffer sql_insert_column = new StringBuffer();// 插入列
			StringBuffer sql_insert_value = new StringBuffer();// 插入值
			for (ColumnData columnData : columnDatas) {
				// 列名
				sql_columns.append(columnData.getPropertyName()).append(", ");
				
				// 查询条件
				if (columnData.getDataType().indexOf("Integer") > 0 || columnData.getDataType().indexOf("Float") > 0 || columnData.getDataType().indexOf("Double") > 0 || columnData.getDataType().indexOf("Long") > 0 || columnData.getDataType().indexOf("BigDecimal") > 0 ) {
					sql_condition.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">and ").append(columnData.getPropertyName()).append(" = #{").append(columnData.getPropertyName()).append("}</if>\r");
				} else {
					sql_condition.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null and ").append(columnData.getPropertyName()).append(" != \'\'\">and ").append(columnData.getPropertyName()).append(" = #{").append(columnData.getPropertyName()).append("}</if>\r");
				}
				
				// 更新
				sql_update_set.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">, ").append(columnData.getPropertyName()).append(" = #{").append(columnData.getPropertyName()).append("}</if>\r");
				
				// 插入
				if (StringUtils.equals(primaryKeyType, "01")) {
					if (StringUtils.equals(columnData.getColumnKey(), "PRI")) {
						context.put("primaryKey", columnData.getPropertyName());
						context.put("primaryKeyDataType", columnData.getDataType());
						context.put("primaryKeyShortDataType", columnData.getShortDataType());
						// 插入列
						sql_insert_column.append("\t\t\t<if test=\"1 == 1\">, ").append(columnData.getPropertyName()).append("</if>\r");
						// 插入值
						sql_insert_value.append("\t\t\t<if test=\"1 == 1\">, ").append("#{").append(columnData.getPropertyName()).append("}</if>\r");
					} else {
						// 插入列
						sql_insert_column.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">, ").append(columnData.getPropertyName()).append("</if>\r");
						// 插入值
						sql_insert_value.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">, ").append("#{").append(columnData.getPropertyName()).append("}</if>\r");
					}
					
				} else {
					if (StringUtils.equals(columnData.getColumnKey(), "PRI")) {
						context.put("primaryKey", columnData.getPropertyName());
						context.put("primaryKeyDataType", columnData.getDataType());
						context.put("primaryKeyShortDataType", columnData.getShortDataType());
						// 插入列
//						sql_insert_column.append("\t\t\t<if test=\"1 == 1\">, ").append(columnData.getPropertyName()).append("</if>\r");
						// 插入值
//						sql_insert_value.append("\t\t\t<if test=\"1 == 1\">, ").append("#{").append(columnData.getPropertyName()).append("}</if>\r");
					} else {
						// 插入列
						sql_insert_column.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">, ").append(columnData.getPropertyName()).append("</if>\r");
						// 插入值
						sql_insert_value.append("\t\t\t<if test=\"").append(columnData.getPropertyName()).append(" != null\">, ").append("#{").append(columnData.getPropertyName()).append("}</if>\r");
					}
				}
			}
			if (sql_columns.length() > 0) {
				String tempCols = sql_columns.substring(0, sql_columns.lastIndexOf(", "));
				context.put("sql_columns", tempCols);
			} else {
				context.put("sql_columns", sql_columns);
			}
			context.put("sql_condition", sql_condition);
			context.put("sql_update_set", sql_update_set);
			context.put("sql_insert_column", sql_insert_column);
			context.put("sql_insert_value", sql_insert_value);
			
			rs.close();
			ps.close();
			con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				try {
					if (!rs.isClosed()) {
						rs.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (ps != null) {
				try {
					if (!ps.isClosed()) {
						ps.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if (con != null) {
				try {
					if (!con.isClosed()) {
						con.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	/**
	 * 字段类型转换
	 * @param columnData
	 * @param dataType
	 * @param precision
	 * @param scale
	 * @return
	 */
	public void transDataType(ColumnData columnData, String dataType, String precision, String scale) {
		dataType = dataType.toLowerCase();
		if (StringUtils.equals(dataType, "char") || StringUtils.equals(dataType, "varchar") || StringUtils.equals(dataType, "text")) {
			columnData.setDataType("java.lang.String");
			columnData.setShortDataType("String");
		} else if (StringUtils.equals(dataType, "blob")) {
			columnData.setDataType("java.lang.byte");
			columnData.setShortDataType("byte[]");
		} else if (StringUtils.equals(dataType, "int")) {
			columnData.setDataType("java.lang.Long");
			columnData.setShortDataType("Long");
		} else if (StringUtils.equals(dataType, "tinyint") || StringUtils.equals(dataType, "smallint") || StringUtils.equals(dataType, "mediumint")) {
			columnData.setDataType("java.lang.Integer");
			columnData.setShortDataType("Integer");
		} else if (StringUtils.equals(dataType, "bigint")) {
			columnData.setDataType("java.math.BigInteger");
			columnData.setShortDataType("BigInteger");
		} else if (StringUtils.equals(dataType, "float")) {
			columnData.setDataType("java.lang.Float");
			columnData.setShortDataType("Float");
		} else if (StringUtils.equals(dataType, "double")) {
			columnData.setDataType("java.lang.Double");
			columnData.setShortDataType("Double");
		} else if (StringUtils.equals(dataType, "bit")) {
			columnData.setDataType("java.lang.Boolean");
			columnData.setShortDataType("Boolean");
		} else if (StringUtils.equals(dataType, "decimal")) {
			columnData.setDataType("java.math.BigDecimal");
			columnData.setShortDataType("BigDecimal");
		} else if (StringUtils.equals(dataType, "date") || StringUtils.equals(dataType, "year")) {
			columnData.setDataType("java.sql.Date");
			columnData.setShortDataType("Date");
		} else if (StringUtils.equals(dataType, "time")) {
			columnData.setDataType("java.sql.Time");
			columnData.setShortDataType("Time");
		} else if (StringUtils.equals(dataType, "datetime")) {
			columnData.setDataType("java.sql.Timestamp");
			columnData.setShortDataType("Timestamp");
		} else if (StringUtils.equals(dataType, "timestamp")) {
			columnData.setDataType("java.sql.Timestamp");
			columnData.setShortDataType("Timestamp");
		} else if (StringUtils.equals(dataType, "clob")) {
			columnData.setDataType("java.sql.Clob");
			columnData.setShortDataType("Clob");
		} else if (StringUtils.equals(dataType, "number")) {
			if ((StringUtils.isNotBlank(scale)) && (Integer.parseInt(scale) > 0)) {
				columnData.setDataType("java.math.BigDecimal");
				columnData.setShortDataType("BigDecimal");
			} else if ((StringUtils.isNotBlank(precision)) && (Integer.parseInt(precision) > 6)) {
				columnData.setDataType("java.lang.Long");
				columnData.setShortDataType("Long");
			} else {
				columnData.setDataType("java.lang.Integer");
				columnData.setShortDataType("Integer");
			}
		} else {
			columnData.setDataType("java.lang.Object");
			columnData.setShortDataType("Object");
		}
		
	}
	
	public String getNullAble(String nullable) {
		if (("YES".equals(nullable)) || ("yes".equals(nullable)) || ("y".equals(nullable)) || ("Y".equals(nullable))) {
			return "Y";
		}
		if (("NO".equals(nullable)) || ("N".equals(nullable)) || ("no".equals(nullable)) || ("n".equals(nullable))) {
			return "N";
		}
		return null;
	}
	
}