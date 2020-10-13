<!--#include file="class_contact_form.asp"-->
<%
	set oContact = new contact_form
	
	if request.QueryString("post") <> "" then
		oContact.parseForm()
	end if	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="/Templates/Master.dwt" codeOutsideHTMLIsLocked="false" -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Premier Lifestyle - Worldwide services for the privileged</title>
<meta name="author" content="Designed and produced by Digital Frequency for Adedayo Adebayo @ Premier Lifestyle Ltd">
<meta name="keywords" content="Premier, Lifestyle, Adedayo Adebayo, Rugby, Star, International, Professional Sports, Travel, Sport, Sports, Mobile, Dual SIM, Membership, Nigeria, England, UK, Company">
<link href="Styles/master.css" rel="stylesheet" type="text/css" />
<!-- InstanceBeginEditable name="head" --><!-- InstanceEndEditable -->
</head>

<body>
<div align="center">
  <table width="900" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="10" align="left" valign="top">&nbsp;</td>
      <td width="880" colspan="2" align="left" valign="top"><img src="Images/logo_top.jpg" alt="top of logo" width="255" height="40" /></td>
      <td width="10" align="left" valign="top">&nbsp;</td>
    </tr>
    <tr>
      <td align="left" valign="top"><img src="Images/tl_shadow.jpg" alt="shadow" width="10" height="242" /></td>
      <td width="880" colspan="2" align="left" valign="top"><!-- InstanceBeginEditable name="banner" --><img src="Images/main_banner_contact.jpg" alt="Premier Lifestyle - Worldwide services for the privileged" width="880" height="242" border="0" usemap="#Map"/>
        <!-- InstanceEndEditable --></td>
      <td align="left" valign="top"><img src="Images/tr_shadow.jpg" alt="shadow" width="10" height="242" /></td>
    </tr>
    <tr>
      <td rowspan="2" align="left" valign="top" class="lshadow">&nbsp;</td>
      <td colspan="2" align="left" valign="top"><table width="880" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="30" rowspan="2" align="left" valign="top" class="lnavborderbg"><img src="Images/lnav_border.jpg" alt="nav border" width="30" height="450" /></td>
          <td width="220" align="left" valign="top" class="navbg"><img src="Images/nav_top.gif" alt="top" width="220" height="20" border="0" /><br />
