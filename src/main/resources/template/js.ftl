
		/**
		 * ${remark}
		 */
		// 查询条件
		var v_cond = {
			"pageNum": 1,
			"pageSize": 10
		};
		#[[$]]#(function() {
			loadData();
		});

		/**
		 * 加载数据
		 * @returns
		 */
		function loadData() {
			v_cond.searchKey = #[[$]]#('#searchKey').val();
			v_cond.datemin = #[[$]]#('#datemin').val();
			v_cond.datemax = #[[$]]#('#datemax').val();
			var ly_index = layer.load(0, {shade: [0.5,'#fff'], time: 120000}); //0代表加载的风格，2分钟
			#[[$]]#.ajax({
				url: "#[[$]]#!webPath/sys/query${className}",
				type: "post",
				dataType: "json",
				data: v_cond,
				success: function(data) {
					var html = '<tr class="text-c"><td colspan="3" style="text-align: center;">未查询到数据</td></tr>';
					var rstData = data.data;
		            var results = rstData.list;
		            if(results.length > 0) {
		            	html = '';
		                for (var i = 0; i < results.length; i++) {
		                	var result = results[i];
		                	html += '';
		                	
		                	html += '<tr class="text-c">';
	                			html += '<td><input type="checkbox" value="' + result.${primaryKey} + '" name="cbx_id"></td>';
		       					if(result.status == 0) {
		    						html += '<td class="td-status"><span class="label label-success">已启用</span></td>';
		       					} else {
		    						html += '<td class="td-status"><span class="label label-warning">已停用</span></td>';
		       					}
		      					html += '<td class="td-manage">';
	      							if(result.status == -1) {
	      								html += '<a title="启用" href="javascript:void(0);" onClick="stopStart(this, ' + result.${primaryKey} + ', 0, 1, \'#[[$]]#!webPath/sys/update${className}\')" class="permission_start" style="text-decoration:none"><i class="fa fa-check-circle-o"></i></a>';
	      							} else {
	      								html += '<a title="停用" href="javascript:void(0);" onClick="stopStart(this, ' + result.${primaryKey} + ', -1, 0, \'#[[$]]#!webPath/sys/update${className}\')" class="permission_stop" style="text-decoration:none"><i class="fa fa-ban"></i></a>';
	      							}
	      							html += '<a title="编辑" href="javascript:void(0);" onclick="showPage(\'编辑${remark}\',\'#[[$]]#!webPath/edit${className}/' + result.${primaryKey} + '\', 60, 60)" class="ml-5 permission_edit" style="text-decoration:none"><i class="fa fa-edit"></i></a>';
	      							html += '<a title="删除" href="javascript:void(0);" onclick="del(this, ' + result.${primaryKey} + ', \'#[[$]]#!webPath/sys/del${className}\')" class="ml-5 permission_del" style="text-decoration:none"><i class="fa fa-times-circle"></i></a>';
		      					html += '</td>';
		    				html += '</tr>';
		                }
		            }
		            #[[$]]#('#tb_data').html('').html(html);
		            layer.close(ly_index);
		            initPager(rstData.total, v_cond);// 分页
		        },
		        error: function(XmlHttpRequest, textStatus, errorThrown) {
		        	var data = JSON.parse(XmlHttpRequest.responseText);
		            layer.msg(data.message, { icon: 1, time: 1000 });
		            layer.close(ly_index);
		        }
			});
		}
