package lj.cpy.mbtool.codeGenerate;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class CreateFile {
	private static VelocityEngine ve;
	private static final String CONTENT_ENCODING = "UTF-8";
	private static final Log log = LogFactory.getLog(CreateFile.class);

	public CreateFile() {

	}

	public CreateFile(String templatePath) {
		try {
			ve = new VelocityEngine();
			Properties properties = new Properties();
			properties.setProperty("resource.loader", "file");
			properties.setProperty("file.resource.loader.description", "Velocity File Resource Loader");
			properties.setProperty("file.resource.loader.path", templatePath.replaceAll("%20", " "));
			properties.setProperty("file.resource.loader.cache", "true");
			properties.setProperty("file.resource.loader.modificationCheckInterval", "30");
			properties.setProperty("runtime.log.logsystem.class", "org.apache.velocity.runtime.log.Log4JLogChute");
			properties.setProperty("runtime.log.logsystem.log4j.logger", "org.apache.velocity");
			properties.setProperty("directive.set.null.allowed", "true");
			properties.setProperty("output.encoding", CONTENT_ENCODING);
			properties.setProperty("input.encoding", CONTENT_ENCODING);
			ve.init(properties);
		} catch (Exception e) {
			log.error(e);
		}
	}

	public void writerPage(VelocityContext context, String templateName, String fileDirPath, String targetFile) {
		if (ve == null) {
			log.info("引擎初始化失败");
			return;
		}
		File file = new File(fileDirPath + targetFile);
		if (!file.exists()) {
			new File(file.getParent()).mkdirs();
		} else {
			log.info("替换文件:" + file.getAbsolutePath());
		}

		Template template = ve.getTemplate(templateName, CONTENT_ENCODING);
		if (template != null) {
			FileOutputStream fos = null;
			BufferedWriter writer = null;
			try {
				fos = new FileOutputStream(file);
				writer = new BufferedWriter(new OutputStreamWriter(fos, CONTENT_ENCODING));
				template.merge(context, writer);
				writer.flush();
				writer.close();
				fos.close();
				log.info("生成文件：" + file.getAbsolutePath());
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				if (writer != null) {
					try {
						writer.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				if (fos != null) {
					try {
						fos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else {
			log.info("===================获取模板失败=================" + templateName);
		}
	}
}