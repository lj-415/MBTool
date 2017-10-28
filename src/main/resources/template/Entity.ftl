package ${bussPackage}.entity;

import java.io.Serializable;
#foreach($columnData in $!{columnDatas})
#if($!columnData.dataType.indexOf("java.lang") < 0)
import $!columnData.dataType;
#end
#end

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
	
}