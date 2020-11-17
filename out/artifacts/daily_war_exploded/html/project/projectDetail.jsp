<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>项目成员列表</title>
    <jsp:include page="/html/default/pub.jsp"/>
    <link href="/js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="layui-card">
    <div class="layui-card-header">
        <!-- 搭建显示页面 -->
        <!-- 标题 -->
        <div>
            <p>项目编号：<span id="pro_code"></span>&nbsp;&nbsp;&nbsp;&nbsp;项目名称：<span id="pro_name"></span></p>
        </div>
        <!-- 按钮 -->
        <button class="layui-btn" onclick="history.go(-1)">返回</button>
        <button class="layui-btn layui-btn-normal" id="proUser_add_btn" privilege-id="28">新增</button>
    </div>
    <!-- 显示表格数据 -->
    <div class="layui-card-body">
        <table id="projectDetail" class="layui-table" lay-filter="projectDetailEvent"></table>
    </div>
</div>

<script type="text/html" id="toolbar">
    {{# if(privilegeList.indexOf(29) != -1){}}
    <a class="layui-btn layui-btn-danger layui-btn-xs " lay-event="del">删除</a>
    {{# } }}
</script>
<script type="text/javascript">
    var projectId = (window.location.search).split("=")[1];
    $("#proUser_add_btn").attr("project-id", projectId);
    layer = layui.layer //弹层
    var totalRecord, currentPage;
    //获取当前用户的权限列表
    var privilegeList = ${user.privilegeList};
    //根据权限列表判断是否显示
    if (privilegeList.indexOf(28) == -1) {
        $("#proUser_add_btn").hide();
    }

    getProjectInfo();
    to_page();

    //分页查询处理
    function search(page, limit) {
        layui.use('table', function () {
            var table = layui.table;

            table.render({
                elem: '#projectDetail'
                , url: '/project/getProjectUserByProjectId' //数据接口
                , where: {projectId: projectId, roleType: "00"}
                , page: {
                    layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
                    , curr: page //设定初始在第 1 页
                    , limit: limit
                    , groups: 5 //只显示 5 个连续页码
                }
                , cols: [[ //表头
                    {field: 'userName', title: '姓名', width: 200}
                    , {
                        field: 'gender', title: '性别', width: 150, templet: function (d) {
                            return d.gender == 0 ? "女" : "男"
                        }
                    }
                    , {field: 'email', title: '邮箱', width: 200}
                    , {field: 'roleName', title: '项目角色', width: 200}
                    , {field: 'mobile', title: '手机号', width: 160}
                    , {
                        field: 'dosomething',
                        title: '操作',
                        id: 'hide',
                        align: 'center',
                        toolbar: '#toolbar'
                    }
                ]]
                , response: {
                    statusName: 'code'
                    , statusCode: '100'
                    , msgName: 'msg'
                    , countName: 'total'
                    , dataName: 'data'
                }
            });

            table.on('tool(projectDetailEvent)', function (obj) {
                var data = obj.data;
                if (obj.event === 'del') {
                    deleteProjectUser(data.userName, data.userId, data.userRoleId);
                }
            });
        })
    }

    //
    function getProjectInfo() {
        $.ajax({
            url: "/project/getProjectUserByProjectId",
            data: {"projectId": projectId, roleType: "00"},
            type: "POST",
            success: function (result) {
                $("#pro_code").html(result.data[0].projectCode);
                $("#pro_name").html(result.data[0].projectName);
            }
        });
    }


    //清空表单样式及内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //单个删除

    function deleteProjectUser(userName, userId, userRoleId) {
        //1、弹出是否确认删除对话框
        // var userName = $(this).parents("tr").find("td:eq(0)").text();
        // var userId = $(this).attr("user-id");
        // var userRoleId = $(this).parents("tr").find("td:eq(6)").text();
        layer.confirm('确定删除【' + userName + '】吗？', {icon: 3, title: '确认信息'}, function (index) {
            //确认，发送ajax请求删除即可
            $.ajax({
                url: "/project/deleteProjectUser/" + userId + "/" + userRoleId,
                type: "DELETE",
                success: function (result) {
                    layer.msg(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        });
    };

    //点击新增，跳转到项目成员新增页面
    $(document).on("click", "#proUser_add_btn", function () {
        var id = this.getAttribute("project-id");
        window.location.href = "/html/project/projectUserAdd.jsp?projectId=" + id;

    });

    function to_page() {
        layui.use(['laypage'], function () {
            var laypage = layui.laypage;
            //调用分页
            laypage.render({
                curr: 1 //设定初始在第 1 页
                , limit: 10//每页显示条数
                , groups: 5 //只显示 5 个连续页码
                , layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
                , jump: function (obj) {
                    var page = obj.curr;
                    var limit = obj.limit;
                    search(page, limit);
                }
            });
        });
    }
</script>
</body>
</html>
