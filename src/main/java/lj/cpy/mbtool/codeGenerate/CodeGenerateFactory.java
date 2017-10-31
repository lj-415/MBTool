package lj.cpy.mbtool.codeGenerate;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.velocity.VelocityContext;

/**
 * @description 
 * @author LiJing
 * @date 2017年10月27日 下午5:09:08
 */
public class CodeGenerateFactory {
	private static final Log log = LogFactory.getLog(CodeGenerateFactory.class);
	private static String url = CodeResource.URL;
	private static String username = CodeResource.USERNAME;
	private static String passWord = CodeResource.PASSWORD;

	private static String buss_package = CodeResource.bussiPackage;
	private static String projectPath = getProjectPath();

	/**
	 * @param tableName：表名
	 * @param className：类对象名
	 * @param remark：注释
	 * @param keyType：主键生成方式 01:UUID 02:自增
	 * @param isHtml:是否生产html页面和js文件
	 */
	public static void codeGenerate(String tableName, String className, String remark, String keyType, boolean isHtml) {
		CreateBean createBean = new CreateBean();
		createBean.setDbInfo(url, username, passWord);

		//String className = createBean.getTableNameToClassName(tableName);
		String lowerName = className.substring(0, 1).toLowerCase() + className.substring(1, className.length());

		String srcPath = projectPath + CodeResource.source_root_package + "/";
		String pckPath = srcPath + CodeResource.bussiPackageUrl + "/";
		String webPath = projectPath + CodeResource.webapp_package + "/WEB-INF" + "/views/";

		String entityPath = "entity/" + className + ".java";
		String mapperPath = "mapper/" + className + "Mapper.java";
		String mapperXmlPath = "mapper/" + className + "Mapper.xml";
		String servicePath = "service/" + className + "Service.java";
		String serviceImplPath = "service/impl/" + className + "ServiceImpl.java";
		String controllerPath = "controller/system/" + className + "Controller.java";
		String appControllerPath = "controller/app/App" + className + "Controller.java";
		String htmlPath = "system/" + lowerName + "/" + lowerName + "List.html";
		String jsPath = "system/" + lowerName + "/" + lowerName + ".js";

		VelocityContext context = new VelocityContext();
		context.put("className", className);
		context.put("lowerName", lowerName);
		context.put("remark", remark);
		context.put("tableName", tableName);
		context.put("bussPackage", buss_package);
		context.put("keyType", keyType);
		context.put("user", System.getProperty("user.name"));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		context.put("time", df.format(new Date()));
		context.put("organization", CodeResource.getOrganization());
		context.put("author", CodeResource.getAuthor());
		createBean.initTableInfo(context, tableName);

		CreateFile.writerPage(context, "Entity.ftl", pckPath, entityPath);
		CreateFile.writerPage(context, "Mapper.ftl", pckPath, mapperPath);
		CreateFile.writerPage(context, "MapperXml.ftl", pckPath, mapperXmlPath);
		CreateFile.writerPage(context, "Service.ftl", pckPath, servicePath);
		CreateFile.writerPage(context, "ServiceImpl.ftl", pckPath, serviceImplPath);
		CreateFile.writerPage(context, "Controller.ftl", pckPath, controllerPath);
		CreateFile.writerPage(context, "AppController.ftl", pckPath, appControllerPath);
		if (isHtml) {
			CreateFile.writerPage(context, "htmlList.ftl", webPath, htmlPath);
			CreateFile.writerPage(context, "js.ftl", webPath, jsPath);
		}

		log.info("----------------------------代码生成完毕---------------------------");
	}

	public static String getProjectPath() {
		return System.getProperty("user.dir").replace("\\", "/") + "/";
	}

}