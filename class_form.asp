<%

' Public Methods:
' ---------------
' getFormData()
' - Retrieves the input from a http post and stores it in the form_collection object
'
' parseForm(form_collection)
'	- called after the "get data" operations, and passes in the collected data into the primary validation function
'
' primValidation(oFieldSpec, form_collection)
'	- performs primary validation on the form_collection again the oFieldSpec object (data dictionary)
'
' GetData()
'	- Retrieve data from the database - specify sp's in the otable object
'
' cleanInput(strInput, strFieldType)
'	- take the crap out of any user input (any rouge html or sql injection)
'	
' public function keepData(strElementId, strValue)
'	- Called with a form element when the page is refreshed this re-populates the users input into the form element
'	- If using for a free text field, simply use: keepData('my_text_field', "")
'	- 'strValue' paramater is used for multi choice inputs only (radio buttons and checkboxes)
'	- usage: <input type="radio" value="value_1" id="radio_group" < % =keepData("radio_group","value_1" % >> 
'	- if this radio button was checked the keepdata function will add 'checked' into the html element.
	
' public function keepData_withDefault(strElementId, strValue, strDefault)
' 	- The same as the keep data function, exept that if a user has not inputed any data a default value can be displayed
'	- use "checked" for default on radio buttons or check boxes and "selected" for default on list boxes
'	
' displayErrors(strElementId)
'	- displays validation errors to the user
'	
' displayRS(rs)
'	- simple debug function to output the contents of a recordset.
	

