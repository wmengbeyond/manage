<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- iCheck for checkboxes and radio inputs -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/adminlte/plugins/iCheck/all.css">

<!-- iCheck 1.0.1 -->
<script src="${pageContext.request.contextPath}/adminlte/plugins/iCheck/icheck.min.js"></script>

<script>
    // 查询参数
    search_type = 0
    search_keyWord = null

    $(function(){
        datePickerInit();
        baseTableInit();
        searchActionInit();

        //iCheck for checkbox and radio inputs
        $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
            checkboxClass: 'icheckbox_minimal-blue',
            radioClass: 'iradio_minimal-blue'
        });
        //Red color scheme for iCheck
        $('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
            checkboxClass: 'icheckbox_minimal-red',
            radioClass: 'iradio_minimal-red'
        });
        //Flat red color scheme for iCheck
        $('input[type="checkbox"].square-green, input[type="radio"].square-green').iCheck({
            checkboxClass: 'icheckbox_flat-green',
            radioClass: 'iradio_flat-green'
        });
    })

    // 日期选择器初始化
	function datePickerInit(){
		$('.form_date').datetimepicker({
			format:'yyyy-mm-dd',
			language : 'zh-CN',
			endDate : new Date(),
			weekStart : 1,
			todayBtn : 1,
			autoClose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			minView:2
		});
	}

	// 表格初始化
	function baseTableInit(){
	    $('#baseRecordDOS').bootstrapTable({
	        columns:[{
	            field : 'id',
	            title : '记录ID'
	        },{
	            field : 'code',
	            title : '编号'
	        },{
	            field : 'name',
	            title : '名称'
	        },{
	            field : 'addr',
	            title : '地址'
	        },{
	            field : 'tel',
	            title : '座机'
	        },{
	            field : 'contact',
	            title : '负责人'
            },{
                field : 'phone',
                title : '负责人手机'
            },{
                field : 'operation',
                title : '操作',
                formatter : function(value, row, index) {
                    var s = '<button class="btn btn-info btn-sm edit"><span>编辑</span></button>';
                    var d = '<button class="btn btn-danger btn-sm delete"><span>删除</span></button>';
                    var fun = '';
                    return s + ' ' + d;
                },
                events : {
                    // 操作列中编辑按钮的动作
                    'click .edit' : function(e, value,
                                             row, index) {
                        selectID = row.id;
                        rowEditOperation(row);
                    },
                    'click .delete' : function(e,
                                               value, row, index) {
                        selectID = row.id;
                        $('#deleteWarning_modal').modal(
                            'show');
                    }
                }
	        }],
	        url : 'baseManage/getWarehouseRecords',
            onLoadError:function(status){
                handleAjaxError(status);
            },
	        method : 'GET',
	        queryParams : queryParams,
            sidePagination : "server",
            dataType : 'json',
            pagination : true,
            pageNumber : 1,
            pageSize : 5,
            pageList : [ 5, 10, 25, 50, 100 ],
            clickToSelect : true
	    });
	}

	// 表格刷新
	function tableRefresh() {
		$('#baseRecordDOS').bootstrapTable('refresh', {
			query : {}
		});
	}

	// 分页查询参数
	function queryParams(params) {
		var temp = {
			limit : params.limit,
			offset : params.offset,
            keyWord : search_keyWord,
            searchType : search_type
		}
		return temp;
	}

    // 行编辑操作
    function rowEditOperation(row) {
        $('#edit_modal').modal("show");

        // load info
        $('#customer_form_edit').bootstrapValidator("resetForm", true);
        $('#customer_name_edit').val(row.name);
        $('#customer_person_edit').val(row.personInCharge);
        $('#customer_tel_edit').val(row.tel);
        $('#customer_email_edit').val(row.email);
        $('#customer_address_edit').val(row.address);
    }

    // 查询操作
    function searchActionInit(){
        $('#search_button').click(function(){
            keyWord = $('#keyWord').val();
            search_type = $('#search_type').val();
            tableRefresh();
        })
    }
</script>

<div class="panel panel-default">
    <ol class="breadcrumb">
        <li>中心仓数据</li>
    </ol>
    <div class="panel-body">
        <div class="row">
            <div class="col-md-4">
                <form action="" class="form-inline">
                    <div class="form-group">
                        <label class="form-label">搜索：</label>
                        <label>
                            <input type="radio" name="r3" class="square-green" checked>
                            名称
                        </label>
                        <label>
                            <input type="radio" name="r3" class="square-green">
                            负责人
                        </label>
                        <label>
                            <input type="radio" name="r3" class="square-green">
                            编号
                        </label>
                    </div>
                </form>
            </div>
            <div class="col-md-2">
                <input type="text" id="key_word" class="form-control" placeholder="指定关键字">
            </div>
            <div class="col-md-2">
                <button class="btn btn-success" id="search_button">
                    <span class="glyphicon glyphicon-search"></span> <span>查询</span>
                </button>
            </div>
        </div>
        <div class="row" style="margin-top:25px">
            <div class="col-md-12">
                <table class="table table-striped" id="baseRecordDOS"></table>
            </div>
        </div>
    </div>
</div>
