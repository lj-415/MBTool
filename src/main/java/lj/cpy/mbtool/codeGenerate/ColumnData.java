package lj.cpy.mbtool.codeGenerate;

public class ColumnData {
	private String columnName;// 列名
	private String columnComment;// 列备注
	private String columnType;// 列数据类型
	private String charmaxLength;// 最大长度
	private String nullable;// 是否为空
	private String precision;// 精度
	private String scale;// 小数位数
	private String columnKey;// 列标识 PRI主键
	
	private String dataType;// 数据类型
	private String shortDataType;// 数据类型简写
	private String propertyName;// entity属性名
	private String upperPropertyName;// entity属性名首字母大写

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnComment() {
		return columnComment;
	}

	public void setColumnComment(String columnComment) {
		this.columnComment = columnComment;
	}

	public String getColumnType() {
		return columnType;
	}

	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}

	public String getCharmaxLength() {
		return charmaxLength;
	}

	public void setCharmaxLength(String charmaxLength) {
		this.charmaxLength = charmaxLength;
	}

	public String getNullable() {
		return nullable;
	}

	public void setNullable(String nullable) {
		this.nullable = nullable;
	}

	public String getPrecision() {
		return precision;
	}

	public void setPrecision(String precision) {
		this.precision = precision;
	}

	public String getScale() {
		return scale;
	}

	public void setScale(String scale) {
		this.scale = scale;
	}

	public String getColumnKey() {
		return columnKey;
	}

	public void setColumnKey(String columnKey) {
		this.columnKey = columnKey;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getShortDataType() {
		return shortDataType;
	}

	public void setShortDataType(String shortDataType) {
		this.shortDataType = shortDataType;
	}

	public String getPropertyName() {
		return propertyName;
	}

	public void setPropertyName(String propertyName) {
		this.propertyName = propertyName;
	}

	public String getUpperPropertyName() {
		return upperPropertyName;
	}

	public void setUpperPropertyName(String upperPropertyName) {
		this.upperPropertyName = upperPropertyName;
	}

}