class generic_form
	private fieldName, fieldType, fieldLength, fieldRequired
	private fileFolder, fileTypes, fileSize, imageWidth, imageHeight, imageDimensions
	private	defaultError, tooLongError, invalidError
	private oFieldValid, oErrors,bSuccess, intInvalidCount, strKey
	private strUserResponse, strType, intLength, bRequired, intResponseLength, bValid
	private strPostCode, intPCLength, strText
	private oFile
	
	private bDebug
	
	public oFieldSpec
	public oFileSpec
	public oTable
	public oErrorMessages
	public form_collection
	public form_collection_formatted
	
	Private Sub Class_Initialize(  )
			
		fieldName = 0
		fieldType = 1
		fieldLength =2
		fieldRequired = 3
		
		fileFolder = 0
		fileTypes = 1
		fileSize = 2
		
		imageDimensions = 3
		imageWidth = 0
		imageHeight = 1
		
		defaultError = 0
		tooLongError = 1
		invalidError = 2
		
		bDebug = false
					
		set oFieldValid 				= CreateObject("Scripting.Dictionary")
		Set oFieldSpec					= CreateObject("Scripting.Dictionary")
		set oErrorMessages				= CreateObject("Scripting.Dictionary")
		set oErrors 					= CreateObject("Scripting.Dictionary")
		set form_collection 			= CreateObject("Scripting.Dictionary")
		set form_collection_formatted	= CreateObject("Scripting.Dictionary")
		
	end sub
	
	
	public function getData(strWhichData)
		dim strSQL, rsData
		
		set rsData = server.CreateObject("adodb.recordset")
		
		if oTable.exists(strWhichData) then
			strSQL = oTable(strWhichData)
			
			set rsData = queryDb(strSQL)
							
		end if
		
		set getData = rsData
			
	end function
	
		
	'retrieve the input from the http post and store it in the form_collection object
	public function getFormData()
	
		for each strKey in request.form()
			if form_collection.exists(strKey) then
				form_collection(strKey) = request.form(strKey)
			else
				form_collection.add strKey, request.form(strKey)
			end if
		next 
		
		set getFormData = form_collection
			
	end function

	public function parseForm(form_collection)

		'perform primary validation
		set oErrors = primValidation(oFieldSpec, form_collection)
		
		if bDebug then response.write("errors=" & oErrors.count & "<BR>")
		
		if bDebug then
			dim key
			for each key in oErrors
				response.write(key & " :: " & oErrors(key) & "<BR>")
			next
		
		end if
	
		set parseForm = oErrors

	end function
	
	'after a form has been submitted a call to this function is made
	'this invokes the 1st level validation 
	public function primValidation(oFS, f_c)
	
		set oFieldSpec = oFS
		set form_collection = f_c
		
		set primValidation = validate()
	
	end function
		
	
	' this is primary validation against the arFieldSpec array
	' Loop around all fields as defined in the oFieldSpec dictionary object and validate each value against its
	' field specification
	private function validate()
	
		intInvalidCount = 0

		for each strKey in oFieldSpec
				
			strType = oFieldSpec(strKey)(fieldType)
			intLength = oFieldSpec(strKey)(fieldLength)
			bRequired = oFieldSpec(strKey)(fieldRequired)
			
			if bDebug then response.write("input before clean: " & form_collection(strKey) & "<BR>")	
			strUserResponse = cleanInput(form_collection(strKey), strType)
			form_collection_formatted(strKey) = strUserResponse
			if bDebug then response.write("input after clean: " & form_collection_formatted(strKey) & "<BR>")

			
			if bDebug then response.write(strKey & " / " & strType & " / " & intLength & " / " & bRequired & "<BR>" & strUserResponse & "<BR>")
			
			select case strType
				case "varchar"
					bValid = validateVarChar(strKey,strUserResponse,intLength,bRequired)
				case "postcode"
					bValid = validatePostCode(strKey,strUserResponse,intLength,bRequired)
				case "datetime"
					bValid = validateDateTime(strKey,strUserResponse,intLength,bRequired)				
				case "email"
					bValid = validateEmail(strKey,strUserResponse,intLength,bRequired)
				case "list"
					bValid = validateList(strKey,struserResponse,intLength,bRequired)	
				case "multiList"
					bValid = validateMultiList(strKey,strUserResponse,bRequired)
				
			end select

			if bDebug then response.write(bValid &  "<BR><BR>" )
			
			oFieldValid.Add strKey, bValid
			
		next
		
		set validate = oErrors
	
	end function
	
	
	'valided input from a list box which allows multiple selections
	private function validateMultiList(strKey,strUserResponse,bRequired)
	
		dim aList, selection
		bValid = false
		
		aList = split(strUserResponse,",")
		
		for each selection in aList

			if selection <> "" then 
				bValid = true
			end if
			
		next
		
		if not bValid and bRequired then
			addError strKey, "Please select at least one item from the list", defaultError
		else
			bValid = true
		end if
		
		validateMultiList = bValid
	
	end function
	
	private function validateList(strKey,strUserResponse,intLength,bRequired)
			
		bValid = validateLength(strKey,strUserResponse,intLength,bRequired)
	
		if bValid and strUserResponse <> "" then
			if strUserResponse <> "-1" then 
				bValid = true
			else			
				addError strKey, "Please select an option from the list", defaultError
			end if
		end if
	
		validateList = bValid
	
	end function
		
	'validate a DATETIME value
	'this will need to be made more robust for future usage.
	private function validateDateTime(strKey,strUserResponse,intLength,bRequired)
	
		bValid = validateLength(strKey,strUserResponse,intLength,bRequired)
		
		if bValid and strUserResponse <> "" then 
			bValid = isDate(strUserResponse)
			if not(bValid) then 
				addError strKey, "Please enter a valid date", invalidError
			end if
		end if
			
		validateDateTime = bValid
	
	end function
	
	private function validateVarChar(strKey,strUserResponse,intLength, bRequired)
	
		bValid = validateLength(strKey,strUserResponse,intLength, bRequired)
		
		validateVarChar = bValid
			
	end function


	private function validatePostCode(strKey,strPostCode, intLength, bRequired)
	
		bValid = false
		
		strPostCode = ucase(strPostCode)
		
		'clean up postcode - insert a space in the middle of it if necessary
		intPCLength = len(strPostCode)
		if intPCLength > 4 then
			if not mid(strPostCode,intPCLength-3,1) = " " then
				strPostCode = left(strPostCode,intPCLength-3) & " " & right(strPostCode,3)
			end if
		end if
		
		form_collection_formatted(strKey) = strPostCode
		
		bValid = validateLength(strKey,strPostCode,intLength, bRequired) 
			
		if bValid and strPostCode <> "" then 
		
			if bDebug then response.write("postcode being tested: " & strPostCode & " :: ")
			
			Dim RegEx
	
			Set RegEx = New RegExp
			
			RegEx.Pattern = "([A-Za-z]{1,2})([0-9]{1,2})([A-Za-z]{1,2})?( )?([0-9])([A-Za-z]{2})"
			RegEx.Global = True
		
			bValid = RegEx.Test(strPostCode)
			
			if not(bValid) then 
				addError strKey, "Please enter a valid UK Post Code", invalidError
			end if
			
		end if
		
		validatePostCode = bValid
	
	end function
	
	private Function validateEmail(strKey,strEmail, intLength, bRequired)
		bValid = False
	
		bValid = validateLength(strKey,strEmail,intLength, bRequired)
	
		if bValid and strEmail <> "" then 
			dim regEx
						
			set regEx = New RegExp
			
			regEx.IgnoreCase = False
			
			regEx.Pattern = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
			bValid = regEx.Test(strEmail)
			
			if not(bValid) then 
				addError strKey, "Please enter a valid email address", invalidError
			end if
			
		end if
		
		validateEmail = bValid
		
	End Function
	
	private function validateLength(strKey,strText, intLength, bRequired)

		intResponseLength = len(strText)		
		bValid = false

		if bDebug then response.write("checkLength:")
		
		if bRequired then
			
			if intResponseLength > 0 and intResponseLength <= intLength then
				bValid = true
			else
				if intResponseLength = 0 then
					addError strKey, "This is a required field", defaultError
				else
					addError strKey, "Your response contains too many characters", tooLongError
				end if
			end if
		else 
			if intResponseLength <= intLength then
				bValid = true
			end if
		end if
	
		if bDebug then response.write(bValid & "<BR>")
			
		validateLength = bValid
		
	end function
	
	'take the crap out of any user input
	'hopfully this should stop sql injection attacks and other nastyness
	public function cleanInput(strInput, strFieldType)
	
		select case strFieldType
			case "html"
				strInput = cleanUpHTML(strInput)
			case else
				strInput = removeHTML(strInput)
		end select
		
		strInput = removeSQLChars(strInput)
		
		cleanInput = strInput
	
	end function
	
	private function removeSQLChars(strText)
		Dim RegEx
	
		strText = Replace(strText,"'","''")
	
		Set RegEx = New RegExp
	
		RegEx.Pattern = "[\""]|\-{2}"
		RegEx.Global = True
	
		removeSQLChars = RegEx.Replace(strText, "")
	end function
	
	private Function removeHTML( strText )
		Dim RegEx
	
		Set RegEx = New RegExp
	
		RegEx.Pattern = "<[^>]*>"
		RegEx.Global = True
	
		removeHTML = RegEx.Replace(strText, "")
	End Function
	
	' clean up the html, but leave tags in for <ul>,<ol>,<li>,<strong>,<em>,
	private Function cleanUpHTML( strText )
		Dim RegEx
	
		Set RegEx = New RegExp
		if bDebug then response.write("cleaning up html<br>")
	
		RegEx.Pattern = "(<( )*\/{0,1}( )*(?!strong|/strong|b|/b|em|/em|i|/i|u|/u|ul|/ul|li|/li|ol|/ol)[^>]*>)"
		RegEx.Global = True
	
		cleanUpHTML = RegEx.Replace(strText, "")
	End Function
	
	'add a value to a dictionary object. (made this function AFTER I'd build the rest of the page, so 
	'it's probably not used much. d'oh.)
	public function addToDictionary(strKey, strValue, obj, bAppend, bOverwrite)
	
		if obj.exists(strKey) then
			if bAppend then obj(strKey) = obj(strKey) & "<BR>" & strValue
			if bOverwrite then obj(strKey) = strValue
		else
			obj.Add strKey, strValue
		end if
		
		set addToDictionary = obj
	
		set obj=nothing
	end function
		
	'add an error message to the oErrors object
	public function addError(strKey, strDefaultError, errorType)

		dim strDefinedError
		
		'add the default error message, unless a specific one has been defined in oErrorMessages
		if oErrorMessages.exists(strKey) then 
			strDefinedError = oErrorMessages(strKey)(errorType)
			if strDefinedError <> "" then
				set oErrors = addToDictionary(strKey, strDefinedError, oErrors, false, true)
			else 
				set oErrors = addToDictionary(strKey, strDefaultError, oErrors, false, true)
			end if
		else
			set oErrors = addToDictionary(strKey, strDefaultError, oErrors, false, true)
		end if
	
	end function
	
	'Called with a form element when the page is refreshed this re-populates the users input into the form element
	'If using for a free text field, simply use: keepData('my_text_field', "")
	''strValue' paramater is used for multi choice inputs only (radio buttons and checkboxes)
	'usage: <input type="radio" value="value_1" id="radio_group" < % =keepData("radio_group","value_1" % >> 
	'if this radio button was checked the keepdata function will add 'checked' into the html element.
	public function keepData(strElementId, strValue)
	
		if oFieldSpec.exists(strElementId) then
			strType = oFieldSpec(strElementId)(1)
		else
			strType = ""
		end if
		
		'response.write("checking element " & strElementId & " type = " & strType)
		'response.write("<br>user input " & form_collection(strElementId))
		'response.write("<br>value=" & strValue& "<br>")
		
		select case strType
			
			case "list"
				if form_collection(strElementId) = strValue then		
					keepData = "checked selected" 'a list can be either a list box (uses 'selected') or a radio button list (uses 'checked') this is a bit of a bodge...
				end if
			case "multilist"
				if instr(form_collection(strElementId), strValue) then
					keepData = "checked"
				end if
			case "varchar", "datetime", "postcode"
				keepData = form_collection(strElementId)
			case "email"
				keepData = form_collection(strElementId)
			case else
				keepData = form_collection(strElementId)
		
		end select

	end function
	
	'keep user input in fields, but if no user input is present then fill in the default value.
	public function keepData_withDefault(strElementId, strValue, strDefault)
		dim strUserEntry, bLoggedin, strReturn
		
		strUserEntry = keepData(strElementId, strValue)
		
		if bDebug then response.write("Keep Data: User Entry: " & strUserEntry & " <br>")
		
		if session("UID") <> ""  and isNull(rsReader) then
			Set objReader = server.createObject(strObj&".reader")
			Set rsReader = objReader.getbyIDrsReader(cInt(session("UID")),cStr(strConn))
		end if
		
		if  session("UID") = "" then 
			bLoggedIn = false
		else
			bLoggedIn = true
		end if
		
		if strUserEntry = "" then
			
			select case strDefault
				case "user_firstname"
					if bLoggedIn then strReturn = rsReader("fldFirstName")
				case "user_lastname"
					if bLoggedIn then strReturn = rsReader("fldLastName")
				case "user_name" '(first initial & surname)
					if bLoggedIn then strReturn = rsReader("fldFirstName") & " " & rsReader("fldFirstName")
				case "user_daynumber"
					if bLoggedIn then strReturn = rsReader("fldDayNo")			
				case "user_email"
					if bLoggedIn then strReturn = rsReader("fldEmail")
					
				case else
					strReturn = strDefault

			end select
		
			if bDebug then response.write("Default value requested: " & strDefault & " <BR> " & "default value returned: " & strReturn)
		
			keepData_withDefault = strReturn
		
		else '(if user has filled in this field)
		
			keepData_withDefault = strUserEntry
			
		end if
	
	end function

	public function displayErrors(strElementId)
	
		if oErrors.exists(strElementId) then
			displayErrors = "<span class='error'>" & oErrors(strElementId) & "</span>"
		else
			displayErrors=""
		end if
	
	end function
	
	'test your result set with this handy bastard.
	public function displayRS(rs)
	
		'Do Until rs Is Nothing 
			do while not rs.eof
			
				for each oField in rs.fields
					response.write("<strong>"&oField.name & "</strong>: "& oField.value & "<br>")		
				next
				rs.movenext
			
			loop
	'		Set rs = rs.NextRecordset 
	'	loop
	
	end function
	



end class

%>