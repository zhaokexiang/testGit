<%@ page contentType="text/html;charset=UTF-8"%>
<%@include file="../../common/taglibs.jspf"%>
<!DOCTYPE html>
<html>
<%@include file="../../common/head.jspf" %>
<title><c:choose><c:when test="${not empty editFlag}">编辑</c:when><c:otherwise>查看</c:otherwise></c:choose></title>
</head>
<body>               
<article class="page-container">
	<form action="/activity/saveRecActivity" method="post" enctype="multipart/form-data" class="form form-horizontal layui-form" id="editRecActivityForm">
		<div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>活动ID：</label>
			<div class="formControls  col-sm-6">
				<input type="text" name="activityId"  id="activityId"
				 class="input-text" style="width:450px;" value="${activity.id}" onchange="activityInfo($(this).val())">
			</div>
		</div>
		
		<div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>活动名称：</label>
			<div class="formControls  col-sm-6">
				<input id="name" type="text" class="input-text" style="width:450px;" value="${activity.name}" name="name" >
			</div>
		</div>

	<div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>是否推荐展示：</label>
			<div class="formControls  col-sm-6">
			        <select class="select" id="status" name="status" style="width:450px;">
			          <option id="jobstate-tongbu" value="1" ${activity.status==1?'selected=""':'' }>展示</option>
			          <option id="jobstate-stop" value="0" ${activity.status==0?'selected=""':'' }>不展示</option>
			        </select>
			  </div>
			</div>
		</div>

        <div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>推荐标题：</label>
			<div class="formControls  col-sm-5">
				<input id="title" type="text" name="title" class="input-text" style="width:450px;" placeholder="推荐标题" value="${activity.title}">
			</div>
		</div>
		
		        <div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>推荐标语：</label>
			<div class="formControls  col-sm-5">
				<input id="summary" type="text" name="summary" class="input-text" style="width:450px;" placeholder="推荐标语" value="${activity.summary}">
			</div>
			</div>
		
		   <div class="row cl">
			<label class="form-label col-sm-2"><span class="c-red">*</span>活动地址：</label>
			<div class="formControls  col-sm-5">
				<input id="actUrl" type="text" name="actUrl" class="input-text" style="width:450px;" placeholder="推荐标提" value="${activity.actUrl}">
			</div>
		</div>
	
			<div class="row cl">
				<label class="form-label col-sm-2">推荐图展示：</label>
				<div class="formControls  col-sm-5">
					<img id="actRecImage" src="${imgPre}${activity.recImage}" style="max-width:500px;max-height: 350px"  alt="" />
				</div>
			</div>
		
		<div class="row cl">
			<label class="form-label col-sm-2">推荐图：</label>
			<div class="formControls  col-sm-10">
				<span class="btn-upload form-group">
	  				<input class="input-text upload-url" style="width:450px;"type="text" id="recImage" readonly
	  				placeholder="不可为空，图片最大2M">
	  					<a href="javascript:void();" class="btn btn-primary radius">浏览文件</a>
	  				<input type="file" id="recImage" name="recImage" class="input-file">
			</div>
  				</span>
		</div>
		
		<%-- <zh:authorize ifAllGranted="NEWS_ACTIVITY_EDIT">
		 </zh:authorize> --%>
		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button class="btn btn-primary radius" id="submitbutton" type="submit"><i class="Hui-iconfont"></i> 保存</button>
			</div>
		 </div>
		
	</form>
</article>

<%@include file="../../common/foot.jspf" %>

<zh:authorize ifAllGranted="NEWS_ACTIVITY_EDIT">
<script type="text/javascript">
$(function(){
	 $("#editRecActivityForm").validate({                           
			rules:{                                                 
				title:{                                           
					required:true,                                      
					maxlength:100                                       
				},
				summary:{  
					required: true
			    },
			    actUrl:{  
					required: true
			    },
			    status:{
			    	required:true
			    },
			},
			messages:{
				title:{
	               required: "活动推荐标题不能为空",
	               maxlength: "活动推荐标题长度为100"
		         },
		         summary:{
		        	 required: "活动推荐标语不能为空"
		         },
		         actUrl:{
		        	 required: "活动路径不能为空"
		         },
		         status:{
		        	 required: "活动推荐标识不能为空"
		         },
			},
			onkeyup:false,                       
			focusCleanup:true,                                      
			success:"valid",                                        
			submitHandler:function(form){
				$("#editRecActivityForm").ajaxSubmit(function(data){
					if(data.code){
						layer.alert(data.message,{icon:1,time:3000});
    					setTimeout(function(){
    						var index = parent.layer.getFrameIndex(window.name);
    						parent.location.reload();
    						parent.layer.close(index);
    					},2000);
					}else{
						layer.alert(data.message,{icon:0,time:3000});
					}
				});  
			}                                                       
		});        
});
function activityInfo(activityId) {
    if (activityId > 0) {
        var data = {activityId: activityId, needCoins: 1};
        ajaxRequest("/activity/info", data, 'post', passCallBack);
		
        function passCallBack(result) {
            if (result.code === 501) {
                layer.msg("此活动不存在" + activityId, {icon: 2, time: 3000});
                $("#name").val('');
                
            } else if (result.code === 200) {
            	var imgPre = "http://static.zongheng.com/upload";
                //设置各个节点信息
                $("#name").val(result.result.name);
                $("#status").val(result.result.status);
                $("#title").val(result.result.title);
                $("#summary").val(result.result.summary);
                $("#actUrl").val(result.result.actUrl);
                $("#actRecImage").attr("src",imgPre+result.result.recImage);
            }
        }
    }
}
</script>
</zh:authorize>
<!--/请在上方写此页面业务相关的脚本-->
</body>
</html>