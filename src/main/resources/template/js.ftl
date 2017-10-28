function add() {
	self.location = "@_@!webPath/add${className}";
}

function edit(id) {
	self.location = "@_@!webPath/edit${className}/" + id;
}

function update(thiz, id, status) {
	$.ajax({
		url: "@_@!webPath/sys/update${className}",
		type: "post",
		dataType: "json",
		data: {
			"${primaryKey}": id,
			"status": status
		},
		success: function(data) {
			layer.msg(data.message);
			if(status == -1) {
				$('#'+id).html('删除');
				$(thiz).parent().append('<button class="btn btn-primary btn-xs" type="button" onclick="update(this, \'' + id + '\', 0)">启 用</button>');
				$(thiz).remove();
			} else {
				$('#'+id).html('正常');
				$(thiz).parent().append('<button class="btn btn-danger btn-xs" type="button" onclick="update(this, \'' + id + '\', -1)">删 除</button>');
				$(thiz).remove();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			var data = JSON.parse(jqXHR.responseText);
			layer.msg(data.message);
		}
	});
}

function query() {
	$('#pageNum').val(1);
	$('#queryForm').submit();
}