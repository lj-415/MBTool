<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
  "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${bussPackage}.mapper.${className}Mapper">
	<resultMap id="${lowerName}Mapper" type="${className}">
#foreach($item in $!columnDatas)
		<result property="$item.propertyName" column="$!item.columnName"/>
#end
	</resultMap>

	<sql id="sql_columns">
		${sql_columns}
	</sql>

	<sql id="sql_condition">
		<trim prefix="where" prefixOverrides="and|or">
${sql_condition}
		</trim>
	</sql>

	<sql id="sql_update_set">
		<trim prefix="set" prefixOverrides=",">
${sql_update_set}
		</trim>
	</sql>

	<sql id="sql_insert_column">
		<trim prefix="" prefixOverrides=",">
${sql_insert_column}
		</trim>
	</sql>

	<sql id="sql_insert_value">
		<trim prefix="" prefixOverrides=",">
${sql_insert_value}
		</trim>
	</sql>

	<select id="get${className}ByPrimaryKey" parameterType="String" resultMap="${lowerName}Mapper">
		select
		<include refid="sql_columns" />
		from ${tableName} where ${primaryKey} = #{param1}
	</select>

	<select id="get${className}s" parameterType="${lowerName}" resultMap="${lowerName}Mapper">
		select
		<include refid="sql_columns" />
		from ${tableName}
		<include refid="sql_condition" />
	</select>
	
#if(${keyType} == '01')
	<insert id="insert" parameterType="${lowerName}">
		<selectKey resultType="java.lang.String" order="BEFORE" keyProperty="${primaryKey}">
			select replace(uuid(), '-', '')
		</selectKey>
		insert into ${tableName} (
		<include refid="sql_insert_column" />
		) values (
		<include refid="sql_insert_value" />
		)
	</insert>
#else
	<insert id="insert" parameterType="${lowerName}" useGeneratedKeys="true" keyProperty="${primaryKey}">
		insert into ${tableName} (
		<include refid="sql_insert_column" />
		) values (
		<include refid="sql_insert_value" />
		)
	</insert>
#end

	<update id="update" parameterType="${lowerName}">
		update ${tableName}
		<include refid="sql_update_set" />
		where ${primaryKey} = #{param1}
	</update>

	<delete id="delete" parameterType="String">
		delete from ${tableName} where ${primaryKey} = #{param1}
	</delete>

</mapper>