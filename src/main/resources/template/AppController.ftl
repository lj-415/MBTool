package ${bussPackage}.controller.app;

#if($!primaryKeyDataType.indexOf("java.lang") < 0)
import $!primaryKeyDataType;
#end
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${bussPackage}.constant.Constants;
import ${bussPackage}.controller.common.BaseController;
import ${bussPackage}.core.Page;
import ${bussPackage}.entity.${className};
import ${bussPackage}.service.${className}Service;
import ${bussPackage}.utils.CommUtil;

/**
 * @description ${remark}
 * @author ${author}
 * @date ${time}
 */
@RestController
public class App${className}Controller extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(App${className}Controller.class);
	
	@Autowired
	private ${className}Service ${lowerName}Service;
	
	/**
	 * 清单
	 * @param ${lowerName}
	 * @param page
	 * @return
	 */
	@RequestMapping("/app/get${className}s")
	public Object get${className}s(@ModelAttribute("${lowerName}") ${className} ${lowerName}, @ModelAttribute("page") Page page) {
		PageHelper.startPage(page.getPageNum(), page.getPageSize());
		List<${className}> ${lowerName}s = ${lowerName}Service.getList(${lowerName});
		
		setReturnData(new PageInfo<>(${lowerName}s));
		return map;
	}
	
	/**
	 * 详情
	 * @param ${primaryKey}
	 * @return
	 */
	@RequestMapping("/app/get${className}Detail")
	public Object get${className}Detail(@RequestParam("${primaryKey}") ${primaryKeyShortDataType} ${primaryKey}) {
		${className} ${lowerName} = ${lowerName}Service.queryByPrimaryKey(${primaryKey});
		if (${lowerName} == null) {
			initErroeMsg(map, Constants.STATUS_MSG.REQ_ID_NOTEXITS.getKey(), Constants.STATUS_MSG.REQ_ID_NOTEXITS.getValue());
		} else {
			setReturnData(${lowerName});
		}
		
		return map;
	}
	
	/**
	 * 新增更新
	 * @param ${lowerName}
	 * @return
	 */
	@RequestMapping("/app/merge${className}")
	public Object merge${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}) {
		int flag = -1;
		if (${lowerName}.getId() != null) {// 更新
			flag = ${lowerName}Service.update(${lowerName});
		} else {// 新增
			${lowerName}.setStatus(Constants.NUMBER.ZERO.getValue());
			${lowerName}.setAddTime(CommUtil.formatDate(new Date()));
			flag = ${lowerName}Service.insert(${lowerName});
		}
		
		if (flag <= 0) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
			return map;
		}
		setReturnData(${lowerName});
		
		return map;
	}
	
	/**
	 * 删除
	 * @param ${primaryKey}
	 * @param ${primaryKey}s 多个ID， 用英文逗号分隔
	 * @return
	 */
	@RequestMapping("/app/delete${className}")
	public Object sysDeleteFeedback(@RequestParam(value = "${primaryKey}", required = false) ${primaryKeyShortDataType} ${primaryKey}, @RequestParam(value = "${primaryKey}s", required = false) String ${primaryKey}s) {
		if (${primaryKey} == null && StringUtils.isBlank(${primaryKey}s)) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), "未选择需要删除的数据");
			return map;
		}
		int flag = -1;
		if (${primaryKey} != null) {
			flag = ${lowerName}Service.deleteByPrimaryKey(${primaryKey});
		}
		if (StringUtils.isNotBlank(${primaryKey}s)) {
			List<Object> ${primaryKey}List = Arrays.asList(${primaryKey}s.split(","));
			flag = ${lowerName}Service.deleteByPrimaryKeys(${primaryKey}List);
		}
		if (flag < 1) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
		}

		return map;
	}

}
