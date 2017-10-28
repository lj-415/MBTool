package ${bussPackage}.controller.app;

import java.util.Date;
import java.util.List;

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
import ${bussPackage}.entity.Page;
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
		List<${className}> ${lowerName}s = ${lowerName}Service.get${className}s(${lowerName});
		
		setReturnData(new PageInfo<>(${lowerName}s));
		return map;
	}
	
	/**
	 * 详情
	 * @param ${primaryKey}
	 * @return
	 */
	@RequestMapping("/app/get${className}Detail")
	public Object get${className}Detail(@RequestParam("${primaryKey}") String ${primaryKey}, @ModelAttribute("page") Page page) {
		${className} ${lowerName} = ${lowerName}Service.get${className}ByPrimaryKey(${primaryKey});
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
	 * @return
	 */
	@RequestMapping("/app/delete${className}")
	public Object delete${className}(@RequestParam("${primaryKey}") String ${primaryKey}) {
		int flag = ${lowerName}Service.delete(${primaryKey});
		
		if (flag <= 0) {
			initErroeMsg(map, Constants.STATUS_MSG.FAILURE.getKey(), Constants.STATUS_MSG.FAILURE.getValue());
			return map;
		}
		
		return map;
	}

}
