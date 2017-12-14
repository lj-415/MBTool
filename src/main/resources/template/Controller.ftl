package ${bussPackage}.controller.system;

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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import ${bussPackage}.constant.Constants;
import ${bussPackage}.controller.common.BaseController;
import ${bussPackage}.core.Page;
import ${bussPackage}.entity.${className};
import ${bussPackage}.mv.JModelAndView;
import ${bussPackage}.service.ConfigService;
import ${bussPackage}.service.${className}Service;
import ${bussPackage}.utils.CommUtil;

/**
 * @description ${remark}
 * @author ${author}
 * @date ${time}
 */
@Controller
public class ${className}Controller extends BaseController {
	private static final Logger LOGGER = LoggerFactory.getLogger(${className}Controller.class);

	@Autowired
	private ${className}Service ${lowerName}Service;
	
	@Autowired
	private ConfigService configService;
	
	@RequestMapping("/${lowerName}s")
	public ModelAndView get${className}s(@ModelAttribute("${lowerName}") ${className} ${lowerName}, @ModelAttribute("page") Page page) {
		ModelAndView mv = new JModelAndView("${lowerName}/${lowerName}List", configService.getSysConfig(), 1, request, response);

		return mv;
	}

	@RequestMapping("/${lowerName}Detail/{${primaryKey}}")
	public ModelAndView ${lowerName}Detail(@PathVariable("${primaryKey}") ${primaryKeyShortDataType} ${primaryKey}) {
		ModelAndView mv = new JModelAndView("${lowerName}/${lowerName}Detail", configService.getSysConfig(), 1, request, response);
		${className} ${lowerName} = ${lowerName}Service.queryByPrimaryKey(${primaryKey});
		mv.addObject("${lowerName}", ${lowerName});

		return mv;
	}

	@RequestMapping("/add${className}")
	public ModelAndView add${className}() {
		ModelAndView mv = new JModelAndView("${lowerName}/add${className}", configService.getSysConfig(), 1, request, response);
		return mv;
	}

	@RequestMapping("/edit${className}/{${primaryKey}}")
	public ModelAndView edit${className}(@PathVariable("${primaryKey}") ${primaryKeyShortDataType} ${primaryKey}) {
		ModelAndView mv = new JModelAndView("${lowerName}/${lowerName}Detail", configService.getSysConfig(), 1, request, response);
		${className} ${lowerName} = ${lowerName}Service.queryByPrimaryKey(${primaryKey});
		mv.addObject("${lowerName}", ${lowerName});

		return mv;
	}

	/**
	 * AJAX详情
	 * 
	 * @param ${primaryKey}
	 * @return
	 */
	@RequestMapping("/sys/${lowerName}Detail")
	@ResponseBody
	public Object sys${className}Detail(@RequestParam("${primaryKey}") ${primaryKeyShortDataType} ${primaryKey}) {
		${className} ${lowerName} = ${lowerName}Service.queryByPrimaryKey(${primaryKey});
		if (${lowerName} == null) {
			initErroeMsg(map, Constants.STATUS_MSG.REQ_ID_NOTEXITS.getKey(), Constants.STATUS_MSG.REQ_ID_NOTEXITS.getValue());
		} else {
			setReturnData(${lowerName});
		}

		return map;
	}

	/**
	 * AJAX查询
	 * 
	 * @param user
	 * @param page
	 * @return
	 */
	@RequestMapping("/sys/query${className}")
	@ResponseBody
	public Object sysQuery${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}, @ModelAttribute("page") Page page) {
		List<${className}> ${lowerName}s = ${lowerName}Service.getList(${lowerName}, page);
		setReturnData(new PageInfo<>(${lowerName}s));

		return map;
	}

	/**
	 * AJAX保存
	 * 
	 * @param ${lowerName}
	 * @return
	 */
	@RequestMapping("/sys/save${className}")
	@ResponseBody
	public Object sysSave${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}) {
		int flag = -1;
		if (${lowerName}.getId() != null) {
			${lowerName}.setUpdateTime(CommUtil.formatDate(new Date()));
			flag = ${lowerName}Service.update(${lowerName});
		} else {
			${lowerName}.setAddTime(CommUtil.formatDate(new Date()));
			flag = ${lowerName}Service.insert(${lowerName});
		}
		if (flag < 1) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
		}

		return map;
	}

	/**
	 * AJAX更新
	 * 
	 * @param ${lowerName}
	 * @return
	 */
	@RequestMapping("/sys/update${className}")
	@ResponseBody
	public Object sysUpdate${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}) {
		${lowerName}.setUpdateTime(CommUtil.formatDate(new Date()));
		int flag = ${lowerName}Service.update(${lowerName});
		if (flag < 1) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
		}

		return map;
	}

	/**
	 * AJAX删除
	 * 
	 * @param ${primaryKey}
	 * @param ${primaryKey}s 多个ID， 用英文逗号分隔
	 * @return
	 */
	@RequestMapping("/sys/del${className}")
	@ResponseBody
	public Object sysDelete${className}(@RequestParam(value = "${primaryKey}", required = false) ${primaryKeyShortDataType} ${primaryKey}, @RequestParam(value = "${primaryKey}s", required = false) String ${primaryKey}s) {
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
