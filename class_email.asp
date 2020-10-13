<%


class email

	public strFrom
	public strTo
	public strCC
	public strBCC
	public strSubject
	public strBody
	private strMailFormat
	public strMissingFields
	private bMailFormat
	
	public strHTMLheader
	public strHTMLFooter

	private oMail

	Private Sub Class_Initialize(  )

		Set oMail = CreateObject("CDONTS.NewMail")

		strMailFormat = "text"	'mail format - this property is set by the user and so is text rather than the 0 or 1 of bmailformat
		bMailFormat = 1			'mail format to text
		
		strHTMLheader="<HTML><HEAD><TITLE></TITLE><STYLE>body, html{ font-family: Arial, Helvetica, sans-serif;	font-size=90% } table{font-size=100%;} </STYLE></HEAD><BODY>"
		strHTMLfooter="</BODY></HTML>"
		
	end sub

	public function setMailFormat(strFormat)
	
		strMailFormat = strFormat
		select case strMailFormat
			case "text"
				bMailFormat = 1
			case "html"
				bMailFormat = 0
			case else
				strmailFormat = "text"
				bMailFormat = 0
		end select
		
	end function
	
	public function attachFile(strFileName)
		dim oFs
		Set oFs = CreateObject("Scripting.FileSystemObject")

		If oFs.FileExists(strFileName) Then
			oMail.AttachFile strFileName
			attachFile = true
		else
			attachFile = false
		end if
	
	end function

	public function SendEmail()

		oMail.From 		= strFrom
		oMail.To 		= strTo
		oMail.Cc 		= strCC
		oMail.Bcc		= strBCC
		oMail.Subject 	= strSubject
		oMail.Body 		= strBody
		oMail.MailFormat= bMailFormat
		if strMailFormat = "html" then
			oMail.BodyFormat = 0
		end if
		
		oMail.Send
			
		set oMail=nothing
		
		if err.number<>0 then 
			SendEmail=false
		else
			SendEmail=true
		end if 
		
	end function 


end class


%>