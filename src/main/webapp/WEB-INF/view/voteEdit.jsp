<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" errorPage="/error.jsp" %>
<%@include file="../common/taglibs.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="../common/head.jspf" %>
    <title>书籍推荐票增减</title>
</head>
<body>
<style>
    .clearfix:after{content:"\20";display:block;height:0;clear:both;visibility:hidden}.clearfix{zoom:1}
    .tabBar {border-bottom: 2px solid #222}
    .tabBar span {background-color: #e8e8e8;cursor: pointer;display: inline-block;float: left;font-weight: bold;height: 30px;line-height: 30px;padding: 0 15px}
    .tabBar span.current{background-color: #222;color: #fff}
    .tabCon {display: none}
</style>
<div class="page-container">
    <div id="coin_tab" class="HuiTab">
        <div class="tabCon">
            <div class="mt-10">
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">书籍ID：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" name="bookId" id="bookId" class="input-text" style="width:240px"
                               onchange="bookVoteNumInfo($(this).val())"
                               placeholder=""
                               value="${bookId }"/>
                    </div>
                </div>
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">书籍名称：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" disabled="disabled"  class="input-text" id="bookName" name="bookName"style="width:240px" placeholder="" >
                    </div>
                </div>
                  <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">总推荐票数：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" disabled="disabled"  class="input-text" id="totalCount" name="totalCount" style="width:240px">
                    </div>
                </div>
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">本日推荐票数：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" disabled="disabled"  class="input-text" id="dayCount" name="dayCount" style="width:240px">
                    </div>
                </div>
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">本周推荐票数：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" disabled="disabled"  class="input-text" id="weekCount" name="weekCount" style="width:240px">
                    </div>
                </div>
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">本月推荐票数：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" disabled="disabled"  class="input-text" id="monthCount" name="monthCount"
                               style="width:240px" placeholder="">
                    </div>
                </div>
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">数量：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" name="num" id="num" class="input-text" style="width:240px"placeholder=""value=""/>
                         <div style="color:red">
							<p>无论增加，还是扣除，都为正整数</p>	
							<p>扣除数量不得大于相应时间内的票数</p>		
						</div>
                    </div>
                </div>
                
                <div class="row cl mt-5">
                    <label class="form-label col-sm-2 text-r">投票时间：</label>
                    <div class="formControls  col-sm-6">
                        <input type="text" class="input-text zhdate" style="width:240px" id="periodTime" name="periodTime"   
                        value=""  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="yyyy-MM-dd">
                          <div style="color:red">
							<p>此时间不填默认为当天时间</p>
							<p>填写时间等于当天时间，则影响本日，本周，本月推荐票榜单 以及周推荐票数、总票数（数据库数据）</p>
							<p>填写时间小于当天大于等于本周周一，则影响本周，本月推荐票榜单 以及走推荐票数、总票数（数据库数据）</p>
							<p>填写时间小于本周周一大于等于本月1号，则影响 本日，本周，本月推荐票榜单 以及总票数</p>
							<p>填写时间在小于本月1号则影响 本月推荐票榜单 以及总票数</p>
							
						</div>
                    </div>
                  
                </div>
                <div class="row cl  mt-5">
                    <label class="form-label col-sm-2"></label>
                    <div class="col-sm-6">
                    <zh:authorize ifAllGranted="ADD_BOOK_TICKET">
                        <button type="submit" id="addVote"  class="btn btn-primary radius">
                        	<i class="Hui-iconfont">&#xe600;</i> 增加
                        </button>
                        </zh:authorize>
                        <zh:authorize ifAllGranted="REDUCE_BOOK_TICKET">
                        <button type="submit" id="decVote" class="btn btn-danger radius">
                            <i class="Hui-iconfont">&#xe6a1;</i> 扣除
                        </button>
                        </zh:authorize>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="../common/foot.jspf" %>
<script type="text/javascript">
    $(function () {
        $.Huitab("#coin_tab .tabBar span", "#coin_tab .tabCon", "current", "click", "0");
    });

    $("#addVote").bind("click", function () {
        var bookId = $('#bookId').val();
        var bookName = $('#bookName').val();
        var num = $('#num').val();
        var periodTime = $('#periodTime').val();
        if(num<=0||num==null){
            layer.alert("增加数量不能为0", {icon: 2, time: 3000});
            return;
        }
        layer.confirm('<div>确定给《'+bookName+'》增加'+num+'张推荐票吗？</div>', function () {
            $.ajax({
                type: "POST",
                url: "/recommendticket/addVoteNum",
                data: {bookId: bookId, type: 0, num: num, periodTime: periodTime},
                dataType: "json",
                success: function (result) {
                    if(result.code == 200){
                        layer.alert("增加成功", {icon: 1, time: 3000});
                    }else{
                        layer.alert("增加失败"+result.message, {icon: 2, time: 5000});
                    }
                    showUserNickNameAndUserName(userId);
                    //window.location.reload();
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.alert("出错了", {icon: 1, time: 3000});
                }
            })
        })
    });

    $("#decVote").bind("click", function () {
    	 var bookId = $('#bookId').val();
         var bookName = $('#bookName').val();
         var num = $('#num').val();
         var periodTime = $('#periodTime').val();
         if(num<=0||num==null){
             layer.alert(" 扣除数量不能为0", {icon: 2, time: 3000});
             return;
         }
         layer.confirm('<div>确定给《'+bookName+'》 扣除'+num+'张推荐票吗？</div>', function () {
             $.ajax({
                 type: "POST",
                 url: "/recommendticket/reduceVoteNum",
                 data: {bookId: bookId, type: 1, num: num, periodTime: periodTime},
                 dataType: "json",
                 success: function (result) {
                     if(result.code == 200){
                         layer.alert("扣除成功", {icon: 1, time: 3000});
                     }else{
                         layer.alert("扣除失败！"+result.message, {icon: 2, time: 5000});
                     }
                     showUserNickNameAndUserName(userId);
                     //window.location.reload();
                 },
                 error: function (XMLHttpRequest, textStatus, errorThrown) {
                     layer.alert("出错了", {icon: 1, time: 3000});
                 }
             })
         })
    });



    function bookVoteNumInfo(bookId) {
        if (bookId > 0) {
            var data = {bookId: bookId, needCoins: 1};
            ajaxRequest("/recommendticket/numInfo", data, 'post', passCallBack);

            function passCallBack(result) {
                if (result.code === 501) {
                    layer.msg("此书籍不存在" + bookId, {icon: 2, time: 3000});
                    $("#totalCount").val('');
                    $("#monthCount").val('');
                    $("#weekCount").val('');
                    $("#dayCount").val('');
                    $("#bookName").val('');
                } else if (result.code === 200) {
                    //设置各个节点信息
                    $("#totalCount").val(result.result.totalCount);
                    $("#monthCount").val(result.result.monthCount);
                    $("#weekCount").val(result.result.weekCount);
                    $("#dayCount").val(result.result.dayCount);
                    $("#bookName").val(result.result.bookName);
                }
            }
        }
    }
</script>
</body>
</html>