<!-- InstanceBeginEditable name="Nav" --><a href="index.html" onMouseOver="nav1.src='Images/nav_home_on.gif';" onMouseOut="nav1.src='Images/nav_home.gif';"><img src="Images/nav_home.gif" alt="Home" name="nav1" width="220" height="30" border="0" id="nav1" /></a><br />
            <a href="aboutpl.html" onMouseOver="nav2.src='Images/nav_about_pl_ov.gif';" onMouseOut="nav2.src='Images/nav_about_pl.gif';"><img src="Images/nav_about_pl.gif" alt="About PL" name="nav2" width="220" height="30" border="0" id="nav2" /></a><br />
            <a href="travel.html" onMouseOver="nav3.src='Images/nav_services_ov.gif';" onMouseOut="nav3.src='Images/nav_services.gif';"><img src="Images/nav_services.gif" alt="Services" name="nav3" width="220" height="25" border="0" id="nav3" /></a><br />
            <a href="sportsevents.html" onMouseOver="nav4.src='Images/nav_membership_ov.gif';" onMouseOut="nav4.src='Images/nav_membership.gif';"><img src="Images/nav_membership.gif" alt="Membership" name="nav4" width="220" height="18" border="0" id="nav4" /></a><br />
            <a href="corporateprivileges.html" onMouseOver="nav5.src='Images/nav_corporate_ov.gif';" onMouseOut="nav5.src='Images/nav_corporate.gif';"><img src="Images/nav_corporate.gif" alt="Corporate" name="nav5" width="220" height="24" border="0" id="nav5" /></a><br />
            <a href="membership.html" onMouseOver="nav6.src='Images/nav_whybuy.gif';" onMouseOut="nav6.src='Images/nav_whybuy_ov.gif';"><img src="Images/nav_whybuy.gif" alt="Why Buy Hospitality" name="nav6" width="220" height="30" border="0" id="nav6" /></a><br />		<a href="membership.html" onMouseOver="nav7.src='Images/nav_events.gif';" onMouseOut="nav7.src='Images/nav_events_ov.gif';"><img src="Images/nav_events.gif" alt="Why Buy Hospitality" name="nav7" width="220" height="30" border="0" id="nav7" /></a><br />
            <a href="contactus.asp" onMouseOver="nav8.src='Images/nav_contact_ov.gif';" onMouseOut="nav8.src='Images/nav_contact_ov.gif';"><img src="Images/nav_contact_ov.gif" alt="Contact Us" name="nav8" width="220" height="30" border="0" id="nav8" /></a><br />
              <!-- InstanceEndEditable --></td>
          <td width="19" rowspan="2" align="left" valign="top" class="lborderbg"><img src="Images/lborder.jpg" alt="border" width="19" height="564" /></td>
          <td width="592" rowspan="2" align="left" valign="top" bgcolor="#999282" class="sectionbg"><img src="Images/section_top_space.gif" alt="spacer" width="592" height="6" /><!-- InstanceBeginEditable name="Header" --><!-- InstanceEndEditable -->
              <img src="Images/section_head_strip.jpg" alt="header" width="592" height="25" /><br />
              <!-- InstanceBeginEditable name="Content" -->
              <table width="592" border="0" cellpadding="0" cellspacing="0" class="sectionbg">
                <tr>
                  <td width="14" align="left" valign="top"><img src="Images/spacer.gif" alt="spacer" width="14" height="5" /></td>
                  <td width="82" align="left" valign="top"><img src="Images/spacer.gif" alt="spacer" width="82" height="5" /></td>
                  <td width="400" align="left" valign="top"><span class="H2">Contact Us</span> <br />
                    <br />
                    <strong>Premier Lifestyle</strong><br />
                    9th Floor Fortune Towers <br />
                    27-29 Adeyemo Alakija Street <br />
                    Victoria Island <br />
                    Lagos <br />
                    <br />
                    <strong>Tel:</strong> +234 (0) 1 270 5839 <br />
                    <strong>Fax:</strong> +234 (0) 1 270 3372<br />
                    <br />
                    <span class="labeltxt">Email:</span> <a href="mailto:info@premierlifestyle.com">info@premierlifestyle.com</a></td>
                  <td width="82" align="left" valign="top"><img src="Images/spacer.gif" alt="spacer" width="82" height="5" /></td>
                  <td width="14" align="left" valign="top">&nbsp;</td>
                </tr>
                <tr>
                  <td colspan="5" align="left" valign="top"><img src="Images/section_rule.gif" alt="rule" width="592" height="25" /></td>
                </tr>
                
                <tr>
                  <td align="left" valign="top">&nbsp;</td>
                  <td align="left" valign="top">&nbsp;</td>
                  <td align="left" valign="top">All information is treated with confidentiality.</td>
                  <td align="left" valign="top">&nbsp;</td>
                  <td align="left" valign="top">&nbsp;</td>
                </tr>
              </table>
              <!-- InstanceEndEditable --><br /></td>
          <td width="18" rowspan="2" align="left" valign="top" class="rborderbg"><img src="Images/rborder.jpg" alt="border" width="19" height="564" /></td>
        </tr>
        <tr>
          <td align="left" valign="bottom" class="navbg"><a href="SGP_Newsletter.pdf" target="_blank"><img src="Images/spacer.gif" alt="Become a Member Now!" width="220" height="87" border="0" /></a></td>
        </tr>
        <tr>
          <td colspan="2" align="left" valign="top"><a href="SGP_Newsletter.pdf" target="_blank"><img src="Images/base_bar_templateb.gif" alt="Become a Member Now!" width="250" height="17" border="0" /></a></td>
          <td colspan="3" align="left" valign="top"><img src="Images/section_base.jpg" alt="base" width="630" height="17" /></td>
          </tr>
      </table></td>
      <td rowspan="2" align="left" valign="top" class="rshadow">&nbsp;</td>
    </tr>
    <tr>
      <td width="269" align="left" valign="top" class="basebarbg"><a href="SGP_Newsletter.pdf" target="_blank"><img src="Images/base_bar_left_b.gif" alt="base bar" width="266" height="32" border="0" /></a></td>
      <td width="611" align="left" valign="top" class="basebarbg"><table width="100%" border="0" cellpadding="0" cellspacing="0" id="footer">
        <tr>
          <td colspan="3"><img src="Images/spacer.gif" alt="spacer" width="5" height="9" /></td>
          </tr>
        <tr>
          <td class="normaltxt">Copyright © 2009 Premiere Lifestyle Limited. All rights reserved.</td>
          <td class="normaltxt"><div align="right"><a href="privacypolicy.html">Privacy Policy</a>  |  <a href="privacypolicy.html">Terms &amp; Conditions</a></div></td>
          <td width="19" class="normaltxt"><img src="Images/spacer.gif" alt="spacer" width="15" height="5" /></td>
        </tr>
      </table></td>
    </tr>
    <tr>
      <td rowspan="2" align="left" valign="top"><img src="Images/bl_shadow.jpg" alt="shadow" width="10" height="40" /></td>
      <td colspan="2" align="left" valign="top"><img src="Images/base.gif" alt="base" width="880" height="30" border="0" usemap="#Tag" /></td>
      <td rowspan="2" align="left" valign="top"><img src="Images/br_shadow.jpg" alt="shadow" width="10" height="40" /></td>
    </tr>
    <tr>
      <td colspan="2" align="left" valign="top"><img src="Images/base_shadow.jpg" alt="base shadow" width="880" height="10" /><br />
</td>
    </tr>
  </table>
</div>
<map name="Tag" id="Tag">
  <area shape="rect" coords="781,3,876,27" href="http://www.digitalfrequency.co.uk" target="_blank" alt="Designed by: Digital Frequency" />
</map>
<map name="Map" id="Map">
  <area shape="rect" coords="30,1,250,121" href="index.html" alt="Premier Lifestyle" />
</map>
</body>
<!-- InstanceEnd --></html>
