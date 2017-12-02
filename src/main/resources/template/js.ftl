function add() {
	self.location = "#[[$]]#!webPath/add${className}";
}

function edit(id) {
	self.location = "#[[$]]#!webPath/edit${className}/" + id;
}

function update(thiz, id, status) {
	var v_data = {
		"${primaryKey}": id,
		"status": val
	};
	var v_status_html = '正常';
	var v_btn_html = '';
	if(val == -1) {// 删除
		v_status_html = '删除';
		v_btn_html = '<button class="btn btn-success btn-xs" type="button" onclick="update(this, \'' + id + '\', 0)">启 用</button>';
	} else if(val == 0) {
		v_status_html = '正常';
		v_btn_html = '<button class="btn btn-danger btn-xs" type="button" onclick="update(this, \'' + id + '\', -1)">停 用</button>';
	} else {
		v_status_html = '';
		v_btn_html = '';
	}
	#[[$]]#.ajax({
		url: "#[[$]]#!webPath/sys/update${className}",
		type: "post",
		dataType: "json",
		data: v_data,
		success: function(data) {
			layer.msg(data.message);
			#[[$]]#('#'+id).html(v_status_html);
			#[[$]]#(thiz).after(v_btn_html);
			#[[$]]#(thiz).remove();
		},
		error: function(jqXHR, textStatus, errorThrown) {
			var data = JSON.parse(jqXHR.responseText);
			layer.msg(data.message);
		}
	});
}

function query() {
	#[[$]]#('#pageNum').val(1);
	#[[$]]#('#queryForm').submit();
}