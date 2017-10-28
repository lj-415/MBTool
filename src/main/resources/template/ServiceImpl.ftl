package ${bussPackage}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${bussPackage}.entity.${className};
import ${bussPackage}.mapper.${className}Mapper;
import ${bussPackage}.service.${className}Service;

/**
 * @description: ${remark}
 * @author ${author}
 * @date ${time}
 */
@Service
public class ${className}ServiceImpl implements ${className}Service {
	
	@Autowired
	private ${className}Mapper ${lowerName}Mapper;

	@Override
	public ${className} get${className}ByPrimaryKey(String ${primaryKey}) {
		// TODO Auto-generated method stub
		return ${lowerName}Mapper.get${className}ByPrimaryKey(${primaryKey});
	}

	@Override
	public List<${className}> get${className}s(${className} ${lowerName}) {
		// TODO Auto-generated method stub
		return ${lowerName}Mapper.get${className}s(${lowerName});
	}

	@Override
	public int insert(${className} ${lowerName}) {
		// TODO Auto-generated method stub
		return ${lowerName}Mapper.insert(${lowerName});
	}

	@Override
	public int update(${className} ${lowerName}) {
		// TODO Auto-generated method stub
		return ${lowerName}Mapper.update(${lowerName});
	}

	@Override
	public int delete(String ${primaryKey}) {
		// TODO Auto-generated method stub
		return ${lowerName}Mapper.delete(${primaryKey});
	}
	
}