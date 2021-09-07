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
        <script src="http://asp.center.his/media/js/jquery-2.0.2.min.js"></script>
        <link href="css/alone_common_20170330.css" rel="stylesheet" type="text/css" />
        <link href="css/alone.css" rel="stylesheet" type="text/css" />
        
        <title>無題ドキュメント</title>
        <script>

function send_form(){
	var int_chk1=0
	$(".answer").each(function() {
	
		if($(this).prop('checked')){
		$("#a_val_"+$("#now_q").val()).val($(this).val())
		$("#a_num_"+$("#now_q").val()).val(int_chk1)
		}
	int_chk1=int_chk1+1
	});	
<%if request("q")=ubound(ar_question) then%>
document.form1.action="result.aspx"
document.form1.submit();

<%else%>

document.form1.action="question.aspx?q=<%response.write(int_chk1+1)%>"
document.form1.submit();
<%end if%>

}


function back_form(){
	document.form1.action="question.aspx?q=<%response.write(int_chk1-1)%>"
	document.form1.submit();
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
			<input type="hidden" name="now_q" id="now_q" value="<%response.write(int_chk1)%>">
			<input type="hidden" name="send_photo" value="<%response.write(int_photo)%>" />
        <%for int_loop1=0 to ubound(ar_question)%>
        	<input type="hidden" name="a_val_<%response.write(int_loop1)%>" id="a_val_<%response.write(int_loop1)%>" class="" value="<%response.write(request("a_val_"&int_loop1))%>">
        	<input type="hidden" name="a_num_<%response.write(int_loop1)%>" id="a_num_<%response.write(int_loop1)%>" class="" value="<%response.write(request("a_num_"&int_loop1))%>">

        <%next int_loop1%>
        
        
			<div class="op_90_bgc_lv01 pad_a50 tex_lef w400 bgc_lv01 mar_l_at mar_r_at rad_4">
                <div class="fnt_s16 fnt_b mar_b50"><span class="fnt_c02 fnt_s24">Q<%response.write(int_chk1+1)%>.</span>
                    <%response.write(ar_question(int_chk1))%>
                </div>
                <div class="fnt_b mar_b50 lhg_200">
                    <%for int_loop1=0 to ubound(ar_answer)
					
					'response.write(int_chk1)
'					response.end
					%>
                    <label><input type="radio" value="<%response.write(ar_answer_value(int_loop1))%>" name="answer" class="answer" id="a<%response.write(int_loop1)%>"<%
					if request("a_num_"&int_chk1)<>""
						if int_loop1=cint(request("a_num_"&int_chk1)) then
							response.write(" checked=""checked""")
						end if
					else
							if int_loop1=0 then
								response.write(" checked=""checked""")
							end if
					end if
					%>><%response.write(ar_answer(int_loop1))%></label><br />
    
                    <%next int_loop1%>
    
                </div>
                <div class="tex_cen">
                <input type="button" value="戻る" onclick="back_form()" class="bor_a_w1 bor_c04 bgc_lv_non fnt_s16 fnt_c04 pad_t5 pad_r10 pad_b5 pad_l10 w120 mar_r10">
                <input type="button" value="次へ" onclick="send_form()" class="bor_a_w1 bor_c04 bgc_lv_non fnt_s16 fnt_c04 pad_t5 pad_r10 pad_b5 pad_l10 w120 mar_l10"></div>
			</div>

        </form>
    </body>
</html>
<!--  #include file="alone_common.inc" -->
