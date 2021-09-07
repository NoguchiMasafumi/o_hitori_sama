<script language="VB" runat="Server">
'***********　DB基本宣言　************
	Dim CMD As Object
	Dim DB As Object
	
	Dim ar_question as String()={"fastfood","Rhamen","yoshinoya","yajiniku","kaiten","shopping","EIGA","consert","karaoke","Disney","domestic","abroad"}
	Dim ar_answer as String()={"kotoga aru" , "1 de ikitai" , "Yes（行ける）" , "kotoganai(option)" , "ikenai" , "Dont think"}
	Dim ar_answer_value as String()={80,100,60,40,0,60}



	'*** 変数 ***
	Dim int_loop1 As Integer
	Dim int_loop2 As Integer
	Dim int_loop3 As Integer
	
	Dim int_chk1 As Integer
	Dim int_chk2 As Integer
	Dim int_chk3 As Integer
	
	Dim dbl_chk1 As Double
	Dim dbl_chk2 As Double
	Dim dbl_chk3 As Double
	
	Dim str_chk1 As String
	Dim str_chk2 As String
	Dim str_chk3 As String
	
	Dim str_loop1 As String
	Dim str_loop2 As String
	Dim str_loop3 As String
	
	
	Dim str_this_url as string
	Dim str_this_page_title as string="Third"
	
	Dim str_url1 as string="third.aspx"
	
	
	'　*****************************************　 DBフィールドの値を返却する。nullや空文字だった場合は空文字を返却する。（主にhidden用）　*****************************************　
	Function GetDBValueS(ByVal DbField As ADODB.Field,ByVal delimit As String) As object
		Dim dbF As Object = DbField.Value
	
		Dim str_delimit as string
		if delimit="nbsp" then
			str_delimit="&nbsp;"
		else if delimit="blank" then
			str_delimit=""
		else if delimit="hyphen" then
			str_delimit="-"
		else if delimit="0" then
			str_delimit="0"
		end if
	
		If IsDBNull(dbF) Then
			GetDBValueS = str_delimit
		ElseIf CStr(dbF).Trim = "" Then
			GetDBValueS = str_delimit
		Else
			GetDBValueS = dbF.ToString
		End If
	End Function
	
	
	Function frmt_num_int(ByVal int As Integer) as String
		frmt_num_int=(formatnumber(int,0))
	End Function
	
	
	Function frmt_num_int_j(ByVal int As Integer) as String
		if int_chk1=1 then
			frmt_num_int_j="--"
		else
			frmt_num_int_j=(formatnumber(int,0))
		end if
	End Function
	
	
	
	Function frmt_num_per(ByVal int As double) as String
		frmt_num_per=formatnumber(int,1)
	end function
	
	'**********************************************************************************************
	
	'　***************　　***************　
	Sub SetSelectedValue(ByVal qry As String, ByVal val As String)
		If CStr(Request(qry)) <> "" Then
			If Request(qry) = val Then
				Response.Write(" selected=""selected""")
			Else
			End If
		Else
			If Session(qry) = val Then
				Response.Write(" selected=""selected""")
			Else
			End If
		End If
	End Sub
	'　***************　　***************　
	Sub SetCheckedValue(ByVal qry As String, ByVal val As String)
		If CStr(Request(qry)) <> "" Then
			If Request(qry) = val Then
				Response.Write(" checked=""checked""")
			Else
			End If
		Else
			If Session(qry) = val Then
				Response.Write(" checked=""checked""")
			Else
			End If
		End If
	End Sub
	
	
	'**********************************************************************************************
	Dim dt_now_on_pnt_date as date

	Dim dt_this_month_first as date


	Dim int_hide_flag as integer
	Dim int_copy_flag as integer

	Dim str_sql_base_date as string
	Dim str_sql_request_base_date as string
	Dim str_sql_update_base_date as string

	Dim str_sql_now_on_pnt_date as string
	Dim str_sql_request_now_on_pnt_date as string
	Dim str_sql_update_now_on_pnt_date as string

	Dim str_sql_done_pnt_date as string
	Dim str_sql_request_done_pnt_date as string
	Dim str_sql_update_done_pnt_date as string

	Sub sql_insert_update()


