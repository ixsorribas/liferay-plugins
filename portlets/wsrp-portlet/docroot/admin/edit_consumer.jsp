<%
/**
 * Copyright (c) 2000-2010 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ include file="/init.jsp" %>

<%
String redirect = ParamUtil.getString(request, "redirect");

long wsrpConsumerId = ParamUtil.getLong(request, "wsrpConsumerId");

WSRPConsumer wsrpConsumer = null;

try {
	wsrpConsumer = WSRPConsumerLocalServiceUtil.getWSRPConsumer(wsrpConsumerId);
}
catch (NoSuchConsumerException nsce) {
}
%>

<script type="text/javascript">
	function <portlet:namespace />saveConsumer() {
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<form action="<portlet:actionURL name="updateWSRPConsumer"><portlet:param name="jspPage" value="/admin/edit_consumer.jsp" /><portlet:param name="redirect" value="<%= redirect %>" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" onSubmit="<portlet:namespace />saveConsumer(); return false;">
<input name="<portlet:namespace />wsrpConsumerId" type="hidden" value="<%= wsrpConsumerId %>" />

<liferay-ui:error exception="<%= WSRPConsumerNameException.class %>" message="please-enter-a-valid-name" />
<liferay-ui:error exception="<%= WSRPConsumerWSDLException.class %>" message="url-does-not-point-to-a-valid-wsrp-producer" />

<div class="breadcrumbs">
	<span class="first"><a href="<portlet:renderURL />"><liferay-ui:message key="consumers" /></a></span> &raquo;

	<span class="last"><liferay-ui:message key='<%= ((wsrpConsumer == null) ? Constants.ADD : Constants.UPDATE) + "-consumer" %>' /></span>
</div>

<table class="lfr-table">
<tr>
	<td>
		<liferay-ui:message key="name" />
	</td>
	<td>
		<liferay-ui:input-field model="<%= WSRPConsumer.class %>" bean="<%= wsrpConsumer %>" field="name" />
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="url" />
	</td>
	<td>
		<c:choose>
			<c:when test="<%= wsrpConsumer == null %>">
				<liferay-ui:input-field model="<%= WSRPConsumer.class %>" bean="<%= wsrpConsumer %>" field="url" />
			</c:when>
			<c:otherwise>
				<a href="<%= wsrpConsumer.getUrl() %>" target="_blank"><%= wsrpConsumer.getUrl() %></a>

				<input name="<portlet:namespace />url" type="hidden" value="<%= wsrpConsumer.getUrl() %>" />
			</c:otherwise>
		</c:choose>
	</td>
</tr>
</table>

<br />

<input type="submit" value="<liferay-ui:message key="save" />" />

<input type="button" value="<liferay-ui:message key="cancel" />" onClick="location.href = '<%= HtmlUtil.escape(PortalUtil.escapeRedirect(redirect)) %>';" />

</form>

<script type="text/javascript">
	Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />name);
</script>