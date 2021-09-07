<%@ Import namespace="ADODB" %>
<script language="VB" runat="Server">
Dim int_photo as integer
Dim send_photo as integer
Function rnd_photo()
	int_photo=CInt(Math.Floor((14 - 1 + 1) * Rnd())) + 1
end Function
</script>
<%


			if request("q")="" then
				int_chk1=0
			else
				int_chk1=request("q")
			end if
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS" />
        <script src="http://asp.center.his/media/js/jquery-3.1.1.js"></script>
        <script type="text/javascript" src="http://asp.center.his/media/js/highcharts-5.0.9.js"></script>
        <script type="text/javascript" src="http://asp.center.his/media/js/highcharts-more.js"></script>

        <link href="css/alone_common_20170330.css" rel="stylesheet" type="text/css" />
        <link href="css/alone.css" rel="stylesheet" type="text/css" />
        <title>無題ドキュメント</title>
        <script>

function send_form(){

	$(".answer").each(function() {
	
		if($(this).prop('checked')){
		$("#a_val_"+$("#now_q").val()).val($(this).val())
		}
	
	});	
<%if request("q")=ubound(ar_question) then%>
document.form1.action="result.aspx"
document.form1.submit();

<%else%>

document.form1.action="question.aspx?q=<%response.write(int_chk1+1)%>"
document.form1.submit();
<%end if%>

}

        var question=["a1","a2"]
        
        </script>
		<style>
        body {
          /* 画像ファイルの指定 */
          background-image: url(img/img_<%
			if request("send_photo")="" then
				send_photo=1
			else
				send_photo=request("send_photo")		  
			end if
			Do
				call rnd_photo()
			Loop until int_photo<>send_photo 
			response.write(int_photo)%>.jpg);
          
          /* 画像を常に天地左右の中央に配置 */
          background-position: center center;
          
          /* 画像をタイル状に繰り返し表示しない */
          background-repeat: no-repeat;
          
          /* コンテンツの高さが画像の高さより大きい時、動かないように固定 */
          background-attachment: fixed;
          
          /* 表示するコンテナの大きさに基づいて、背景画像を調整 */
          background-size: cover;
          
          /* 背景画像が読み込まれる前に表示される背景のカラー */
          background-color: #464646;
        }
        
        </style>
	</head>

    <body class="mar_a0">
        <div class="op_30_bgc_lv04 fnt_c01" id="header"><span class="op_100">head</span></div>

        <div></div>

        <form name="form1" method="post" class="tex_cen">
			<div class="rad_4 bgc_lv01 op_90_bgc_lv01 mar_r_at mar_l_at w90p pad_a50">
                <input type="hidden" name="now_q" id="now_q" value="<%response.write(int_chk1)%>">
    
                <%for int_loop1=0 to ubound(ar_question)%>
                <input type="hidden" name="a_val_<%response.write(int_loop1)%>" id="a_val_<%response.write(int_loop1)%>" class="" value="<%response.write(request("a_val_"&int_loop1))%>">
                <%next int_loop1%>
            
            
                <div class="flt_lef w500">
                    <div>
                        <%for int_loop1=0 to ubound(ar_answer)
                            int_chk2=int_chk2+request("a_val_"&int_loop1)
                        next int_loop1
                        response.write(int_chk2)
                        %>
                    </div>
        
                    <div></div>
                    <div>総評</div>
                </div>
    
    
                <div id='chart3_last' class="chart_w3_h2 flt_lef rad_4 mar_b3 mar_r3 w500">
                    <script type="text/javascript">
                $(function () {
                //　***********　宣言。・・・か？　***********　
                Highcharts.setOptions({lang:{thousandsSep:','}});
                
                Highcharts.chart('chart3_last', {
                
                chart: {
                polar: true,
                type: 'line'
                },
                
                title: {
                text: 'alone chart',
                x: -80
                },
                
                pane: {
                size: '80%'
                },
                
                xAxis: {
                categories: [<%for int_loop1=0 to ubound(ar_answer)
                if int_loop1<>0 then
                response.write(",")
                end if
                response.write("'Q"&(int_loop1+1)&"'")
                %>
                
                <%next int_loop1%>],
                tickmarkPlacement: 'on',
                lineWidth: 0
                },
                
                yAxis: {
                gridLineInterpolation: 'polygon',
                lineWidth: 0,
                min: 0,max: 100,
                },
                
                tooltip: {enabled:false},
                
                legend:{enabled:false},
                
                series: [{
                name: 'Question',
                data: [
                <%for int_loop1=0 to ubound(ar_answer)
                if int_loop1<>0 then
                response.write(",")
                end if
                response.write(request("a_val_"&int_loop1))
                %>
                
                <%next int_loop1%>
                ],
                pointPlacement: 'on'
                }],
                credits:{  
                enabled: false,  
                }
                
                });
                
                
                });
                </script>
                </div>
    
    
                <div class="clearfix">&nbsp;</div>
			</div>
			<div class="clearfix">&nbsp;</div>

        </form>
        
        
        
        
        
        
        
    </body>
</html>
<!--  #include file="alone_common.inc" -->
