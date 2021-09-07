<%@ Import namespace="ADODB" %>
<script language="VB" runat="Server">
Dim int_photo as integer
Dim send_photo as integer
Function rnd_photo()
	int_photo=CInt(Math.Floor((14 - 1 + 1) * Rnd())) + 1
end Function
</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS" />
<link href="css/alone_common_20170330.css" rel="stylesheet" type="text/css" />
<link href="css/alone.css" rel="stylesheet" type="text/css" />

<title>無題ドキュメント</title>

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
<script>
function move_question(){
document.form1.action="question.aspx"	
document.form1.submit();
}
</script>

</head>

<body class="mar_a0">

    <div class="op_30_bgc_lv04 fnt_c01" id="header">
    	<span class="op_100">head</span>
	</div>

    <div></div>
    

    <div class="tex_cen mar_t500 pad_t100">
<form name="form1" method="post" class="disp_no">
<input type="hidden" name="send_photo" value="<%response.write(int_photo)%>" />
</form>
    	<input type="button" value="start" class="bor_a_w1 bor_c01 bgc_lv_non fnt_s24 fnt_c01 pad_t5 pad_r10 pad_b5 pad_l10 w200 shd2" onclick="move_question()">
	</div>

</body>
</html>
<!--  #include file="alone_common.inc" -->
