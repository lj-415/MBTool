package ${bussPackage}.service.impl;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${bussPackage}.core.AbstractService;
import ${bussPackage}.entity.${className};
import ${bussPackage}.mapper.${className}Mapper;
import ${bussPackage}.service.${className}Service;
import ${bussPackage}.utils.CommUtil;

/**
 * @description: ${remark}
 * @author ${author}
 * @date ${time}
 */
@Service
public class ${className}ServiceImpl extends AbstractService<${className}> implements ${className}Service {
	
	@Autowired
	private ${className}Mapper ${lowerName}Mapper;
	
	/* (non-Javadoc)
	 * @see ${bussPackage}.service.${className}#[[Service]]##delete${className}(java.lang.String)
	 */
	@Override
	public int delete${className}(String ${primaryKey}s) {
		int flag = -1;
		List<Object> keyList = Arrays.asList(${primaryKey}s.split(","));
		flag = ${lowerName}Mapper.deleteByPrimaryKeys(keyList);
		return flag;
	}
	
	/* (non-Javadoc)
	 * @see ${bussPackage}.service.${className}#[[Service]]##merge${className}(${bussPackage}.entity.${className})
	 */
	@Override
	public int merge${className}(${className} ${lowerName}) {
		int flag = -1;
#set($primaryKey = ${primaryKey})
#set($upperKey = ($!primaryKey.substring(0, 1).toUpperCase() + $!primaryKey.substring(1)))
		if (${lowerName}.get$!upperKey() == null) {
			// 新增
			${lowerName}.setAddTime(CommUtil.formatDate(new Date()));
			flag = ${lowerName}Mapper.insert(${lowerName});
		} else {
			// 更新
			flag = ${lowerName}Mapper.update(${lowerName});
		}
		return flag;
	}
	
}