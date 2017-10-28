package ${bussPackage}.controller.system;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import ${bussPackage}.constant.Constants;
import ${bussPackage}.controller.common.BaseController;
import ${bussPackage}.entity.Page;
import ${bussPackage}.entity.${className};
import ${bussPackage}.mv.JModelAndView;
import ${bussPackage}.service.ConfigService;
import ${bussPackage}.service.${className}Service;

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
		PageHelper.startPage(page.getPageNum(), page.getPageSize());
		List<${className}> ${lowerName}s = ${lowerName}Service.get${className}s(${lowerName});
		mv.addObject("resultPages", new PageInfo<>(${lowerName}s));
		mv.addObject("qrCond", ${lowerName});
		
		return mv;
	}
	
	@RequestMapping("/add${className}")
	public ModelAndView add${className}() {
		ModelAndView mv = new JModelAndView("${lowerName}/add${className}", configService.getSysConfig(), 1, request, response);
		
		return mv;
	}
	
	@RequestMapping("/edit${className}/{${primaryKey}}")
	public ModelAndView edit${className}(@PathVariable(value = "${primaryKey}") String ${primaryKey}) {
		ModelAndView mv = new JModelAndView("${lowerName}/add${className}", configService.getSysConfig(), 1, request, response);
		${className} ${lowerName} = ${lowerName}Service.get${className}ByPrimaryKey(${primaryKey});
		mv.addObject("${lowerName}", ${lowerName});

		return mv;
	}
	
	@RequestMapping("/save${className}")
	public ModelAndView save${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}) {
		ModelAndView mv = new JModelAndView("500", configService.getSysConfig(), 1, request, response);
		
		int flag = -1;
		if (${lowerName}.getId() != null) {
			flag = ${lowerName}Service.update(${lowerName});
		} else {
			flag = ${lowerName}Service.insert(${lowerName});
		}
		if (flag > 0) {
			mv = new JModelAndView("redirect:/${lowerName}s", configService.getSysConfig(), 1, request, response);
		}
		
		return mv;
	}
	
	/**
	 * AJAX更新
	 * @param ${lowerName}
	 * @return
	 */
	@RequestMapping("/sys/update${className}")
	@ResponseBody
	public Object sysUpdate${className}(@ModelAttribute("${lowerName}") ${className} ${lowerName}) {
		int flag = ${lowerName}Service.update(${lowerName});
		if (flag < 1) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
		}
		
		return map;
	}

}
