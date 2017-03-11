<%@ page import="br.com.archive.domain.StorageType" %>

<div class="col-xs-8 form-group ${hasErrors(bean: storageTypeInstance, field: 'name', 'has-error')}">
    <label for="name">
        <g:message code="storageType.name.label" default="Name" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" class="validate required form-control" value="${storageTypeInstance?.name}"/>
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 form-group ${hasErrors(bean: storageTypeInstance, field: 'description', 'has-error')}">
    <label for="description">
        <g:message code="storageType.description.label" default="Description" />
    </label>
    <g:textArea name="description" class="form-control" rows="5" cols="40" value="${storageTypeInstance?.description}"/>
</div>
<g:hiddenField name="owner" value="${sec.loggedInUserInfo(field:'username')}" />