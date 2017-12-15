package ${bussPackage}.service;

import ${bussPackage}.core.Service;
import ${bussPackage}.entity.${className};

/**
 * @description: ${remark}
 * @author ${author}
 * @date ${time}
 */
public interface ${className}Service extends Service<${className}> {

	/**
	 * 删除${remark}
	 * 
	 * @param ids 多个ID， 用英文逗号分隔
	 * @return
	 */
	int delete${className}(String ${primaryKey}s);
	
	/**
	 * 新增、更新${remark}
	 * @param ${lowerName}
	 * @return
	 */
	int merge${className}(${className} ${lowerName});
	
}