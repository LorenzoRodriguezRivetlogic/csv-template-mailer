<%@ include file="/init.jsp" %>

<%
	String fileId = ParamUtil.getString(request, WebKeys.FILE_ID);
	String emailString = ParamUtil.getString(request, WebKeys.COLUMN_EMAIL) ;
	String paramsAttr = ParamUtil.getString(request, WebKeys.COLUMNS_TO_USE);
	String template = ParamUtil.getString(request, WebKeys.CONTENT);
	String emailSender = ParamUtil.getString(request, WebKeys.SENDER_EMAIL);
	String subject = ParamUtil.getString(request, WebKeys.EMAIL_SUBJECT);
	String templateId = ParamUtil.getString(request, WebKeys.TEMPLATE_ID);
	String templateName = ParamUtil.getString(request, WebKeys.TEMPLATE_NAME);
	Long scopeGroupIdTmp = ParamUtil.getLong(request, WebKeys.SCOPE_ID, 0);
	List<FileColumn> params = Utils.deserializeColumns(paramsAttr);
	FileColumn email = (FileColumn) JSONFactoryUtil.looseDeserialize(emailString, FileColumn.class);
	
	Map<String, String> firstRow = FileUtil.getFirstDataRow(fileId, params, email);
	String tempPreview = Utils.replaceDataFirstRow(fileId, params, email, template);
%>


<portlet:actionURL name="sendEmails" var="sendEmailsURL">
	<portlet:param name="backURL" value="<%= currentURL %>"/>
</portlet:actionURL>

<portlet:renderURL var="returnUrl">
	<portlet:param name="mvcPath" value="<%= WebKeys.EMAIL_CONFIGURATION_URL %>" />
    <portlet:param name="fileId" value="<%= fileId %>" />
    <portlet:param name="emailColumn" value="<%= emailString %>" />
    <portlet:param name="columnsToUse" value="<%= paramsAttr %>" />
    <portlet:param name="senderEmail" value="<%= emailSender %>" />
    <portlet:param name="emailSubject" value="<%= subject %>" />
    <portlet:param name="content" value="<%= Utils.removeEscapeChars(template) %>" />
    <portlet:param name="templateId" value="<%= templateId %>" />
    <portlet:param name="name" value="<%= templateName %>" />
    <portlet:param name="scopeId" value="<%= String.valueOf(scopeGroupIdTmp) %>" />
</portlet:renderURL>

<liferay-ui:header showBackURL="true" backURL="<%= returnUrl.toString() %>"  title="preview" />

<table>
	<tr>
		<td><liferay-ui:message key="label-from" /></td>
		<td><%= emailSender %></td>
	</tr>
	<tr>
		<td><liferay-ui:message key="label-to" /></td>
		<td><%= firstRow.get(WebKeys.EMAIL_TO_SEND) %></td>
	</tr>
	<tr>
		<td><liferay-ui:message key="label-subject" /></td>
		<td><%= subject %></td>
	</tr>
</table>
<div style="border: 1px solid #d3d3d3; padding: 10px;">
	<%= tempPreview %>
</div>

<aui:form action="<%= sendEmailsURL %>" method="post" name="fm">
	<aui:input name="fileId" value="<%= fileId %>" type="hidden" />
	<aui:input name="emailColumn" value="<%= emailString %>" type="hidden" />
	<aui:input name="columnsToUse" value="<%= paramsAttr %>" type="hidden" />
	<aui:input name="content" value="<%= template %>" type="hidden" />
	<aui:input name="senderEmail" value="<%= emailSender %>" type="hidden" />
	<aui:input name="emailSubject" value="<%= subject %>" type="hidden" />
	
	<aui:button-row>
        <aui:button type="submit" value="send-button" />
    </aui:button-row>
</aui:form>         