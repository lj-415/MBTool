package ${bussPackage}.entity;

import java.io.Serializable;
#foreach($columnData in $!{columnDatas})
#if($!columnData.dataType.indexOf("java.lang") < 0)
import $!columnData.dataType;
#end
#end

import com.alibaba.fastjson.JSON;

/**
 * @description: ${remark}
 * @author ${author}
 * @date ${time}
 */
public class ${className} implements Serializable {

	private static final long serialVersionUID = 1L;

#foreach($columnData in $!{columnDatas})
	/**
	 * $!columnData.columnComment
	 */
	private $!columnData.shortDataType $!columnData.propertyName;
#end
#foreach($columnData in $!{columnDatas})
#set($upperPropertyName = $!columnData.upperPropertyName)
	
	public $!columnData.shortDataType get${upperPropertyName}() {
		return $!columnData.propertyName;
	}
	
	public void set${upperPropertyName}($!columnData.shortDataType $!columnData.propertyName) {
		this.$!columnData.propertyName = $!columnData.propertyName;
	}
#end
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return JSON.toJSONString(this, false);
	}
}