dt_this_month_first=((left(now(),8))&"01")


		if Request.Form("popup_base_date")<>"" then
			str_sql_base_date="base_date,"
			str_sql_request_base_date="'"&(Request.Form("popup_base_date"))&"',"
			str_sql_update_base_date="base_date='"&(Request.Form("popup_base_date"))&"',"
		
		end if
		
		
		if Request.Form("popup_now_on_pnt_date")<>"" then
			str_sql_now_on_pnt_date="now_on_pnt_date,"
			str_sql_request_now_on_pnt_date="'"&(Request.Form("popup_now_on_pnt_date"))&"',"
			str_sql_update_now_on_pnt_date="now_on_pnt_date='"&(Request.Form("popup_now_on_pnt_date"))&"',"
		end if

		if Request.Form("popup_done_pnt_date")<>"" then
			str_sql_done_pnt_date="done_pnt_date,"
			str_sql_request_done_pnt_date="'"&(Request.Form("popup_done_pnt_date"))&"',"
			str_sql_update_done_pnt_date="done_pnt_date='"&(Request.Form("popup_done_pnt_date"))&"',"
		end if

		if request("popup_id")="" and request("not_plan_team")<>"" then
			'****************************************
			str_chk1=""
			if request("not_plan_team")=1 
				if Request.Form("popup_charge")="web_dev01" then
					str_chk1="web_dev05"
				else if Request.Form("popup_charge")="web_dev02" then
					str_chk1="web_dev06"
				else if Request.Form("popup_charge")="web_dev03" then
					str_chk1="web_dev07"
				else if Request.Form("popup_charge")="web_dev04" then
					str_chk1="web_dev08"
				end if
			else
				str_chk1=Request.Form("popup_charge")
			end if
			'****************************************

			'****************************************
			int_copy_flag=0
			if request("popup_copy_flag")="1" then
				int_copy_flag=1
			end if


			CMD.CommandText = "insert into orders("&(str_sql_base_date) & _
			"date_cat," & _
			"o_from," & _
			"o_to," & _
			"charge," & _
			"category," & _
			"cont," & _
			"sts," & _
			"comment," & _
			"des," & _
			"effect," & _
			"seq," & _
			"first_date," & _
			"last_udate," & _
			"" &(str_sql_now_on_pnt_date) & _
			"" &(str_sql_done_pnt_date) & _
			"hide_flag" & _
			" )values("&(str_sql_request_base_date) & _
			"'" & Request.Form("popup_date_cat") & "'," & _
			"'" & Request.Form("popup_o_from") & "'," & _
			"'" & Request.Form("popup_o_to") & "'," & _
			"'" & str_chk1 & "'," & _
			"'" & Request.Form("popup_category") & "'," & _
			"'" & Request.Form("popup_cont") & "'," & _
			"'" & Request.Form("popup_sts") & "'," & _
			"'" & Request.Form("popup_comment") & "'," & _
			"'" & Request.Form("popup_des") & "'," & _
			"'" & Request.Form("popup_effect") & "'," & _
			"'0'," & _
			"'" & Request.Form("popup_first_date") & "'," & _
			"'" & now() & "'," & _
			""&(str_sql_request_now_on_pnt_date) & _
			""&(str_sql_request_done_pnt_date) & _
			"'0'" & _
			")"
			'response.write(cmd.commandtext)
			'response.end
			CMD.Execute()
		else if request("not_plan_team")="0" then
		
			'****************************************
			if request("popup_seq")="" then
				int_chk1=0
			else
				int_chk1=request("popup_seq")
			end if
		
			'****************************************
			'if request("popup_before_sts")<>request("popup_sts") and (request("popup_sts")="進行中")
			'	dt_now_on_pnt_date=now()
			'else
			'	dt_now_on_pnt_date=request("popup_now_on_pnt_date")
			'end if
		
			'****************************************
			int_hide_flag=0
			if request("popup_hide_flag")="1" then
				int_hide_flag=1
			end if
			'****************************************
			CMD.CommandText = "update orders set " & _
			""&(str_sql_update_base_date) & _
			"date_cat='"&(request("popup_date_cat"))&"'," & _
			"o_from='"&(request("popup_o_from"))&"'," & _
			"o_to='"&(request("popup_o_to"))&"'," & _
			"charge='"&(request("popup_charge"))&"'," & _
			"category='"&(request("popup_category"))&"'," & _
			"cont='"&(request("popup_cont"))&"'," & _
			"sts='"&(request("popup_sts"))&"'," & _
			"comment='"&(request("popup_comment"))&"'," & _
			"des='"&(request("popup_des"))&"'," & _
			"effect='"&(request("popup_effect"))&"'," & _
			"seq='"&(int_chk1)&"'," & _
			"first_date='"&(request("popup_first_date"))&"'," & _
			"last_udate='"&(now())&"'," & _
			""&(str_sql_update_now_on_pnt_date) & _
			""&(str_sql_update_done_pnt_date) & _
			"hide_flag='"&(int_hide_flag)&"' " & _
			"where id='"&(request("popup_id"))&"'"
			'response.write(cmd.commandtext)
			CMD.Execute()
		end if
	End Sub


</script>

