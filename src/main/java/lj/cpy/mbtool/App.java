package lj.cpy.mbtool;

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
		String tableName = "t_member";
		// 类对象名
		String className = "Member";
		// 备注
		String remark = "会员";
		// 主键生成方式 01:UUID 02:自增
		String keyType = CodeResource.KEY_TYPE_01;
		// 是否生成html文件
		boolean isCreateHtml = true;

		CodeGenerateFactory.codeGenerate(tableName, className, remark, keyType, isCreateHtml);
	}
	
}
