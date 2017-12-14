<!DOCTYPE html>
<html>

<head>
    <title>${remark}列表</title>
    <!-- _meta -->
    #[[#]]#parse("./system/_meta.html")
    <!-- _meta -->
</head>

<body class="hold-transition skin-blue sidebar-mini">
    <div class="wrapper">
        #[[#]]#parse("./system/_header.html")
        <!-- Left side column. contains the logo and sidebar -->
        #[[#]]#parse("./system/_menu.html")
        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <h1>${remark}列表</h1>
                <ol class="breadcrumb">
                    <li><a href="#[[$]]#!webPath/admin"><i class="fa fa-dashboard"></i>首页</a></li>
        			<li><a href="javascript:void(0);">${remark}管理</a></li>
        			<li class="active">${remark}列表</li>
                </ol>
            </section>
            <!-- Main content -->
            <section class="content">
            	<div class="row">
            		<div class="col-xs-12">
           				<div class="box box-info">
           					<div class="form-horizontal">
           						<div class="box-body">
           							<div class="col-sm-4">
	           							<div class="form-group">
			           						<div class="input-group">
				            					<input type="text" onfocus="WdatePicker({maxDate:'#F{#[[$]]#dp.#[[$]]#D(\'datemax\')||\'%y-%M-%d\'}'})" id="datemin" class="form-control Wdate" placeholder="添加日期">
											    <span class="input-group-addon">-</span>
									            <input type="text" onfocus="WdatePicker({minDate:'#F{#[[$]]#dp.#[[$]]#D(\'datemin\')}',maxDate:'%y-%M-%d'})" id="datemax" class="form-control Wdate" placeholder="添加日期">
											</div>
			          					</div>
           							</div>
           							<div class="col-sm-4">
	           							<div class="form-group">
								            <input type="text" class="form-control" placeholder="输入名称" id="searchKey" name="searchKey">
			          					</div>
		          					</div>
           							<div class="col-sm-4">
	           							<div class="form-group">
	           								<button type="submit" class="btn btn-success pull-right" onclick="loadData()">搜${remark}</button>
			          					</div>
		          					</div>
           						</div>
           					</div>
				        </div>
			        </div>
            		<div class="col-xs-12">
            			<div class="box box-info">
           					<div class="box-header">
					            <button type="submit" class="btn btn-danger permission_del_all" onclick="delAll('#[[$]]#!webPath/sys/del${className}')">批量删除</button>
					            <button type="submit" class="btn btn-info permission_add" onclick="showPage('添加${remark}','#[[$]]#!webPath/add${className}', 60, 60)">添加${remark}</button>
           					</div>
           					<div class="box-body permission_view">
					        	<table id="_data" class="table table-bordered table-hover">
						            <thead>
						                <tr>
						                    <th width="25"><input type="checkbox" name="" value="" onclick="selectAll(this)"></th>
											<th width="70">状态</th>
											<th width="100">操作</th>
						                </tr>
						            </thead>
						            <tbody id="tb_data">
										
						            </tbody>
						        </table>
						        <div id="div_pagination" style="float: right;"></div>
					        </div>
				        </div>
			        </div>
		        </div>
	        </section>
        </div>
		<!-- /.content-wrapper -->
    	#[[#]]#parse("./system/_footer.html")
        <!-- Control Sidebar -->
        #[[#]]#parse("./system/_sidebar.html")
        <!-- /.control-sidebar -->
        <!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
        <div class="control-sidebar-bg"></div>
    </div>
    #[[#]]#parse("./system/_script.html")
    <script type="text/javascript">
    	#[[#]]#parse("./system/${lowerName}/${lowerName}.js")
    </script>
</body>

</html>