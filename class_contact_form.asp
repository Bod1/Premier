<!--#include file="class_form.asp"-->
<!--#include file="class_email.asp"-->
<%

class contact_form

	private upload
	private oFieldSpec, oFieldValid
	private bValid

	private bDebug
		
	private parent

	public form_collection	'the collection of form elements (this allows us 
	public oErrors			'all validation errors which are returned from the validate functions in class_default_table
	
	private form_collection_formatted
	
	
	Private Sub Class_Initialize(  )
		
		bDebug = false
		multipleSubmits = false
		
		set parent = New generic_form
					
		Set oFieldSpec 		= CreateObject("Scripting.Dictionary")	'specification of all fields
		set oErrors			= CreateObject("Scripting.Dictionary")	'populated with any error messages after validation
		set form_collection = CreateObject("Scripting.Dictionary")	'holds all of the form post data.
		set oErrorMessages	= CreateObject("Scripting.Dictionary")	'bespoke errors					
						
		oFieldSpec.Add "realname",			Array("Users Name", "varchar", 200, true)
		oFieldSpec.Add "compName", 			Array("Company Name", "varchar", 200, true)
		oFieldSpec.Add "email", 			Array("Email Address", "email", 200, true)
		oFieldSpec.Add "message",	 		Array("Message", "varchar", 8000, true)

		'set up bespoke error messages where required
		'									  defaultError, Too Long error, Invalid Error
		oErrorMessages.Add "realname", 	Array("Please enter your name", "",	"")
		oErrorMessages.Add "compName", 	Array("Please enter your company name","", "")
		oErrorMessages.Add "email", 	Array("Please enter your email address","",	"")
		oErrorMessages.Add "message", 	Array("Please enter your message","","")

		set parent.oFieldSpec 		= oFieldSpec
		set parent.oErrorMessages 	= oErrorMessages

				
	End Sub

	public function parseForm()
		'retrieve the form input from the http post
		set form_collection = getFormData()
		
		'valide and clean form input
		set oErrors = parent.parseForm(form_collection)
		
		'set oErrors = secValidation()

		set form_collection_formatted = parent.form_collection_formatted

		'if no validation errors, then send email and redirect to thankyou page
		if oErrors.count = 0 then
			sendemail()
			response.redirect("http://www.premierlifestyle.com/thanks.html")
		end if

		set parseForm = oErrors
		
	end function
	
	
	private function sendemail()
	
		dim obj_email

		set obj_email = new email
		obj_email.strBody = obj_email.strHTMLHeader & getEmailBody() & obj_email.strHTMLFooter
		
		obj_email.strTo 		= "info@www.premierlifestyle.com"
		obj_email.strfrom 		= "root@www.premierlifestyle.com"
		obj_email.strSubject 	= "Formail from Premier Lifestyle.com"
		obj_email.setMailFormat("html")
		obj_email.sendEmail
	
	end function
	
	
	private function getEmailBody()
		dim strBody, strFieldName, strResponse, key
		
		strBody = "A user has filled in the Premier Lifestyle.com contact us form.<br></br><table>" 
		
		for each key in oFieldSpec
		
			strFieldName = oFieldSpec(key)(0)
			strResponse = form_collection_formatted(key)		
			
			strBody = strBody & "<tr><td><strong>" & strFieldName & "</strong></td><td>" & strResponse & "</td></tr>"
		
		next
		
		strBody = strBody & "</table>"
		
		getEmailBody = strBody 
	
	end function
	
	
	private function getFormData()
		set getFormData = parent.getFormData()
	end function
	
	'secondary validation goes here	
	private function secValidation()

	end function

	public function keepData(strElementId, strValue)
		keepData = parent.keepData(strElementId, strValue)
	end function
	
	public function keepData_withDefault(strElementId, strValue, strDefault)
		keepData_withDefault = parent.keepData_withDefault(strElementId, strValue, strDefault)
	end function
	
	public function displayErrors(strElementId)
		displayErrors = parent.displayErrors(strElementId)
	end function
	
	public function addError(strKey, strDefaultError, errorType)
		parent.addError strKey, strDefaultError, errorType
	end function
	
end class

%>