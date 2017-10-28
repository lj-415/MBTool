<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <link rel="shortcut icon" href="@_@!webPath/resources/images/logo_icon.png" type="image/png">
    <title>${remark}管理</title>
    
    <link href="@_@!webPath/resources/js/advanced-datatable/css/demo_table.css" rel="stylesheet" />
    <link href="@_@!webPath/resources/css/style.css" rel="stylesheet">
    <link href="@_@!webPath/resources/css/style-responsive.css" rel="stylesheet">
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
	<script src="@_@!webPath/resources/js/html5shiv.js"></script>
	<script src="@_@!webPath/resources/js/respond.min.js"></script>
	<![endif]-->
	<!-- 文字太多转成点点 -->
	<style type="text/css">
		.table-data {
			table-layout: fixed;
		}
		.table-data td {
			text-overflow: ellipsis;
			white-space: nowrap;
			overflow: hidden;
		}
	</style>
</head>

<body class="sticky-header">
    <section>
        <!-- left side start-->
        @=@parse("./system/nav.html")
        <!-- left side end-->
        <!-- main content start-->
        <div class="main-content">
            <!-- header section start-->
            @=@parse("./system/header.html")
            <!-- header section end-->
            <!-- page heading start-->
            <div class="page-heading">
                <ul class="breadcrumb">
                    <li>
                        <a href="@_@!webPath/admin">首页</a>
                    </li>
                    <li>
                        <a href="javascript:void(0)">业务管理</a>
                    </li>
                    <li class="active">${remark}管理</li>
                </ul>
            </div>
            <!-- page heading end-->
            <!--body wrapper start-->
            <div class="wrapper">
                <div class="row">
                    <div class="col-sm-12">
                        <section class="panel">
                        	<form id="queryForm" action="@_@!webPath/${lowerName}s" method="post">
	                        	<header class="panel-heading">
						            &nbsp;
	                        		<span class="tools pull-left col-md-10">
	                        			<div class="row">
	                        				<div class="col-md-2 form-group">
							                	<input class="form-control" type="text" placeholder="姓名或介绍" name="searchKey" value="@_@!qrCond.searchKey">
	                        				</div>
	                        				<div class="col-md-2 form-group">
								                <select class="form-control" name="status">
			                                        <option value="">状态</option>
			                                        <option value="0" @=@if(@_@!qrCond.status == 0)selected@=@end>正常</option>
			                                        <option value="-1" @=@if(@_@!qrCond.status == -1)selected@=@end>删除</option>
		                                    	</select>
	                        				</div>
							         	</div>
						            </span>
	                                <span class="tools pull-right">
						                <button class="btn btn-primary btn-sm" type="button" onclick="query()">搜 索</button>
						                <button class="btn btn-primary btn-sm" type="button" onclick="add()">新 增</button>
						             </span>
	                            </header>
	                            <div class="panel-body">
	                                <div class="adv-table">
	                                    <table class="display table table-bordered table-striped">
	                                        <thead>
	                                            <tr>
	                                                <th class="col-md-1">ID</th>
	                                                <th class="col-md-1">状态</th>
	                                                <th class="col-md-1">操作</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	@_@set(@_@items = @_@!resultPages.list)
	                                            @=@foreach(@_@item in @_@!items)
	                                            <tr class="gradeA">
	                                                <td>@_@!item.${primaryKey}</td>
	                                                <td id="@_@!item.${primaryKey}">@=@if(@_@!item.status == -1)删除@=@else正常@=@end</td>
	                                                <td class="center">
	                                                	<button class="btn btn-info btn-xs" type="button" onclick="edit('@_@!item.${primaryKey}')" style="margin: 4px;" style="margin: 4px;">编 辑</button>
	                                                	@=@if(@_@!item.status == "0")
	                                                	<button class="btn btn-danger btn-xs" type="button" onclick="update(this, '@_@!item.${primaryKey}', -1)">删 除</button>
	                                                	@=@else
	                                                	<button class="btn btn-primary btn-xs" type="button" onclick="update(this, '@_@!item.${primaryKey}', 0)">启 用</button>
	                                                	@=@end
	                                                </td>
	                                            </tr>
	                                            @=@end
	                                        </tbody>
	                                    </table>
	                                    <span class="tools pull-right">
	                                    	@=@parse("./system/pager.html")
	                                    </span>
	                                </div>
	                            </div>
                        	</form>
                        </section>
                    </div>
                </div>
            </div>
            <!--body wrapper end-->
            <!--footer section start-->
            @=@parse("./system/footer.html")
            <!--footer section end-->
        </div>
        <!-- main content end-->
    </section>
    
    @=@parse("./system/commPage.html")
    <!--common scripts for all pages-->
    <script src="@_@!webPath/resources/js/scripts.js"></script>
    <script src="${lowerName}.js"></script>
    
</body>

</html>
