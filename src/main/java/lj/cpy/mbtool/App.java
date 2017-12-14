package lj.cpy.mbtool;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import lj.cpy.mbtool.codeGenerate.CodeGenerateFactory;
import lj.cpy.mbtool.codeGenerate.CodeResource;

/**
 * @description
 * @author LiJing
 * @date 2017年10月27日 下午1:58:43
 */
public class App {

	public static void main(String[] args) {
		// 表名
		String tableName = null;
		// 类对象名
		String className = null;
		// 备注
		String remark = null;
		// 主键生成方式 01:UUID 02:自增
		String keyType = CodeResource.KEY_TYPE_02;
		// 是否生成html文件
		boolean isCreateHtml = true;
		
		String templatePath = ClassLoader.getSystemResource("template").getPath();
		if (templatePath.startsWith("/")) {
			templatePath = templatePath.substring(1, templatePath.length());
		}

		try {
			File file = new File("src/main/resources/tables.xlsx");
			XSSFWorkbook workbook = new XSSFWorkbook(file);
			if (workbook != null) {
				for (Iterator<Sheet> iSheet = workbook.sheetIterator(); iSheet.hasNext();) {
					Sheet sheet = iSheet.next();
					if (sheet == null) {
						continue;
					}
					int ind = 0;
					for (Iterator<Row> iRow = sheet.iterator(); iRow.hasNext();) {
						// 过滤第一行
						if (ind == 0) {
							++ind;
							iRow.next();
							continue;
						}
						Row row = iRow.next();
						if (row == null) {
							continue;
						}
						tableName = null;
						className = null;
						remark = null;
						for (Iterator<Cell> iCell = row.iterator(); iCell.hasNext();) {
							Cell cell = iCell.next();
							if (ind == 1) {
								tableName = cell.getStringCellValue();
							} else if (ind == 2) {
								className = cell.getStringCellValue();
							} else if (ind == 3) {
								remark = cell.getStringCellValue();
							}
							++ind;
						}
						if (tableName != null && className != null) {
							CodeGenerateFactory.codeGenerate(tableName, className, remark, keyType, isCreateHtml, templatePath);
						}
					}
				}
				workbook.close();
			}
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
