package ${bussPackage}.service;

import java.util.List;

import ${bussPackage}.entity.${className};

/**
 * @description: ${remark}
 * @author ${author}
 * @date ${time}
 */
public interface ${className}Service {
	
	public ${className} get${className}ByPrimaryKey(String ${primaryKey});

	public List<${className}> get${className}s(${className} ${lowerName});

	public int insert(${className} ${lowerName});

	public int update(${className} ${lowerName});

	public int delete(String ${primaryKey});
	
}