package lj.cpy.mbtool.codeGenerate;

import java.util.ResourceBundle;

public class CodeResource {
	private static final ResourceBundle BUNDLE_DATABASE = ResourceBundle.getBundle("database");
	private static final ResourceBundle BUNDLE_CONFIG = ResourceBundle.getBundle("config");

	public static String DRIVER_NAME = "com.mysql.cj.jdbc.Driver";
	public static String URL = "jdbc:mysql://localhost:3306/sys?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&failOverReadOnly=false";
	public static String USERNAME = "root";
	public static String PASSWORD = "root";
	public static String DATABASE_NAME = "sys";

	public static String DATABASE_TYPE = "mysql";
	public static String DATABASE_TYPE_MYSQL = "mysql";
	public static String DATABASE_TYPE_ORACLE = "oracle";
	
	public static String KEY_TYPE_01 = "01";// 主键生成方式UUID
	public static String KEY_TYPE_02 = "02";// 主键生成方式 自增

	public static String source_root_package = "src";
	public static String webapp_package = "webapp";

	public static String bussiPackage = "com.sun";
	public static String bussiPackageUrl = "com.sun";

	public static String organization = "China";
	public static String author = "China";

	static {
		DRIVER_NAME = getDriverName();
		URL = getUrl();
		USERNAME = getUserName();
		PASSWORD = getPassword();
		DATABASE_NAME = getDatabaseName();

		source_root_package = getSourceRootPackage();
		webapp_package = getWebappPackage();
		bussiPackage = getBussiPackage();
		
		bussiPackageUrl = bussiPackage.replace(".", "/");
		source_root_package = source_root_package.replace(".", "/");
		webapp_package = webapp_package.replace(".", "/");

		if ((URL.indexOf("mysql") >= 0) || (URL.indexOf("MYSQL") >= 0)) {
			DATABASE_TYPE = DATABASE_TYPE_MYSQL;
		} else if ((URL.indexOf("oracle") >= 0) || (URL.indexOf("ORACLE") >= 0)) {
			DATABASE_TYPE = DATABASE_TYPE_ORACLE;
		}
	}

	public static final String getDriverName() {
		return BUNDLE_DATABASE.getString("driver_name");
	}

	public static final String getUrl() {
		return BUNDLE_DATABASE.getString("url");
	}

	public static final String getUserName() {
		return BUNDLE_DATABASE.getString("user_name");
	}

	public static final String getPassword() {
		return BUNDLE_DATABASE.getString("password");
	}

	public static final String getDatabaseName() {
		return BUNDLE_DATABASE.getString("database_name");
	}

	private static String getBussiPackage() {
		return BUNDLE_CONFIG.getString("bussi_package");
	}

	public static final String getSourceRootPackage() {
		return BUNDLE_CONFIG.getString("source_root_package");
	}
	
	public static final String getWebappPackage() {
		return BUNDLE_CONFIG.getString("webapp_package");
	}
	
	public static final String getTemplatePath() {
		return BUNDLE_CONFIG.getString("template_path");
	}

	public static final String getSystemEncoding() {
		return BUNDLE_CONFIG.getString("system_encoding");
	}

	public static final String getOrganization() {
		return BUNDLE_CONFIG.getString("organization");
	}
	
	public static final String getAuthor() {
		return BUNDLE_CONFIG.getString("author");
	}

}