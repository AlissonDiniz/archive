<%@ page import="br.com.archive.security.SecUser" %>

<div class="col-xs-8 form-group ${hasErrors(bean: secUserInstance, field: 'name', 'has-error')}">
    <label for="name">
        <g:message code="secUser.name.label" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="name" class="validate required form-control" placeholder="${message (code: "secUser.name.label")}" value="${secUserInstance?.name}" />
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 form-group ${hasErrors(bean: secUserInstance, field: 'username', 'has-error')}">
    <label for="username">
        <g:message code="secUser.username.label" />
        <span class="required-indicator">*</span>
    </label>
    <g:textField name="username" class="validate required form-control" placeholder="${message (code: "secUser.username.label")}" value="${secUserInstance?.username}"/>
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 form-group ${hasErrors(bean: secUserInstance, field: 'password', 'has-error')}">
    <label for="password">
        <g:message code="secUser.password.label" />
        <span class="required-indicator">*</span>
    </label>
    <g:field type="password" name="password" class="validate required form-control" placeholder="${message (code: "secUser.password.label")}" value="${secUserInstance?.password}"/>
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 form-group">
    <label for="confirmPassword">
        <g:message code="secUser.confirmPassword.label" />
        <span class="required-indicator">*</span>
    </label>
    <g:field type="password" name="confirmPassword" class="validate confirm form-control" data-field="password" placeholder="${message (code: "secUser.confirmPassword.label")}" />
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-confirm="${message (code: "default.field.confirm")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 form-group">
    <label for="role">
        <g:message code="secUser.role.label" />
        <span class="required-indicator">*</span>
    </label>
    <g:select id="role" name="role.id" class="validate required form-control" from="${br.com.archive.security.SecRole.list()}" optionKey="id" value="${secRoleInstance?.id}" noSelection="${['': g.message(code: "default.field.noSelection")]}"/>
    <span class="glyphicon glyphicon-exclamation-sign form-control-feedback" title="" data-message-required="${message (code: "default.field.required")}" data-message-confirm="${message (code: "default.field.confirm")}" aria-hidden="true"></span>
</div>
<div class="col-xs-8 checkbox">
    <label for="enabled">
        <g:checkBox name="enabled" value="${secUserInstance?.enabled}" />
        <g:message code="secUser.enabled.label" />
    </label>
</div>
<div class="col-xs-8 checkbox">
    <label for="accountExpired">
        <g:checkBox name="accountExpired" value="${secUserInstance?.accountExpired}" />
        <g:message code="secUser.accountExpired.label" />
    </label>
</div>
<div class="col-xs-8 checkbox">
    <label for="accountLocked">
        <g:checkBox name="accountLocked" value="${secUserInstance?.accountLocked}" />
        <g:message code="secUser.accountLocked.label" />
    </label>
</div>
<div class="col-xs-8 checkbox">
    <label for="passwordExpired">
        <g:checkBox name="passwordExpired" value="${secUserInstance?.passwordExpired}" />
        <g:message code="secUser.passwordExpired.label" />
    </label>
</div>
<g:hiddenField name="owner" value="${sec.loggedInUserInfo(field:'username')}" />